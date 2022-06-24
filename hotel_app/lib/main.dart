import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/facilities_service.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/screens/services/found_room_service.dart';
import 'package:first_app_flutter/screens/services/posts_service.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/screens/services/statistics_service.dart';
import 'package:first_app_flutter/screens/user_screens/notifiers.dart';
import 'package:first_app_flutter/screens/wrapper.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyBgaJM8Qfu8iTIm79eW2z-BN8vseP-28wE",
      //     authDomain: "license-hotelapplication.firebaseapp.com",
      //     projectId: "license-hotelapplication",
      //     storageBucket: "license-hotelapplication.appspot.com",
      //     messagingSenderId: "301348829669",
      //     appId: "1:301348829669:web:ec91e24ba3399d5287d70c")
      );

  runApp(const MyApp());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF124559, color);
    final _init = Firebase.initializeApp(
        // options: const FirebaseOptions(
        //     apiKey: "AIzaSyBgaJM8Qfu8iTIm79eW2z-BN8vseP-28wE",
        //     authDomain: "license-hotelapplication.firebaseapp.com",
        //     projectId: "license-hotelapplication",
        //     storageBucket: "license-hotelapplication.appspot.com",
        //     messagingSenderId: "301348829669",
        //     appId: "1:301348829669:web:ec91e24ba3399d5287d70c")
        );
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorWidget();
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
              ChangeNotifierProvider<FoundRoomServices>.value(
                  value: FoundRoomServices()),
              StreamProvider<User?>.value(
                value: AuthServices().user,
                initialData: null,
              ),
              // ChangeNotifierProvider<UserService>.value(value: UserService())
              ChangeNotifierProvider(create: (_) => UserService()),
              ChangeNotifierProvider(create: (_) => FeedbackService()),
              ChangeNotifierProvider(create: (_) => RoomsService()),
              ChangeNotifierProvider(create: (_) => FacilityService()),
              ChangeNotifierProvider(create: (_) => ReservationService()),
              ChangeNotifierProvider(create: (_) => StatisticsService()),
              ChangeNotifierProvider(create: (_) => PostsService()),

              ChangeNotifierProvider<SingleNotifier>(
                create: (_) => SingleNotifier(),
              ),
              ChangeNotifierProvider<MultipleNotifier>(
                create: (_) => MultipleNotifier([]),
              )
            ],
            child: MaterialApp(
              theme: ThemeData(
                primarySwatch: colorCustom,
              ),
              debugShowCheckedModeBanner: false,
              home: const Wrapper(),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: const [Icon(Icons.error), Text("Something went wrong !")],
    )));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
