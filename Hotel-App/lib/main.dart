import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/screens/authentication/authentication.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/authentication/login.dart';
import 'package:first_app_flutter/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
Map<int, Color> color =
{
  50:const Color.fromRGBO(136,14,79, .1),
  100:const Color.fromRGBO(136,14,79, .2),
  200:const Color.fromRGBO(136,14,79, .3),
  300:const Color.fromRGBO(136,14,79, .4),
  400:const Color.fromRGBO(136,14,79, .5),
  500:const Color.fromRGBO(136,14,79, .6),
  600:const Color.fromRGBO(136,14,79, .7),
  700:const Color.fromRGBO(136,14,79, .8),
  800:const Color.fromRGBO(136,14,79, .9),
  900:const Color.fromRGBO(136,14,79, 1),
};
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF124559, color);
    final _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot){
      if (snapshot.hasError){
        return ErrorWidget();
      } else if(snapshot.hasData){
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
              StreamProvider<User?>.value(
                value: AuthServices().user, initialData: null,)
          ],
          child: MaterialApp(
           theme: ThemeData(
             primarySwatch: colorCustom
           ),
           debugShowCheckedModeBanner: false,
           home: Wrapper(),
         ));
      }else{
        return Loading();
      }
    },
    );
  }
}

class ErrorWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Column(
         children: const [Icon(Icons.error), Text("Something went wrong !")],
       )
     ));
  }
}

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}