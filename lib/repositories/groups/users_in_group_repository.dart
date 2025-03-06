import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/app_user.dart';
import 'package:sincroniza/repositories/database/firebase_firestore_repository.dart';

part 'users_in_group_repository.g.dart';

@riverpod
UsersInGroupRepository usersInGroupRepository(Ref ref) {
  final database = ref.read(firestoreRepositoryProvider);
  return UsersInGroupRepository(database: database);
}

class UsersInGroupRepository {
  UsersInGroupRepository({required this.database});

  final FirebaseFirestore database;

  Future<List<AppUser>> fetchUsersInGroup(String groupId) async {
    final docSnapshot = await database.collection('groups').doc(groupId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      final usersList = data?['users'];
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
