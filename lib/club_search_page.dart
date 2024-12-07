import 'package:flutter/material.dart';
import 'widgets/common_bottom_navigation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'main_page.dart';

class ClubSearchPage extends StatefulWidget {
  ClubSearchPage({Key? key}) : super(key: key);

  @override
  State<ClubSearchPage> createState() => _ClubSearchPageState();
}

class _ClubSearchPageState extends State<ClubSearchPage> {
  String selectedCategory = '전체';
  String searchQuery = '';
  
  final List<String> categories = [
    '전체',
    '교양',
    '문예',
    '사회봉사',
    '체육',
    '학술',
    '가동아리',
  ];

  final List<Map<String, dynamic>> allClubs = [
    {
      'name': '댄스 동아리 FLOW',
      'category': '교양',
      'description': '매주 화/목 18:00 정기연습',
      'members': '32명',
      'views': '156',
      'likes': '45',
      'color': const Color(0xFF90CDF4),
      'isLarge': true,
    },
    {
      'name': '코딩 클럽',
      'category': '학술',
      'description': '매주 수 19:00 정기모임',
      'members': '25명',
      'views': '120',
      'likes': '32',
      'color': const Color(0xFFFFB4A2),
      'isLarge': false,
    },
    {
      'name': '사진반 MOMENT',
      'category': '문예',
      'description': '매주 금 17:00 정기모임',
      'members': '28명',
      'views': '98',
      'likes': '28',
      'color': const Color(0xFFFFD791),
      'isLarge': true,
    },
    {
      'name': '밴드부 Echo',
      'category': '교양',
      'description': '매주 월/수 18:00 합주',
      'members': '15명',
      'views': '145',
      'likes': '38',
      'color': const Color(0xFFFFA07A),
      'isLarge': false,
    },
    {
      'name': '농구동아리 Slam',
      'category': '체육',
      'description': '매주 토 14:00 정기연습',
      'members': '20명',
      'views': '167',
      'likes': '42',
      'color': const Color(0xFFB5E6D8),
      'isLarge': true,
    },
  ];

  List<Map<String, dynamic>> get filteredClubs {
    return allClubs.where((club) {
      final matchesCategory = selectedCategory == '전체' || 
                            club['category'] == selectedCategory;
      final matchesQuery = searchQuery.isEmpty ||
                          club['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          club['description']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '동아리 검색',
          style: TextStyle(color: Color(0xFFFF7F50)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFFF7F50)),
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
          // 검색창
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: '동아리 이름, 설명 검색',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFFF7F50)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFFF7F50)),
                ),
              ),
            ),
          ),
          
          // 카테고리 필터
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: const Color(0xFFFFA07A),
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600],
                    ),
                    backgroundColor: Colors.white,
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 8),
          
          // 검색 결과를 그리드 뷰로 변경
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: filteredClubs.length,
                itemBuilder: (context, index) {
                  final club = filteredClubs[index];
                  return Card(
                    color: club['color'] as Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: club['isLarge'] as bool ? 200 : 140,
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
                              club['category']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            club['name']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: club['isLarge'] as bool ? 20 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            club['description']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: club['isLarge'] as bool ? 14 : 12,
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
                                club['views']!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.favorite_border,
                                size: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                club['likes']!,
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
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavigation(currentIndex: 3),
    );
  }
}
