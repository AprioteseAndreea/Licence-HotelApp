import 'dart:io';
import 'package:first_app_flutter/screens/services/facilities_service.dart';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/screens/services/statistics_service.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserService userService = UserService();
  RoomsService roomsService = RoomsService();
  FeedbackService feedbackService = FeedbackService();
  StatisticsService statisticsService = StatisticsService();
  ReservationService reservationService = ReservationService();
  FacilityService facilityService = FacilityService();

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
      await userService.getUsersCollectionFromFirebase();
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      await userService.getNameFromSharedPrefs();
      String role = "";
      for (int i = 0; i < userService.getUsers().length; i++) {
        if (userService.getUsers()[i].email ==
            firebaseAuth.currentUser!.email) {
          role = userService.getUsers()[i].role;
        }
      }
      setLoading(false);
      notifyListeners();
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

  Future<void> logout() async {
    await DefaultCacheManager().emptyCache();
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _deleteCacheDir();
      await _deleteAppDir();
    }

    await firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
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
