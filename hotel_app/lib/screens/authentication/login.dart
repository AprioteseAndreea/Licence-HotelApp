import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/authentication/register.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../wrapper.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    final user = Provider.of<User?>(context);

    Size mediaQuery = MediaQuery.of(context).size;

    users = userService.getUsers();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: defaultTargetPlatform == TargetPlatform.android
                        ? mediaQuery.width
                        : mediaQuery.width * 0.4,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      elevation: 6,
                      shadowColor: const Color(0xFF124559),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: const Color(0xFAFAFAFA),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/grand_hotel_logo4.jpg',
                          ), //   <--- image
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: mediaQuery.height * 0.015),
                                  Text(
                                    Strings.welcomeBack,
                                    style: TextStyle(
                                      color: Color(Strings.darkTurquoise),
                                      fontSize: defaultTargetPlatform ==
                                              TargetPlatform.android
                                          ? mediaQuery.width * 0.05
                                          : mediaQuery.width * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: defaultTargetPlatform ==
                                            TargetPlatform.android
                                        ? mediaQuery.height * 0.015
                                        : mediaQuery.height * 0.02,
                                  ),
                                  Text(
                                    Strings.signInToContinue,
                                    style: TextStyle(
                                        fontSize: defaultTargetPlatform ==
                                                TargetPlatform.android
                                            ? mediaQuery.width * 0.045
                                            : mediaQuery.width * 0.02,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: defaultTargetPlatform ==
                                            TargetPlatform.android
                                        ? mediaQuery.height * 0.03
                                        : mediaQuery.height * 0.02,
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                      fontSize: defaultTargetPlatform ==
                                              TargetPlatform.android
                                          ? mediaQuery.width * 0.04
                                          : mediaQuery.width * 0.015,
                                    ),
                                    controller: _emailController,
                                    validator: (val) => val!.isNotEmpty
                                        ? null
                                        : Strings.errorEnterEmail,
                                    decoration: InputDecoration(
                                      hintText: Strings.email,
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Color(Strings.darkTurquoise),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: mediaQuery.height * 0.03),
                                  TextFormField(
                                    style: TextStyle(
                                      fontSize: defaultTargetPlatform ==
                                              TargetPlatform.android
                                          ? mediaQuery.width * 0.04
                                          : mediaQuery.width * 0.015,
                                    ),
                                    controller: _passwordController,
                                    validator: (val) => val!.isNotEmpty
                                        ? null
                                        : Strings.errorPassword,
                                    obscureText: _obscuredText,
                                    decoration: InputDecoration(
                                        suffixIcon: TextButton(
                                            onPressed: _toggle,
                                            child: Icon(Icons.remove_red_eye,
                                                color: _obscuredText
                                                    ? Colors.black12
                                                    : Color(Strings.orange))),
                                        hintText: Strings.password,
                                        prefixIcon: Icon(
                                          Icons.vpn_key,
                                          color: Color(Strings.darkTurquoise),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      Strings.rememberMe,
                                      style: TextStyle(
                                          fontSize: defaultTargetPlatform ==
                                                  TargetPlatform.android
                                              ? mediaQuery.width * 0.04
                                              : mediaQuery.width * 0.015,
                                          color: Color(Strings.darkTurquoise),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: _checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checked = value!;
                                      });
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
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
                                              builder: (context) =>
                                                  const ForgotPassword(),
                                            ),
                                          )
                                        },
                                        child: Text(
                                          Strings.forgotPassword,
                                          style: TextStyle(
                                              fontSize: defaultTargetPlatform ==
                                                      TargetPlatform.android
                                                  ? mediaQuery.width * 0.035
                                                  : mediaQuery.width * 0.015,
                                              color: Color(Strings.orange),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: mediaQuery.height * 0.05),
                                  MaterialButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString(
                                            'email', _emailController.text);
                                        if (_checked) {
                                          prefs.setString('rememberIsChecked',
                                              _checked.toString());
                                        }

                                        await loginProvider.login(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        );
                                        if (user != null) {
                                          Navigator.pop(context);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Wrapper(),
                                              ),
                                              ModalRoute.withName('/'));
                                        }
                                      }
                                    },
                                    height: defaultTargetPlatform ==
                                            TargetPlatform.android
                                        ? mediaQuery.width * 0.1
                                        : mediaQuery.width * 0.035,
                                    minWidth:
                                        loginProvider.isLoading ? null : 150,
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
                                              fontSize: defaultTargetPlatform ==
                                                      TargetPlatform.android
                                                  ? mediaQuery.width * 0.042
                                                  : mediaQuery.width * 0.015,
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
                                        style: TextStyle(
                                          fontSize: defaultTargetPlatform ==
                                                  TargetPlatform.android
                                              ? mediaQuery.width * 0.035
                                              : mediaQuery.width * 0.015,
                                        ),
                                      ),
                                      // ignore: prefer_const_constructors
                                      SizedBox(width: mediaQuery.height * 0.01),
                                      TextButton(
                                        // onPressed: () => widget.toggleScreen(),
                                        onPressed: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Register(),
                                            ),
                                          )
                                        },
                                        child: Text(
                                          Strings.register,
                                          style: TextStyle(
                                              fontSize: defaultTargetPlatform ==
                                                      TargetPlatform.android
                                                  ? mediaQuery.width * 0.035
                                                  : mediaQuery.width * 0.015,
                                              color: Color(Strings.orange),
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
                                                fontSize:
                                                    mediaQuery.width * 0.035)),
                                        leading: const Icon(Icons.error),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () =>
                                              loginProvider.setMessage(""),
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
