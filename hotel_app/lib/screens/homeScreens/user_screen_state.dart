import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/homeScreens/user_home_screen.dart';
import 'package:first_app_flutter/screens/user_screens/contact_screen.dart';
import 'package:first_app_flutter/screens/user_screens/get_room_step_one.dart';
import 'package:first_app_flutter/screens/user_screens/profile.dart';
import 'package:first_app_flutter/screens/user_screens/feedback.dart'
    as feedback_screen;
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeState extends StatefulWidget {
  const UserHomeState({Key? key}) : super(key: key);

  @override
  State createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeState> {
  int _currentIndex = 2;
  String? name, role, gender, email, old, phoneNumber;
  AuthServices authServices = AuthServices();

  final List _children = [];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
        email = value.email;
        phoneNumber = value.photoURL;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
    });
  }

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');
    final _gender = _prefs.getString('gender');
    final _old = _prefs.getString('old');

    if (_value != null) {
      setState(() {
        role = _value;
      });
    }
    if (_gender != null) {
      setState(() {
        gender = _gender;
      });
    }
    if (_old != null) {
      setState(() {
        old = _old;
      });
    }
  }

  Future<void> _readData() async {
    _children.add(
      Profile(
        gender: gender,
        name: name,
        email: email,
        old: old,
        phoneNumber: phoneNumber,
      ),
    );
    _children.add(const GetRoom());
    _children.add(const UserHomeScreen());
    _children.add(const feedback_screen.Feedback());
    _children.add(const Contact());
  }

  @override
  void initState() {
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
        email = value.email;
        phoneNumber = value.photoURL;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
      await _readData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.isNotEmpty
          ? _children[_currentIndex]
          : const CircularProgressIndicator(),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
              icon: const Icon(
                CupertinoIcons.person_alt,
                size: 22,
                color: Colors.white,
              ),
              title: Strings.profile),
          TabItem(
              icon: const Icon(
                CupertinoIcons.book_fill,
                size: 22,
                color: Colors.white,
              ),
              title: Strings.book),
          TabItem(
              icon: const Icon(
                CupertinoIcons.home,
                size: 22,
                color: Colors.white,
              ),
              title: Strings.home),
          TabItem(
              icon: const Icon(
                CupertinoIcons.star_fill,
                size: 22,
                color: Colors.white,
              ),
              title: Strings.feedbacks),
          TabItem(
              icon: const Icon(
                CupertinoIcons.location,
                size: 22,
                color: Colors.white,
              ),
              title: Strings.contact),
        ],
        top: -20,
        initialActiveIndex: _currentIndex, //optional, default as 0
        onTap: onTabTapped,
        color: Colors.white,
        activeColor: Color(Strings.orange),
        backgroundColor: Color(Strings.darkTurquoise),
        height: 50,
      ),
    );
  }
}
