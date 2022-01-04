import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/annual_revenue_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late List<AnnualRModel> _monthlyReservations;

  late List<charts.Series<AnnualRModel, String>> series = [];

  _generateData(monthlyReservations) {
    series.clear();
    series.add(charts.Series(
        id: "Annual Revenue",
        data: monthlyReservations,
        domainFn: (AnnualRModel series, _) => series.year,
        measureFn: (AnnualRModel series, _) => series.revenue,
        colorFn: (AnnualRModel m, _) =>
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
            height: mediaQuery.height * 0.6,
            child: _buildAnnualRevenue(context),
          ),
        ],
      )),
    ));
  }

  Widget _buildAnnualRevenue(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else {
            List<dynamic> monthlyReservations = snapshot.data!.docs
                .firstWhere(
                    (element) => element.id == 'annualRevenue')['annual']
                .map((doc) => AnnualRModel.fromJson(doc))
                .toList();

            return _buildChart(context, monthlyReservations);
          }
        });
  }

  Widget _buildChart(BuildContext context, List<dynamic> monthlyReservations) {
    _monthlyReservations = monthlyReservations.cast<AnnualRModel>();
    _generateData(_monthlyReservations);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Annual revenue',
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
