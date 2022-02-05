import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/admin_screens/about_reservation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key, this.email}) : super(key: key);
  final String? email;
  @override
  _MyBookings createState() => _MyBookings();
}

class _MyBookings extends State<MyBookings> {
  @override
  void initState() {
    super.initState();
  }

  String formatDate(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('MMM d, yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Widget bookingCard(dynamic reservation) {
    String currenremail = super.widget.email.toString();
    if (reservation['user'].toString() == currenremail) {
      return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        elevation: 6,
        shadowColor: const Color(0xFF124559),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: const Color(0xFFFFFFFF),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/tourist_avatar.png',
                        height: 30,
                      ),
                      Text(
                        ' ${reservation['name']}',
                        style: const TextStyle(
                            color: Color(0xFF124559),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/bed_logo.png',
                        height: 35,
                      ),
                      Text(
                        'ROOM ${reservation['room']}',
                        style: const TextStyle(
                            color: Color(0xFFE16A10),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ]),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Card(
                color: const Color(0xFF124559),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        formatDate(reservation['checkIn']),
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                        ),
                      ),
                      Image.asset(
                        'assets/images/calendar.png',
                        height: 25,
                        width: 25,
                      ),
                      Text(
                        formatDate(reservation['checkOut']),
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${formatDate(reservation['date'])}',
                  style: const TextStyle(
                      color: Color(0xFFE16A10),
                      fontSize: 14,
                      fontStyle: FontStyle.italic),
                ),
                if (reservation['approved'].toString() == 'true')
                  const Padding(
                      padding: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            'APPROVED',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                if (reservation['approved'].toString() == 'false')
                  const Padding(
                      padding: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.orange,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            'PENDING',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
              ],
            ),
          )
        ]),
      );
    } else {
      return const SizedBox(width: 0, height: 0);
    }
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
            'My Bookings',
            style: TextStyle(color: Color(0xFF124559)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      return ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          children: asyncSnapshot.data!.docs
                              .firstWhere((element) =>
                                  element.id == 'reservations')['reservations']
                              .map<Widget>(
                                (reservation) => GestureDetector(
                                  onTap: () {
                                    ReservationModel resCurrent =
                                        ReservationModel(
                                            checkIn: reservation['checkIn'],
                                            checkOut: reservation['checkOut'],
                                            date: reservation['date'],
                                            price: reservation['price'],
                                            room: reservation['room'],
                                            user: reservation['user'],
                                            approved: reservation['approved'],
                                            facilities:
                                                reservation['facilities']
                                                    .cast<String>(),
                                            guests: reservation['guests'],
                                            name: reservation['name'],
                                            id: reservation['id']);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AboutReservation(
                                            reservationModel: resCurrent,
                                            isUser: true),
                                      ),
                                    );
                                  },
                                  child: bookingCard(reservation),
                                ),
                              )
                              .toList());
                    } else if (asyncSnapshot.hasError) {
                      return const Text('No bookings');
                    }
                    return const CircularProgressIndicator();
                  })),
        ));
  }
}
