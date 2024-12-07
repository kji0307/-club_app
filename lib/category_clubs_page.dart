import 'package:flutter/material.dart';
import 'widgets/common_bottom_navigation.dart';
import 'club_detail_page.dart';

class CategoryClubsPage extends StatelessWidget {
  final String category;
  final Color categoryColor;

  const CategoryClubsPage({
    Key? key,
    required this.category,
    required this.categoryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 임시 동아리 데이터
    final clubs = [
      {
        'name': '$category 동아리 1',
        'description': '매주 화/목 18:00 정기모임',
        'members': '32명',
        'location': '학생회관 302호',
        'imageUrl': 'https://picsum.photos/500/300',
      },
      {
        'name': '$category 동아리 2',
        'description': '매주 수 19:00 정기모임',
        'members': '25명',
        'location': '학생회관 303호',
        'imageUrl': 'https://picsum.photos/500/301',
      },
      {
        'name': '$category 동아리 3',
        'description': '매주 금 17:00 정기모임',
        'members': '28명',
        'location': '학생회관 304호',
        'imageUrl': 'https://picsum.photos/500/302',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      appBar: AppBar(
        title: Text(
          '$category 동아리',
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
                  builder: (context) => ClubDetailPage(
                    clubName: club['name']!,
                    clubColor: categoryColor,
                    imageUrl: club['imageUrl']!,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: categoryColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 동아리 이미지
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        club['imageUrl']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.white54,
                                size: 30,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 동아리 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            club['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            club['description']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                club['members']!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  club['location']!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CommonBottomNavigation(currentIndex: 2),
    );
  }
} 