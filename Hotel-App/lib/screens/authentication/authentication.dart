import 'package:first_app_flutter/screens/authentication/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isToggle = false;
  void toggleScreen(){
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
   if(isToggle){
     return Register(toggleScreen: toggleScreen);
    }else{
     return Login(toggleScreen: toggleScreen);
   }
  }
}
