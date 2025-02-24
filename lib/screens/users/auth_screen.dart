import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_button/sign_button.dart';
import 'package:sincroniza/providers/users/auth_provider.dart';
import 'package:sincroniza/screens/events/events_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _form = GlobalKey<FormState>();

    final authController = ref.read(authControllerProvider.notifier);
    final authState = ref.watch(authStateProvider);
    final user = ref.watch(authStateProvider).value;

    var _enteredEmail = '';
    var _enteredPassword = '';

    void _submit() async {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }
      _form.currentState!.save();
      try {
        authController.signInWithEmail(_enteredEmail, _enteredPassword);
        if (user != null) {
          context.goNamed('events');
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          // ...
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    }

    return authState.when(
      data: (user) {
        if (user != null) {
          return const EventsScreen();
        }
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 0,
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    width: 260,
                    child: Image.asset('assets/images/logo_bonina.png'),
                  ),
                  Text(
                    'Bem vindo(a) de volta!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondaryFixed,
                        fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Rounded corners
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer,
                                      width: 2), // Focus effect
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          width: 8),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  child: const Icon(Icons.email),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Por favor, insira um e-mail válido.';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Rounded corners
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer,
                                      width: 2), // Focus effect
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          width: 8),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  child: const Icon(Icons.password_rounded),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Senha deve ter pelo menos 6 caracteres.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(
                                'Entrar',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .shadow,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed('sign-up');
                              },
                              child: Text(
                                'Não tem uma conta?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceBright,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                        decoration: TextDecoration.underline),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceBright,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SignInButton(
                                  buttonType: ButtonType.google,
                                  btnText: 'Entre com o Google',
                                  onPressed: authController.signInWithGoogle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => const Center(
        child: Text('Ocorreu um erro ao tentar se conectar.'),
      ),
    );
  }
}
