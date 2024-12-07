import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'widgets/common_bottom_navigation.dart';
import 'add_schedule_page.dart';
import 'main_page.dart';

class ClubSchedulePage extends StatefulWidget {
  final String clubName;
  final Color clubColor;

  const ClubSchedulePage({
    super.key,
    required this.clubName,
    required this.clubColor,
  });

  @override
  State<ClubSchedulePage> createState() => _ClubSchedulePageState();
}

class _ClubSchedulePageState extends State<ClubSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  // 임시 일정 데이터
  final Map<DateTime, List<Map<String, String>>> _events = {
    DateTime.utc(2024, 3, 15): [
      {
        'time': '18:00',
        'title': '정기 모임',
        'location': '학생회관 302호',
        'description': '동아리 정기 모임 및 활동 계획 논의',
      }
    ],
    DateTime.utc(2024, 3, 20): [
      {
        'time': '17:00',
        'title': '특별 세미나',
        'location': '학생회관 대강당',
        'description': '외부 강사 초청 특강',
      }
    ],
    DateTime.utc(2024, 3, 25): [
      {
        'time': '19:00',
        'title': '친목 모임',
        'location': '학생식당',
        'description': '동아리 회원 친목 도모',
      }
    ],
  };

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      appBar: AppBar(
        title: Text(
          '${widget.clubName} 일정',
          style: const TextStyle(
            color: Color(0xFFFF7F50),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFF7F50)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
              (route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          // 캘린더
          Card(
            margin: const EdgeInsets.all(16),
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: widget.clubColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: widget.clubColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: widget.clubColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
          // 선택된 날짜의 일정 목록
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _selectedDay != null
                  ? _getEventsForDay(_selectedDay!).length
                  : 0,
              itemBuilder: (context, index) {
                if (_selectedDay == null) return const SizedBox.shrink();
                
                final events = _getEventsForDay(_selectedDay!);
                final event = events[index];
                
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    // 삭제 확인 다이얼로그
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('일정 삭제'),
                          content: const Text('이 일정을 삭제하시겠습니까?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                '삭제',
                                style: TextStyle(color: Colors.red[700]),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    setState(() {
                      // 선택된 날짜의 이벤트 목록에서 해당 일정 삭제
                      _events[_selectedDay!]!.removeAt(index);
                      
                      // 해당 날짜의 모든 일정이 삭제되면 날짜 키도 삭제
                      if (_events[_selectedDay!]!.isEmpty) {
                        _events.remove(_selectedDay!);
                      }
                    });
                    
                    // 삭제 완료 메시지
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('일정이 삭제되었습니다.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onLongPress: () async {
                        // 길게 누르면 삭제 확인 다이얼로그 표시
                        final delete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('일정 삭제'),
                              content: const Text('이 일정을 삭제하시겠습니까?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('취소'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text(
                                    '삭제',
                                    style: TextStyle(color: Colors.red[700]),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (delete == true) {
                          setState(() {
                            _events[_selectedDay!]!.removeAt(index);
                            if (_events[_selectedDay!]!.isEmpty) {
                              _events.remove(_selectedDay!);
                            }
                          });

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('일정이 삭제되었습니다.'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.clubColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    event['time']!,
                                    style: TextStyle(
                                      color: widget.clubColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  event['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  event['location']!,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              event['description']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSchedulePage(
                clubName: widget.clubName,
                clubColor: widget.clubColor,
                selectedDate: _selectedDay ?? _focusedDay,
              ),
            ),
          );
          
          if (result != null) {
            // 새 일정 추가
            setState(() {
              final date = DateTime.utc(
                result['date'].year,
                result['date'].month,
                result['date'].day,
              );
              
              if (!_events.containsKey(date)) {
                _events[date] = [];
              }
              
              _events[date]!.add({
                'time': result['time'].format(context),
                'title': result['title'],
                'location': result['location'],
                'description': result['description'],
              });
              
              _selectedDay = date;
              _focusedDay = date;
            });
          }
        },
        backgroundColor: widget.clubColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CommonBottomNavigation(currentIndex: 2),
    );
  }
} 