import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_firestore_repository.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseFirestoreRepository firestoreRepository(Ref ref) {
  final database = ref.watch(firebaseFirestoreProvider);
  return FirebaseFirestoreRepository(database);
}

class FirebaseFirestoreRepository {
  FirebaseFirestoreRepository(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  Future<void> postRecord(
      String collectionName, String docName, Map<String, dynamic> data) async {
    return _firebaseFirestore.collection(collectionName).doc(docName).set(data);
  }
}
