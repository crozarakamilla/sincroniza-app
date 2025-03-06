import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/database/firebase_firestore_repository.dart';

import '../../models/group.dart';

part 'user_groups_repository.g.dart';

@riverpod
UserGroupsRepository userGroupsRepository(Ref ref) {
  final database = ref.read(firestoreRepositoryProvider);
  return UserGroupsRepository(database: database);
}

class UserGroupsRepository {
  UserGroupsRepository({required this.database});

  final FirebaseFirestore database;

  Future<List<Group>> fetchUserGroups(String userId) async {
    final querySnapshot = await database
        .collection('groups')
        .where('groupAdmins', arrayContains: userId)
        .get();
    final groups = querySnapshot.docs.map((doc) => doc.data()).toList();

    final groupsList = groups.map((group) => Group.fromJson(group)).toList();
    return groupsList;
  }
}
