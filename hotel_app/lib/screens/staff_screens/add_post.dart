import 'package:first_app_flutter/models/comment_model.dart';
import 'package:first_app_flutter/models/post_model.dart';
import 'package:first_app_flutter/screens/services/posts_service.dart';
import 'package:first_app_flutter/screens/staff_screens/posts.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  final String name, gender;
  const AddPost({Key? key, required this.name, required this.gender})
      : super(key: key);
  @override
  _AddPost createState() => _AddPost();
}

class _AddPost extends State<AddPost> {
  late TextEditingController _postController;
  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final postsService = Provider.of<PostsService>(context);
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Add new post',
          style: TextStyle(color: Color(0xFF124559)),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Image.asset(
            'assets/images/addpost.jpg',
            height: mediaQuery.height * 0.35,
          ),
          Text(
            "Add a new post for your collegues",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(Strings.darkTurquoise)),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
            child: TextField(
              controller: _postController,
              decoration: const InputDecoration(
                hintText: "Add a new post...",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  String hour =
                      now.hour.toString() + ":" + now.minute.toString();
                  String date = hour +
                      ", " +
                      now.day.toString() +
                      "/" +
                      now.month.toString() +
                      "/" +
                      now.year.toString(); // 30/09/2021 15:54:30
                  List<Comment> comments = [];
                  if (_postController.text != "") {
                    Post newPost = Post(
                        userName: super.widget.name,
                        post: _postController.text,
                        gender: super.widget.gender,
                        date: date,
                        comments: comments.cast<Comment>());

                    postsService.addPostInFirebase(newPost);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Posts(),
                        ));
                  }
                },
                height: 40,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Post",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ))),
    );
  }
}
