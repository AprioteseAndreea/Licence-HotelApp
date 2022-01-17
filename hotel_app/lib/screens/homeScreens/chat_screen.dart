import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _ChatScreen();
  }
}

class _ChatScreen extends State {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Chat"),
    );
  }
}
