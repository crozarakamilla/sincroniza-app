import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/app_user.dart';
import 'package:sincroniza/repositories/events/users_in_event_repository.dart';

part 'users_in_event_controller.g.dart';

@riverpod
class UsersInEventController extends _$UsersInEventController {
  @override
  FutureOr<List<AppUser>> build(String eventId) async {
    return ref.read(usersInEventRepositoryProvider).fetchUsersInEvent(eventId);
  }
}
