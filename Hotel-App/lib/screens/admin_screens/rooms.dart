import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'add_room.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);
  @override
  _Rooms createState() => _Rooms();
}

class _Rooms extends State<Rooms> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String current_user = '';
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Rooms',
          style: TextStyle(color: Color(0xFF124559)),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.add_circled,
              size: 30,
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddRoom(),
                ),
              )
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs
                          .firstWhere(
                              (element) => element.id == 'rooms')['rooms']
                          .map<Widget>((room) => Card(
                              margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                              elevation: 6,
                              shadowColor: const Color(0xFF124559),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/hotel_details_rooms.jpg"),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, top: 7, bottom: 4),
                                          child: Text(
                                            'ROOM ${room['number']}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7,
                                              top: 7,
                                              bottom: 7,
                                              right: 7),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.euro,
                                                color: Color(0xFF124559),
                                                size: 25.0,
                                              ),
                                              Text(
                                                room['cost'].toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF72B0D4),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        if (room['pending'].toString() ==
                                            'true')
                                          const Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Card(
                                                color: Colors.orange,
                                                child: Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text(
                                                    'PENDING',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        if (room['free'].toString() == 'true' &&
                                            room['pending'].toString() ==
                                                'false')
                                          const Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Card(
                                                color: Colors.green,
                                                child: Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text(
                                                    'FREE',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        if (room['free'].toString() == 'false')
                                          const Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Card(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text(
                                                    'OCCUPIED',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                      ],
                                    ),
                                    if (room['id_user'].toString() != 'none')
                                      Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4,
                                                          top: 4,
                                                          bottom: 4),
                                                  child: Text(
                                                    '${room['id_user']}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF124559),
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Icon(
                                                    Icons
                                                        .horizontal_rule_rounded,
                                                    color: Color(0xFF124559),
                                                    size: 40.0,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7,
                                                          top: 7,
                                                          bottom: 4),
                                                  child: Text(
                                                    '${room['interval']}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF124559),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      )
                                  ],
                                ),
                              )))
                          .toList());
                } else if (snapshot.hasError) {
                  return const Text('No feedbacks');
                }
                throw ('Some error occurred...');
              }),
        ),
      ),
    );
  }
}
