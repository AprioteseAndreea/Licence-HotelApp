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
        backgroundColor: const Color(0xFF124559),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Contact',
            style: TextStyle(color: Color(0xFF124559)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/contact.jpg",
                      height: mediaQuery.height * 0.25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "You can find us at:",
                      style: TextStyle(
                          fontSize: 23,
                          color: Color(0xFFF0972D),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.0,
                            width: mediaQuery.width * 0.85,
                            color: const Color(0xFF124559),
                            child: Card(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        "assets/images/googlepin.png",
                                        height: 35,
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Street Avenue 2301, SUA",
                                          style: TextStyle(
                                            fontSize: 18,
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
                            color: const Color(0xFF124559),
                            child: Card(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        "assets/images/phone.png",
                                        height: 35,
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "800 234 583",
                                          style: TextStyle(
                                            fontSize: 18,
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
                            color: const Color(0xFF124559),
                            child: Card(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        "assets/images/email.png",
                                        height: 35,
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "grandluxuryhotel@gmail.com",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: Divider(
                    color: Color(0xFFF0972D),
                    thickness: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Or: ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFF0972D),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/facebook_logo.png",
                        width: 35,
                      ),
                      Image.asset(
                        "assets/images/instagram_logo.png",
                        width: 35,
                      ),
                      Image.asset(
                        "assets/images/youtube_logo.png",
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
