import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/app_user.dart';
import 'package:sincroniza/repositories/events/event_repository.dart';

import '../../models/event.dart';

part 'event_controller.g.dart';

@riverpod
class EventController extends _$EventController {
  @override
  FutureOr<List<Event>> build() async {
    return ref.read(eventRepositoryProvider).fetchEvents();
  }

  Future<void> addUserToEvent(String eventId, List<String> usersIds) async {
    await ref.read(eventRepositoryProvider).addUsersToEvent(eventId, usersIds);
    await future;
  }

  Future<void> postEvent(Event event) async {
    await ref
        .read(eventRepositoryProvider)
        .postEvent(event, event.id!, event.toJson());
    ref.invalidateSelf();
    await future;
  }

  Future<List<AppUser>> fetchUsersInEvent(String eventId) {
    final users = ref.read(eventRepositoryProvider).fetchUsersInEvent(eventId);
    return users;
  }
}
