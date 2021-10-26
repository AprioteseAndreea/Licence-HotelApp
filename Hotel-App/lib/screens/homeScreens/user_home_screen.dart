import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/user_model.dart' as UserModel;
import 'package:first_app_flutter/repository/user_repository.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  @override
  _UserHomeScreen createState() => _UserHomeScreen();
}

class _UserHomeScreen extends State<UserHomeScreen> {
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
    double menuContainerHeight = mediaQuery.height / 2;

    users = userService.getUsers();
    return SafeArea(
        child: Scaffold(
            body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(255, 65, 108, 1.0),
        Color.fromRGBO(255, 75, 73, 1.0)
      ])),
      width: mediaQuery.width,
      child: Stack(
        children: <Widget>[
          Text(
            'Hello $name',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Center(
            child: MaterialButton(
                color: Colors.white,
                child: const Text(
                  "Hello World",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {}),
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
                                    "assets/images/grand_hotel_logo2.jpeg",
                                    width: sidebarSize,
                                  ),
                                  const Text(
                                    "Andreea",
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 18),
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
                                  text: "My profile",
                                  iconData: Icons.person,
                                  textSize: getSize(0),
                                  height: (menuContainerHeight) / 8,
                                ),
                                MyButton(
                                  text: "Get a room",
                                  iconData: Icons.checkroom,
                                  textSize: getSize(1),
                                  height: (menuContainerHeight) / 8,
                                ),
                                MyButton(
                                  text: "My bookings",
                                  iconData: Icons.book,
                                  textSize: getSize(2),
                                  height: (mediaQuery.height / 2) / 8,
                                ),
                                MyButton(
                                  text: "Chat",
                                  iconData: Icons.chat_bubble,
                                  textSize: getSize(1),
                                  height: (mediaQuery.height / 2) / 8,
                                ),
                                MyButton(
                                  text: "Events",
                                  iconData: Icons.event,
                                  textSize: getSize(4),
                                  height: (menuContainerHeight) / 8,
                                ),
                                MyButton(
                                  text: "Menu",
                                  iconData: Icons.emoji_food_beverage,
                                  textSize: getSize(4),
                                  height: (menuContainerHeight) / 8,
                                ),
                                MyButton(
                                  text: "Settings",
                                  iconData: Icons.settings_applications_sharp,
                                  textSize: getSize(4),
                                  height: (menuContainerHeight) / 8,
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
                          color: Colors.black45,
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
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Row(
    //         children: [
    //           const Text(
    //             'Grand Hotel  ',
    //             style: TextStyle(
    //               fontSize: 16,
    //             ),
    //           ),
    //           Image.asset(
    //             'assets/images/stars.png',
    //             width: 60,
    //             height: 14,
    //           ),
    //         ],
    //       ),
    //       // leading: IconButton(
    //       //   icon: const Icon(Icons.menu_rounded),
    //       //   onPressed: () async => await loginProvider.logout(),
    //       // ),
    //       actions: [
    //         IconButton(
    //           icon: const Icon(Icons.perm_identity_outlined),
    //           onPressed: () async => await loginProvider.logout(),
    //         ),
    //         IconButton(
    //           icon: const Icon(Icons.exit_to_app),
    //           onPressed: () async => await loginProvider.logout(),
    //         )
    //       ],
    //     ),
    //     drawer: Drawer(
    //       child: ListView(
    //         children: const <Widget>[
    //           UserAccountsDrawerHeader(
    //               accountName: Text("Andreea"),
    //               accountEmail: Text("text@gmail.com"))
    //         ],
    //       ),
    //     ),
    //     body: Center(
    //       child: Column(
    //         children: <Widget>[
    //           Text('Buna: $name, your role is: $role '),
    //         ],
    //       ),
    //     ),
    //   );
  }
}

class MyButton extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final double? textSize;
  final double? height;

  MyButton({this.text, this.iconData, this.textSize, this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.black45,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text!,
            style: TextStyle(color: Colors.black45, fontSize: textSize),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}

class DrawerPainter extends CustomPainter {
  final Offset? offset;

  DrawerPainter({this.offset});

  double getControlPointX(double width) {
    if (offset!.dx == 0) {
      return width;
    } else {
      return offset!.dx > width ? offset!.dx : width + 75;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        getControlPointX(size.width), offset!.dy, size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
