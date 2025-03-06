import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:sincroniza/widgets/user_image_picker.dart';

import '../../controllers/users/firebase_auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;

  BuildContext? _progressIndicatorContext;

  bool _validate() {
    if (_nameController == null ||
        _nameController.text.trim().isEmpty ||
        _nameController.text.length < 3) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um nome válido'),
        ),
      );
      return false;
    }

    if (_emailController.text == null ||
        _emailController.text.trim().isEmpty ||
        !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um e-mail válido'),
        ),
      );
      return false;
    }
    if (_passwordController == null ||
        _passwordController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um e-mail válido'),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _signUp() async {
    if (!_validate()) {
      return;
    }
    final auth = ref.read(authControllerProvider.notifier);
    await auth.createUserWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
        _selectedImage);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      Navigator.of(_progressIndicatorContext!).pop();
      _progressIndicatorContext = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (prev, state) async {
      if (state.isLoading) {
        await showDialog(
            context: context,
            builder: (ctx) {
              _progressIndicatorContext = ctx;
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_progressIndicatorContext != null &&
            _progressIndicatorContext!.mounted) {
          Navigator.of(_progressIndicatorContext!).pop();
          _progressIndicatorContext = null;
        }
      });

      if (state.hasError) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Error: ${state.error}'),
          ),
        );
      }
    });
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Criar Conta',
        showDefaultActions: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 75, left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  right: 18,
                  left: 18,
                  bottom: 18,
                ),
                child: Column(
                  children: [
                    UserImagePicker(
                      onPickedImage: (pickedImage) {
                        setState(() {
                          _selectedImage = pickedImage;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          child: Text(
                            'Cadastrar',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceBright,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
