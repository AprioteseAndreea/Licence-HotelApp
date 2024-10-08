import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/post_model.dart';
import 'package:flutter/cupertino.dart';

class PostsService with ChangeNotifier {
  static final PostsService _singletonPosts = PostsService._interval();
  PostsService._interval();

  FirebaseFirestore? _instance;
  final List<Post> _posts = [];

  factory PostsService() {
    return _singletonPosts;
  }
  List<Post> getPosts() {
    return _posts;
  }

  Future<void> getPostsCollectionFromFirebase() async {
    _posts.clear();
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc('posts').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomsData = data['posts'] as List<dynamic>;
      for (var roomData in roomsData) {
        Post post = Post.fromJson(roomData);
        if (!verifyIfAlreadyPostExist(post)) {
          _posts.add(post);
        }
      }
    }
  }

  bool verifyIfAlreadyPostExist(Post post) {
    for (var p in _posts) {
      if (p.post == post.post && p.userName == post.userName) return true;
    }
    return false;
  }

  Future<void> addPostInFirebase(Post p) async {
    DocumentReference<Map<String, dynamic>> feedbacks =
        FirebaseFirestore.instance.collection('users').doc('posts');
    _posts.add(p);
    final postsMap = <Map<String, dynamic>>[];
    for (var f in _posts) {
      postsMap.add(f.toJSON());
    }
    feedbacks.set({
      'posts': postsMap,
    });
  }

  Future<void> deletePostInFirebase(Post p) async {
    DocumentReference<Map<String, dynamic>> rooms =
        FirebaseFirestore.instance.collection('users').doc('posts');
    for (int i = 0; i < _posts.length; i++) {
      if (_posts[i].userName == p.userName &&
          _posts[i].post == p.post &&
          _posts[i].date == p.date) {
        _posts.remove(_posts[i]);
      }
    }
    final postsMap = <Map<String, dynamic>>[];
    for (var f in _posts) {
      postsMap.add(f.toJson());
    }
    rooms.set({
      'posts': postsMap,
    });
  }

  Future<void> updatePostInFirebase(Post post) async {
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users').doc('posts');

    for (int i = 0; i < _posts.length; i++) {
      if (_posts[i].userName == post.userName && _posts[i].post == post.post) {
        _posts[i].post = post.post;
        _posts[i].userName = post.userName;
        _posts[i].date = post.date;
        _posts[i].gender = post.gender;
        _posts[i].comments = post.comments;
      }
    }
    final staffMap = <Map<String, dynamic>>[];
    for (var f in _posts) {
      staffMap.add(f.toJSON());
    }
    users.set({
      'posts': staffMap,
    });
  }
}
