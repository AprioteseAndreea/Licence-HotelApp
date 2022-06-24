import 'package:first_app_flutter/screens/homeScreens/home_screen.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isPressed = false;
  bool isToggle = false;

  void forgotPressed() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return const Login();
  }
}
