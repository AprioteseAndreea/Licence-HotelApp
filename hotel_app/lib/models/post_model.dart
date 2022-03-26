import 'package:first_app_flutter/models/comment_model.dart';

class Post {
  late String userName;
  late String post;
  late String gender;
  late String date;
  late List<Comment> comments = [];
  Post(
      {required this.userName,
      required this.post,
      required this.gender,
      required this.date,
      required this.comments});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userName: json['userName'],
        post: json['post'],
        gender: json['gender'],
        date: json['date'],
        comments: json['comments'].cast<Comment>());
  }
  Map<String, dynamic> toJson() => postToJson(this);
  Map<String, dynamic> postToJson(Post post) => <String, dynamic>{
        "userName": post.userName,
        "post": post.post,
        "gender": post.gender,
        "date": post.date,
        "comments": post.comments
      };
}
