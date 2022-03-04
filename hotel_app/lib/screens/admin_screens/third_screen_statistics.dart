import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/rooms_statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late List<RoomStatisticsModel> _roomsStatistics;

  late List<charts.Series<RoomStatisticsModel, String>> series = [];
  calculatePercentage(int value) {
    return ((value * 100) /
            (_roomsStatistics[0].value + _roomsStatistics[1].value))
        .toStringAsPrecision(4);
  }

  _generateData(roomStatistics) {
    series.clear();
    series.add(charts.Series(
        id: "Rooms statistics",
        data: roomStatistics,
        domainFn: (RoomStatisticsModel series, _) =>
            '${calculatePercentage(series.value)}% ${series.status}',
        measureFn: (RoomStatisticsModel series, _) => series.value,
        colorFn: (RoomStatisticsModel m, _) =>
            charts.Color.fromHex(code: m.color)));
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: mediaQuery.height * 0.6,
            child: _buildRoomsStatistics(context),
          ),
        ],
      )),
    ));
  }

  Widget _buildRoomsStatistics(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else {
            List<dynamic> roomsStatistics = snapshot.data!.docs
                .firstWhere((element) => element.id == 'roomStatistics')[
                    'roomStatistics']
                .map((doc) => RoomStatisticsModel.fromJson(doc))
                .toList();

            return _buildChart(context, roomsStatistics);
          }
        });
  }

  Widget _buildChart(BuildContext context, List<dynamic> roomsStatistics) {
    _roomsStatistics = roomsStatistics.cast<RoomStatisticsModel>();
    _generateData(_roomsStatistics);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Rooms statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: charts.PieChart(
                series,
                defaultRenderer: charts.ArcRendererConfig(
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside)
                    ]),
                animate: true,
                animationDuration: const Duration(seconds: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
