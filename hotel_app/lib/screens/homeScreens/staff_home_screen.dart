import 'package:first_app_flutter/models/user_model.dart' as user_model;
import 'package:first_app_flutter/screens/admin_screens/bookings.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/screens/staff_screens/book_staff.dart';
import 'package:first_app_flutter/screens/staff_screens/posts.dart';
import 'package:first_app_flutter/screens/staff_screens/staff_profile.dart';
import 'package:first_app_flutter/screens/user_screens/facilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({Key? key}) : super(key: key);
  @override
  _StaffHomeScreen createState() => _StaffHomeScreen();
}

class _StaffHomeScreen extends State<StaffHomeScreen> {
  UserService userService = UserService();
  late List<user_model.User> users = [];
  String? name, role, gender;
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readData();
    });
    super.initState();
  }

  Future<void> _readData() async {
    final _prefs = await SharedPreferences.getInstance();
    String? _value = _prefs.getString('role');
    String? _name = _prefs.getString('name');
    String? _gender = _prefs.getString('gender');

    if (_value != null) {
      setState(() {
        role = _value;
      });
    }
    if (_name != null) {
      setState(() {
        name = _name;
      });
    }
    if (_gender != null) {
      setState(() {
        gender = _gender;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    Size mediaQuery = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthServices>(context);

    users = userService.getUsers();
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
      width: mediaQuery.width,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Image.asset('assets/images/grand_hotel_logo4.jpg'),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StaffProfile(),
                            ),
                          )
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color(0xFF124559),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: mediaQuery.height * 0.15,
                                width: mediaQuery.width * 0.35,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.account_circle_rounded,
                                        color: Colors.white,
                                        size: mediaQuery.width * 0.085,
                                      ),
                                      const Text(
                                        'MY PROFILE',
                                        style: TextStyle(
                                            color: Color(0xFFF0972D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Posts(),
                            ),
                          )
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color(0xFF124559),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: mediaQuery.height * 0.15,
                                width: mediaQuery.width * 0.35,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.chat_rounded,
                                        color: Colors.white,
                                        size: mediaQuery.width * 0.085,
                                      ),
                                      const Text(
                                        'POSTS',
                                        style: TextStyle(
                                            color: Color(0xFFF0972D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Rooms(),
                            ),
                          )
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color(0xFF124559),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: mediaQuery.height * 0.15,
                                width: mediaQuery.width * 0.35,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.bed_sharp,
                                        color: Colors.white,
                                        size: mediaQuery.width * 0.085,
                                      ),
                                      const Text(
                                        'ROOMS',
                                        style: TextStyle(
                                            color: Color(0xFFF0972D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Bookings(),
                            ),
                          )
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color(0xFF124559),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: mediaQuery.height * 0.15,
                                width: mediaQuery.width * 0.35,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.auto_stories_rounded,
                                        color: Colors.white,
                                        size: mediaQuery.width * 0.085,
                                      ),
                                      const Text(
                                        'BOOKINGS',
                                        style: TextStyle(
                                            color: Color(0xFFF0972D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BookStaff())),
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color(0xFF124559),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: mediaQuery.height * 0.15,
                                width: mediaQuery.width * 0.35,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.create,
                                        color: Colors.white,
                                        size: mediaQuery.width * 0.085,
                                      ),
                                      const Text(
                                        'BOOK NOW',
                                        style: TextStyle(
                                            color: Color(0xFFF0972D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async => await loginProvider.logout(),
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color(0xFF124559),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: mediaQuery.height * 0.15,
                                width: mediaQuery.width * 0.35,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                        size: mediaQuery.width * 0.085,
                                      ),
                                      const Text(
                                        'LOGOUT',
                                        style: TextStyle(
                                            color: Color(0xFFF0972D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
