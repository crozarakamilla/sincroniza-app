import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/widgets/user_image_picker.dart';

import '../../providers/users/auth_provider.dart';
import '../events/events_screen.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _form = GlobalKey<FormState>();
    final authController = ref.read(authControllerProvider.notifier);
    final authState = ref.watch(authStateProvider);

    var _enteredEmail = '';
    var _enteredName = '';
    var _enteredPassword = '';
    File? _selectedImage;

    void _submit() async {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }
      _form.currentState!.save();
      try {
        authController.signUpWithEmail(
            _enteredEmail, _enteredPassword, _enteredName, _selectedImage);
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
          body: Padding(
            padding:
                const EdgeInsets.only(top: 75, left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Criar conta',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryFixed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color:
                                  Theme.of(context).colorScheme.surfaceBright,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      right: 18,
                      left: 18,
                      bottom: 18,
                    ),
                    child: Column(
                      children: [
                        UserImagePicker(
                          onPickedImage: (pickedImage) {
                            _selectedImage = pickedImage;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _form,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Nome',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer,
                                        width: 2), // Focus effect
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                ),
                                keyboardType: TextInputType.name,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value.length < 4) {
                                    return 'Por favor, insira um nome válido.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredName = value!;
                                },
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'E-mail',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer,
                                        width: 2), // Focus effect
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
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
                                        10), // Rounded corners
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer,
                                        width: 2), // Focus effect
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 6) {
                                    return 'Senha deve ter pelo menos 6 caracteres.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredPassword = value!;
                                },
                              ),
                              const SizedBox(height: 25),
                              ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                                child: Text(
                                  'Cadastrar',
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
                            ],
                          ),
                        ),
                      ],
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
      error: (error, stackTrace) {
        return const Center(
          child: Text('Ocorreu um erro ao tentar se conectar.'),
        );
      },
    );
  }
}
