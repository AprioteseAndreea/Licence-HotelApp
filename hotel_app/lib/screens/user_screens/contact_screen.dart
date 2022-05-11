import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);
  @override
  _Contact createState() => _Contact();
}

class _Contact extends State<Contact> {
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
            color: Color(Strings.darkTurquoise), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            Strings.contactUs,
            style: TextStyle(color: Color(Strings.darkTurquoise)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: const Color(0xFFFFFFFF),
                  elevation: 5,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/toursist.jpg",
                              width: mediaQuery.width * 0.45,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You can find us at:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Strings.darkTurquoise),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60.0,
                                    width: mediaQuery.width * 0.85,
                                    color: Colors.white,
                                    child: Card(
                                      color: Color(Strings.lightTurquoise),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Icon(
                                                Icons.map,
                                                size: 30,
                                                color: Color(
                                                    Strings.darkTurquoise),
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                Strings.street,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60.0,
                                    width: mediaQuery.width * 0.85,
                                    color: Colors.white,
                                    child: Card(
                                        color: Color(Strings.lightTurquoise),
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Icon(
                                                  Icons.phone,
                                                  size: 30,
                                                  color: Color(
                                                      Strings.darkTurquoise),
                                                )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  Strings.hotelPhone,
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                  ),
                                                ))
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60.0,
                                    width: mediaQuery.width * 0.85,
                                    color: Colors.white,
                                    child: Card(
                                        color: Color(Strings.lightTurquoise),
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Icon(
                                                  Icons.mail,
                                                  size: 30,
                                                  color: Color(
                                                      Strings.darkTurquoise),
                                                )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(Strings.hotelEmail,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                    )))
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 40),
                          child: Divider(
                            color: Color(Strings.darkTurquoise),
                            thickness: 2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                "Or: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(Strings.darkTurquoise),
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70, right: 70, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.facebook,
                                size: 30,
                                color: Color(Strings.orange),
                              ),
                              Image.asset(
                                "assets/images/instagram_logo.png",
                                width: 30,
                                color: Color(Strings.orange),
                              ),
                              Image.asset("assets/images/youtube_logo.png",
                                  height: 30, color: Color(Strings.orange)),
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
