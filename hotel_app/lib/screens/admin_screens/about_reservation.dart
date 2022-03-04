import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/utils/buttons/reservation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_node/timeline_node.dart';
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
  String buttonText = "APPROVE";
  final List<String> timeLineList = [];
  Color cardBackgroundColor = Colors.orange;

  void changeColor(Color changeToColor) {
    setState(() {
      cardBackgroundColor = changeToColor;
    });
  }

  @override
  void initState() {
    super.initState();
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
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Booking details',
              style: TextStyle(color: Color(0xFF124559))),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/booking.jpg',
                  width: mediaQuery.width,
                  height: mediaQuery.height * 0.18,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/tourist_avatar.png',
                        width: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        super.widget.reservationModel.name!,
                        style: const TextStyle(
                            color: Color(0xFF124559),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TimelineNode(
                  style: TimelineNodeStyle(
                    lineType: TimelineNodeLineType.BottomHalf,
                    lineColor: const Color(0xFF124559),
                  ),
                  indicator: SizedBox(
                    width: 10,
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: const Color(0xFFE16A10),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const Text(
                              'Check-in: ',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFFE16A10),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatDate(timeLineList[0]),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF124559),
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TimelineNode(
                  style: TimelineNodeStyle(
                    lineType: TimelineNodeLineType.TopHalf,
                    lineColor: const Color(0xFF124559),
                  ),
                  indicator: SizedBox(
                    width: 10,
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: const Color(0xFFE16A10),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const Text(
                              'Check-out: ',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFFE16A10),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatDate(timeLineList[1]),
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF124559),
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    CupertinoIcons.calendar,
                                    size: 25,
                                    color: Color(0xFFF0972D),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Reservation date: ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF124559),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    formatDate(
                                        super.widget.reservationModel.date),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF124559),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.tag_fill,
                                  size: 25,
                                  color: Color(0xFFF0972D),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'ROOM ${super.widget.reservationModel.room}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFFE16A10),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/dollar.png',
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  super
                                      .widget
                                      .reservationModel
                                      .price
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Color(0xFFE16A10),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.person_2_fill,
                                  size: 25,
                                  color: Color(0xFFF0972D),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Guests: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF124559),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  super
                                      .widget
                                      .reservationModel
                                      .guests
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFFE16A10),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    'Show facilities (${super.widget.reservationModel.facilities.length.toString()})',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () =>
                                      _showMultipleChoiceDialog(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Icon(
                              CupertinoIcons.pin_fill,
                              size: 25,
                              color: Color(0xFFF0972D),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Other details: ',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF124559),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          super.widget.reservationModel.otherDetails,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15, color: Color(0xFF124559)),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (super.widget.isUser == true &&
                        !super.widget.reservationModel.approved)
                      ReservationButton(
                        textButton: "Cancel reservation",
                        color: 0xFFF0972D,
                        onTap: () async {
                          _showCancelReservationDialog(context);
                        },
                      ),
                    if (super.widget.isUser == true &&
                        super.widget.reservationModel.approved)
                      ReservationButton(
                        textButton: "APPROVED",
                        color: 0xFF2dba49,
                        onTap: () {},
                      ),
                    if (super.widget.reservationModel.approved &&
                        super.widget.isUser == false)
                      ReservationButton(
                        textButton: "APPROVED",
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
                                      .updateReservationInFirebase(
                                          super.widget.reservationModel.id),
                                  changeColor(Colors.green),
                                  setState(() {
                                    buttonText = "APPROVED";
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
                )
              ],
            ),
          ),
        ));
  }

  _showMultipleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selected facilities'),
          content: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: super
                      .widget
                      .reservationModel
                      .facilities
                      .map((e) => ListTile(
                            title: Text(e),
                          ))
                      .toList(),
                )),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
  _showCancelReservationDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final reservationProvider = Provider.of<ReservationService>(context);

        return AlertDialog(
          title: const Text('Do you want to delete this reservation?'),
          actions: [
            TextButton(
              child: const Text('YES'),
              onPressed: () async {
                await reservationProvider
                    .deleteReservation(super.widget.reservationModel);
                Navigator.pop(context);

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
