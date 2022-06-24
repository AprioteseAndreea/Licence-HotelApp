import 'package:first_app_flutter/screens/admin_screens/second_screen_statistics.dart';
import 'package:first_app_flutter/screens/admin_screens/third_screen_statistics.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'first_screen_statistics.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);
  @override
  _Statistics createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: Color(Strings.darkTurquoise) //change your color here
                ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(Strings.statistics,
                style: TextStyle(color: Color(Strings.darkTurquoise))),
            bottom: TabBar(
              labelColor: Color(Strings.darkTurquoise),
              tabs: [
                Tab(
                  text: Strings.monthlyStats,
                ),
                Tab(
                  text: Strings.annualStats,
                ),
                Tab(
                  text: Strings.roomsStats,
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [FirstScreen(), SecondScreen(), ThirdScreen()],
          )),
    );
  }
}
