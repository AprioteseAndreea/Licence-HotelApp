import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/admin_screens/about_reservation.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key, this.email}) : super(key: key);
  final String? email;
  @override
  _MyBookings createState() => _MyBookings();
}

class _MyBookings extends State<MyBookings> {
  List<ReservationModel> myBookings = [];
  String? email;
  ReservationService reservationService = ReservationService();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
    });
  }

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('email');

    if (_value != null) {
      setState(() {
        email = _value;
      });
    }
  }

  String formatDate(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('MMM d, yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Widget bookingCard(ReservationModel reservation, BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    // String currenremail = super.widget.email.toString();
    // if (reservation['user'].toString() == currenremail) {
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
          padding: const EdgeInsets.only(left: 20, right: 15, top: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/tourist_avatar.png',
                  height: mediaQuery.height * 0.04,
                ),
                Text(
                  reservation.name!,
                  style: TextStyle(
                      color: const Color(0xFF124559),
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.width * 0.04),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/bed_logo.png',
                  height: mediaQuery.height * 0.04,
                ),
                Text(
                  'ROOM ${reservation.room}',
                  style: TextStyle(
                      color: const Color(0xFFE16A10),
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.width * 0.03),
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
                      formatDate(reservation.checkIn),
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: mediaQuery.width * 0.04,
                      ),
                    ),
                    Image.asset(
                      'assets/images/calendar.png',
                      height: mediaQuery.width * 0.06,
                      width: mediaQuery.width * 0.06,
                    ),
                    Text(
                      formatDate(reservation.checkOut),
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: mediaQuery.width * 0.04,
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
                'Date: ${formatDate(reservation.date)}',
                style: TextStyle(
                    color: const Color(0xFFE16A10),
                    fontSize: mediaQuery.width * 0.04,
                    fontStyle: FontStyle.italic),
              ),
              if (reservation.approved.toString() == 'true')
                Padding(
                    padding: const EdgeInsets.all(2),
                    child: Card(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          'APPROVED',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: mediaQuery.width * 0.03),
                        ),
                      ),
                    )),
              if (reservation.approved.toString() == 'false')
                Padding(
                    padding: const EdgeInsets.all(2),
                    child: Card(
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          'PENDING',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: mediaQuery.width * 0.03),
                        ),
                      ),
                    )),
            ],
          ),
        )
      ]),
    );
    // } else {
    //   return const SizedBox(width: 0, height: 0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    myBookings = reservationService.getReservations();
    for (int i = 0; i < myBookings.length; i++) {
      if (firebaseAuth.currentUser!.email != myBookings[i].user) {
        myBookings.remove(myBookings[i]);
      }
    }
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
          child: myBookings.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(5),
                  physics: const ClampingScrollPhysics(),
                  controller: _controller,
                  itemCount: myBookings.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutReservation(
                                reservationModel: myBookings[index],
                                isUser: true),
                          ),
                        );
                      },
                      child: bookingCard(myBookings[index], context),
                      // return bookingCard(myBookings[index]);
                    );
                  })
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/images/nodatafound.jpg',
                      height: mediaQuery.height * 0.4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "No reservations found!",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: mediaQuery.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        "You can try to add a new reservation on your hotel.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: mediaQuery.width * 0.045,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
        )));
  }
}
