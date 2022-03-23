import 'dart:ui';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogRoomDetails extends StatefulWidget {
  final String title;

  const CustomDialogRoomDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _CustomDialogRoomDetailsState createState() =>
      _CustomDialogRoomDetailsState();
}

class _CustomDialogRoomDetailsState extends State<CustomDialogRoomDetails> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return AlertDialog(
      title: Text(Strings.room),
      content: SingleChildScrollView(
        child: SizedBox(width: double.infinity, child: Column()),
      ),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(
          child: Text(Strings.ok),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
