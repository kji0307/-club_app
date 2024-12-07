import 'package:flutter/material.dart';
import 'widgets/common_bottom_navigation.dart';
import 'club_join_page.dart';

class ClubDetailPage extends StatelessWidget {
  final String clubName;
  final Color clubColor;
  final String imageUrl;

  const ClubDetailPage({
    super.key,
    required this.clubName,
    required this.clubColor,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 앱바와 이미지를 포함한 상단부
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: clubColor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    clubName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // 동아리 정보
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 기본 정보 섹션
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '기본 정보',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(Icons.people_outline, '회원 수', '32명'),
                              _buildInfoRow(Icons.location_on_outlined, '동아리방', '학생회관 302호'),
                              _buildInfoRow(Icons.access_time, '정기모임', '매주 화/목 18:00'),
                              _buildInfoRow(Icons.person, '회장', '홍길동'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 동아리 소개
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '동아리 소개',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '우리 동아리는 다양한 활동을 통해 회원들의 성장을 도모하고 있습니다. '
                                '정기적인 모임을 통해 서로의 경험을 공유하고, 새로운 것을 배우며, '
                                '즐거운 대학 생활을 만들어가고 있습니다.',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 주요 활동
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '주요 활동',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildActivityItem('정기 모임', '매주 화/목요일 정기 모임을 통해 활동 진행'),
                              _buildActivityItem('학기 발표회', '매 학기 말 정기 발표회 개최'),
                              _buildActivityItem('친목 활동', '매월 1회 친목 도모를 위한 활동 진행'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 가입하기 버튼 추가
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClubJoinPage(
                      clubName: clubName,
                      clubColor: clubColor,
                    ),
                  ),
                );
              },
              backgroundColor: clubColor,
              label: const Text(
                '가입하기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavigation(currentIndex: 2),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 20, color: clubColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
