import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/lables.dart';
import '../components/snackbar.dart';
import '../root.dart';
import 'providers/auth_view_model_provider.dart';

class RegisterPgae extends ConsumerWidget {
  RegisterPgae({super.key});
  static const String route = '/register';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final provider = AuthViewModelProvider;
    final model = ref.read(provider);
    return Stack(children: [
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Lables.singUp,
                  style: style.headlineLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return TextFormField(
                      initialValue: model.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          label: Text(Lables.email)),
                      onChanged: (v) {
                        model.email = v;
                      },
                      validator: (v) => model.emailValidate(v!),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(
                        provider.select((value) => value.obscurePassword));
                    return TextFormField(
                      obscureText: model.obscurePassword,
                      initialValue: model.password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          label: const Text(Lables.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                model.obscurePassword = !model.obscurePassword;
                              },
                              icon: Icon(model.obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined))),
                      onChanged: (v) => model.password = v,
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider
                        .select((value) => value.obscureConfirmPassword));
                    return TextFormField(
                      obscureText: model.obscureConfirmPassword,
                      initialValue: model.confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          label: const Text(Lables.confirmPassword),
                          suffixIcon: IconButton(
                              onPressed: () {
                                model.obscureConfirmPassword =
                                    !model.obscureConfirmPassword;
                              },
                              icon: Icon(model.obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined))),
                      onChanged: (v) => model.confirmPassword = v,
                      validator: (value) => value != model.password
                          ? "Don't match password"
                          : null,
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider);
                    return MaterialButton(
                      onPressed: model.email.isNotEmpty &&
                              model.password.isNotEmpty &&
                              model.confirmPassword.isNotEmpty
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await model.register();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacementNamed(
                                      context, Root.route);
                                } catch (e) {
                                  AppSnackBar(context).error(e);
                                }
                              }
                            }
                          : null,
                      color: scheme.primaryContainer,
                      padding: const EdgeInsets.all(16),
                      child: const Text(Lables.singUp),
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Root.route);
                      },
                      child: const Text(Lables.singIn),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      if (model.loading)
        Material(
          surfaceTintColor: scheme.surfaceVariant.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
    ]);
  }
}
