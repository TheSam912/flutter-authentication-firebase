import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase_riverpod/firebase_options.dart';
import 'package:flutter_auth_firebase_riverpod/ui/Splash/SplashPage.dart';
import 'package:flutter_auth_firebase_riverpod/ui/route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorSchem = ColorScheme.fromSeed(seedColor: Colors.yellow);
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          buttonTheme: const ButtonThemeData(
              shape: StadiumBorder(), textTheme: ButtonTextTheme.primary),
          textTheme: const TextTheme(
              headlineLarge: TextStyle(fontWeight: FontWeight.bold)),
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder()),
          colorScheme: colorSchem,
          primaryColor: colorSchem.primary),
      initialRoute: SplashPage.route,
      onGenerateRoute: AppRouter.onNavigate,
    );
  }
}
