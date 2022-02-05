class User {
  late String email;
  late String name;
  late String phoneNumber;
  late String role;
  late String gender;
  late String old;
  String? referenceId;
  User(
      {required this.email,
      required this.name,
      required this.phoneNumber,
      required this.role,
      required this.gender,
      required this.old});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        role: json['role'],
        gender: json['gender'],
        old: json['old']);
  }
  Map<String, dynamic> toJson() => userToJson(this);
  Map<String, dynamic> userToJson(User user) => <String, dynamic>{
        "email": user.email,
        "name": user.name,
        "phoneNumber": user.phoneNumber,
        "role": user.role,
        "gender": user.gender,
        "old": user.old
      };
}
