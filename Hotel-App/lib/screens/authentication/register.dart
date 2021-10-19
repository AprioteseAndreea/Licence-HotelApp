import 'package:first_app_flutter/screens/authentication/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_services/auth_services.dart';

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

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);

    return Scaffold(
      body: SafeArea(
        child:
        SingleChildScrollView(
          child: Column(
              children: [
              Image.asset('assets/images/grand_hotel_logo2.jpeg'), //   <--- image
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Create account to continue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _emailController,
                    validator: (val) => val!.isNotEmpty ? null : "Please enter a email address",
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    validator: (val) => val!.length <6 ? "Enter more than 6 char": null,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.vpn_key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _fullNameController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Full Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    validator: (val) => val!.length <10 ? "Phone number must be 10 characters.": null,
                    controller: _phoneNumberController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Phone number",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(height: 25),
                  MaterialButton(
                    onPressed: () async {
                      if(_formkey.currentState!.validate()){
                        // ignore: avoid_print
                        print("Email: ${_emailController.text}");
                        // ignore: avoid_print
                        print("Password: ${_passwordController.text}");
                        await loginProvider.register(_emailController.text.trim(), _passwordController.text.trim(),);
                      }
                    },
                    height: 65,
                    minWidth: loginProvider.isLoading? null :  double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:loginProvider.isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white,
                      ),
                    )
                        :  const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      // ignore: prefer_const_constructors
                      Text("Already have an account?"),
                      // ignore: prefer_const_constructors
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a, b) => const Login(),
                                transitionDuration: const Duration(seconds: 0),
                              ),
                                  (route) => false)
                        },
                        child:  const Text("Login"),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  if(loginProvider.errorMessage !="")
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginProvider.errorMessage),
                        leading: const Icon(Icons.error),
                        trailing: IconButton(
                          icon:const Icon(Icons.close),
                          onPressed: () => loginProvider.setMessage(null),
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
