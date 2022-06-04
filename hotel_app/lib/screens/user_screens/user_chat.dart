import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserChat extends StatefulWidget {
  const UserChat({Key? key}) : super(key: key);
  @override
  _UserChat createState() => _UserChat();
}

class _UserChat extends State<UserChat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(Strings.darkTurquoise), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            Strings.chat,
            style: TextStyle(color: Color(Strings.darkTurquoise)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: const [],
            ),
          ),
        ));
  }
}
