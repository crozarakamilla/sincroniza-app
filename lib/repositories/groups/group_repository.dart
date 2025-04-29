import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/database/firebase_firestore_repository.dart';

import '../../models/event.dart';
import '../../models/group.dart';
import '../user/firebase_auth_repository.dart';

part 'group_repository.g.dart';

@riverpod
GroupRepository groupRepository(Ref ref) {
  final database = ref.read(firestoreRepositoryProvider);
  final user = ref.read(authRepositoryProvider).currentUser!.uid;
  return GroupRepository(userId: user, database: database);
}

class GroupRepository {
  GroupRepository({required this.database, required this.userId});

  final FirebaseFirestore database;
  String userId = '';
  String currentGroupId = '';

  String get getCurrentGroupId => currentGroupId;

  Future<Group> get currentGroup => getCurrentGroup();

  Future<void> setCurrentGroupId(String groupId) async {
    currentGroupId = groupId;
  }

  Future<Group> getCurrentGroup() async {
    final querySnapshot =
        await database.collection('groups').doc(currentGroupId).get();
    final group = querySnapshot.data();
    return Group.fromJson(group!);
  }

  Future<void> postGroup(
      Group group, String docName, Map<String, dynamic> data) async {
    database.collection('groups').doc(docName).set(data);
  }

  Future<List<Group>> fetchGroups() async {
    final querySnapshot = await database
        .collection('groups')
        .where('users', arrayContains: userId)
        .get();
    final groups = querySnapshot.docs.map((doc) => doc.data()).toList();

    final groupsList = groups.map((group) => Group.fromJson(group)).toList();
    return groupsList;
  }

  Future<List<Event>> fetchGroupEvents(String groupId) async {
    final querySnapshot = await database
        .collection('events')
        .where('groupId', isEqualTo: groupId)
        .get();
    final events = querySnapshot.docs.map((doc) => doc.data()).toList();

    final eventsList = events.map((group) => Event.fromJson(group)).toList();

    return eventsList;
  }
}
