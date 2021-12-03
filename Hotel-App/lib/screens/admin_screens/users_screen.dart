import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'about_room.dart';
import 'add_room.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);
  @override
  _UsersScreen createState() => _UsersScreen();
}

class _UsersScreen extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  return ListView(
                      shrinkWrap: true,
                      children: asyncSnapshot.data!.docs
                          .firstWhere(
                              (element) => element.id == 'myUsers')['users']
                          .map<Widget>((user) => Card(
                                margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                elevation: 6,
                                shadowColor: const Color(0xFF124559),
                                child: InkWell(
                                    onTap: () {
                                      User currentUser = User(
                                          name: user['name'],
                                          email: user['email'],
                                          gender: user['gender'],
                                          phoneNumber: user['phoneNumber'],
                                          role: user['role']);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const AboutRoom(
                                      //      // roomModel: currentRoom,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //       "assets/images/hotel_details_rooms.jpg"),
                                          //   fit: BoxFit.fitWidth,
                                          //   alignment: Alignment.topCenter,
                                          // ),
                                          ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  if (user['gender'] == 'Male')
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 7,
                                                                top: 7,
                                                                bottom: 4),
                                                        child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/images/male2.png'))),
                                                  if (user['gender'] ==
                                                      'Female')
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 7,
                                                                top: 7,
                                                                bottom: 4),
                                                        child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/images/female.png'))),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 7,
                                                            top: 7,
                                                            bottom: 4),
                                                    child: Text(
                                                      '${user['name']}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 7,
                                                            top: 7,
                                                            bottom: 4,
                                                            right: 5),
                                                    child: Text(
                                                      '${user['phoneNumber']}',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  const Icon(Icons.phone,
                                                      color: Color(0xFFF0972D)),
                                                  const SizedBox(
                                                    width: 5,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ))
                          .toList());
                } else if (asyncSnapshot.hasError) {
                  return const Text('No feedbacks');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
