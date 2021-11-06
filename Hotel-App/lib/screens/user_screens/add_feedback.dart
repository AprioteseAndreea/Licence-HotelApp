import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFeedback extends StatefulWidget {
  const AddFeedback({Key? key}) : super(key: key);
  @override
  _AddFeedback createState() => _AddFeedback();
}

class _AddFeedback extends State<AddFeedback> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late List<FeedbackModel> feedbacks = [];

  double rating = 5.0;
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
          title: const Text('Feedback'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Text(
                  "Send us your feedback!",
                  style: TextStyle(
                    color: Color(0xFF124559),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 8),
                  child: Text(
                    "Please tell us what your experience at the Grand Hotel was like",
                    style: TextStyle(
                      color: Color(0xFF5E676C),
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Image.asset(
                  'assets/images/feedback_image_two.jpg',
                  height: 200,
                ), //   <--- image
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "How was your experience?",
                          style: TextStyle(
                            color: Color(0xFF124559),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SmoothStarRating(
                          allowHalfRating: true,
                          onRated: (v) {
                            setState(() {
                              rating = v;
                            });
                          },
                          rating: 5.0,
                          starCount: 5,
                          size: 40.0,
                          isReadOnly: true,
                          color: Colors.green,
                          borderColor: Colors.green,
                          spacing: 0.0,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          height: 55,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "Send feedback",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
