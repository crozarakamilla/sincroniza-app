import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/database/firebase_firestore_repository.dart';

import '../../models/event.dart';

part 'event_repository.g.dart';

@riverpod
EventRepository eventRepository(Ref ref) {
  final database = ref.read(firestoreRepositoryProvider);
  return EventRepository(database: database);
}

class EventRepository {
  EventRepository({required this.database});

  final FirebaseFirestore database;

  Future<void> postEvent(
      Event event, String docName, Map<String, dynamic> data) async {
    database.collection('events').doc(docName).set(data);
  }

  Future<List<Event>> fetchEvents() async {
    final querySnapshot = await database.collection('events').get();
    final events = querySnapshot.docs.map((doc) => doc.data()).toList();

    final eventsList = events.map((event) => Event.fromJson(event)).toList();
    return eventsList;
  }
}
