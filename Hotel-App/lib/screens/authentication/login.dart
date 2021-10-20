import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/authentication/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  bool _obscuredText = true;
  bool _checked = false;
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
   if(_value!=null){
     setState(() {
       _emailController.text = _value;
     });
   }


  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
  _toggle(){
    setState(() {
      _obscuredText = !_obscuredText;
    });
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val!.length <6 ? "Enter more than 6 char": null,
                  controller: _passwordController,
                    obscureText: _obscuredText,

                  decoration: InputDecoration(
                      suffixIcon: FlatButton(onPressed: _toggle, child:Icon(Icons.remove_red_eye, color: _obscuredText ? Colors.black12 : Theme.of(context).primaryColor)),
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.vpn_key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),

                CheckboxListTile(
                  title: const Text("Remember me"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _checked,
                  onChanged: (bool? value){
                    setState(() {
                      _checked = value!;
                    });
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  activeColor: Colors.white,
                  checkColor: Theme.of(context).primaryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
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
                      await loginProvider.login(_emailController.text.trim(), _passwordController.text.trim(),);
                      if(_checked){
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('email', _emailController.text);
                      }

                    }
                  },
                  height: 55,
                  minWidth:loginProvider.isLoading? null :  200,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: loginProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
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
                        // onPressed: () => widget.toggleScreen(),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        )
                      },
                        child:  const Text("Register"),
                    )
                  ],
                ),
                const SizedBox(height: 15),
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
