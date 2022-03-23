import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService with ChangeNotifier {
  FirebaseFirestore? _instance;
  final List<User> _users = [];
  final List<Staff> _staff = [];

  String name = "";

  List<User> getUsers() {
    return _users;
  }

  String getName() {
    return name;
  }

  UserService() {
    getUsersCollectionFromFirebase();
    getNameFromSharedPrefs();
    getStaffCollectionFromFirebase();
  }
  Future<void> getUsersCollectionFromFirebase() async {
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

  Future<void> getStaffCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('staff').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var staffData = data['staff'] as List<dynamic>;
      for (var data in staffData) {
        Staff staff = Staff.fromJson(data);
        _staff.add(staff);
      }
    }

    // getNameFromSharedPrefs();
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

  Future<void> addStaffInFirebase(Staff staff) async {
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users').doc('staff');
    _staff.add(staff);
    final staffMap = <Map<String, dynamic>>[];
    for (var staff in _staff) {
      staffMap.add(staff.toJson());
    }
    users.set({
      'staff': staffMap,
    });
  }

  Future<void> updateStaffInFirebase(Staff staff) async {
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users').doc('staff');

    for (int i = 0; i < _staff.length; i++) {
      if (_staff[i].email == staff.email) {
        _staff[i].email = staff.email;
        _staff[i].gender = staff.gender;
        _staff[i].name = staff.name;
        _staff[i].old = staff.old;
        _staff[i].phone = staff.phone;
        _staff[i].position = staff.position;
        _staff[i].salary = staff.salary;
      }
    }
    final staffMap = <Map<String, dynamic>>[];
    for (var f in _staff) {
      staffMap.add(f.toJson());
    }
    users.set({
      'staff': staffMap,
    });
  }

  Future<void> updateUserInFirebase(
      String email, String name, String phoneNumber) async {
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users').doc('myUsers');

    for (int i = 0; i < _users.length; i++) {
      if (_users[i].email == email) {
        _users[i].email = email;
        _users[i].name = name;
        _users[i].phoneNumber = phoneNumber;
      }
    }
    final usersMap = <Map<String, dynamic>>[];
    for (var f in _users) {
      usersMap.add(f.toJson());
    }
    users.set({
      'users': usersMap,
    });
  }

  Future<void> getNameFromSharedPrefs() async {
    final _prefs = await SharedPreferences.getInstance();
    String? email = _prefs.getString('email');
    String name = "",
        phoneNumber = "",
        role = "",
        gender = "",
        old = "",
        position = "";
    int salary = 0;
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].email == email) {
        name = _users[i].name;
        phoneNumber = _users[i].phoneNumber;
        role = _users[i].role;
        gender = _users[i].gender;
        old = _users[i].old;
      }
    }
    // for (int i = 0; i < _staff.length; i++) {
    //   if (_staff[i].email == email) {
    //     name = _staff[i].name;
    //     phoneNumber = _staff[i].phone;
    //     role = "staff";
    //     gender = _staff[i].gender;
    //     old = _staff[i].old;
    //     position = _staff[i].position;
    //     salary = _staff[i].salary;
    //   }
    // }
    await _prefs.setString('name', name);
    await _prefs.setString('phoneNumber', phoneNumber);
    if (role == "") {
      await _prefs.setString('role', "staff");
    } else {
      await _prefs.setString('role', role);
    }
    await _prefs.setString('gender', gender);
    await _prefs.setString('old', old);
    await _prefs.setString('position', position);
    await _prefs.setString('salary', salary.toString());
  }
}
