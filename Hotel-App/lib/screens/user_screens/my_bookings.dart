import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);
  @override
  _MyBookings createState() => _MyBookings();
}

class _MyBookings extends State<MyBookings> {
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
            'My Bookings',
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
