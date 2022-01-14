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
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Chat',
            style: TextStyle(color: Color(0xFF124559)),
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
