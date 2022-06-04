import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/user_screens/my_bookings.dart';
import 'package:first_app_flutter/utils/buttons/reservation_button.dart';
import 'package:first_app_flutter/screens/user_screens/pdf.dart' as pdf;
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AboutReservation extends StatefulWidget {
  final ReservationModel reservationModel;
  final bool isUser;
  const AboutReservation(
      {Key? key, required this.reservationModel, required this.isUser})
      : super(key: key);
  @override
  _AboutReservation createState() => _AboutReservation();
}

class _AboutReservation extends State<AboutReservation> {
  late String name;
  String buttonText = Strings.approve;
  final List<String> timeLineList = [];
  Color cardBackgroundColor = Colors.orange;
  String rooms = '';
  void changeColor(Color changeToColor) {
    setState(() {
      cardBackgroundColor = changeToColor;
    });
  }

  @override
  void initState() {
    super.initState();
    for (var r in super.widget.reservationModel.rooms) {
      rooms += (" • ") + r;
    }
    name = super.widget.reservationModel.name!;
    timeLineList.add(super.widget.reservationModel.checkIn);
    timeLineList.add(super.widget.reservationModel.checkOut);
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
    final reservationProvider = Provider.of<ReservationService>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(Strings.darkTurquoise), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(Strings.bookingDetails,
              style: TextStyle(color: Color(Strings.darkTurquoise))),
          actions: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.square_favorites,
                size: 25,
              ),
              onPressed: () => {_showMultipleChoiceDialog(context)},
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color(0xfff5f5f5),
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Text(
                              'Booking ID: ${super.widget.reservationModel.id}',
                              style: TextStyle(
                                  color: Color(Strings.darkTurquoise),
                                  fontSize: mediaQuery.width * 0.040,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(
                            children: [
                              Text(
                                'Booking On: ${super.widget.reservationModel.date.substring(0, 10)}',
                                style: TextStyle(
                                    color: Color(Strings.darkTurquoise),
                                    fontSize: mediaQuery.width * 0.040,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  elevation: 6,
                  shadowColor: const Color(0xFF124559),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xFFFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Text(
                                Strings.bookingDetails,
                                style: TextStyle(
                                    color: Color(Strings.darkTurquoise),
                                    fontSize: mediaQuery.width * 0.044,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: const Icon(
                            CupertinoIcons.person_solid,
                            size: 30,
                            color: Color(0xff848181),
                          ),
                          title: Text(
                            Strings.userName,
                            style: TextStyle(
                              color: const Color(0xff848181),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          horizontalTitleGap: 5,
                          subtitle: Text(
                            super.widget.reservationModel.name!,
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.calendar,
                            size: 30,
                            color: Color(Strings.orange),
                          ),
                          title: Text(
                            'Check-In - Check-Out',
                            style: TextStyle(
                              color: const Color(0xff848181),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          horizontalTitleGap: 5,
                          subtitle: Text(
                            formatDate(timeLineList[0]) +
                                ' - ' +
                                formatDate(timeLineList[1]),
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            CupertinoIcons.tag_fill,
                            size: 30,
                            color: Color(0xff848181),
                          ),
                          title: Text(
                            Strings.rooms,
                            style: TextStyle(
                              color: const Color(0xff848181),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          horizontalTitleGap: 5,
                          subtitle: Text(
                            rooms,
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.person_2_fill,
                            size: 30,
                            color: Color(Strings.orange),
                          ),
                          title: Text(
                            Strings.guests,
                            style: TextStyle(
                              color: const Color(0xff848181),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          horizontalTitleGap: 5,
                          subtitle: Text(
                            super.widget.reservationModel.guests.toString(),
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            CupertinoIcons.pencil_ellipsis_rectangle,
                            size: 30,
                            color: Color(0xff848181),
                          ),
                          title: Text(
                            Strings.otherDetails,
                            style: TextStyle(
                              color: const Color(0xff848181),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          horizontalTitleGap: 5,
                          subtitle: getWidget(mediaQuery.width * 0.040),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, bottom: 10),
                              child: Text(
                                Strings.paymentSummary,
                                style: TextStyle(
                                    color: Color(Strings.darkTurquoise),
                                    fontSize: mediaQuery.width * 0.044,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.subtotal,
                              style: TextStyle(
                                color: Color(Strings.darkTurquoise),
                                fontSize: mediaQuery.width * 0.040,
                              ),
                            ),
                            Text(
                              "\$" +
                                  super
                                      .widget
                                      .reservationModel
                                      .price
                                      .toString(),
                              style: TextStyle(
                                color: Color(Strings.darkTurquoise),
                                fontSize: mediaQuery.width * 0.040,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.vat,
                              style: TextStyle(
                                color: Color(Strings.darkTurquoise),
                                fontSize: mediaQuery.width * 0.040,
                              ),
                            ),
                            Text(
                              "\$" +
                                  ((super.widget.reservationModel.price * 23) /
                                          100)
                                      .toString(),
                              style: TextStyle(
                                color: Color(Strings.darkTurquoise),
                                fontSize: mediaQuery.width * 0.040,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (super.widget.isUser == true &&
                                !super.widget.reservationModel.approved)
                              ReservationButton(
                                textButton: Strings.cancelReservation,
                                color: 0xFFF0972D,
                                onTap: () async {
                                  _showCancelReservationDialog(context);
                                },
                              ),
                            if (super.widget.isUser == true &&
                                super.widget.reservationModel.approved)
                              ReservationButton(
                                  textButton: Strings.downloadBill,
                                  color: 0xFF2dba49,
                                  onTap: () => {
                                        pdf.createPDF(
                                            super.widget.reservationModel),
                                      }),
                            if (super.widget.reservationModel.approved &&
                                super.widget.isUser == false)
                              ReservationButton(
                                textButton: Strings.approved,
                                color: 0xFF2dba49,
                                onTap: () {},
                              ),
                            if (!super.widget.reservationModel.approved &&
                                super.widget.isUser == false)
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: GestureDetector(
                                    onTap: () => {
                                          reservationProvider
                                              .updateReservationInFirebase(super
                                                  .widget
                                                  .reservationModel
                                                  .id),
                                          changeColor(Colors.green),
                                          setState(() {
                                            buttonText = Strings.approved;
                                          }),
                                        },
                                    child: Card(
                                      color: cardBackgroundColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          buttonText,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget getWidget(double fontSize) {
    if (super.widget.reservationModel.otherDetails != "") {
      return Text(
        super.widget.reservationModel.otherDetails,
        style: TextStyle(
          color: Color(Strings.darkTurquoise),
          fontSize: fontSize,
        ),
      );
    } else {
      return Text(
        'No other details added',
        style: TextStyle(
          color: Color(Strings.darkTurquoise),
          fontSize: fontSize,
        ),
      );
    }
  }

  _showMultipleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(Strings.selectedFacilities),
          content: SingleChildScrollView(
            child:
                SizedBox(width: double.infinity, child: getFacilities(context)),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(Strings.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
  getFacilities(BuildContext context) {
    if (super.widget.reservationModel.facilities.isEmpty) {
      return const Text('No facilities selected!');
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: super
            .widget
            .reservationModel
            .facilities
            .map((e) => ListTile(
                  title: Text(e),
                ))
            .toList(),
      );
    }
  }

  _showCancelReservationDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final reservationProvider = Provider.of<ReservationService>(context);
        return AlertDialog(
          title: Text(Strings.deleteReservationQuestion),
          actions: [
            TextButton(
              child: Text(Strings.yes),
              onPressed: () async {
                await reservationProvider
                    .deleteReservation(super.widget.reservationModel);
                await reservationProvider
                    .getReservationsCollectionFromFirebase();
                Navigator.of(context).pop();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyBookings(),
                    ));
              },
            ),
            TextButton(
              child: Text(Strings.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
