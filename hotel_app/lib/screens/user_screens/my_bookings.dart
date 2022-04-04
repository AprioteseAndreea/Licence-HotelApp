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
  String? name;
  ReservationService reservationService = ReservationService();
  @override
  void initState() {
    super.initState();
    myBookings = reservationService.getListOfReservations();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
    });
  }

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');

    if (_value != null) {
      setState(() {
        name = _value;
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

  Widget bookingCard(ReservationModel reservation) {
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
          padding: const EdgeInsets.only(left: 20, right: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/tourist_avatar.png',
                  height: 30,
                ),
                Text(
                  reservation.name!,
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
                  'ROOM ${reservation.room}',
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
                      formatDate(reservation.checkIn),
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
                      formatDate(reservation.checkOut),
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
                'Date: ${formatDate(reservation.date)}',
                style: const TextStyle(
                    color: Color(0xFFE16A10),
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              ),
              if (reservation.approved.toString() == 'true')
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
              if (reservation.approved.toString() == 'false')
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
    // } else {
    //   return const SizedBox(width: 0, height: 0);
    // }
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
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(5),
              itemCount: myBookings.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutReservation(
                            reservationModel: myBookings[index], isUser: true),
                      ),
                    );
                  },
                  child: myBookings[index].user == name
                      ? bookingCard(myBookings[index])
                      : const SizedBox(
                          height: 0,
                        ),
                  // return bookingCard(myBookings[index]);
                );
              }),
        )));
  }
}
