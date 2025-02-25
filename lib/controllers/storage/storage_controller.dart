import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/loading_state.dart';
import 'package:sincroniza/repositories/storage/firebase_storage_repository.dart';

part 'storage_controller.g.dart';

@riverpod
class StorageController extends _$StorageController {
  @override
  LoadingState build() {
    return const LoadingState(LoadingStateEnum.initial, null);
  }

  Future<void> uploadFile(
      UserCredential userCredential, File enteredImage) async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final storageRepository = ref.watch(storageRepositoryProvider);
      await storageRepository.uploadFile(userCredential, enteredImage);
      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      print(e);
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }
}
