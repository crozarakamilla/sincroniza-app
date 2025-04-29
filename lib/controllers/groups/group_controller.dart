import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/groups/group_repository.dart';

import '../../models/event.dart';
import '../../models/group.dart';

part 'group_controller.g.dart';

@riverpod
class GroupController extends _$GroupController {
  @override
  FutureOr<List<Group>> build() async {
    return ref.read(groupRepositoryProvider).fetchGroups();
  }

  Future<void> postGroup(Group group) async {
    await ref
        .read(groupRepositoryProvider)
        .postGroup(group, group.id, group.toJson());
    ref.invalidateSelf();
    await future;
  }

  Future<List<Event>> fetchGroupEvents(String groupId) async {
    final events =
        await ref.read(groupRepositoryProvider).fetchGroupEvents(groupId);
    return events;
  }
}
