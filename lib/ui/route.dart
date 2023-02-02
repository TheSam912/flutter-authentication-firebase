import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase_riverpod/ui/Splash/SplashPage.dart';
import 'package:flutter_auth_firebase_riverpod/ui/auth/LoginPage.dart';
import 'package:flutter_auth_firebase_riverpod/ui/auth/RegisterPage.dart';
import 'package:flutter_auth_firebase_riverpod/ui/root.dart';

class AppRouter {
  static Route<MaterialPageRoute> onNavigate(RouteSettings settings) {
    late Widget selectedPage;
    selectedPage = const Root();
    switch (settings.name) {
      case SplashPage.route:
        selectedPage = const SplashPage();
        break;
      case RegisterPgae.route:
        selectedPage = RegisterPgae();
        break;
      case LoginPage.route:
        selectedPage = LoginPage();
        break;
    }
    return MaterialPageRoute(builder: (context) => selectedPage);
  }
}
