import 'dart:io';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/screens/services/statistics_service.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = "";
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(
      String email, String password, String name, String phoneNumber) async {
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      user!.updateDisplayName(name);
      user.updatePhotoURL(phoneNumber);

      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage('No internet, please connect to internet');
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future login(String email, String password) async {
    setLoading(true);
    try {
      UserService userService = UserService();
      RoomsService roomsService = RoomsService();
      FeedbackService feedbackService = FeedbackService();
      StatisticsService statisticsService = StatisticsService();
      ReservationService reservationService = ReservationService();
      // await reservationService.actualizeInformation();
      await reservationService.countNumberOfReservations(email);
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      setLoading(false);

      return user;
    } on SocketException {
      setLoading(false);
      setMessage('No internet, please connect to internet');
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
    // await actualizeInformation();
    notifyListeners();
  }

  Future<void> actualizeInformation() async {
    ReservationService reservationService = ReservationService();
    await reservationService.actualizeInformation();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Stream<User?> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
