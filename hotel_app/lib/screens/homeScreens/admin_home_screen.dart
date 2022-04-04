import 'package:first_app_flutter/models/user_model.dart' as user_model;
import 'package:first_app_flutter/screens/admin_screens/bookings.dart';
import 'package:first_app_flutter/screens/admin_screens/home_card.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/admin_screens/staff_screen.dart';
import 'package:first_app_flutter/screens/admin_screens/statistics.dart';
import 'package:first_app_flutter/screens/admin_screens/users_screen.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  @override
  _AdminHomeScreen createState() => _AdminHomeScreen();
}

class _AdminHomeScreen extends State<AdminHomeScreen> {
  UserService userService = UserService();
  late List<user_model.User> users = [];
  AuthServices authServices = AuthServices();
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userService = Provider.of<UserService>(context);
    Size mediaQuery = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthServices>(context);

    //users = userService.getUsers();
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
      width: mediaQuery.width,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: mediaQuery.height * 0.040,
          ),
          CircleAvatar(
              radius: mediaQuery.height * 0.055,
              backgroundColor: Color(Strings.orange),
              child: CircleAvatar(
                  radius: mediaQuery.height * 0.050,
                  backgroundImage:
                      const AssetImage('assets/images/adminphoto.jpg'))),
          SizedBox(
            height: mediaQuery.height * 0.040,
          ),
          Text(
            Strings.adminMode,
            style: TextStyle(
                color: Color(Strings.darkTurquoise),
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.width * 0.050),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Manage your business with a simple click away.',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: mediaQuery.width * 0.048, color: Colors.grey),
            maxLines: 2,
          ),
          SizedBox(
            height: mediaQuery.height * 0.045,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeCard(
                        title: "ROOMS",
                        imageUrl: "assets/images/rooms.png",
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Rooms(),
                            ),
                          )
                        },
                      ),
                      HomeCard(
                        title: "BOOKINGS",
                        imageUrl: "assets/images/bookings.png",
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Bookings(),
                            ),
                          )
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeCard(
                        title: "USERS",
                        imageUrl: "assets/images/users.png",
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UsersScreen(),
                            ),
                          )
                        },
                      ),
                      HomeCard(
                        title: "STAFF",
                        imageUrl: "assets/images/staff.png",
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StaffScreen(),
                            ),
                          )
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeCard(
                        title: "STATISTICS",
                        imageUrl: "assets/images/statistics.png",
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Statistics(),
                            ),
                          )
                        },
                      ),
                      HomeCard(
                        title: "LOGOUT",
                        imageUrl: "assets/images/logout.png",
                        onPressed: () async => await loginProvider.logout(),
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
