import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/staff_screens/book_staff_two.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'get_room_step_two.dart';

class PossibleRooms extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults, children;
  final List<FacilityModel> selectedSpecialFacilities;
  final List<RoomModel> foundedRooms;
  final String name;
  final String otherDetails;
  final bool isStaff;
  final String email;
  const PossibleRooms(
      {Key? key,
      required this.checkInDate,
      required this.checkOutDate,
      required this.adults,
      required this.children,
      required this.selectedSpecialFacilities,
      required this.foundedRooms,
      required this.name,
      required this.otherDetails,
      required this.isStaff,
      required this.email})
      : super(key: key);
  @override
  _PossibleRooms createState() => _PossibleRooms();
}

class _PossibleRooms extends State<PossibleRooms> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Strings.step2,
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
                currentStep: 2,
                size: 13,
                selectedColor: Color(Strings.darkTurquoise),
                unselectedColor: Color(Strings.lightBlue),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                controller: _controller,
                itemCount: super.widget.foundedRooms.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.hotel,
                      size: 30,
                      color: Color(Strings.orange),
                    ),
                    title: Text(
                      'Room ' + super.widget.foundedRooms[index].number,
                      style: TextStyle(
                        color: const Color(0xff848181),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                    ),
                    horizontalTitleGap: 5,
                    subtitle: Text(
                      'Max guests for this room: ' +
                          super.widget.foundedRooms[index].maxGuests,
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if (super.widget.isStaff) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookStaffTwo(
                                checkInDate: super.widget.checkInDate,
                                checkOutDate: super.widget.checkOutDate,
                                adults: super.widget.adults,
                                children: super.widget.children,
                                selectedSpecialFacilities:
                                    super.widget.selectedSpecialFacilities,
                                rooms: super.widget.foundedRooms,
                                name: super.widget.name,
                                email: super.widget.email,
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetRoomS2(
                                checkInDate: super.widget.checkInDate,
                                checkOutDate: super.widget.checkOutDate,
                                adults: super.widget.adults,
                                children: super.widget.children,
                                selectedSpecialFacilities:
                                    super.widget.selectedSpecialFacilities,
                                foundedRooms: super.widget.foundedRooms,
                                name: super.widget.name,
                                email: super.widget.email,
                                otherDetails: super.widget.otherDetails,
                              ),
                            ));
                      }
                    },
                    height: 40,
                    minWidth: 200,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Continue",
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
    );
  }
}
