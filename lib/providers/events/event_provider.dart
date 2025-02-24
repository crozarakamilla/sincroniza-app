import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/event_repository.dart';

import '../../models/event.dart';

part 'event_provider.g.dart';

@riverpod
Future<Event> event(Ref ref) async {
  final response = await EventRepository().fetchEvents();
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  // Finally, we convert the Map into an Activity instance.
  return Event.fromJson(json);
}
