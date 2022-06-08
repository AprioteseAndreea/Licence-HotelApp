import 'package:first_app_flutter/models/comment_model.dart';
import 'package:first_app_flutter/models/post_model.dart';
import 'package:first_app_flutter/screens/services/posts_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final ScrollController _controller = ScrollController();
  PostsService postsService = PostsService();
  List<Post> postsList = [];

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
    postsService = Provider.of<PostsService>(context);
    postsList = [];
    postsList = postsService.getPosts();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(Strings.darkTurquoise),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            Strings.posts,
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
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            itemCount: postsList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        postsList[index].userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(Strings.darkTurquoise)),
                      ),
                      subtitle: Text('Posted ${postsList[index].date}'),
                      leading: postsList[index].gender == Strings.male
                          ? Padding(
                              padding: const EdgeInsets.only(top: 7, bottom: 4),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(Strings.orange),
                                  child: const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          'assets/images/male2.png'))),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 7, bottom: 4),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(Strings.orange),
                                  child: const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          'assets/images/female.png'))),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Text(
                        postsList[index].post,
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
                                  text: postsList[index]
                                          .comments
                                          .cast<Comment>()
                                          .length
                                          .toString() +
                                      " " +
                                      "comments",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      List<Comment> postsComments = [];
                                      var commentsData =
                                          postsList[index].comments;
                                      for (var c in commentsData) {
                                        postsComments.add(c);
                                      }
                                      postsList[index].comments = postsComments;

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Comments(
                                            currentPost: postsList[index],
                                            loggedUser: userName,
                                          ),
                                        ),
                                      );
                                    }),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
        )));
  }
}
