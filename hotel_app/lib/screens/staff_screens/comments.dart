import 'package:first_app_flutter/models/comment_model.dart';
import 'package:first_app_flutter/models/post_model.dart';
import 'package:first_app_flutter/screens/services/posts_service.dart';
import 'package:first_app_flutter/screens/staff_screens/posts.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final Post currentPost;
  final String loggedUser;
  const Comments(
      {Key? key, required this.currentPost, required this.loggedUser})
      : super(key: key);
  @override
  _Comments createState() => _Comments();
}

class _Comments extends State<Comments> {
  late TextEditingController _commentController;
  late PostsService postsService = PostsService();

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final postsService = Provider.of<PostsService>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(Strings.darkTurquoise),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            Strings.comments,
            style: TextStyle(color: Color(Strings.darkTurquoise)),
          ),
          actions: [
            if (super.widget.loggedUser == super.widget.currentPost.userName)
              IconButton(
                icon: const Icon(
                  CupertinoIcons.delete,
                  size: 25,
                ),
                onPressed: () => {showAlertDialog(context)},
              ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Posts(),
                      ));
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        super.widget.currentPost.userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(Strings.darkTurquoise)),
                      ),
                      subtitle: Text('Posted ${super.widget.currentPost.date}'),
                      leading: super.widget.currentPost.gender == 'male'
                          ? const Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 4),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xFFF0972D),
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          'assets/images/male2.png'))),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 4),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xFFF0972D),
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
                        super.widget.currentPost.post,
                        style: const TextStyle(fontSize: 18),
                        maxLines: 5,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: super.widget.currentPost.comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Row(
                              children: [
                                Text(
                                  super.widget.currentPost.comments[index].user,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  super
                                      .widget
                                      .currentPost
                                      .comments[index]
                                      .hour
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                )
                              ],
                            ),
                            subtitle: Text(
                              super
                                  .widget
                                  .currentPost
                                  .comments[index]
                                  .comment
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          );
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: Strings.addYourCommentHere,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      DateTime now = DateTime.now(); // 30/09/2021 15:54:30
                      String hour =
                          now.hour.toString() + ":" + now.minute.toString();
                      if (_commentController.text != "") {
                        Comment newComment = Comment(
                            user: super.widget.loggedUser,
                            comment: _commentController.text,
                            hour: hour);
                        setState(() {
                          super.widget.currentPost.comments.add(newComment);
                        });
                        _commentController = TextEditingController();
                        super.widget.currentPost.comments;
                        await postsService
                            .updatePostInFirebase(super.widget.currentPost);
                      }
                    },
                    height: 40,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      Strings.post,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(Strings.cancel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
        child: Text(Strings.ok),
        onPressed: () async {
          await postsService.deletePostInFirebase(super.widget.currentPost);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Posts(),
              ));
        });
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Strings.deleteRoom),
      content: Text(Strings.deletePostQuestion),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
