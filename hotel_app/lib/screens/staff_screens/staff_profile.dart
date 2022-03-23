import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffProfile extends StatefulWidget {
  final Staff staffModel;
  const StaffProfile({Key? key, required this.staffModel}) : super(key: key);
  @override
  _StaffProfile createState() => _StaffProfile();
}

class _StaffProfile extends State<StaffProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'My profile',
          style: TextStyle(color: Color(0xFF124559)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                  elevation: 6,
                  shadowColor: Color(Strings.darkTurquoise),
                  child: Container(
                    height: 155,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/lineargradient.jpg"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            super.widget.staffModel.gender == 'female'
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 7, bottom: 4),
                                    child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                            'assets/images/femalestaff.jpg')))
                                : const Padding(
                                    padding: EdgeInsets.only(top: 7, bottom: 4),
                                    child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                            'assets/images/malestaff.jpg'))),
                          ],
                        ),
                        Row()
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
