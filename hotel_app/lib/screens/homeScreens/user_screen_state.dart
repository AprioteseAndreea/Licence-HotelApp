import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:first_app_flutter/screens/homeScreens/chat_screen.dart';
import 'package:first_app_flutter/screens/homeScreens/user_home_screen.dart';
import 'package:first_app_flutter/screens/user_screens/get_room_step_one.dart';
import 'package:first_app_flutter/screens/user_screens/profile.dart';
import 'package:first_app_flutter/screens/user_screens/feedback.dart'
    as FeedbackScreen;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserHomeState extends StatefulWidget {
  const UserHomeState({Key? key}) : super(key: key);

  @override
  State createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State {
  int _currentIndex = 2;
  final List _children = [
    const Profile(),
    const GetRoom(),
    const UserHomeScreen(),
    const ChatScreen(),
    const FeedbackScreen.Feedback()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(
              icon: Icon(
                CupertinoIcons.person_alt,
                size: 22,
                color: Colors.white,
              ),
              title: 'Profile'),
          TabItem(
              icon: Icon(
                CupertinoIcons.book_fill,
                size: 22,
                color: Colors.white,
              ),
              title: 'Book'),
          TabItem(
              icon: Icon(
                CupertinoIcons.home,
                size: 22,
                color: Colors.white,
              ),
              title: 'Home'),
          TabItem(
              icon: Icon(
                CupertinoIcons.bubble_left_fill,
                size: 22,
                color: Colors.white,
              ),
              title: 'Chat'),
          TabItem(
              icon: Icon(
                CupertinoIcons.star_fill,
                size: 22,
                color: Colors.white,
              ),
              title: 'Feedbacks'),
        ],
        top: -20,
        initialActiveIndex: _currentIndex, //optional, default as 0
        onTap: onTabTapped,
        color: Colors.white,
        activeColor: const Color(0xFFF0972D),
        backgroundColor: const Color(0xFF124559),
        height: 50,
      ),
    );
  }
}
