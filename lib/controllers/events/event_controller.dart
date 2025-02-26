import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/events/event_repository.dart';

import '../../models/event.dart';

part 'event_controller.g.dart';

@riverpod
class EventController extends _$EventController {
  @override
  FutureOr<List<Event>> build() async {
    return ref.read(eventRepositoryProvider).fetchEvents();
  }

  Future<void> postEvent(Event event) async {
    await ref
        .read(eventRepositoryProvider)
        .postEvent(event, event.id, event.toJson());
    ref.invalidateSelf();
    await future;
  }
}
