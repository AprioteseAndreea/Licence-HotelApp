import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'add_feedback.dart';
import 'notifiers.dart';

class Feedback extends StatefulWidget {
  const Feedback({Key? key}) : super(key: key);
  @override
  _Feedback createState() => _Feedback();
}

class _Feedback extends State<Feedback> {
  late List<FeedbackModel> feedbacks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedbackService = Provider.of<FeedbackService>(context);
    feedbacks = feedbackService.getFeedbacks();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Feedback'),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.add_circled,
              size: 30,
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddFeedback(),
                ),
              )
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs
                          .firstWhere((element) => element.id == 'feedbacks')[
                              'feedbacks']
                          .map<Widget>((doc) => Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(doc['user']),
                                      subtitle: Text('Posted ${doc['date']}'),
                                      trailing: SmoothStarRating(
                                        allowHalfRating: true,
                                        rating: double.parse(doc['stars']),
                                        starCount: 5,
                                        size: 20.0,
                                        isReadOnly: false,
                                        color: const Color(0xFFF0972D),
                                        borderColor: const Color(0xFFCD7700),
                                        spacing: 0.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 10),
                                      child: Text(
                                        doc['feedback'],
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic),
                                        maxLines: 5,
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return const Text('No feedbacks');
                }
                throw ('Some error occurred...');
              }),
        ),
      ),
    );
  }
}
