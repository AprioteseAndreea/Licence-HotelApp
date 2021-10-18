import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
   final Function toggleScreen;

  const Login({Key? key, required this.toggleScreen }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

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
                // IconButton(
                //   icon: const Icon(Icons.arrow_back_ios),
                //   color: Theme.of(context).primaryColor,
                //   onPressed: (){},),
                const SizedBox(height: 30
                ),
                const Text(

                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "sign in to continue",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    // const SizedBox(width: 3),
                    // TextButton(
                    //   onPressed: () => widget.forgotPressed(),
                    //   child:  const Text("Forgot password?"),
                    // )
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        )
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: () async {
                    if(_formkey.currentState!.validate()) {
                      // ignore: avoid_print
                      print("Email: ${_emailController.text}");
                      // ignore: avoid_print
                      print("Password: ${_passwordController.text}");
                      await loginProvider.login(_emailController.text.trim(), _passwordController.text.trim(),);
                    }
                  },
                  height: 65,
                  minWidth:loginProvider.isLoading? null :  double.infinity,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: loginProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                    "Login",
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
                    Text("Don't have an account?"),
                    // ignore: prefer_const_constructors
                    SizedBox(width: 5),
                    TextButton(
                        onPressed: () => widget.toggleScreen(),
                        child:  const Text("Register"),
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
