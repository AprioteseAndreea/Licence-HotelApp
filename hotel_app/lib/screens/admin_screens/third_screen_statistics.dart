import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/rooms_statistics.dart';
import 'package:first_app_flutter/screens/services/statistics_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  StatisticsService statisticsService = StatisticsService();
  List<RoomStatisticsModel> _roomsStatistics = [];
  late List<charts.Series<RoomStatisticsModel, String>> series = [];
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getRoomsStatistics();
    });
    super.initState();
  }

  Future<void> getRoomsStatistics() async {
    await statisticsService.calculateRoomsStatistics();
    _roomsStatistics = statisticsService.getRoomsStatistics();
  }

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
            '${calculatePercentage(series.value)}%',
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
          )
        ],
      )),
    ));
  }

  Widget _buildRoomsStatistics(BuildContext context) {
    _roomsStatistics = statisticsService.getRoomsStatistics();
    return _buildChart(context, _roomsStatistics);
  }

  Widget _buildChart(
      BuildContext context, List<RoomStatisticsModel> roomsStatistics) {
    Size mediaQuery = MediaQuery.of(context).size;
    _roomsStatistics = statisticsService.getRoomsStatistics();
    _generateData(_roomsStatistics);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text(
              Strings.roomsStatistics,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(Strings.darkTurquoise)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              Strings.roomsStatisticsTitle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: mediaQuery.width * 0.048, color: Colors.grey),
              maxLines: 2,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color(0xFFFFFFFF),
                    elevation: 5,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            CupertinoIcons.bed_double_fill,
                            color: Color(0xFFF0972D),
                            size: 30,
                          ),
                          Text(
                            Strings.capsFREE,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(Strings.orange)),
                          ),
                          Text(
                            _roomsStatistics[0].value.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(Strings.orange)),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color(0xFFFFFFFF),
                    elevation: 5,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            CupertinoIcons.bed_double_fill,
                            color: Color(Strings.darkTurquoise),
                            size: 30,
                          ),
                          Text(
                            Strings.capsOCCUPIED,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(Strings.darkTurquoise)),
                          ),
                          Text(
                            _roomsStatistics[1].value.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(Strings.darkTurquoise)),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
