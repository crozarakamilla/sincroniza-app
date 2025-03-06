import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/groups/user_groups_repository.dart';

import '../../models/group.dart';

part 'user_groups_controller.g.dart';

@riverpod
class UserGroupsController extends _$UserGroupsController {
  @override
  FutureOr<List<Group>> build(String userId) async {
    return ref.read(userGroupsRepositoryProvider).fetchUserGroups(userId);
  }
}
