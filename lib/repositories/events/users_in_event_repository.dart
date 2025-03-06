import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/app_user.dart';
import 'package:sincroniza/repositories/database/firebase_firestore_repository.dart';

part 'users_in_event_repository.g.dart';

@riverpod
UsersInEventRepository usersInEventRepository(Ref ref) {
  final database = ref.read(firestoreRepositoryProvider);
  return UsersInEventRepository(database: database);
}

class UsersInEventRepository {
  UsersInEventRepository({required this.database});

  final FirebaseFirestore database;

  Future<List<AppUser>> fetchUsersInEvent(String eventId) async {
    final docSnapshot = await database.collection('events').doc(eventId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      final usersList = data?['participants'];
      List<AppUser> appUserList = [];
      if (usersList != null) {
        for (String userId in usersList) {
          final user = await database.collection('users').doc(userId).get();
          if (user.exists) {
            appUserList.add(
              AppUser.fromJson(user.data()!),
            );
          }
        }
      }

      return appUserList;
    }
    return [];
  }
}
