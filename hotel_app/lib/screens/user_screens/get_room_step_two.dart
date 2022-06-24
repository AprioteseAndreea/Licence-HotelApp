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

class GetRoomS2 extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults, children;
  final List<FacilityModel> selectedSpecialFacilities;
  final List<RoomModel> foundedRooms;
  final String name, email;
  final String otherDetails;
  const GetRoomS2(
      {Key? key,
      required this.checkInDate,
      required this.checkOutDate,
      required this.adults,
      required this.children,
      required this.selectedSpecialFacilities,
      required this.foundedRooms,
      required this.name,
      required this.email,
      required this.otherDetails})
      : super(key: key);
  @override
  _GetRoomS2 createState() => _GetRoomS2();
}

class _GetRoomS2 extends State<GetRoomS2> {
  late String facilitiesEnumeration = '', roomsNumber = '';
  late int extraFacilities = 0, roomCost = 0, nights = 0, total = 0, guests = 0;

  @override
  void initState() {
    super.initState();
    for (var f in super.widget.selectedSpecialFacilities) {
      facilitiesEnumeration += (" • ") + f.facility;
      extraFacilities +=
          int.parse(f.cost) * (super.widget.adults + super.widget.children);
    }
    for (var r in super.widget.foundedRooms) {
      roomsNumber += (" • ") + r.number;
    }
    nights =
        super.widget.checkOutDate.difference(super.widget.checkInDate).inDays +
            1;
    int roomsTotal = 0;
    for (var r in super.widget.foundedRooms) {
      roomsTotal += int.parse(r.cost);
    }
    roomCost = roomsTotal * nights;
    total = roomCost + extraFacilities;
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
        Strings.noFacilitiesSelected,
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
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Step 3',
          style: TextStyle(color: Color(Strings.darkTurquoise)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepProgressIndicator(
                totalSteps: 3,
                currentStep: 3,
                size: 13,
                selectedColor: Color(Strings.darkTurquoise),
                unselectedColor: Color(Strings.lightBlue),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                elevation: 6,
                shadowColor: Color(Strings.darkTurquoise),
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
                          Strings.fullName,
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
                          Strings.email,
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
                          Strings.checkInCheckOut,
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
                          Strings.guests,
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
                          Strings.rooms,
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: Text(
                          roomsNumber,
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
                          Strings.facilities,
                          style: TextStyle(
                            color: const Color(0xff848181),
                            fontSize: mediaQuery.width * 0.040,
                          ),
                        ),
                        horizontalTitleGap: 5,
                        subtitle: showFacilities(mediaQuery.width * 0.040),
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
                            Strings.roomCost,
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
                            Strings.facilitiesCost,
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
                            Strings.subtotal,
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
                            Strings.vat,
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
                            Strings.total,
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
                              List<String> rooms = [];
                              for (var r in super.widget.foundedRooms) {
                                rooms.add(r.number);
                              }

                              ReservationModel r = ReservationModel(
                                  checkIn: super.widget.checkInDate.toString(),
                                  checkOut:
                                      super.widget.checkOutDate.toString(),
                                  date: DateTime.now().toString(),
                                  price: total,
                                  rooms: rooms,
                                  user: super.widget.email,
                                  approved: false,
                                  facilities: facilities,
                                  guests: super.widget.adults +
                                      super.widget.children,
                                  name: super.widget.name,
                                  id: DateTime.now().hour.toString() +
                                      DateTime.now().minute.toString() +
                                      DateTime.now().day.toString() +
                                      DateTime.now().month.toString() +
                                      DateTime.now().year.toString(),
                                  otherDetails: super.widget.otherDetails);

                              await reservationProvider
                                  .addReservationsInFirebase(r);
                              await reservationProvider
                                  .getReservationsCollectionFromFirebase();
                              //await reservationProvider.actualizeInformation();

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
                            child: Text(
                              Strings.confirmReservation,
                              style: const TextStyle(
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
