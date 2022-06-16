import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/admin_screens/about_reservation.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bookings extends StatefulWidget {
  List<ReservationModel> reservations = [];
  Bookings({Key? key, required this.reservations}) : super(key: key);
  @override
  _Bookings createState() => _Bookings();
}

class _Bookings extends State<Bookings> {
  final ScrollController _controller = ScrollController();
  ReservationService reservationService = ReservationService();

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
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: super.widget.reservations.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  controller: _controller,
                  itemCount: super.widget.reservations.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ReservationModel resCurrent = ReservationModel(
                            checkIn: super.widget.reservations[index].checkIn,
                            checkOut: super.widget.reservations[index].checkOut,
                            date: super.widget.reservations[index].date,
                            price: super.widget.reservations[index].price,
                            rooms: super.widget.reservations[index].rooms,
                            user: super.widget.reservations[index].user,
                            approved: super.widget.reservations[index].approved,
                            facilities: super
                                .widget
                                .reservations[index]
                                .facilities
                                .cast<String>(),
                            guests: super.widget.reservations[index].guests,
                            name: super.widget.reservations[index].name,
                            id: super.widget.reservations[index].id,
                            otherDetails:
                                super.widget.reservations[index].otherDetails);
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
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/tourist_avatar.png',
                                        height: mediaQuery.height * 0.04,
                                      ),
                                      Text(
                                        ' ${super.widget.reservations[index].name}',
                                        style: TextStyle(
                                            color: Color(Strings.darkTurquoise),
                                            fontWeight: FontWeight.bold,
                                            fontSize: mediaQuery.width * 0.04),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/bed_logo.png',
                                        height: mediaQuery.height * 0.04,
                                      ),
                                      Text(
                                        Strings.room +
                                            super
                                                .widget
                                                .reservations[index]
                                                .rooms[0],
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
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        formatDate(super
                                            .widget
                                            .reservations[index]
                                            .checkIn),
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
                                        formatDate(super
                                            .widget
                                            .reservations[index]
                                            .checkOut),
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
                                  Strings.date +
                                      formatDate(super
                                          .widget
                                          .reservations[index]
                                          .date),
                                  style: TextStyle(
                                      color: Color(Strings.orange),
                                      fontSize: mediaQuery.width * 0.04,
                                      fontStyle: FontStyle.italic),
                                ),
                                if (super
                                        .widget
                                        .reservations[index]
                                        .approved
                                        .toString() ==
                                    'true')
                                  Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Card(
                                        color: Colors.green,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Text(
                                            Strings.approved,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: mediaQuery.width * 0.03,
                                            ),
                                          ),
                                        ),
                                      )),
                                if (!super.widget.reservations[index].approved)
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: GestureDetector(
                                        onTap: () => {
                                              reservationService
                                                  .updateReservationInFirebase(
                                                      super
                                                          .widget
                                                          .reservations[index]
                                                          .id),
                                              reservationService
                                                  .countNumberOfReservations(
                                                      super
                                                          .widget
                                                          .reservations[index]
                                                          .user),
                                            },
                                        child: Card(
                                          color: Colors.orange,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Text(
                                              Strings.approve,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize:
                                                    mediaQuery.width * 0.03,
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
                )
              : Column(children: [
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
                ])),
    ));
  }
}
