import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase_riverpod/ui/auth/LoginPage.dart';
import 'package:flutter_auth_firebase_riverpod/ui/auth/email_verify_page.dart';
import 'package:flutter_auth_firebase_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:flutter_auth_firebase_riverpod/ui/home/homePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Root extends ConsumerWidget {
  const Root({super.key});

  static const String route = '/';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(AuthViewModelProvider);
    return auth.user != null
        ? auth.user!.emailVerified
            ? const HomePage()
            : const EmailVerifyPage()
        : LoginPage();
  }
}
