import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/user/aditional_user_info_repository.dart';
import 'package:sincroniza/repositories/user/firebase_auth_repository.dart';

import '../../models/app_user.dart';

part 'aditional_user_info_controller.g.dart';

@Riverpod(keepAlive: true)
class AditionalUserInfoController extends _$AditionalUserInfoController {
  @override
  Future<AppUser?> build() async {
    AppUser? currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser != null) {
      return fetchUser(currentUser.uid);
    }
    return null;
  }

  Future<AppUser?> fetchUser(String uid) {
    final user = ref.read(aditionalUserInfoRepositoryProvider).fetchUser(uid);
    return user;
  }

  Future<void> postUser(String name, {String uid = ""}) async {
    await ref
        .read(aditionalUserInfoRepositoryProvider)
        .saveUserData(name, uid: uid);
    ref.invalidateSelf();
  }
}
