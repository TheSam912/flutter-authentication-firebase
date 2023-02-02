import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase_riverpod/utils/lables.dart';

import '../root.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String route = "/splash";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      Navigator.pushNamedAndRemoveUntil(
          context, Root.route, ((route) => false));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              size: 80,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(Lables.appName,
                style: style.headlineLarge!
                    .copyWith(color: scheme.onPrimaryContainer))
          ],
        ),
      ),
    );
  }
}
