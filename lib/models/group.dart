import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sincroniza/models/app_user.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group({
    required String id,
    required String name,
    required List<String> users,
    required List groupAdmins,
    required List? events,
    required bool instruments,
  }) = _Group;

  const Group._();

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
