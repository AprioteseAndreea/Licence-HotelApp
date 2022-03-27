class Comment {
  late String user;
  late String comment;
  late String hour;

  Comment({required this.user, required this.comment, required this.hour});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        user: json['user'], comment: json['comment'], hour: json['hour']);
  }

  Map<String, dynamic> toJson() => commentToJson(this);
  Map<String, dynamic> commentToJson(Comment comment) => <String, dynamic>{
        "user": comment.user,
        "comment": comment.comment,
        "hour": comment.hour,
      };
}
