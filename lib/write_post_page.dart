import 'package:flutter/material.dart';

class WritePostPage extends StatefulWidget {
  const WritePostPage({Key? key}) : super(key: key);

  @override
  State<WritePostPage> createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = '교양동아리';

  final List<String> _categories = [
    '교양동아리',
    '문예동아리',
    '사회봉사',
    '체육',
    '학술',
    '가동아리',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      appBar: AppBar(
        title: const Text(
          '게시글 작성',
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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 게시글 저장 로직
              Navigator.pop(context);
            },
            child: const Text(
              '완료',
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
            // 카테고리 선택
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: '카테고리',
                labelStyle: const TextStyle(color: Color(0xFFFF7F50)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFFF7F50)),
                ),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '제목',
                labelStyle: const TextStyle(color: Color(0xFFFF7F50)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFFF7F50)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 내용 입력
            TextField(
              controller: _contentController,
              maxLines: 15,
              decoration: InputDecoration(
                labelText: '내용',
                alignLabelWithHint: true,
                labelStyle: const TextStyle(color: Color(0xFFFF7F50)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFFF7F50)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 