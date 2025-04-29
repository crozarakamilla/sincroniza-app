import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/group.dart';

part 'current_group_controller.g.dart';

@Riverpod(keepAlive: true)
class CurrentGroupController extends _$CurrentGroupController {
  Group? currentGroup;

  @override
  FutureOr<Group?> build() async {
    return currentGroup;
  }

  void setCurrentGroup(Group group) {
    currentGroup = group;
    ref.invalidateSelf();
  }
}
