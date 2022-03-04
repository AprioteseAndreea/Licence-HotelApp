import 'package:first_app_flutter/models/user_model.dart' as user_model;
import 'package:first_app_flutter/screens/authentication/authentication.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/homeScreens/staff_home_screen.dart';
import 'package:first_app_flutter/screens/homeScreens/user_screen_state.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  UserService userService = UserService();
  late List<user_model.User> users = [];
  String? role;
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readRole();
    });
  }

  Future<void> _readRole() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');

    if (_value != null) {
      setState(() {
        role = _value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case 'user':
        return const UserHomeState();
      case 'admin':
        return const AdminHomeScreen();
      case 'staff':
        return const StaffHomeScreen();
      default:
        return const Authentication();
    }
  }
}
