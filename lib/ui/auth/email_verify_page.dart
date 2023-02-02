import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:flutter_auth_firebase_riverpod/ui/components/snackbar.dart';
import 'package:flutter_auth_firebase_riverpod/ui/root.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerifyPage extends ConsumerWidget {
  const EmailVerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final model = ref.read(AuthViewModelProvider);
    model.sendEmail();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify Email",
                style: style.titleLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Verification link sent to ${model.user!.email}",
                style: style.bodySmall,
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await model.reload();
                    if (model.user!.emailVerified) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, Root.route);
                    } else {
                      // ignore: use_build_context_synchronously
                      AppSnackBar(context).error("Email not verified yet !");
                    }
                  },
                  child: const Text("DONE"))
            ],
          ),
        ),
      ),
    );
  }
}
