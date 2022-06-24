import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/screens/admin_screens/add_staff.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);
  @override
  _StaffScreen createState() => _StaffScreen();
}

class _StaffScreen extends State<StaffScreen> {
  final ScrollController _controller = ScrollController();
  UserService userService = UserService();
  List<Staff> staffList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Staff emptyStaff;
    staffList = [];
    userService = Provider.of<UserService>(context);
    staffList = userService.getStaff();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Strings.hotelStaff,
          style: TextStyle(color: Color(Strings.darkTurquoise)),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.plus_circle_fill,
              size: 30,
            ),
            onPressed: () => {
              emptyStaff = Staff(
                  email: Strings.none,
                  gender: Strings.none,
                  name: Strings.none,
                  old: Strings.none,
                  phone: Strings.none,
                  position: Strings.none,
                  salary: 0),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStaff(staff: emptyStaff),
                ),
              )
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            itemCount: staffList.length,
            itemBuilder: (context, index) {
              return Card(
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  elevation: 6,
                  shadowColor: Color(Strings.darkTurquoise),
                  child: ListTile(
                    title: Text(
                      staffList[index].name,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(Strings.darkTurquoise),
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    subtitle: Text(staffList[index].position),
                    leading: staffList[index].gender == Strings.female
                        ? const Padding(
                            padding: EdgeInsets.only(top: 7, bottom: 4),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                    'assets/images/femalestaff.jpg')))
                        : const Padding(
                            padding: EdgeInsets.only(top: 7, bottom: 4),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/images/malestaff.jpg'))),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Color(Strings.darkTurquoise),
                          onPressed: () {
                            emptyStaff = Staff(
                                email: staffList[index].email,
                                gender: staffList[index].gender,
                                name: staffList[index].name,
                                old: staffList[index].old,
                                phone: staffList[index].phone,
                                position: staffList[index].position,
                                salary: staffList[index].salary);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddStaff(staff: emptyStaff),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          color: Color(Strings.orange),
                          onPressed: () {
                            launch('tel: +${staffList[index].phone}');
                          },
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
