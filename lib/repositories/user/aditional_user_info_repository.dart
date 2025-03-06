import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/storage/firebase_storage_repository.dart';
import 'package:sincroniza/repositories/user/firebase_auth_repository.dart';

import '../../models/app_user.dart';
import '../database/firebase_firestore_repository.dart';

part 'aditional_user_info_repository.g.dart';

@Riverpod(keepAlive: true)
AditionalUserInfoRepository aditionalUserInfoRepository(Ref ref) {
  final database = ref.watch(firebaseFirestoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  final storage = ref.watch(firebaseStorageProvider);
  return AditionalUserInfoRepository(database, auth, storage);
}

class AditionalUserInfoRepository {
  AditionalUserInfoRepository(this._database, this._auth, this._storage);

  final FirebaseFirestore _database;
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;

  Future<AppUser?> saveUserData(String name, {String uid = ""}) async {
    String photoUrl = "";
    try {
      final ref = _storage.ref().child("user_images/" + uid + ".jpg");
      // no need of the file extension, the name will do fine.
      photoUrl = await ref.getDownloadURL();
      print(photoUrl);
    } on Exception catch (e) {
      print("Erro ao criar photoURL");
    }

    await _database.collection('users').doc(_auth.currentUser!.uid).set({
      'uid': _auth.currentUser!.uid,
      'name': name,
      'email': _auth.currentUser!.email.toString(),
      'photoUrl': uid == "" ? _auth.currentUser!.photoURL : photoUrl,
    });
  }

  Future<AppUser?> fetchUser(String uid) async {
    final docSnapshot = await _database.collection('users').doc(uid).get();
    if (docSnapshot.exists) {
      return AppUser.fromJson(docSnapshot.data()!);
    }
    return null;
  }

/*
  Future<User> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  Future<User> updateUserData(String uid) async {
    // Update the user in the database
    return User();
  }

  Future<void> deleteUser(String uid) async {
    // Delete the user from the database
  }*/
}
