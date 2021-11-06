import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

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
          title: Text('Feedback ${feedbacks.length}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_comment),
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
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: feedbacks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(feedbacks[index].user),
                          subtitle: Text('Posted ${feedbacks[index].date}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: Text(
                            feedbacks[index].feedback,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                            maxLines: 5,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ));
  }
}
