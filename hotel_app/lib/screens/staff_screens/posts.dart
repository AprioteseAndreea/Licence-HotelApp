import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/comment_model.dart';
import 'package:first_app_flutter/models/post_model.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_post.dart';
import 'comments.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);
  @override
  _Posts createState() => _Posts();
}

class _Posts extends State<Posts> {
  String userName = "", gender = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readName();
    });
  }

  Future<void> _readName() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('name');
    final _gender = _prefs.getString('gender');

    if (_value != null) {
      setState(() {
        userName = _value;
      });
    }
    if (_gender != null) {
      setState(() {
        gender = _gender;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Posts',
            style: TextStyle(color: Color(0xFF124559)),
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
                    builder: (context) => AddPost(
                      name: userName,
                      gender: gender,
                    ),
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
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      children: snapshot.data!.docs
                          .firstWhere(
                              (element) => element.id == 'posts')['posts']
                          .map<Widget>((doc) => Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        doc['userName'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color(0xFF124559)),
                                      ),
                                      subtitle: Text('Posted ${doc['date']}'),
                                      leading: doc['gender'] == 'male'
                                          ? const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 7, bottom: 4),
                                              child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      Color(0xFFF0972D),
                                                  child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/male2.png'))),
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 7, bottom: 4),
                                              child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      Color(0xFFF0972D),
                                                  child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/female.png'))),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 10),
                                      child: Text(
                                        doc['post'],
                                        style: const TextStyle(fontSize: 18),
                                        maxLines: 5,
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: doc['comments']
                                                          .cast<Comment>()
                                                          .length
                                                          .toString() +
                                                      " " +
                                                      "comments",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Post post =
                                                              Post.fromJson(
                                                                  doc);

                                                          List<Comment>
                                                              postsComments =
                                                              [];
                                                          var commentsData =
                                                              doc['comments']
                                                                  as List<
                                                                      dynamic>;
                                                          for (var c
                                                              in commentsData) {
                                                            Comment comm =
                                                                Comment
                                                                    .fromJson(
                                                                        c);
                                                            postsComments
                                                                .add(comm);
                                                          }
                                                          post.comments =
                                                              postsComments;

                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Comments(
                                                                currentPost:
                                                                    post,
                                                                loggedUser:
                                                                    userName,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return const Text('No feedbacks');
                }
                return const CircularProgressIndicator();
              }),
        )));
  }
}
