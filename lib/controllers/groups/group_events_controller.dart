import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/event.dart';
import '../../repositories/groups/group_repository.dart';
import 'current_group_controller.dart';

part 'group_events_controller.g.dart';

@riverpod
class GroupEventsController extends _$GroupEventsController {
  @override
  FutureOr<List<Event>> build() async {
    final currentGroup =
        ref.watch(currentGroupControllerProvider.notifier).currentGroup;
    if (currentGroup != null) {
      return ref
          .read(groupRepositoryProvider)
          .fetchGroupEvents(currentGroup.id);
    }
    return [];
  }
}
