import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'notifiers.dart';

class GetRoomS2 extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults, children;

  const GetRoomS2(
      {Key? key,
      required this.checkInDate,
      required this.checkOutDate,
      required this.adults,
      required this.children})
      : super(key: key);
  @override
  _GetRoomS2 createState() => _GetRoomS2();
}

class _GetRoomS2 extends State<GetRoomS2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Grand Hotel',
            style: TextStyle(color: Color(0xFF124559)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                StepProgressIndicator(
                  totalSteps: 3,
                  currentStep: 2,
                  size: 13,
                  selectedColor: Color(0xFF124559),
                  unselectedColor: Color(0xFF72B0D4),
                ),
              ],
            ),
          ),
        ));
  }
}
