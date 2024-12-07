import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSchedulePage extends StatefulWidget {
  final String clubName;
  final Color clubColor;
  final DateTime? selectedDate;

  const AddSchedulePage({
    super.key,
    required this.clubName,
    required this.clubColor,
    this.selectedDate,
  });

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.clubColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.clubColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      appBar: AppBar(
        title: Text(
          '${widget.clubName} 일정 추가',
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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 일정 저장 로직
              Navigator.pop(context, {
                'title': _titleController.text,
                'date': _selectedDate,
                'time': _selectedTime,
                'location': _locationController.text,
                'description': _descriptionController.text,
              });
            },
            child: const Text(
              '저장',
              style: TextStyle(
                color: Color(0xFFFF7F50),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜 선택
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  DateFormat('yyyy년 MM월 dd일').format(_selectedDate),
                ),
                onTap: () => _selectDate(context),
              ),
            ),
            const SizedBox(height: 16),
            // 시간 선택
            Card(
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(_selectedTime.format(context)),
                onTap: () => _selectTime(context),
              ),
            ),
            const SizedBox(height: 16),
            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '일정 제목',
                labelStyle: TextStyle(color: widget.clubColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: widget.clubColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 장소 입력
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: '장소',
                labelStyle: TextStyle(color: widget.clubColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: widget.clubColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 설명 입력
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: '설명',
                alignLabelWithHint: true,
                labelStyle: TextStyle(color: widget.clubColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: widget.clubColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 