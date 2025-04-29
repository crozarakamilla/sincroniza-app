import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/controllers/configs/current_date_provider.dart';
import 'package:sincroniza/repositories/events/event_repository.dart';

import '../../models/event.dart';
import '../groups/current_group_controller.dart';

part 'events_filtered_by_date_controller.g.dart';

@riverpod
class EventsFilteredByDateController extends _$EventsFilteredByDateController {
  @override
  FutureOr<List<Event>> build() async {
    final currentGroup =
        ref.watch(currentGroupControllerProvider.notifier).currentGroup;
    if (currentGroup != null) {
      final dateProvider = ref.read(currentDateProvider);
      return ref.read(eventRepositoryProvider).eventsFilteredByDateAndGroup(
          currentGroup.id,
          dateProvider["startDate"]!,
          dateProvider["endDate"]!);
    }
    return [];
  }
}
