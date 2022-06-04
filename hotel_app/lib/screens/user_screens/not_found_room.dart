import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class NotFoundRoom extends StatefulWidget {
  const NotFoundRoom({Key? key}) : super(key: key);
  @override
  _NotFoundRoom createState() => _NotFoundRoom();
}

class _NotFoundRoom extends State<NotFoundRoom> {
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
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.sorry,
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: 25,
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
                  Image.asset(
                    'assets/images/notfoundroom.png',
                    height: 200,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 280,
                      child: Center(
                        child: Text(
                          Strings.noRoomAvailable,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17,
                              color: Color(Strings.darkTurquoise)),
                          maxLines: 2,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.pleaseTryAgain,
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
