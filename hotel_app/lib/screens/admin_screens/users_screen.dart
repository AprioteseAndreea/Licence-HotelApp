import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/screens/admin_screens/custom_user_info_dialog.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);
  @override
  _UsersScreen createState() => _UsersScreen();
}

class _UsersScreen extends State<UsersScreen> {
  UserService userService = UserService();
  List<User> usersList = [];
  List<User> filteredList = [];
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    usersList = userService.getUsers();
    for (var u in usersList) {
      if (u.role == "user") {
        filteredList.add(u);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userService = Provider.of<UserService>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Strings.usersTitle,
          style: TextStyle(color: Color(Strings.darkTurquoise)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                            userName: filteredList[index].name,
                            userPhone: filteredList[index].phoneNumber,
                            userEmail: filteredList[index].email,
                            userOld: filteredList[index].old,
                            userGender: filteredList[index].gender);
                      });
                },
                child: Card(
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  elevation: 6,
                  shadowColor: Color(Strings.darkTurquoise),
                  child: ListTile(
                    title: Text(
                      filteredList[index].name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text('Since: ${filteredList[index].old}'),
                    leading: filteredList[index].gender == 'male'
                        ? Padding(
                            padding: const EdgeInsets.only(top: 7, bottom: 4),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(Strings.orange),
                                child: const CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage('assets/images/male2.png'))),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 7, bottom: 4),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(Strings.orange),
                                child: const CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                        'assets/images/female.png'))),
                          ),
                    trailing: IconButton(
                      icon: const Icon(Icons.phone),
                      color: Color(Strings.orange),
                      onPressed: () {
                        launch('tel: +${filteredList[index].phoneNumber}');
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
