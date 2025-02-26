import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_firestore_repository.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseFirestore firestoreRepository(Ref ref) {
  final database = ref.watch(firebaseFirestoreProvider);
  return FirebaseFirestoreRepository(database).database;
}

class FirebaseFirestoreRepository {
  FirebaseFirestoreRepository(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  FirebaseFirestore get database => _firebaseFirestore;
}
