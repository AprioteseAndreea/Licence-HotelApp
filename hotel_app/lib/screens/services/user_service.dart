import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService with ChangeNotifier {
  static final UserService _singletionUsers = UserService._interval();
  UserService._interval();
  FirebaseFirestore? _instance;
  List<User> _users = [];
  late List<Staff> _staff = [];

  String name = "";

  List<User> getUsers() {
    return _users;
  }

  List<Staff> getStaff() {
    return _staff;
  }

  String getName() {
    return name;
  }

  factory UserService() {
    return _singletionUsers;
    // getUsersCollectionFromFirebase();
    // getNameFromSharedPrefs();
    // getStaffCollectionFromFirebase();
  }
  Future<void> getUsersCollectionFromFirebase() async {
    _users.clear();
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
    _staff.clear();
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');
    DocumentSnapshot snapshot = await categories.doc('staff').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var staffData = data['staff'] as List<dynamic>;
      for (var s in staffData) {
        Staff staff = Staff.fromJson(s);
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

  Future<void> deleteStaffFromFirebase(String email) async {
    DocumentReference<Map<String, dynamic>> rooms =
        FirebaseFirestore.instance.collection('users').doc('staff');

    for (int i = 0; i < _staff.length; i++) {
      if (_staff[i].email == email) {
        _staff.remove(_staff[i]);
      }
    }
    final roomsMap = <Map<String, dynamic>>[];
    for (var f in _staff) {
      roomsMap.add(f.toJson());
    }
    rooms.set({
      'staff': roomsMap,
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
    if (_users.isNotEmpty) {
      final usersMap = <Map<String, dynamic>>[];
      for (var f in _users) {
        usersMap.add(f.toJson());
      }
      users.set({
        'users': usersMap,
      });
    }
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
    await _prefs.setString('name', name);
    await _prefs.setString('phoneNumber', phoneNumber);
    await _prefs.setString('role', role);
    await _prefs.setString('gender', gender);
    await _prefs.setString('old', old);
    await _prefs.setString('position', position);
    await _prefs.setString('salary', salary.toString());
  }
}
