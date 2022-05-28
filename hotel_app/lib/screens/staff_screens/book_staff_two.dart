import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/user_screens/confirm_reservation.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BookStaffTwo extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults, children;
  final List<FacilityModel> selectedSpecialFacilities;
  final RoomModel room;
  final String name;
  final String email;
  const BookStaffTwo({
    Key? key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.selectedSpecialFacilities,
    required this.room,
    required this.name,
    required this.email,
  }) : super(key: key);
  @override
  _BookStaffTwo createState() => _BookStaffTwo();
}

class _BookStaffTwo extends State<BookStaffTwo> {
  late String facilitiesEnumeration = '';
  late int extraBeds;
  late int extraFacilities = 0;
  late int roomCost = 0;
  late int nights = 0;
  late int total = 0;
  late int guests = 0;
  @override
  void initState() {
    super.initState();
    for (var f in super.widget.selectedSpecialFacilities) {
      facilitiesEnumeration += (" • ") + f.facility;
      extraFacilities +=
          int.parse(f.cost) * (super.widget.adults + super.widget.children);
    }
    if (int.parse(super.widget.room.maxGuests) <
        (super.widget.adults + super.widget.children)) {
      extraBeds = (super.widget.adults + super.widget.children) -
          int.parse(super.widget.room.maxGuests);
    } else {
      extraBeds = 0;
    }
    nights =
        super.widget.checkOutDate.difference(super.widget.checkInDate).inDays +
            1;
    roomCost = int.parse(super.widget.room.cost) * nights;
    total = roomCost + (extraBeds * 10) + extraFacilities;
    guests = super.widget.adults + super.widget.children;
  }

  Widget showFacilities(double fontSize) {
    if (facilitiesEnumeration.isNotEmpty) {
      return Text(
        facilitiesEnumeration,
        style: TextStyle(
          color: Color(Strings.darkTurquoise),
          fontSize: fontSize,
        ),
      );
    } else {
      return Text(
        'No facilities selected',
        style: TextStyle(
          color: Color(Strings.darkTurquoise),
          fontSize: fontSize,
        ),
      );
    }
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
    final reservationProvider = Provider.of<ReservationService>(context);
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Grand Hotel',
          style: TextStyle(color: Color(0xFF124559)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepProgressIndicator(
                totalSteps: 3,
                currentStep: 2,
                size: 13,
                selectedColor: Color(0xFF124559),
                unselectedColor: Color(0xFF72B0D4),
              ),
              const SizedBox(
                height: 15,
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
                              'Booking Details',
                              style: TextStyle(
                                  color: Color(Strings.darkTurquoise),
                                  fontSize: mediaQuery.width * 0.044,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 30,
                          color: Color(Strings.orange),
                        ),
                        title: Text(
                          'Name',
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: Text(
                          super.widget.name,
                          style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          size: 30,
                          color: Color(Strings.orange),
                        ),
                        title: Text(
                          'Email',
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: Text(
                          super.widget.email,
                          style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.calendar_today,
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
                          formatDate(super.widget.checkInDate.toString()) +
                              ' - ' +
                              formatDate(super.widget.checkOutDate.toString()),
                          style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.people,
                          size: 30,
                          color: Color(Strings.orange),
                        ),
                        title: Text(
                          'Guests',
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: Text(
                          '$guests (${super.widget.adults} adults + ${super.widget.children} children)',
                          style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.tag_fill,
                          size: 30,
                          color: Color(Strings.orange),
                        ),
                        title: Text(
                          'Room',
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: Text(
                          super.widget.room.number,
                          style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.spa,
                          size: 30,
                          color: Color(Strings.orange),
                        ),
                        title: Text(
                          'Facilities',
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: showFacilities(mediaQuery.width * 0.040),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.king_bed,
                          size: 30,
                          color: Color(Strings.orange),
                        ),
                        title: Text(
                          'Extra beds',
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: Text(
                          extraBeds.toString(),
                          style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, bottom: 10),
                            child: Text(
                              'Payment Summary',
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
                            'Room cost',
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          Text(
                            "\$" + roomCost.toString(),
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
                            'Facilities cost',
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          Text(
                            "\$" + extraFacilities.toString(),
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
                            'Extra beds cost',
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          Text(
                            '\$${extraBeds * 10}',
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
                            'Subtotal',
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          Text(
                            "\$" + total.toString(),
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
                            'VAT (23%)',
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          Text(
                            "\$" + ((total * 23) / 100).toString(),
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
                            'Total',
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                          Text(
                            "\$" + (((total * 23) / 100) + total).toString(),
                            style: TextStyle(
                              color: Color(Strings.darkTurquoise),
                              fontSize: mediaQuery.width * 0.040,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              List<String> facilities = [];
                              for (var f
                                  in super.widget.selectedSpecialFacilities) {
                                facilities.add(f.facility);
                              }

                              ReservationModel r = ReservationModel(
                                  checkIn: super.widget.checkInDate.toString(),
                                  checkOut:
                                      super.widget.checkOutDate.toString(),
                                  date: DateTime.now().toString(),
                                  price: total,
                                  room: super.widget.room.number,
                                  user: super.widget.email,
                                  approved: true,
                                  facilities: facilities,
                                  guests: super.widget.adults +
                                      super.widget.children,
                                  name: super.widget.name,
                                  id: DateTime.now().hour.toString() +
                                      DateTime.now().minute.toString() +
                                      DateTime.now().day.toString() +
                                      DateTime.now().month.toString() +
                                      DateTime.now().year.toString(),
                                  otherDetails: "");

                              await reservationProvider
                                  .addReservationsInFirebase(r);
                              await reservationProvider
                                  .getReservationsCollectionFromFirebase();
                              await reservationProvider.actualizeInformation();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ConfirmReservation(),
                                  ));
                            },
                            height: 40,
                            minWidth: 200,
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              "Confirm reservation",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
