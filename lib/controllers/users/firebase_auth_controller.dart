import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/controllers/users/aditional_user_info_controller.dart';
import 'package:sincroniza/models/loading_state.dart';

import '../../repositories/user/firebase_auth_repository.dart';
import '../storage/storage_controller.dart';

part 'firebase_auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  LoadingState build() {
    return const LoadingState(LoadingStateEnum.initial, null);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signInWithEmail(email, password);
      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> singInWithGoogle() async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      final credential = await authRepository.signInWithGoogle();
      if (credential != null && credential.user != null) {
        await ref
            .read(aditionalUserInfoControllerProvider.notifier)
            .postUser(credential.user!.displayName.toString(), uid: "");
      }
      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name, File? enteredImage) async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      final UserCredential? userCredential =
          await authRepository.signUpWithEmail(email, password);

      if (userCredential != null && enteredImage != null) {
        final storageController = ref.read(storageControllerProvider.notifier);
        await storageController.uploadFile(userCredential, enteredImage);
      }

      if (userCredential != null) {
        await ref
            .read(aditionalUserInfoControllerProvider.notifier)
            .postUser(name, uid: userCredential.user!.uid);
      }

      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> signOut() async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signOut();
      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }
}
