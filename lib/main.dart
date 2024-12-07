import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'main_page.dart';
import 'club_search_page.dart';
import 'club_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Club App',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'NotoSans',
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/main': (context) => const MainPage(),
        '/club_search': (context) => ClubSearchPage(),
      },
    );
  }
}

