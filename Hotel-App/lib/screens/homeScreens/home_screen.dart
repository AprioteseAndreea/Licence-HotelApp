import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/repository/user_repository.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  UserService userService = UserService();
  late List<User> users = [];
  String name = '';

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final userService = Provider.of<UserService>(context);
    name = userService.getName();
    users = userService.getUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async => await loginProvider.logout(),
          )
        ],
      ),

      // body: StreamBuilder<QuerySnapshot>(
      //     stream: userRepository.getStream(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) return const LinearProgressIndicator();
      //
      //       final data = snapshot.requireData;
      //       return ListView.builder(
      //           itemCount: data.size,
      //           itemBuilder: (context, index) {
      //             if (data.docs[index]['name'] == 'Andreea') {
      //               name = data.docs[index]['name'];
      //             }
      //             return Text('User name: $name');
      //           });
      //     }),
    );
  }
}
