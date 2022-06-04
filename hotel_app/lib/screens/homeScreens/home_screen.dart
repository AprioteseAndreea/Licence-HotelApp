import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/models/user_model.dart' as user_model;
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/authentication/login.dart';
import 'package:first_app_flutter/screens/homeScreens/staff_home_screen.dart';
import 'package:first_app_flutter/screens/homeScreens/user_screen_state.dart';
import 'package:first_app_flutter/screens/services/facilities_service.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/screens/services/posts_service.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/screens/services/statistics_service.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  UserService userService = UserService();
  RoomsService roomsService = RoomsService();
  FeedbackService feedbackService = FeedbackService();
  StatisticsService statisticsService = StatisticsService();
  ReservationService reservationService = ReservationService();
  FacilityService facilityService = FacilityService();
  PostsService postService = PostsService();

  late List<user_model.User> users = [];
  late List<Staff> staff = [];

  String? role;
  AuthServices authServices = AuthServices();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readRole();
    });
  }

  Future<void> _readRole() async {
    final _prefs = await SharedPreferences.getInstance();
    final _value = _prefs.getString('role');

    if (_value != null) {
      setState(() {
        role = _value;
      });
    }
  }

  Future<void> writeInSharePrefs() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("role", "admin");
  }

  Future<void> actualizeInformation() async {
    ReservationService reservationService = ReservationService();
    // await reservationService.actualizeInformation();
  }

  Future<void> instantiateDataForUser() async {
    await reservationService
        .countNumberOfReservations(firebaseAuth.currentUser!.email);
    await feedbackService.getFeedbacksCollectionFromFirebase();
    await facilityService.getFacilitiesCollectionFromFirebase();
  }

  Future<void> instantiateDataForStaff() async {
    await userService.getStaffCollectionFromFirebase();
    await postService.getPostsCollectionFromFirebase();
    await roomsService.getRoomsCollectionFromFirebase();
    await facilityService.getFacilitiesCollectionFromFirebase();
    await reservationService.getReservationsCollectionFromFirebase();
    await writeStaffDataInSharedPreferences();
  }

  Future<void> writeStaffDataInSharedPreferences() async {
    staff = userService.getStaff();
    final _prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < staff.length; i++) {
      if (staff[i].email == firebaseAuth.currentUser!.email) {
        await _prefs.setString('email', staff[i].email);
        await _prefs.setString('name', staff[i].name);
        await _prefs.setString('phoneNumber', staff[i].phone);
        await _prefs.setString('gender', staff[i].gender);
        await _prefs.setString('old', staff[i].old);
        await _prefs.setString('position', staff[i].position);
        await _prefs.setString('salary', staff[i].salary.toString());
      }
    }
  }

  Future<void> instantiateDataForAdmin() async {
    await roomsService.getRoomsCollectionFromFirebase();
    await reservationService.getReservationsCollectionFromFirebase();
    await userService.getStaffCollectionFromFirebase();
    await userService.getUsersCollectionFromFirebase();
    // await statisticsService.getRoomStatisticsCollectionFromFirebase();
    // await statisticsService.getMonthlyReservationsCollectionFromFirebase();
    // await statisticsService.getMonthlyIncomeCollectionFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    userService = Provider.of<UserService>(context);
    users = userService.getUsers();
    for (int i = 0; i < users.length; i++) {
      if (users[i].email == firebaseAuth.currentUser!.email) {
        role = users[i].role;
      }
    }
    switch (role) {
      case 'user':
        {
          instantiateDataForUser();
          return const UserHomeState();
        }
      case 'admin':
        {
          instantiateDataForAdmin();
          return const AdminHomeScreen();
        }
      case 'staff':
        {
          instantiateDataForStaff();
          return const StaffHomeScreen();
        }
      default:
        return const Login();
    }
  }
}
