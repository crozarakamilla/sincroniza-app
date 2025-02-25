import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class UserRepository {
  Future<AppUser?> saveUserData(AppUser user) async {
    // Save the user to the database
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'name': user.name,
        'photoUrl': user.photoUrl,
        'groupId': user.groupId,
      });
    } catch (e) {
      print('Error saving user data: $e');
      return null;
    }
    return user;
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
