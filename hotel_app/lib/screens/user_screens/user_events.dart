import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserEvents extends StatefulWidget {
  const UserEvents({Key? key}) : super(key: key);
  @override
  _UserEvents createState() => _UserEvents();
}

class _UserEvents extends State<UserEvents> {
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
            'Events',
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
