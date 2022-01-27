import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile(
      {Key? key,
      this.gender,
      this.name,
      this.email,
      this.old,
      this.phoneNumber})
      : super(key: key);
  final String? gender;
  final String? name;
  final String? email;
  final String? old;
  final String? phoneNumber;

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  AuthServices authServices = AuthServices();
  // String name = "";
  //String photoURL = "";

  @override
  void initState() {
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        //  name = value!.displayName!;
        // photoURL = value.photoURL!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Color(0xFF124559)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      super.widget.gender == 'Male'
                          ? const CircleAvatar(
                              radius: 42,
                              backgroundColor: Color(0xFFF0972D),
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/images/male2.png')))
                          : const CircleAvatar(
                              radius: 42,
                              backgroundColor: Color(0xFFF0972D),
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/images/female.png'))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: const Color(0xFFFFFFFF),
                        elevation: 10,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: Text(
                                  super.widget.name ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color(0xFF124559),
                                  ),
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/goldmedal.png",
                            height: 44,
                          ),
                          const Text(
                            "GOLD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF124559),
                            ),
                          ),
                          const Text(
                            " - 12 Bookings",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF124559),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: const Color(0xFFFFFFFF),
                          elevation: 10,
                          child: SizedBox(
                            width: mediaQuery.width * 0.9,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.person_fill,
                                      color: Color(0xFF124559),
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Full Name",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      super.widget.name ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF124559),
                                      ),
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: const Color(0xFFFFFFFF),
                                      elevation: 5,
                                      child: const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Icon(
                                          CupertinoIcons.pencil,
                                          color: Color(0xFFF0972D),
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.envelope_fill,
                                      color: Color(0xFF124559),
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Email",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      super.widget.email ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF124559),
                                      ),
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.phone_fill,
                                      color: Color(0xFF124559),
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Phone number",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      super.widget.phoneNumber ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF124559),
                                      ),
                                    ),
                                    Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: const Color(0xFFFFFFFF),
                                      elevation: 5,
                                      child: const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Icon(
                                          CupertinoIcons.pencil,
                                          color: Color(0xFFF0972D),
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.calendar,
                                      color: Color(0xFF124559),
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Account created at",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      super.widget.old ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF124559),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFff8b00), Color(0xFFf1c796)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 150.0, minHeight: 35.0),
                            alignment: Alignment.center,
                            child: const Text(
                              "Update profile",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return const CircleAvatar(
      radius: 48,
      child: Icon(
        Icons.people_alt_rounded,
      ),
    );
  }
}
