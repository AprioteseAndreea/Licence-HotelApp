import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService with ChangeNotifier {
  FirebaseFirestore? _instance;

  final List<User> _users = [];
  String name = "";

  List<User> getUsers() {
    return _users;
  }

  String getName() {
    return name;
  }

  UserService() {
    getCategoriesCollectionFromFirebase();
    getNameFromSharedPrefs();
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
    getNameFromSharedPrefs();
  }

  Future<void> addUserInFirebase(User user) async {
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users').doc('myUsers');
    _users.add(user);
    final usersMap = <Map<String, dynamic>>[];
    for (var user in _users) {
      usersMap.add(user.toJson());
    }
    users.set({
      'users': usersMap,
    });
  }

  Future<void> getNameFromSharedPrefs() async {
    final _prefs = await SharedPreferences.getInstance();
    String? email = _prefs.getString('email');
    String _name = "", phoneNumber = "", role = "";
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].email == email) {
        _name = _users[i].name;
        phoneNumber = _users[i].phoneNumber;
        role = _users[i].role;
        name = _name;
      }
    }
    _prefs.setString('name', _name);
    _prefs.setString('phoneNumber', phoneNumber);
    _prefs.setString('role', role);
  }
}
