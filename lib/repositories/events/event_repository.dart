import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/database/firebase_firestore_repository.dart';

import '../../models/event.dart';
import '../user/firebase_auth_repository.dart';

part 'event_repository.g.dart';

@riverpod
EventRepository eventRepository(Ref ref) {
  final database = ref.read(firestoreRepositoryProvider);
  final user = ref.read(authRepositoryProvider).currentUser!.uid;
  return EventRepository(database: database, currentUserId: user);
}

class EventRepository {
  EventRepository({required this.database, required this.currentUserId});

  final FirebaseFirestore database;
  String currentUserId = '';

  Future<void> postEvent(
      Event event, String docName, Map<String, dynamic> data) async {
    database.collection('events').doc(docName).set(data);
  }

  Future<void> patchEvent(
      Event event, String docName, Map<String, dynamic> data) async {
    database.collection('events').doc(docName).update(data);
  }

  Future<void> addUsersToEvent(String eventId, List<String> usersIds) async {
    await database
        .collection('events')
        .doc(eventId)
        .update({"participants": usersIds});
  }

  Future<void> deleteEvent(String eventId) async {
    await database.collection('events').doc(eventId).delete();
  }

  Future<Event?> fetchEventById(String eventId) async {
    final docSnapshot = await database.collection('events').doc(eventId).get();
    return docSnapshot.exists ? Event.fromJson(docSnapshot.data()!) : null;
  }

  Future<List<Event>> fetchEventsByGroup(String groupId) async {
    final querySnapshot = await database
        .collection('events')
        .where('groupId', isEqualTo: groupId)
        .orderBy('eventDate')
        .get();
    final events = querySnapshot.docs.map((doc) => doc.data()).toList();
    final eventsList = events.map((group) => Event.fromJson(group)).toList();
    return eventsList;
  }

  Future<List<Event>> eventsFilteredByUser(String userId) async {
    final querySnapshot = await database
        .collection('events')
        .where('participants', arrayContains: userId)
        .get();
    final events = querySnapshot.docs.map((doc) => doc.data()).toList();
    final eventsList = events.map((group) => Event.fromJson(group)).toList();
    return eventsList;
  }

  Future<List<Event>> eventsFilteredByDateAndGroup(
      String groupId, DateTime startDate, DateTime endDate) async {
    final querySnapshot = await database
        .collection('events')
        .where('groupId', isEqualTo: groupId)
        .get();
    final events = querySnapshot.docs.map((doc) => doc.data()).toList();
    final eventsList = events.map((group) => Event.fromJson(group)).toList();
    return eventsList;
  }
}
