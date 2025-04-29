import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../controllers/groups/current_group_controller.dart';
import '../controllers/groups/user_groups_controller.dart';
import '../repositories/user/firebase_auth_repository.dart';

part 'initial_setup.g.dart';

@riverpod
Future<void> initialSetup(Ref ref) async {
  final currentUser = ref.read(authRepositoryProvider).currentUser!.uid;
  if (currentUser != '') {
    final userGroups =
        await ref.read(userGroupsControllerProvider(currentUser).future);
    ref
        .read(currentGroupControllerProvider.notifier)
        .setCurrentGroup(userGroups.first);
  }
}
