import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key, required this.gender, required this.name})
      : super(key: key);
  final String? gender, name;
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
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/female.png'))),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF124559),
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "view profile",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
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
            title: const Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(
              Icons.border_color,
              color: Color(0xFFF0972D),
            ),
            title: const Text('Book now'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.book_fill,
              color: Color(0xFF124559),
            ),
            title: const Text('My bookings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.bubble_left_fill,
              color: Color(0xFFF0972D),
            ),
            title: const Text('Chat'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.star_fill,
              color: Color(0xFF124559),
            ),
            title: const Text('Feedbacks'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.envelope_fill,
              color: Color(0xFFF0972D),
            ),
            title: const Text('Contact'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.square_arrow_right,
              color: Color(0xFF124559),
            ),
            title: const Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
