import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/app_user.dart';
import 'package:sincroniza/repositories/database/firebase_firestore_repository.dart';

import '../../models/event.dart';
import '../../models/group.dart';
import '../user/firebase_auth_repository.dart';

part 'event_repository.g.dart';

@riverpod
EventRepository eventRepository(Ref ref) {
  final database = ref.read(firestoreRepositoryProvider);
  final user = ref.read(authRepositoryProvider).currentUser!.uid;
  return EventRepository(database: database, userId: user);
}

class EventRepository {
  EventRepository({required this.database, required this.userId});

  final FirebaseFirestore database;
  String userId = '';

  Future<void> postEvent(
      Event event, String docName, Map<String, dynamic> data) async {
    database.collection('events').doc(docName).set(data);
  }

  Future<void> addUsersToEvent(String eventId, List<String> usersIds) async {
    final eventQuery = await database.collection('events').doc(eventId).get();
    final existingParticipants = eventQuery.data()?['participants'];
    List<String> usersToAdd = [];
    for (String userId in usersIds) {
      if (!usersIds.contains(userId)) {
        usersToAdd.add(userId);
      }
    }
    final eventQuerySnapshot = await database
        .collection('events')
        .doc(eventId)
        .update({"participants": usersToAdd});
  }

  Future<List<Event>> fetchEvents() async {
    final List<Event> userEventsList = [];
    final groupQuerySnapshot = await database
        .collection('groups')
        .where('users', arrayContains: userId)
        .get();
    final groups = groupQuerySnapshot.docs.map((doc) => doc.data()).toList();

    final userGroupsList =
        groups.map((group) => Group.fromJson(group)).toList();

    for (Group group in userGroupsList) {
      final eventsQuerySnapshot = await database
          .collection('events')
          .where('groupId', isEqualTo: group.id)
          .get();
      final events = eventsQuerySnapshot.docs.map((doc) => doc.data()).toList();

      final List<Event> eventsList =
          events.map((event) => Event.fromJson(event)).toList();
      for (Event event in eventsList) {
        userEventsList.add(event);
      }
    }

    return userEventsList;
  }

  Future<List<AppUser>> fetchUsersInEvent(String eventId) async {
    final docSnapshot = await database.collection('events').doc(eventId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      final usersList = data?['participants'];
      List<AppUser> appUserList = [];
      for (String userId in usersList) {
        final user = await database.collection('users').doc(userId).get();
        if (user.exists) {
          appUserList.add(
            AppUser.fromJson(user.data()!),
          );
        }
      }

      return usersList;
    }
    return [];
  }
}
