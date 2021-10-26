import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/user_model.dart' as UserModel;
import 'package:first_app_flutter/repository/user_repository.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({Key? key}) : super(key: key);
  @override
  _StaffHomeScreen createState() => _StaffHomeScreen();
}

class _StaffHomeScreen extends State<StaffHomeScreen> {
  UserService userService = UserService();
  late List<UserModel.User> users = [];
  String? name, role;
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
    });
  }

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');

    if (_value != null) {
      setState(() {
        role = _value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final userService = Provider.of<UserService>(context);

    users = userService.getUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grand Hotel - Staff interface',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async => await loginProvider.logout(),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Buna: $name, your role is: $role '),
          ],
        ),
      ),
    );
  }
}
