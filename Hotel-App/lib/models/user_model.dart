import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String name;
  final String phoneNumber;
  final String role;
  String? referenceId;
  User(
      {required this.email,
      required this.name,
      required this.phoneNumber,
      required this.role,
      this.referenceId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        role: json['role']);
  }
  Map<String, dynamic> toJson() => userToJson(this);
  Map<String, dynamic> userToJson(User user) => <String, dynamic>{
        "email": user.email,
        "name": user.name,
        "phoneNumber": user.phoneNumber,
        "role": user.role
      };
}
