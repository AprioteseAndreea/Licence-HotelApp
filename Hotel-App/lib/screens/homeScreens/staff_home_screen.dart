import 'package:first_app_flutter/models/user_model.dart' as UserModel;
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
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
  late List<UserModel.User> users = [];
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const Rooms(),
                          //   ),
                          // )
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
                                        width: 40,
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const Bookings(),
                          //   ),
                          // )
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const UsersScreen(),
                          //   ),
                          // )
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const Rooms(),
                          //   ),
                          // )
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
                                        "assets/images/chat.png",
                                        fit: BoxFit.cover,
                                        width: 45,
                                      ),
                                      const Text(
                                        'CHAT',
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const Rooms(),
                          //   ),
                          // )
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
