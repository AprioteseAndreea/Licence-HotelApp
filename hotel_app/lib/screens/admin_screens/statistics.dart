import 'package:first_app_flutter/screens/admin_screens/second_screen_statistics.dart';
import 'package:first_app_flutter/screens/admin_screens/third_screen_statistics.dart';
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
            iconTheme: const IconThemeData(
              color: Color(0xFF124559), //change your color here
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text('Statistics',
                style: TextStyle(color: Color(0xFF124559))),
            bottom: const TabBar(
              labelColor: Color(0xFF124559),
              tabs: [
                Tab(
                  text: 'Monthly stats',
                ),
                Tab(
                  text: 'Annual stats',
                ),
                Tab(
                  text: 'Rooms stats',
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
