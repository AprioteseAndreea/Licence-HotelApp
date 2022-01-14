import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);
  @override
  _UsersScreen createState() => _UsersScreen();
}

class _UsersScreen extends State<UsersScreen> {
  final ScrollController _controller = ScrollController();
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
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      controller: _controller,
                      children: asyncSnapshot.data!.docs
                          .firstWhere(
                              (element) => element.id == 'myUsers')['users']
                          .map<Widget>((user) => Card(
                                margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                elevation: 6,
                                shadowColor: const Color(0xFF124559),
                                child: ListTile(
                                  title: Text(
                                    user['name'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle:
                                      Text('Since: ${user['old'].toString()}'),
                                  leading: user['gender'] == 'Male'
                                      ? const Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 4),
                                          child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Color(0xFFF0972D),
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/male2.png'))),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 4),
                                          child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Color(0xFFF0972D),
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/female.png'))),
                                        ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.phone),
                                    color: const Color(0xFFF0972D),
                                    onPressed: () {
                                      launch('tel: +${user['phoneNumber']}');
                                    },
                                  ),
                                ),
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
