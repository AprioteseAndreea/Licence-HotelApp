import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bookings.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);
  @override
  _BookingsScreen createState() => _BookingsScreen();
}

class _BookingsScreen extends State<BookingsScreen> {
  List<ReservationModel> allReservations = [];
  List<ReservationModel> lastDayReservations = [];
  List<ReservationModel> lastMonthReservations = [];
  List<ReservationModel> lastYearReservations = [];

  ReservationService reservationService = ReservationService();

  @override
  void initState() {
    allReservations = reservationService.getReservations();
    for (var r in allReservations) {
      DateTime reservationDate = DateTime.parse(r.date);
      if (daysBetween(reservationDate, DateTime.now()) == 1 ||
          daysBetween(reservationDate, DateTime.now()) == 0) {
        lastDayReservations.add(r);
      } else if (daysBetween(reservationDate, DateTime.now()) > 1 &&
          daysBetween(reservationDate, DateTime.now()) < 32) {
        lastMonthReservations.add(r);
      } else {
        lastYearReservations.add(r);
      }
    }
    super.initState();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays).round();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Color(0xFF124559), //change your color here
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(Strings.bookings,
                style: const TextStyle(color: Color(0xFF124559))),
            bottom: const TabBar(
              labelColor: Color(0xFF124559),
              tabs: [
                Tab(
                  text: 'Last day',
                ),
                Tab(
                  text: 'Last month',
                ),
                Tab(
                  text: 'Last year',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Bookings(reservations: lastDayReservations),
              Bookings(reservations: lastMonthReservations),
              Bookings(reservations: lastYearReservations),
            ],
          )),
    );
  }
}
