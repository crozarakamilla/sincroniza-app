import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/event.dart';

part 'event_provider.g.dart';

@riverpod
class AsyncEvents extends _$AsyncEvents {
  @override
  FutureOr<Event?> build() {
    return null; // Initial state
  }

  Future<List<Event>> _fetchEvents() async {
    final json = await http.get(Uri.https('boredapi.com', '/api/activity'));
    // Using dart:convert, we then decode the JSON payload into a Map data structure.
    final events = jsonDecode(json.body) as List<Map<String, dynamic>>;
    // Finally, we convert the Map into an Activity instance.
    return events.map(Event.fromJson).toList();
  }

  Future<void> newEvent(Event event) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    state = await AsyncValue.guard(() async {
      //var newEventJson = await http.post(
      //   Uri.https('boredapi.com', '/api/activity'),
      //  body: event.toJson());
      //final newEvent = jsonDecode(newEventJson.body) as Map<String, dynamic>;
      return event;
      //return Event.fromJson(newEvent);
    });
  }
}
