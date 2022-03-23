import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/comment_model.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_post.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);
  @override
  _Posts createState() => _Posts();
}

class _Posts extends State<Posts> {
  @override
  void initState() {
    super.initState();
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
                    builder: (context) => const AddPost(),
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
                                      child: Text(
                                        doc['comments']
                                                .cast<Comment>()
                                                .length
                                                .toString() +
                                            " " +
                                            "comments",
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                        maxLines: 5,
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
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
