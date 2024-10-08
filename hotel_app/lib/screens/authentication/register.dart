import 'package:first_app_flutter/models/gender.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/screens/authentication/login.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:first_app_flutter/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication_services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'custom_radio.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumberController;
  final _formkey = GlobalKey<FormState>();
  var email = "", name = "", phoneNumber = "";
  List<Gender> genders = [];
  bool _obscuredText = true;
  String date = "";

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();

    genders.add(Gender("Male", Icons.male, true));
    genders.add(Gender("Female", Icons.female, false));

    DateTime dateToday = DateTime.now();
    date = DateFormat('MMMM dd, yyyy').format(dateToday);

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  List<Map<String, dynamic>> users = [];

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final userService = Provider.of<UserService>(context);
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users').doc('myUsers');
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Image.asset(
                  'assets/images/grand_hotel_logo4.jpg'), //   <--- image
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 10, left: 20, right: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        Strings.createAccountToContinue,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: mediaQuery.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.035,
                        ),
                        controller: _emailController,
                        validator: (value) =>
                            FieldValidator.validateEmail(value),
                        decoration: InputDecoration(
                          hintText: Strings.email,
                          prefixIcon:
                              Icon(Icons.mail, color: Color(Strings.orange)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.035,
                        ),
                        validator: (val) =>
                            FieldValidator.validatePassword(val!),
                        controller: _passwordController,
                        obscureText: _obscuredText,
                        decoration: InputDecoration(
                            suffixIcon: TextButton(
                                onPressed: _toggle,
                                child: Icon(Icons.remove_red_eye,
                                    color: _obscuredText
                                        ? Colors.black12
                                        : Theme.of(context).primaryColor)),
                            hintText: Strings.password,
                            prefixIcon: Icon(Icons.vpn_key,
                                color: Color(Strings.orange)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.035,
                        ),
                        controller: _fullNameController,
                        validator: (val) =>
                            val!.isNotEmpty ? null : Strings.errorFullName,
                        decoration: InputDecoration(
                            hintText: Strings.fullName,
                            prefixIcon: Icon(Icons.person,
                                color: Color(Strings.orange)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.04,
                        ),
                        validator: (val) =>
                            val!.length < 10 ? Strings.enterPhoneNumber : null,
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            hintText: Strings.phoneNumber,
                            prefixIcon:
                                Icon(Icons.phone, color: Color(Strings.orange)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            splashColor: Color(Strings.orange),
                            onTap: () {
                              setState(() {
                                for (var gender in genders) {
                                  gender.isSelected = false;
                                }
                                genders[0].isSelected = true;
                              });
                            },
                            child: CustomRadio(genders[0]),
                          ),
                          InkWell(
                            splashColor: Color(Strings.orange),
                            onTap: () {
                              setState(() {
                                for (var gender in genders) {
                                  gender.isSelected = false;
                                }
                                genders[1].isSelected = true;
                              });
                            },
                            child: CustomRadio(genders[1]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(
                                'email', _emailController.text);
                            await loginProvider.register(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                                _fullNameController.text.trim(),
                                _phoneNumberController.text.trim());
                            String gender = '';
                            if (genders[0].isSelected) {
                              gender = 'male';
                            } else if (genders[1].isSelected) {
                              gender = 'female';
                            }
                            User user = User(
                                email: email,
                                name: name,
                                phoneNumber: phoneNumber,
                                role: 'user',
                                gender: gender,
                                old: date);
                            await userService.addUserInFirebase(user);

                            Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => const Login(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                ),
                                (route) => false);
                          }
                        },
                        height: mediaQuery.width * 0.12,
                        minWidth: loginProvider.isLoading ? null : 150,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: loginProvider.isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            : Text(
                                Strings.register,
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.042,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ignore: prefer_const_constructors
                          Text(Strings.alreadyHaveAnAccount,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: mediaQuery.width * 0.035)),
                          // ignore: prefer_const_constructors
                          SizedBox(width: 3),
                          TextButton(
                            onPressed: () => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) =>
                                        const Login(),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                  (route) => false)
                            },
                            child: Text(Strings.login,
                                style: TextStyle(
                                    fontSize: mediaQuery.width * 0.035)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
