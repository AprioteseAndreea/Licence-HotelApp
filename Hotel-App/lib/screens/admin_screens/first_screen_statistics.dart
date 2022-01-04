import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/monthly_reservation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<String> months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  late List<MonthlyRModel> _monthlyReservations;

  late List<charts.Series<MonthlyRModel, String>> series = [];

  _generateData(monthlyReservations) {
    series.clear();
    series.add(charts.Series(
        id: "MontlyReservations",
        data: monthlyReservations,
        domainFn: (MonthlyRModel series, _) => months[int.parse(series.month)],
        measureFn: (MonthlyRModel series, _) => series.numberOfR,
        colorFn: (MonthlyRModel m, _) =>
            charts.MaterialPalette.blue.shadeDefault));
  }

  late List<MonthlyRModel> _monthlyIncome;

  late List<charts.Series<MonthlyRModel, num>> seriesTwo = [];

  _generateDataTwo(monthlyIncome) {
    seriesTwo.add(charts.Series(
        id: "MontlyIncome",
        data: monthlyIncome,
        domainFn: (MonthlyRModel series, _) => int.parse(series.month) + 1,
        measureFn: (MonthlyRModel series, _) => series.numberOfR,
        colorFn: (MonthlyRModel m, _) =>
            charts.MaterialPalette.blue.shadeDefault));
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
            height: mediaQuery.height * 0.4,
            child: _buildMonthlyReservation(context),
          ),
          SizedBox(
            height: mediaQuery.height * 0.4,
            child: _buildMonthlyIncome(context),
          )
        ],
      )),
    ));
  }

  Widget _buildMonthlyReservation(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else {
            List<dynamic> monthlyReservations = snapshot.data!.docs
                .firstWhere(
                    (element) => element.id == 'monthlyReservations')['monthly']
                .map((doc) => MonthlyRModel.fromJson(doc))
                .toList();

            return _buildChart(context, monthlyReservations);
          }
        });
  }

  Widget _buildMonthlyIncome(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else {
            List<dynamic> monthlyReservations = snapshot.data!.docs
                .firstWhere(
                    (element) => element.id == 'monthlyIncome')['monthly']
                .map((doc) => MonthlyRModel.fromJson(doc))
                .toList();

            return _buildChartTwo(context, monthlyReservations);
          }
        });
  }

  Widget _buildChart(BuildContext context, List<dynamic> monthlyReservations) {
    _monthlyReservations = monthlyReservations.cast<MonthlyRModel>();
    _generateData(_monthlyReservations);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Monthly Reservations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,
                animationDuration: const Duration(seconds: 1),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChartTwo(BuildContext context, List<dynamic> monthlyIncome) {
    _monthlyReservations = monthlyIncome.cast<MonthlyRModel>();
    _generateDataTwo(_monthlyReservations);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Monthly Income',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: charts.LineChart(
                seriesTwo,
                domainAxis: const charts.NumericAxisSpec(
                  tickProviderSpec:
                      charts.BasicNumericTickProviderSpec(zeroBound: false),
                ),
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
