import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/screens/user_screens/feedback.dart'
    as FeedBackScreen;
import 'package:first_app_flutter/utils/strings.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
    date = DateFormat('MMMM dd, yyyy').format(dateToday);

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
          centerTitle: true,
          title: Text(
            Strings.addNewFeedback,
            style: TextStyle(color: Color(Strings.darkTurquoise)),
          ),
          iconTheme: IconThemeData(
            color: Color(Strings.darkTurquoise),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Text(
                  Strings.sendUsYourFeedback,
                  style: TextStyle(
                    color: Color(Strings.darkTurquoise),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 8),
                  child: Text(
                    Strings.facilityPhrase,
                    style: const TextStyle(
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
                        Text(
                          Strings.howWasYourExperience,
                          style: TextStyle(
                            color: Color(Strings.darkTurquoise),
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
                          decoration: InputDecoration(
                            hintText: Strings.describeYourExperience,
                            border: const OutlineInputBorder(),
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
                            if (_feedbackController.text != "") {
                              feedbackService.addFeedbackInFirebase(feedback);
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FeedBackScreen.Feedback(),
                                ));
                          },
                          height: 55,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            Strings.sendFeedback,
                            style: const TextStyle(
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
