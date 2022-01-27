import 'package:first_app_flutter/models/user_model.dart' as UserModel;
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/homeScreens/side_bar/side_drawer.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/cupertino.dart';
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
  String? name, role, gender, email, old, phoneNumber;
  String profilePicture = "";
  AuthServices authServices = AuthServices();
  List<String> facilities = [];
  List<String> placeToVisitPath = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  GlobalKey globalKey = GlobalKey();
  bool isMenuOpen = false;
  @override
  void initState() {
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
        email = value.email;
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

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');
    final _gender = _prefs.getString('gender');
    final _old = _prefs.getString('old');
    final _phoneNumber = _prefs.getString('phoneNumber');
    if (_value != null) {
      setState(() {
        role = _value;
      });
    }
    if (_gender != null) {
      setState(() {
        gender = _gender;
      });
    }
    if (_old != null) {
      setState(() {
        old = _old;
      });
    }
    if (_phoneNumber != null) {
      setState(() {
        phoneNumber = _phoneNumber;
      });
    }
  }

  Color gradientStart = Colors.transparent;
  Color gradientEnd = Colors.black;
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final userService = Provider.of<UserService>(context);

    users = userService.getUsers();
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideDrawer(
        gender: gender ?? "",
        name: name ?? "",
        email: email ?? "",
        old: old ?? "",
        phoneNumber: phoneNumber ?? "",
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.square_arrow_right,
              size: 25,
            ),
            onPressed: () async => {await loginProvider.logout()},
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                CupertinoIcons.circle_grid_3x3_fill,
                size: 25,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Hi $name !',
                        style: const TextStyle(
                            fontSize: 23,
                            color: Color(0xFF124559),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/tourists.jpg",
                          height: 130,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Do you want to visit us?',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF124559),
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff124559),
                                    Color(0xff637e8d)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 150.0, minHeight: 30.0),
                              alignment: Alignment.center,
                              child: const Text(
                                "BOOK NOW",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Row(
                      children: const [
                        Text(
                          'Facilities',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF124559),
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
                          top: 10,
                          bottom: 20,
                        ),
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: facilities.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 90,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: const Color(0xFFFFFFFF),
                                  elevation: 5,
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
                    padding: const EdgeInsets.only(left: 15, top: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Places to visit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF124559),
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(
                              CupertinoIcons.arrow_right,
                              size: 20,
                            ),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        height: 170,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: placeToVisitPath.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 150,
                                child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    color: const Color(0xFFFFFFFF),
                                    elevation: 5,
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
                                            ).createShader(Rect.fromLTRB(0, -50,
                                                rect.width, rect.height));
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
              ]),
            )
          ],
        ),
      ),
    );
  }
}
