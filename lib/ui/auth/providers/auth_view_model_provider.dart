import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AuthViewModelProvider = ChangeNotifierProvider(
  (ref) => AuthViewModel(),
);

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;
  String _email = '';
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool obscurePassword) {
    _obscurePassword = obscurePassword;
    notifyListeners();
  }

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  set obscureConfirmPassword(bool obscureConfirmPassword) {
    _obscureConfirmPassword = obscureConfirmPassword;
    notifyListeners();
  }

  String? emailValidate(String value) {
    String format =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    return !RegExp(format).hasMatch(value) ? "Enter valid email" : null;
  }

  Future<void> login() async {
    loading = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _loading = false;
    } on FirebaseAuthException catch (e) {
      loading = false;
      if (e.code == 'wrong-password') {
        return Future.error('Password incorect');
      } else if (e.code == "user-not-found") {
        return Future.error('User not found');
      } else {
        return Future.error(e.message ?? "");
      }
    } catch (e) {
      loading = false;
      print(e);
    }
  }

  Future<void> register() async {
    loading = true;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _loading = false;
    } on FirebaseAuthException catch (e) {
      loading = false;
      if (e.code == 'weak-password') {
        return Future.error('Weak Password');
      } else {
        return Future.error(e.message ?? "");
      }
    } catch (e) {
      loading = false;
      print(e);
    }
  }

  Future<void> singOut() async {
    await _auth.signOut();
  }

  Future<void> reload() async {
    await _auth.currentUser!.reload();
  }

  void sendEmail() {
    _auth.currentUser!.sendEmailVerification();
  }
}
