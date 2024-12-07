import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'club_search_page.dart';
import 'profile_page.dart';
import 'board_page.dart';
import 'my_clubs_page.dart';
import 'category_clubs_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2;
  final ScrollController _scrollController = ScrollController();
  bool _isScrollingToPosition = false;

  void _navigateToBoardPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BoardPage()),
    ).then((_) {
      setState(() {
        _selectedIndex = 2;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_isScrollingToPosition) {
        if (_scrollController.offset > 300) {
          _navigateToBoardPage();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        '교내',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFA07A),
                        ),
                      ),
                      Text(
                        '동아리',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFA07A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ready to join?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    // 각 카드의 설정
                    final cardConfigs = [
                      {
                        'title': '교양',
                        'subtitle': '23 sessions',
                        'color': const Color(0xFF90CDF4),
                        'isLarge': true,
                      },
                      {
                        'title': '문예',
                        'subtitle': '18 sessions',
                        'color': const Color(0xFFFFB4A2),
                        'isLarge': false,
                      },
                      {
                        'title': '사회봉사',
                        'subtitle': '12 sessions',
                        'color': const Color(0xFFFFD791),
                        'isLarge': true,
                      },
                      {
                        'title': '체육',
                        'subtitle': '15 sessions',
                        'color': const Color(0xFFFFA07A),
                        'isLarge': false,
                      },
                      {
                        'title': '학술',
                        'subtitle': '8 sessions',
                        'color': const Color(0xFFB5E6D8),
                        'isLarge': true,
                      },
                      {
                        'title': '가동아리',
                        'subtitle': '20 sessions',
                        'color': const Color(0xFFFFC3B9),
                        'isLarge': false,
                      },
                    ];

                    final config = cardConfigs[index];
                    return _buildCard(
                      config['title'] as String,
                      config['subtitle'] as String,
                      config['color'] as Color,
                      isLarge: config['isLarge'] as bool,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '관심',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFFA07A),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (index == 0) {  // 게시판
            _navigateToBoardPage();
          } else if (index == 2) {  // 홈
            _isScrollingToPosition = true;
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
            ).then((_) {
              _isScrollingToPosition = false;
            });
          } else {
            if (index == 1) {  // 내 동아리
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyClubsPage()),
              );
            } else if (index == 3) {  // 검색
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClubSearchPage()),
              );
            } else if (index == 4) {  // 프로필
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            }
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, Color color, {bool isLarge = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryClubsPage(
              category: title,
              categoryColor: color,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        height: isLarge ? 200 : 140,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLarge ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white70,
                fontSize: isLarge ? 16 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      color: isSelected ? const Color(0xFFFFA07A) : Colors.grey,
      size: 28,
    );
  }
}


