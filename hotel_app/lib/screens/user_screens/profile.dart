import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  AuthServices authServices = AuthServices();
  String name = "";
  //String photoURL = "";

  @override
  void initState() {
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
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
            'My Profile',
            style: TextStyle(color: Color(0xFF124559)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                  Image.asset(
                    'assets/images/hotel_front.jpg',
                    width: mediaQuery.width,
                  ),
                  const ProfilePicture(),
                ]),
                const SizedBox(height: 20),
                const Text('Andreea Apriotese'),
                OutlinedButton(
                  onPressed: () {
                    // uploadImage();
                  },
                  child: const Text('Update Profile Picture'),
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
