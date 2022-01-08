import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'avatar.dart';

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
