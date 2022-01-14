class FeedbackModel {
  final String user;
  final String date;
  final String feedback;
  final String stars;

  FeedbackModel(
      {required this.user,
      required this.date,
      required this.feedback,
      required this.stars});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
        user: json['user'],
        date: json['date'],
        feedback: json['feedback'],
        stars: json['stars']);
  }
  Map<String, dynamic> toJson() => feedbackToJson(this);
  Map<String, dynamic> feedbackToJson(FeedbackModel f) => <String, dynamic>{
        "user": f.user,
        "date": f.date,
        "feedback": f.feedback,
        "stars": f.stars
      };
}
