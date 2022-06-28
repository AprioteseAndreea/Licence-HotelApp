import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/homeScreens/user_screen_state.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late TextEditingController _fullNameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  UserService userService = UserService();
  final formkey = GlobalKey<FormState>();

  late bool _fullNameIsEnable = false;
  late bool _phoneIsEnable = false;

  @override
  void initState() {
    _fullNameController = TextEditingController(text: super.widget.name);
    _phoneController = TextEditingController(text: super.widget.phoneNumber);
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        //  name = value!.displayName!;
        // photoURL = value.photoURL!;
      });
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int reserv = ReservationService.numberOfReservations;
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
          actions: [
            IconButton(
              icon: const Icon(
                Icons.save,
                size: 30,
              ),
              onPressed: () => {
                if (formkey.currentState!.validate())
                  {
                    _saveProfileData(),
                  }
              },
            ),
          ],
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
                          ranking((reserv).round()),
                        ],
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formkey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                                    children: [
                                      Icon(
                                        CupertinoIcons.person_fill,
                                        color: Color(Strings.darkTurquoise),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          Strings.fullName,
                                          style: const TextStyle(
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
                                      Expanded(
                                        child: TextFormField(
                                          controller: _fullNameController,
                                          enabled: _fullNameIsEnable,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Color(Strings.darkTurquoise),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: const Color(0xFFFFFFFF),
                                        elevation: 5,
                                        child: SizedBox(
                                          width: 35,
                                          height: 35,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _fullNameIsEnable = true;
                                              });
                                            },
                                            icon: Icon(
                                              CupertinoIcons.pencil,
                                              color: Color(Strings.orange),
                                              size: 25,
                                            ),
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
                                    children: [
                                      Icon(
                                        CupertinoIcons.envelope_fill,
                                        color: Color(Strings.darkTurquoise),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          Strings.email,
                                          style: const TextStyle(
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
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(Strings.darkTurquoise),
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
                                    children: [
                                      Icon(
                                        CupertinoIcons.phone_fill,
                                        color: Color(Strings.darkTurquoise),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          Strings.phoneNumber,
                                          style: const TextStyle(
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
                                      Expanded(
                                        child: TextFormField(
                                          controller: _phoneController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validator: (val) {
                                            if (val!.length != 10) {
                                              return Strings
                                                  .phoneNumberValidation;
                                            }
                                            return null;
                                          },
                                          enabled: _phoneIsEnable,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Color(Strings.darkTurquoise),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: const Color(0xFFFFFFFF),
                                        elevation: 5,
                                        child: SizedBox(
                                          width: 35,
                                          height: 35,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _phoneIsEnable = true;
                                              });
                                            },
                                            icon: Icon(
                                              CupertinoIcons.pencil,
                                              color: Color(Strings.orange),
                                              size: 25,
                                            ),
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
                                    children: [
                                      Icon(
                                        CupertinoIcons.calendar,
                                        color: Color(Strings.darkTurquoise),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          Strings.accountCreatedAt,
                                          style: const TextStyle(
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
                                        "Feb 21, 2020",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(Strings.darkTurquoise),
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
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _saveProfileData() async {
    var user = firebaseAuth.currentUser;
    await user!.updateDisplayName(_fullNameController.text);
    await user.updatePhotoURL(_phoneController.text);

    await userService.updateUserInFirebase(
        super.widget.email!, _fullNameController.text, _phoneController.text);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully saved"),
    ));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const UserHomeState()),
        (Route<dynamic> route) => false);
  }

  Widget ranking(int noOfReservations) {
    if (noOfReservations < 3) {
      return Row(
        children: [
          Image.asset(
            "assets/images/bronzemedal.png",
            height: 44,
          ),
          const Text(
            "BRONZE - ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF124559),
            ),
          ),
          Text(
            '${noOfReservations.toString()} BOOKINGS',
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF124559),
            ),
          ),
        ],
      );
    } else if (noOfReservations >= 3 && noOfReservations <= 9) {
      return Row(
        children: [
          Image.asset(
            "assets/images/silvermedal.png",
            height: 44,
          ),
          const Text(
            "SILVER - ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF124559),
            ),
          ),
          Text(
            '${noOfReservations.toString()} BOOKINGS',
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF124559),
            ),
          ),
        ],
      );
    } else if (noOfReservations >= 10) {
      return Row(
        children: [
          Image.asset(
            "assets/images/goldmedal.png",
            height: 44,
          ),
          const Text(
            "GOLD - ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF124559),
            ),
          ),
          Text(
            '${noOfReservations.toString()} BOOKINGS',
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF124559),
            ),
          ),
        ],
      );
    }
    return const SizedBox(
      height: 0,
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 48,
      child: Icon(
        Icons.people_alt_rounded,
      ),
    );
  }
}
