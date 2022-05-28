import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/admin_screens/about_reservation.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);
  @override
  _Bookings createState() => _Bookings();
}

class _Bookings extends State<Bookings> {
  final ScrollController _controller = ScrollController();
  ReservationService reservationService = ReservationService();
  List<ReservationModel> reservations = [];
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

  @override
  Widget build(BuildContext context) {
    reservations = [];
    reservations = reservationService.getReservations();
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Bookings',
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
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                ReservationModel resCurrent = ReservationModel(
                    checkIn: reservations[index].checkIn,
                    checkOut: reservations[index].checkOut,
                    date: reservations[index].date,
                    price: reservations[index].price,
                    room: reservations[index].room,
                    user: reservations[index].user,
                    approved: reservations[index].approved,
                    facilities: reservations[index].facilities.cast<String>(),
                    guests: reservations[index].guests,
                    name: reservations[index].name,
                    id: reservations[index].id,
                    otherDetails: reservations[index].otherDetails);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutReservation(
                      reservationModel: resCurrent,
                      isUser: false,
                    ),
                  ),
                );
              },
              child: Card(
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
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/tourist_avatar.png',
                                height: mediaQuery.height * 0.04,
                              ),
                              Text(
                                ' ${reservations[index].name}',
                                style: TextStyle(
                                    color: Color(Strings.darkTurquoise),
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
                                'ROOM ${reservations[index].room}',
                                style: TextStyle(
                                    color: Color(Strings.orange),
                                    fontWeight: FontWeight.bold,
                                    fontSize: mediaQuery.width * 0.03),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    child: Card(
                        color: const Color(0xFF124559),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                formatDate(reservations[index].checkIn),
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
                                formatDate(reservations[index].checkOut),
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
                          'Date: ${formatDate(reservations[index].date)}',
                          style: TextStyle(
                              color: Color(Strings.orange),
                              fontSize: mediaQuery.width * 0.04,
                              fontStyle: FontStyle.italic),
                        ),
                        if (reservations[index].approved.toString() == 'true')
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
                                      fontSize: mediaQuery.width * 0.03,
                                    ),
                                  ),
                                ),
                              )),
                        if (reservations[index].approved.toString() == 'false')
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: GestureDetector(
                                onTap: () => {
                                      reservationService
                                          .updateReservationInFirebase(
                                              reservations[index].id),
                                      reservationService
                                          .countNumberOfReservations(
                                              reservations[index].user),
                                    },
                                child: Card(
                                  color: Colors.orange,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Text(
                                      'APPROVE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: mediaQuery.width * 0.03,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        ),
      )),
    );
  }
}
