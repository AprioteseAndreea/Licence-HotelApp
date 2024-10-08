import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'add_feedback.dart';

class Feedback extends StatefulWidget {
  const Feedback({Key? key}) : super(key: key);
  @override
  _Feedback createState() => _Feedback();
}

class _Feedback extends State<Feedback> {
  final ScrollController _controller = ScrollController();
  FeedbackService feedbackService = FeedbackService();
  List<FeedbackModel> feedbacks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    feedbacks = [];
    feedbacks = feedbackService.getFeedbacks();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Strings.feedbacks,
          style: TextStyle(color: Color(Strings.darkTurquoise)),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.plus_circle_fill,
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
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        feedbacks[index].user,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(Strings.darkTurquoise)),
                      ),
                      subtitle: Text('Posted ${feedbacks[index].date}'),
                      trailing: SmoothStarRating(
                        allowHalfRating: true,
                        rating: double.parse(feedbacks[index].stars),
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
                        feedbacks[index].feedback,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 16),
                        maxLines: 5,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
