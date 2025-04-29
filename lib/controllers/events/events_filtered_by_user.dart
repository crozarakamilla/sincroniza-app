import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/events/event_repository.dart';

import '../../models/event.dart';

part 'events_filtered_by_user.g.dart';

@riverpod
class EventsFilteredByUser extends _$EventsFilteredByUser {
  @override
  FutureOr<List<Event>> build(String userId) async {
    return ref.read(eventRepositoryProvider).eventsFilteredByUser(userId);
  }
}
