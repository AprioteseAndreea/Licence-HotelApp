import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/authentication/register.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late List<User> users = [];
  bool _obscuredText = true, _checked = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readEmail();
    });
  }

  Future<void> _readEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('email');
    final _rememberIsChecked = _prefs.getString('rememberIsChecked');

    if (_value != null && _rememberIsChecked == "true") {
      setState(() {
        _emailController.text = _value;
        _checked = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final userService = Provider.of<UserService>(context);

    Size mediaQuery = MediaQuery.of(context).size;

    users = userService.getUsers();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/grand_hotel_logo4.jpg',
              ), //   <--- image
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: mediaQuery.height * 0.015),
                      Text(
                        Strings.welcomeBack,
                        style: TextStyle(
                          color: const Color(0xFF124559),
                          fontSize: mediaQuery.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.015),
                      Text(
                        Strings.signInToContinue,
                        style: TextStyle(
                            fontSize: mediaQuery.width * 0.045,
                            color: Colors.grey),
                      ),
                      SizedBox(height: mediaQuery.height * 0.03),
                      TextFormField(
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.04,
                        ),
                        controller: _emailController,
                        validator: (val) =>
                            val!.isNotEmpty ? null : Strings.errorEnterEmail,
                        decoration: InputDecoration(
                          hintText: Strings.email,
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Color(0xFF124559),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.03),
                      TextFormField(
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.04,
                        ),
                        controller: _passwordController,
                        // validator: FieldValidator.validatePassword,
                        obscureText: _obscuredText,
                        decoration: InputDecoration(
                            suffixIcon: TextButton(
                                onPressed: _toggle,
                                child: Icon(Icons.remove_red_eye,
                                    color: _obscuredText
                                        ? Colors.black12
                                        : const Color(0xFFF0972D))),
                            hintText: Strings.password,
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFF124559),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      CheckboxListTile(
                        title: Text(
                          Strings.rememberMe,
                          style: TextStyle(
                              fontSize: mediaQuery.width * 0.04,
                              color: const Color(0xFF124559),
                              fontWeight: FontWeight.bold),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _checked,
                        onChanged: (bool? value) {
                          setState(() {
                            _checked = value!;
                          });
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                        activeColor: Colors.white,
                        checkColor: Theme.of(context).primaryColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ),
                              )
                            },
                            child: Text(
                              Strings.forgotPassword,
                              style: TextStyle(
                                  fontSize: mediaQuery.width * 0.035,
                                  color: const Color(0xFFF0972D),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: mediaQuery.height * 0.05),
                      MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(
                                'email', _emailController.text);
                            if (_checked) {
                              prefs.setString(
                                  'rememberIsChecked', _checked.toString());
                            }

                            await loginProvider.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
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
                            ? const CircularProgressIndicator()
                            : Text(
                                Strings.login,
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.042,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            Strings.doYouHaveAnAccount,
                            style:
                                TextStyle(fontSize: mediaQuery.width * 0.035),
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(width: mediaQuery.height * 0.01),
                          TextButton(
                            // onPressed: () => widget.toggleScreen(),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              )
                            },
                            child: Text(
                              Strings.register,
                              style: TextStyle(
                                  fontSize: mediaQuery.width * 0.035,
                                  color: const Color(0xFFF0972D),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: mediaQuery.height * 0.02),
                      if (loginProvider.errorMessage != "")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          color: Colors.amberAccent,
                          child: ListTile(
                            title: Text(loginProvider.errorMessage,
                                style: TextStyle(
                                    fontSize: mediaQuery.width * 0.035)),
                            leading: const Icon(Icons.error),
                            trailing: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => loginProvider.setMessage(""),
                            ),
                          ),
                        )
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
