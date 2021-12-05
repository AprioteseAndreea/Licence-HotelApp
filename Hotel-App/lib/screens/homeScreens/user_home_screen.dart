import 'package:first_app_flutter/models/user_model.dart' as UserModel;
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/homeScreens/side_bar/drawer_painter.dart';
import 'package:first_app_flutter/screens/homeScreens/side_bar/side_bar_button.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/screens/user_screens/bookings.dart';
import 'package:first_app_flutter/screens/user_screens/feedback.dart'
    as FeedbackScreen;
import 'package:first_app_flutter/screens/user_screens/get_room_step_one.dart';
import 'package:first_app_flutter/screens/user_screens/menu.dart';
import 'package:first_app_flutter/screens/user_screens/profile.dart';
import 'package:first_app_flutter/screens/user_screens/settings.dart';
import 'package:first_app_flutter/screens/user_screens/user_chat.dart';
import 'package:first_app_flutter/screens/user_screens/user_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  @override
  _UserHomeScreen createState() => _UserHomeScreen();
}

class _UserHomeScreen extends State<UserHomeScreen> {
  UserService userService = UserService();
  late List<UserModel.User> users = [];
  String? name, role;
  String profilePicture = "";
  AuthServices authServices = AuthServices();
  List<String> facilities = [];
  List<String> placeToVisitPath = [];

  List<String> facilitiesLabel = [
    "Spa",
    "Restaurant",
    "Pool",
    "Babysitter",
    "Car parking",
    "Pet Friendly"
  ];
  List<String> placesToVisit = [
    "Statue of Liberty",
    "Central Park",
    "Rockefeller Center",
    "Metropolitan Museum of Art",
    "Empire State Building",
    "Times Square",
    "Brooklyn Bridge"
  ];

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
        profilePicture = value.photoURL!;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
    });

    facilities.add("assets/images/spa.png");
    facilities.add("assets/images/restaurant.png");
    facilities.add("assets/images/pool.png");
    facilities.add("assets/images/babysitter.png");
    facilities.add("assets/images/car.png");
    facilities.add("assets/images/pet.png");

    placeToVisitPath.add("assets/images/ptv1.jpg");
    placeToVisitPath.add("assets/images/ptv2.jpg");
    placeToVisitPath.add("assets/images/ptv3.jpg");
    placeToVisitPath.add("assets/images/ptv4.jpg");
    placeToVisitPath.add("assets/images/ptv5.jpg");
    placeToVisitPath.add("assets/images/ptv6.jpg");
    placeToVisitPath.add("assets/images/ptv7.jpg");
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

  Color gradientStart = Colors.transparent;
  Color gradientEnd = Colors.black;
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
            padding: const EdgeInsets.only(left: 25, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome $name !',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage("assets/images/hotel_front.jpg"),
                        fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(EvaIcons.power),
                  onPressed: () async => await loginProvider.logout(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Text(
                    'Do you want to visit us?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetRoom(),
                          ),
                        )
                      },
                      height: 27,
                      minWidth: 75,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Book now",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 105, right: 5),
                child: Column(
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 25,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 170.0,
                            child: Image.asset(
                              "assets/images/boston2.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25, top: 20),
                  child: Row(
                    children: const [
                      Text(
                        'Facilities',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 20, right: 5),
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: facilities.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.22,
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                color: const Color(0xFFFFFFFF),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        facilities[index].toString(),
                                        fit: BoxFit.cover,
                                        width: 35,
                                      ),
                                      Text(
                                        facilitiesLabel[index].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25, top: 5),
                  child: Row(
                    children: const [
                      Text(
                        'Places to visited',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 20, right: 5),
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: placeToVisitPath.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  child: Stack(
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (rect) {
                                          return LinearGradient(
                                            begin: Alignment.center,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              gradientStart,
                                              gradientEnd
                                            ],
                                          ).createShader(Rect.fromLTRB(
                                              0, -50, rect.width, rect.height));
                                        },
                                        blendMode: BlendMode.darken,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: ExactAssetImage(
                                                  placeToVisitPath[index]
                                                      .toString()),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 5),
                                            child: Text(
                                              placesToVisit[index].toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
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
                                  text: "My profile",
                                  iconData: Icons.person,
                                  textSize: getSize(0),
                                  height: (mediaQuery.height / 2) / 7,
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Profile(),
                                      ),
                                    )
                                  },
                                ),
                                MyButton(
                                  text: "Get a room",
                                  iconData: Icons.checkroom,
                                  textSize: getSize(1),
                                  height: (mediaQuery.height / 2) / 7,
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const GetRoom(),
                                      ),
                                    )
                                  },
                                ),
                                MyButton(
                                  text: "My bookings",
                                  iconData: Icons.bed,
                                  textSize: getSize(2),
                                  height: (mediaQuery.height / 2) / 7,
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Bookings(),
                                      ),
                                    )
                                  },
                                ),
                                MyButton(
                                  text: "Chat",
                                  iconData: Icons.chat_bubble,
                                  textSize: getSize(1),
                                  height: (mediaQuery.height / 2) / 7,
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const UserChat(),
                                      ),
                                    )
                                  },
                                ),
                                MyButton(
                                  text: "Events",
                                  iconData: Icons.event,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 7,
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UserEvents(),
                                      ),
                                    )
                                  },
                                ),
                                MyButton(
                                  text: "Feedback",
                                  iconData: Icons.feedback,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 7,
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const FeedbackScreen.Feedback(),
                                      ),
                                    )
                                  },
                                ),
                                MyButton(
                                  text: "Settings",
                                  iconData: Icons.settings,
                                  textSize: getSize(4),
                                  height: (mediaQuery.height / 2) / 7,
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Settings(),
                                      ),
                                    )
                                  },
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
                      bottom: mediaQuery.height * 0.07,
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
