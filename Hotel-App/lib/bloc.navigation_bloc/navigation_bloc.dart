// import 'package:bloc/bloc.dart';
// import 'package:first_app_flutter/screens/homeScreens/home_screen.dart';
// import 'package:first_app_flutter/screens/homeScreens/user_home_screen.dart';
//
// enum NavigationEvents {
//   homePageClickedEvent,
//   myAccountClickedEvent,
//   myOrdersClickedEvent,
// }
//
// abstract class NavigationStates {}
//
// class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
//   NavigationBloc(NavigationStates initialState) : super(initialState);
//
//   NavigationStates get initialState => const HomeScreen();
//
//   @override
//   Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
//     switch (event) {
//       case NavigationEvents.homePageClickedEvent:
//         yield const UserHomeScreen();
//         break;
//       case NavigationEvents.myAccountClickedEvent:
//         yield MyAccountsPage();
//         break;
//       case NavigationEvents.myOrdersClickedEvent:
//         yield MyOrdersPage();
//         break;
//     }
//   }
// }
