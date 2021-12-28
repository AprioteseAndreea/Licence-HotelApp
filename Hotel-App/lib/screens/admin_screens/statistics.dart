import 'package:first_app_flutter/models/monthly_reservation_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/screens/services/statistics_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

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
    final statisticsService = Provider.of<StatisticsService>(context);
    List<charts.Series<MonthlyRModel, int>> series = [
      charts.Series(
          id: "MontlyReservations",
          data: statisticsService.getMonthlyReservations(),
          domainFn: (MonthlyRModel series, _) => int.parse(series.month),
          measureFn: (MonthlyRModel series, _) => series.numberOfR,
          colorFn: (MonthlyRModel series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Statistics',
              style: TextStyle(color: Color(0xFF124559))),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Expanded(
                  child: charts.LineChart(
                    series,
                    animate: true,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class TagModel {
  String id;
  String title;

  TagModel({
    required this.id,
    required this.title,
  });
}
