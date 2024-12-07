import 'package:flutter/material.dart';
import 'widgets/common_bottom_navigation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'write_post_page.dart';
import 'main_page.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 임시 게시글 데이터
    final posts = [
      {
        'title': '댄스 동아리 FLOW',
        'category': '교양동아리',
        'description': '매주 화/목 18:00 정기연습',
        'views': '120',
        'comments': '12',
        'color': const Color(0xFF90CDF4),
        'isLarge': true,
      },
      {
        'title': '사진반 MOMENT',
        'category': '문예동아리',
        'description': '매주 금 17:00 정기모임',
        'views': '89',
        'comments': '8',
        'color': const Color(0xFFFFB4A2),
        'isLarge': false,
      },
      {
        'title': '봉사동아리 함께해요',
        'category': '사회봉사',
        'description': '매주 화/목 18:00 정기연습',
        'views': '150',
        'comments': '15',
        'color': const Color(0xFFFFD791),
        'isLarge': true,
      },
      {
        'title': '농구 동아리 모집',
        'category': '체육',
        'description': '매주 금 17:00 정기모임',
        'views': '100',
        'comments': '10',
        'color': const Color(0xFFFFA07A),
        'isLarge': false,
      },
      {
        'title': '코딩 스터디 모집',
        'category': '학술',
        'description': '매주 화/목 18:00 정기연습',
        'views': '200',
        'comments': '20',
        'color': const Color(0xFFB5E6D8),
        'isLarge': true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      appBar: AppBar(
        title: const Text(
          '동아리 홍보 게시판',
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: 10,
          itemBuilder: (context, index) {
            final post = posts[index % posts.length];
            return Card(
              color: post['color'] as Color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: post['isLarge'] as bool ? 200 : 140,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        post['category'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post['title'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: post['isLarge'] as bool ? 20 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post['description'] as String,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: post['isLarge'] as bool ? 14 : 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          post['views'] as String,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          post['comments'] as String,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WritePostPage()),
          );
        },
        backgroundColor: const Color(0xFFFFA07A),
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: const CommonBottomNavigation(currentIndex: 0),
    );
  }
} 