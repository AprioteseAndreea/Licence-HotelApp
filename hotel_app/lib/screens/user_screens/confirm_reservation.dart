import 'package:first_app_flutter/screens/homeScreens/home_screen.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ConfirmReservation extends StatefulWidget {
  const ConfirmReservation({Key? key}) : super(key: key);
  @override
  _ConfirmReservation createState() => _ConfirmReservation();
}

class _ConfirmReservation extends State<ConfirmReservation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Strings.grandHotel,
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
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.thankYouForReservation,
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        Strings.checkInInformation,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, color: Color(Strings.darkTurquoise)),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/confirmation.png',
                    height: 200,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.youreWelcome,
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    height: 40,
                    minWidth: 200,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      Strings.goHome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
