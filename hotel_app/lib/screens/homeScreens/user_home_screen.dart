import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/user_model.dart' as user_model;
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/screens/user_screens/facilities.dart';
import 'package:first_app_flutter/screens/user_screens/get_room_step_one.dart';
import 'package:first_app_flutter/utils/side_bar/side_drawer.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../wrapper.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  @override
  _UserHomeScreen createState() => _UserHomeScreen();
}

class _UserHomeScreen extends State<UserHomeScreen> {
  UserService userService = UserService();
  late List<user_model.User> users = [];
  String? name, role, gender, email, old, phoneNumber;
  String profilePicture = "";
  AuthServices authServices = AuthServices();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<String> facilities = [];
  List<String> placeToVisitPath = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey globalKey = GlobalKey();
  bool isMenuOpen = false;
  @override
  void initState() {
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
        email = value.email;
        phoneNumber = value.photoURL;
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

    placeToVisitPath.add(
        "https://images.unsplash.com/photo-1545671953-0e564e4838a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8&w=1000&q=80");
    placeToVisitPath.add(
        "https://img.freepik.com/free-photo/lake-central-park-new-york-usa_1268-14965.jpg?w=2000");
    placeToVisitPath.add(
        "https://cdn.sanity.io/images/bs9rmafh/main/339ff10691f4eec5f3aac374d8d79dea34f78718-6000x4000.jpg?w=1600&h=1067&fit=crop");
    placeToVisitPath
        .add("https://media.timeout.com/images/105813641/750/422/image.jpg");
    placeToVisitPath.add(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Empire_State_Building_from_the_Top_of_the_Rock.jpg/447px-Empire_State_Building_from_the_Top_of_the_Rock.jpg");
    placeToVisitPath.add(
        "https://cdn.britannica.com/66/154566-050-36E73C15/Times-Square-New-York-City.jpg");
    placeToVisitPath.add(
        "https://img-lumas-avensogmbh1.netdna-ssl.com/showimg_rja21_search.jpg");
  }

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');
    final _gender = _prefs.getString('gender');
    final _old = _prefs.getString('old');
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
  }

  Color gradientStart = Colors.transparent;
  Color gradientEnd = Colors.black;
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final userService = Provider.of<UserService>(context);
    Size mediaQuery = MediaQuery.of(context).size;

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
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.square_arrow_right,
              size: 25,
            ),
            onPressed: () async => {
              await loginProvider.logout(),
              Navigator.pop(context),
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wrapper(),
                  ),
                  ModalRoute.withName('/'))
            },
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
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: const Color(0xFFFFFFFF),
                  elevation: 5,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Text(
                                'Hi $name!',
                                style: TextStyle(
                                    fontSize: mediaQuery.width * 0.055,
                                    color: Color(Strings.darkTurquoise),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Strings.doYouWantToVisitUs,
                                  style: TextStyle(
                                    fontSize: mediaQuery.width * 0.04,
                                    color: Color(Strings.darkTurquoise),
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const GetRoom()));
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(Strings.darkTurquoise),
                                            Color(Strings.lightGrey)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: mediaQuery.width * 0.4,
                                          minHeight: mediaQuery.height * 0.04),
                                      alignment: Alignment.center,
                                      child: Text(
                                        Strings.bookNow,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: mediaQuery.width * 0.04),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/toursist.jpg",
                                  width: mediaQuery.width * 0.35,
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.facilities,
                          style: TextStyle(
                              fontSize: mediaQuery.width * 0.045,
                              color: Color(Strings.darkTurquoise),
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FacilitiesScreen())),
                          },
                          child: Row(
                            children: [
                              Text(
                                Strings.viewInfo,
                                style: TextStyle(
                                    fontSize: mediaQuery.width * 0.042,
                                    color: Color(Strings.darkTurquoise),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Icon(
                                CupertinoIcons.arrow_right,
                                size: 20,
                              ),
                            ],
                          ),
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
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 5, right: 5),
                        height: mediaQuery.height * 0.18,
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: facilities.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: mediaQuery.width * 0.22,
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
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          facilities[index].toString(),
                                          fit: BoxFit.cover,
                                          width: mediaQuery.width * 0.1,
                                        ),
                                        Text(
                                          Strings.facilitiesLabel[index]
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  mediaQuery.width * 0.032),
                                          textAlign: TextAlign.center,
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
                      children: [
                        Text(
                          Strings.placesToVisitTitle,
                          style: TextStyle(
                              fontSize: mediaQuery.width * 0.045,
                              color: Color(Strings.darkTurquoise),
                              fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        height: mediaQuery.height * 0.3,
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: placeToVisitPath.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: mediaQuery.width * 0.35,
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
                                                image: NetworkImage(
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
                                                Strings.placesToVisit[index]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: mediaQuery.width *
                                                        0.036,
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
