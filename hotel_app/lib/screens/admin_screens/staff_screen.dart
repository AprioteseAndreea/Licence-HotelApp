import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);
  @override
  _StaffScreen createState() => _StaffScreen();
}

class _StaffScreen extends State<StaffScreen> {
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
          'Staff',
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
                              (element) => element.id == 'staff')['staff']
                          .map<Widget>((user) => Card(
                                margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                elevation: 6,
                                shadowColor: const Color(0xFF124559),
                                child: ListTile(
                                  title: Text(user['name']),
                                  subtitle: Text(user['position']),
                                  leading: user['gender'] == 'female'
                                      ? const Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 4),
                                          child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: AssetImage(
                                                  'assets/images/femalestaff.jpg')))
                                      : const Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 4),
                                          child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: AssetImage(
                                                  'assets/images/malestaff.jpg'))),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.phone),
                                    color: const Color(0xFFF0972D),
                                    onPressed: () {
                                      launch('tel: +${user['phone']}');
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
