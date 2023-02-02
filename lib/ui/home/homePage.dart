// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:flutter_auth_firebase_riverpod/ui/root.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                await ref.read(AuthViewModelProvider).singOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, Root.route);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text("HomePage"),
      ),
    );
  }
}
