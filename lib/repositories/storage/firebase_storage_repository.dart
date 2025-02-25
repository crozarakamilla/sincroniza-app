import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_storage_repository.g.dart';

@riverpod
FirebaseStorage firebaseStorage(Ref ref) {
  return FirebaseStorage.instance;
}

@riverpod
FirebaseStorageRepository storageRepository(Ref ref) {
  final storage = ref.watch(firebaseStorageProvider);
  return FirebaseStorageRepository(storage);
}

class FirebaseStorageRepository {
  FirebaseStorageRepository(this._firebaseStorage);

  final FirebaseStorage _firebaseStorage;

  Future<TaskSnapshot> uploadFile(
      UserCredential userCredential, File enteredImage) async {
    return _firebaseStorage
        .ref()
        .child('user_images')
        .child('${userCredential.user!.uid}.jpg')
        .putFile(enteredImage);
  }
}
