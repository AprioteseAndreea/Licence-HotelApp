import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/screens/user_screens/feedback.dart'
    as FeedbackScreen;
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
  late TextEditingController _feedbackController;
  String name = "", date = "";
  AuthServices authServices = AuthServices();
  double rating = 5.0;
  @override
  void initState() {
    DateTime dateToday = DateTime.now();
    date = dateToday.toString().substring(0, 10);

    super.initState();
    _feedbackController = TextEditingController();

    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
      });
    });
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
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 8),
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
                  'assets/images/feedback_background3.jpg',
                  height: 200,
                ),
                const SizedBox(
                  height: 20,
                ), //   <--- image
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "How was your experience?",
                          style: TextStyle(
                            color: Color(0xFF124559),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 15,
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
                          isReadOnly: false,
                          color: const Color(0xFFF0972D),
                          borderColor: const Color(0xFFCD7700),
                          spacing: 0.0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _feedbackController,
                          decoration: const InputDecoration(
                            hintText: "Describe your experience here ...",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            FeedbackModel feedback = FeedbackModel(
                                user: name,
                                date: date,
                                feedback: _feedbackController.text,
                                stars: rating.toString());
                            feedbackService.addFeedbackInFirebase(feedback);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FeedbackScreen.Feedback(),
                                ),
                                ModalRoute.withName('/'));
                          },
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
