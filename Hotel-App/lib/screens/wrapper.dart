import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/screens/authentication/authentication.dart';
import 'package:first_app_flutter/screens/homeScreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/login.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final user = Provider.of<User?>(context);
    if(user != null){
      return HomeScreen();
    }else {
      return const Authentication();
    }
  }

}