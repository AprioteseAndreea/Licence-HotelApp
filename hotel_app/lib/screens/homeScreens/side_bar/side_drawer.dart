import 'package:first_app_flutter/screens/user_screens/contact_screen.dart';
import 'package:first_app_flutter/screens/user_screens/feedback.dart'
    as FeedbackScreen;
import 'package:first_app_flutter/screens/user_screens/get_room_step_one.dart';
import 'package:first_app_flutter/screens/user_screens/my_bookings.dart';
import 'package:first_app_flutter/screens/user_screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer(
      {Key? key,
      required this.gender,
      required this.name,
      required this.email,
      required this.old,
      required this.phoneNumber})
      : super(key: key);
  final String gender, name, email, old, phoneNumber;
  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(
              CupertinoIcons.person_fill,
              color: Color(0xFF124559),
            ),
            title: TextWidget('Profile'),
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
            leading: const Icon(
              Icons.border_color,
              color: Color(0xFFF0972D),
            ),
            title: TextWidget('Book now'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GetRoom()))
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.book_fill,
              color: Color(0xFF124559),
            ),
            title: TextWidget('My bookings'),
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
            leading: const Icon(
              CupertinoIcons.bubble_left_fill,
              color: Color(0xFFF0972D),
            ),
            title: TextWidget('Chat'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.star_fill,
              color: Color(0xFF124559),
            ),
            title: TextWidget('Feedbacks'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeedbackScreen.Feedback()))
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.envelope_fill,
              color: Color(0xFFF0972D),
            ),
            title: TextWidget('Contact'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Contact()))
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.square_arrow_right,
              color: Color(0xFF124559),
            ),
            title: TextWidget('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }

  Widget TextWidget(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF124559),
            fontWeight: FontWeight.bold));
  }
}
