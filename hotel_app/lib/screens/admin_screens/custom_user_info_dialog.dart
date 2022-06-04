import 'dart:ui';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String userName, userPhone, userEmail, userOld, userGender;

  const CustomDialogBox(
      {Key? key,
      required this.userName,
      required this.userPhone,
      required this.userEmail,
      required this.userOld,
      required this.userGender})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: 20, top: 45 + 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 5),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.userName,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.envelope_fill,
                    color: Color(0xFFF0972D),
                    size: 20,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.userEmail,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF124559),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.phone_fill,
                    color: Color(0xFFF0972D),
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.userPhone,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF124559),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.close,
                      style: const TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: widget.userGender == Strings.male
                    ? const CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFFF0972D),
                        child: CircleAvatar(
                            radius: 42,
                            backgroundImage:
                                AssetImage('assets/images/male2.png')))
                    : const CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFFF0972D),
                        child: CircleAvatar(
                            radius: 42,
                            backgroundImage:
                                AssetImage('assets/images/female.png')))),
          ),
        ),
      ],
    );
  }
}
