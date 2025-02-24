import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

@riverpod
Stream<User?> authState(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  User? build() {
    return null; // Initial state
  }

  Future<void> signInWithGoogle() async {
    final userCredential =
        await ref.read(authRepositoryProvider).signInWithGoogle();
    if (userCredential != null) {
      state = userCredential.user;
    }
  }

  Future<void> signUpWithEmail(
      String email, String password, String name, File? _enteredImage) async {
    final userCredential = await ref
        .read(authRepositoryProvider)
        .signUpWithEmail(email, password, name);
    if (userCredential != null) {
      state = userCredential.user;
    }

    if (userCredential != null && _enteredImage != null) {
      await FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredential.user!.uid}.jpg')
          .putFile(_enteredImage!);
    }
  }

  Future<UserCredential?> signInWithEmail(
      String _enteredEmail, String _enteredPassword) async {
    UserCredential? credential = await ref
        .read(authRepositoryProvider)
        .signInWithEmail(_enteredEmail, _enteredPassword);
    return credential;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = null;
  }
}
