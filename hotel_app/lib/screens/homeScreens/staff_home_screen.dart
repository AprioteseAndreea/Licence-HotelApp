import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/user_model.dart' as user_model;
import 'package:first_app_flutter/screens/admin_screens/bookings_screens.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/screens/staff_screens/book_staff.dart';
import 'package:first_app_flutter/screens/staff_screens/posts.dart';
import 'package:first_app_flutter/screens/staff_screens/staff_profile.dart';
import 'package:first_app_flutter/utils/strings.dart';
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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    name = firebaseAuth.currentUser!.displayName;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readData();
    });
    super.initState();
  }

  Future<void> _readData() async {
    final _prefs = await SharedPreferences.getInstance();
    String? _gender = _prefs.getString('gender');

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
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Color(0xFF124559),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Strings.applicationTitle,
                      style: TextStyle(color: Color(Strings.darkTurquoise))),
                  Image.asset(
                    'assets/images/stars.png',
                    height: 15,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.square_arrow_right,
                    size: 25,
                  ),
                  onPressed: () async =>
                      {firebaseAuth.signOut(), await loginProvider.logout()},
                ),
              ],
            ),
            body: SizedBox(
              width: mediaQuery.width,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color(0xFFFFFFFF),
                    elevation: 10,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Hello " + name! + "!",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF124559),
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          leading: gender == Strings.female
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 4),
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                          'assets/images/femalestaff.jpg')))
                              : const Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 4),
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                          'assets/images/malestaff.jpg'))),
                        ),
                        CalendarTimeline(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022, 1, 1),
                          lastDate: DateTime(2022, 12, 31),
                          onDateSelected: (date) => print(date),
                          leftMargin: 20,
                          monthColor: Color(Strings.darkTurquoise),
                          dayColor: Color(Strings.lightBlue),
                          activeDayColor: Colors.white,
                          dotsColor: Color(Strings.lightTurquoise),
                          activeBackgroundDayColor:
                              Color(Strings.lightTurquoise),
                          selectableDayPredicate: (date) => date.day != 32,
                          locale: 'en_ISO',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
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
                                      builder: (context) =>
                                          const StaffProfile(),
                                    ),
                                  )
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  shadowColor: Color(Strings.darkTurquoise),
                                  elevation: 10,
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
                                                color: Color(
                                                    Strings.darkTurquoise),
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
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  shadowColor: Color(Strings.darkTurquoise),
                                  elevation: 10,
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
                                                color: Color(
                                                    Strings.darkTurquoise),
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
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  shadowColor: Color(Strings.darkTurquoise),
                                  elevation: 10,
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
                                                color: Color(
                                                    Strings.darkTurquoise),
                                                size: mediaQuery.width * 0.085,
                                              ),
                                              Text(
                                                Strings.roomsCapital,
                                                style: TextStyle(
                                                    color:
                                                        Color(Strings.orange),
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
                                      builder: (context) =>
                                          const BookingsScreen(),
                                    ),
                                  )
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  shadowColor: Color(Strings.darkTurquoise),
                                  elevation: 10,
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
                                                color: Color(
                                                    Strings.darkTurquoise),
                                                size: mediaQuery.width * 0.085,
                                              ),
                                              Text(
                                                Strings.bookings.toUpperCase(),
                                                style: TextStyle(
                                                    color:
                                                        Color(Strings.orange),
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
                                          builder: (context) =>
                                              const BookStaff())),
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  shadowColor: Color(Strings.darkTurquoise),
                                  elevation: 10,
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
                                                color: Color(
                                                    Strings.darkTurquoise),
                                                size: mediaQuery.width * 0.085,
                                              ),
                                              Text(
                                                Strings.bookNow,
                                                style: TextStyle(
                                                    color:
                                                        Color(Strings.orange),
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
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  shadowColor: Color(Strings.darkTurquoise),
                                  elevation: 10,
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
                                                color: Color(
                                                    Strings.darkTurquoise),
                                                size: mediaQuery.width * 0.085,
                                              ),
                                              Text(
                                                Strings.logout.toUpperCase(),
                                                style: TextStyle(
                                                    color:
                                                        Color(Strings.orange),
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
