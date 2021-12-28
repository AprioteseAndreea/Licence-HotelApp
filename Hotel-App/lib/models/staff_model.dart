import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Staff {
  final String email;
  final String gender;
  final String name;
  final DateTime old;
  final String phone;
  final String position;
  final int salary;
  Staff({
    required this.email,
    required this.gender,
    required this.name,
    required this.old,
    required this.phone,
    required this.position,
    required this.salary,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
        email: json['email'],
        gender: json['gender'],
        name: json['name'],
        old: json['old'],
        phone: json['phone'],
        position: json['position'],
        salary: json['salary']);
  }
  Map<String, dynamic> toJson() => userToJson(this);
  Map<String, dynamic> userToJson(Staff user) => <String, dynamic>{
        "email": user.email,
        "gender": user.gender,
        "name": user.name,
        "old": user.old,
        "phone": user.phone,
        "position": user.position,
        "salary": user.salary,
      };
}
