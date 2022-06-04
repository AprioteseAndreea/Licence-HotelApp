import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/user_screens/contact_screen.dart';
import 'package:first_app_flutter/screens/user_screens/facilities.dart';
import 'package:first_app_flutter/screens/user_screens/feedback.dart'
    as feedback_screen;
import 'package:first_app_flutter/screens/user_screens/get_room_step_one.dart';
import 'package:first_app_flutter/screens/user_screens/my_bookings.dart';
import 'package:first_app_flutter/screens/user_screens/profile.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer(
      {Key? key,
      required this.gender,
      required this.name,
      required this.email,
      required this.old,
      required this.phoneNumber})
      : super(key: key);
  final String gender, name, email, old, phoneNumber;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gender == 'Male'
                    ? const CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFFF0972D),
                        child: CircleAvatar(
                            radius: 42,
                            backgroundImage:
                                AssetImage('assets/images/male2.png')))
                    : const CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFFF0972D),
                        child: CircleAvatar(
                            radius: 42,
                            backgroundImage:
                                AssetImage('assets/images/female.png'))),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF124559),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFfafafa),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.person_fill,
              color: Color(Strings.darkTurquoise),
            ),
            title: textWidget(Strings.profile),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            gender: gender,
                            name: name,
                            email: email,
                            old: old,
                            phoneNumber: phoneNumber,
                          )))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Color(Strings.orange),
            ),
            title: textWidget(Strings.bookNowSmall),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GetRoom()))
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.book_fill,
              color: Color(Strings.darkTurquoise),
            ),
            title: textWidget(Strings.myBookings),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBookings(
                            email: email,
                          )))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.spa,
              color: Color(Strings.orange),
            ),
            title: textWidget(Strings.facilities),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FacilitiesScreen()))
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.star_fill,
              color: Color(Strings.darkTurquoise),
            ),
            title: textWidget(Strings.feedbacks),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const feedback_screen.Feedback()))
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.location_fill,
              color: Color(Strings.orange),
            ),
            title: textWidget(Strings.contact),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Contact()))
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.square_arrow_right,
              color: Color(Strings.darkTurquoise),
            ),
            title: textWidget(Strings.logout),
            onTap: () async =>
                {firebaseAuth.signOut(), await loginProvider.logout()},
          ),
        ],
      ),
    );
  }

  Widget textWidget(String text) {
    return Text(text,
        style: TextStyle(
            fontSize: 16,
            color: Color(Strings.darkTurquoise),
            fontWeight: FontWeight.bold));
  }
}
