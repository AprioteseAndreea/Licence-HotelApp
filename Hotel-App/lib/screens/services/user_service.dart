import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserService with ChangeNotifier {
  FirebaseFirestore? _instance;

  final List<User> _users = [];

  List<User> getCategories() {
    return _users;
  }

  UserService() {
    getCategoriesCollectionFromFirebase();
  }
  Future<void> getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('myUsers').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['users'] as List<dynamic>;
      for (var catData in categoriesData) {
        User user = User.fromJson(catData);
        _users.add(user);
      }
    }
  }
}
