import 'package:first_app_flutter/models/gender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final Gender _gender;

  const CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Card(
        color: _gender.isSelected ? const Color(0xFF124559) : Colors.white,
        child: Container(
          height: mediaQuery.height * 0.07,
          width: mediaQuery.height * 0.07,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _gender.icon,
                color: _gender.isSelected ? Colors.white : Colors.grey,
                size: mediaQuery.width * 0.05,
              ),
              const SizedBox(height: 10),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.isSelected ? Colors.white : Colors.grey,
                    fontSize: mediaQuery.width * 0.035),
              )
            ],
          ),
        ));
  }
}
