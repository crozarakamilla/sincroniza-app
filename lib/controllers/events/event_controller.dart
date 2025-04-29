import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/controllers/groups/current_group_controller.dart';
import 'package:sincroniza/repositories/events/event_repository.dart';

import '../../models/event.dart';

part 'event_controller.g.dart';

@riverpod
class EventController extends _$EventController {
  @override
  FutureOr<List<Event>> build() async {
    final currentGroup =
        ref.watch(currentGroupControllerProvider.notifier).currentGroup;
    if (currentGroup != null) {
      return ref
          .read(eventRepositoryProvider)
          .fetchEventsByGroup(currentGroup.id);
    }
    return [];
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

  Future<void> patchEvent(Event event) async {
    await ref
        .read(eventRepositoryProvider)
        .patchEvent(event, event.id!, event.toJson());
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteEvent(Event event) async {
    await ref.read(eventRepositoryProvider).deleteEvent(event.id!);
    ref.invalidateSelf();
    await future;
  }

  Future<Event?> fetchEventById(String eventId) async {
    final event =
        await ref.read(eventRepositoryProvider).fetchEventById(eventId);
    return event;
  }
}
