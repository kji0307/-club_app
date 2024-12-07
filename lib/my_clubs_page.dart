import 'package:flutter/material.dart';
import 'widgets/common_bottom_navigation.dart';
import 'club_schedule_page.dart';
import 'main_page.dart';

class MyClubsPage extends StatelessWidget {
  const MyClubsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 임시 동아리 데이터의 타입을 명시적으로 지정
    final List<Map<String, dynamic>> clubs = [
      {
        'name': '댄스 동아리 FLOW',
        'category': '예술/공연',
        'role': '회장',
        'meetingDay': '화/목 18:00',
        'color': const Color(0xFF90CDF4),
      },
      {
        'name': '코딩 클럽',
        'category': '학술/교양',
        'role': '부원',
        'meetingDay': '수 19:00',
        'color': const Color(0xFFFFB4A2),
      },
      {
        'name': '사진반 MOMENT',
        'category': '예술/공연',
        'role': '부원',
        'meetingDay': '금 17:00',
        'color': const Color(0xFFFFD791),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      appBar: AppBar(
        title: const Text(
          '내 동아리',
          style: TextStyle(
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClubSchedulePage(
                    clubName: club['name']!,
                    clubColor: club['color'] as Color,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: club['color'] as Color,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          club['name']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            club['role']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      club['category']!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          club['meetingDay'] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CommonBottomNavigation(currentIndex: 1),
    );
  }
} 