import 'package:flutter/material.dart';
import '../board_page.dart';
import '../my_clubs_page.dart';
import '../main_page.dart';
import '../club_search_page.dart';
import '../profile_page.dart';

class CommonBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CommonBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFFFFA07A),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.white,
      onTap: (index) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              switch (index) {
                case 0:
                  return const BoardPage();
                case 1:
                  return const MyClubsPage();
                case 2:
                  return const MainPage();
                case 3:
                  return ClubSearchPage();
                case 4:
                  return const ProfilePage();
                default:
                  return const MainPage();
              }
            },
          ),
          (route) => false,
        );
      },
    );
  }
} 