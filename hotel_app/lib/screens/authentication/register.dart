import 'package:first_app_flutter/models/gender.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/screens/authentication/login.dart';
import 'package:first_app_flutter/screens/homeScreens/home_screen.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:email_validator/email_validator.dart';
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

  bool _obscuredText = true;

  final _formkey = GlobalKey<FormState>();
  List<Gender> genders = [];
  var email = "";
  var name = "";
  var phoneNumber = "";
  String date = "";

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    genders.add(Gender("Male", Icons.male, false));
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
                    top: 10, bottom: 10, left: 20, right: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Create account to continue",
                        style: TextStyle(
                          color: Color(0xFF124559),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) => EmailValidator.validate(value)
                            ? null
                            : "Please enter a valid email",
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon:
                              const Icon(Icons.mail, color: Color(0xFFF0972D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (val) =>
                            val!.length < 6 ? "Enter more than 6 char" : null,
                        controller: _passwordController,
                        obscureText: _obscuredText,
                        decoration: InputDecoration(
                            suffixIcon: TextButton(
                                onPressed: _toggle,
                                child: Icon(Icons.remove_red_eye,
                                    color: _obscuredText
                                        ? Colors.black12
                                        : Theme.of(context).primaryColor)),
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.vpn_key,
                                color: Color(0xFFF0972D)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _fullNameController,
                        validator: (val) =>
                            val!.isNotEmpty ? null : "Please enter full name",
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: const Icon(Icons.person,
                                color: Color(0xFFF0972D)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (val) => val!.length < 10
                            ? "Phone number must be 10 characters."
                            : null,
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            hintText: "Phone number",
                            prefixIcon: const Icon(Icons.phone,
                                color: Color(0xFFF0972D)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            splashColor: const Color(0xFFF0972D),
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
                            splashColor: const Color(0xFFF0972D),
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
                              gender = 'Male';
                            } else if (genders[1].isSelected) {
                              gender = 'Female';
                            } else {
                              gender = 'Other';
                            }
                            User user = User(
                                email: email,
                                name: name,
                                phoneNumber: phoneNumber,
                                role: 'user',
                                gender: gender,
                                old: date);
                            userService.addUserInFirebase(user);

                            Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => const Login(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                ),
                                (route) => false);
                          }
                          // await loginProvider.login(
                          //     _emailController.text.trim(),
                          //     _passwordController.text.trim());
                        },
                        height: 45,
                        minWidth: loginProvider.isLoading ? null : 200,
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
                            : const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ignore: prefer_const_constructors
                          Text("Already have an account?",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
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
                            child: const Text("Login",
                                style: TextStyle(fontSize: 15)),
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
