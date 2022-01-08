import 'package:first_app_flutter/models/user_model.dart' as UserModel;
import 'package:first_app_flutter/screens/admin_screens/bookings.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/admin_screens/staff_screen.dart';
import 'package:first_app_flutter/screens/admin_screens/statistics.dart';
import 'package:first_app_flutter/screens/admin_screens/users_screen.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  @override
  _AdminHomeScreen createState() => _AdminHomeScreen();
}

class _AdminHomeScreen extends State<AdminHomeScreen> {
  UserService userService = UserService();
  late List<UserModel.User> users = [];
  AuthServices authServices = AuthServices();
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
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
                                      Image.asset(
                                        "assets/images/rooms.png",
                                        fit: BoxFit.cover,
                                        width: 40,
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
                                      Image.asset(
                                        "assets/images/bookings.png",
                                        fit: BoxFit.cover,
                                        width: 45,
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
                              builder: (context) => const UsersScreen(),
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
                                      Image.asset(
                                        "assets/images/users.png",
                                        fit: BoxFit.cover,
                                        width: 40,
                                      ),
                                      const Text(
                                        'USERS',
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
                              builder: (context) => const StaffScreen(),
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
                                      Image.asset(
                                        "assets/images/staff.png",
                                        fit: BoxFit.cover,
                                        width: 45,
                                      ),
                                      const Text(
                                        'STAFF',
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
                              builder: (context) => const Statistics(),
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
                                      Image.asset(
                                        "assets/images/statistics.png",
                                        fit: BoxFit.cover,
                                        width: 40,
                                      ),
                                      const Text(
                                        'STATISTICS',
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
                                      Image.asset(
                                        "assets/images/logout.png",
                                        fit: BoxFit.cover,
                                        width: 40,
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
