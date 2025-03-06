import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/app_user.dart';

import '../../repositories/groups/users_in_group_repository.dart';

part 'users_in_group_controller.g.dart';

@riverpod
class UsersInGroupController extends _$UsersInGroupController {
  @override
  FutureOr<List<AppUser>> build(String groupId) async {
    return ref.read(usersInGroupRepositoryProvider).fetchUsersInGroup(groupId);
  }
}
