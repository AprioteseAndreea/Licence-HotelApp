import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/screens/admin_screens/custom_user_info_dialog.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
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
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userService = Provider.of<UserService>(context);
    usersList = userService.getUsers();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Users',
          style: TextStyle(color: Color(0xFF124559)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            itemCount: usersList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                            userName: usersList[index].name,
                            userPhone: usersList[index].phoneNumber,
                            userEmail: usersList[index].email,
                            userOld: usersList[index].old,
                            userGender: usersList[index].gender);
                      });
                },
                child: Card(
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  elevation: 6,
                  shadowColor: const Color(0xFF124559),
                  child: ListTile(
                    title: Text(
                      usersList[index].name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text('Since: ${usersList[index].old}'),
                    leading: usersList[index].gender == 'male'
                        ? const Padding(
                            padding: EdgeInsets.only(top: 7, bottom: 4),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xFFF0972D),
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage('assets/images/male2.png'))),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 7, bottom: 4),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xFFF0972D),
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                        'assets/images/female.png'))),
                          ),
                    trailing: IconButton(
                      icon: const Icon(Icons.phone),
                      color: const Color(0xFFF0972D),
                      onPressed: () {
                        launch('tel: +${usersList[index].phoneNumber}');
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
