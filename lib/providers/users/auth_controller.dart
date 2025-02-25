import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/loading_state.dart';

import '../../repositories/firebase_auth_repository.dart';

part 'auth_controller.g.dart';

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
      await authRepository.signInWithGoogle();
      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signUpWithEmail(email, password, name);
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
