import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/screens/authentication/authentication.dart';
import 'package:first_app_flutter/screens/authentication/login.dart';
import 'package:first_app_flutter/screens/homeScreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  _Wrapper createState() => _Wrapper();
}

class _Wrapper extends State<Wrapper> {
  String? role;

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
    final user = Provider.of<User?>(context);
    if (user != null) {
      return const HomeScreen();
    } else {
      return const Login();
    }
  }
}
