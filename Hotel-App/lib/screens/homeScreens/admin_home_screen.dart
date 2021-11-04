import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/user_model.dart' as UserModel;
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/homeScreens/side_bar/drawer_painter.dart';
import 'package:first_app_flutter/screens/homeScreens/side_bar/side_bar_button.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  @override
  _AdminHomeScreen createState() => _AdminHomeScreen();
}

class _AdminHomeScreen extends State<AdminHomeScreen> {
  UserService userService = UserService();
  late List<UserModel.User> users = [];
  String? name, role;
  AuthServices authServices = AuthServices();

  Offset _offset = const Offset(0, 0);
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];

  bool isMenuOpen = false;

  @override
  void initState() {
    limits = [0, 0, 0, 0, 0, 0];
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getPosition;
    });
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
    });
  }

  getPosition(duration) {
    RenderBox renderBox =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    double start = position.dy - 20;
    double contLimit = position.dy + renderBox.size.height - 20;
    double step = (contLimit - start) / 5;
    limits = [];
    for (double x = start; x <= contLimit; x = x + step) {
      limits.add(x);
    }
    setState(() {
      limits = limits;
    });
  }

  double getSize(int x) {
    double size =
        (_offset.dy > limits[x] && _offset.dy < limits[x + 1]) ? 25 : 20;
    return size;
  }

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');

    if (_value != null) {
      setState(() {
        role = _value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final userService = Provider.of<UserService>(context);

    Size mediaQuery = MediaQuery.of(context).size;
    double sidebarSize = mediaQuery.width * 0.65;
    double menuContainerHeight = mediaQuery.height / 1.5;

    users = userService.getUsers();
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
      width: mediaQuery.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10),
            child: Row(
              children: [
                Text(
                  'Hello $name',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: mediaQuery.width * 0.49),
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () async => await loginProvider.logout(),
                )
              ],
            ),
          ),
          Center(
            child: Stack(
              children: [
                Text("$role"),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
            left: isMenuOpen ? 0 : -sidebarSize + 20,
            top: 0,
            curve: Curves.elasticOut,
            child: SizedBox(
              width: sidebarSize,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.localPosition.dx <= sidebarSize) {
                    setState(() {
                      _offset = details.localPosition;
                    });
                  }

                  if (details.localPosition.dx > sidebarSize - 20 &&
                      details.delta.distanceSquared > 2) {
                    setState(() {
                      isMenuOpen = true;
                    });
                  }
                },
                onPanEnd: (details) {
                  setState(() {
                    _offset = const Offset(0, 0);
                  });
                },
                child: Stack(
                  children: <Widget>[
                    CustomPaint(
                      size: Size(sidebarSize, mediaQuery.height),
                      painter: DrawerPainter(offset: _offset),
                    ),
                    SizedBox(
                      height: mediaQuery.height,
                      width: sidebarSize,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(
                            height: mediaQuery.height * 0.20,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/grand_hotel_logo-removebg-2.png",
                                    width: sidebarSize / 1.2,
                                  ),
                                  Text(
                                    "$name",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            key: globalKey,
                            width: double.infinity,
                            height: menuContainerHeight,
                            child: Column(
                              children: <Widget>[
                                MyButton(
                                  text: "Rooms",
                                  iconData: Icons.checkroom,
                                  textSize: getSize(0),
                                  height: (mediaQuery.height / 2) / 6,
                                  onPressed: () {},
                                ),
                                MyButton(
                                  text: "Facilities",
                                  iconData: Icons.spa,
                                  textSize: getSize(1),
                                  height: (mediaQuery.height / 2) / 6,
                                ),
                                MyButton(
                                  text: "Events",
                                  iconData: Icons.event,
                                  textSize: getSize(2),
                                  height: (mediaQuery.height / 2) / 6,
                                ),
                                MyButton(
                                  text: "Menu",
                                  iconData: Icons.emoji_food_beverage,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 6,
                                ),
                                MyButton(
                                  text: "Bookings",
                                  iconData: Icons.book,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 6,
                                ),
                                MyButton(
                                  text: "Users",
                                  iconData: Icons.people,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 6,
                                ),
                                MyButton(
                                  text: "Staff",
                                  iconData: Icons.work,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 6,
                                ),
                                MyButton(
                                  text: "Statistics",
                                  iconData: Icons.auto_graph_sharp,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 6,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 400),
                      right: (isMenuOpen) ? 10 : sidebarSize,
                      bottom: 30,
                      child: IconButton(
                        enableFeedback: true,
                        icon: const Icon(
                          Icons.keyboard_backspace,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            isMenuOpen = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    )));
  }
}
