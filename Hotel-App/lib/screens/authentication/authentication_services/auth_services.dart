import 'dart:io';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // user.updatePhoneNumber(phoneNumber);
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
