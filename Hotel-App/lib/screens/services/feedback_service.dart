import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:flutter/cupertino.dart';

class FeedbackService with ChangeNotifier {
  FirebaseFirestore? _instance;

  final List<FeedbackModel> _feedbacks = [];
  String name = "";

  List<FeedbackModel> getFeedbacks() {
    return _feedbacks;
  }

  FeedbackService() {
    getFeedbacksCollectionFromFirebase();
  }
  Future<void> getFeedbacksCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('feedbacks').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var feedbacksData = data['feedbacks'] as List<dynamic>;
      for (var feedbackData in feedbacksData) {
        FeedbackModel feedback = FeedbackModel.fromJson(feedbackData);
        _feedbacks.add(feedback);
      }
    }
  }

  Future<void> addFeedbackInFirebase(FeedbackModel f) async {
    DocumentReference<Map<String, dynamic>> feedbacks =
        FirebaseFirestore.instance.collection('users').doc('feedbacks');
    _feedbacks.add(f);
    final feedbackMap = <Map<String, dynamic>>[];
    for (var f in _feedbacks) {
      feedbackMap.add(f.toJson());
    }
    feedbacks.set({
      'feedbacks': feedbackMap,
    });
  }
}
