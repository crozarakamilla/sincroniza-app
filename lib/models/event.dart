import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'event.freezed.dart';
part 'event.g.dart';

final formatter = DateFormat('dd/MM/yyyy', 'pt_BR');

@unfreezed
class Event with _$Event {
  factory Event({
    String? id,
    String? title,
    String? eventDay,
    String? startTime,
    String? location,
    String? category,
    String? groupId,
    String? rehearsalsQuantity,
    List<String>? eventDetails,
    String? conductor,
    String? soloist,
    List<String>? participants,
  }) = _Event;

  const Event._();

  List<String>? participantsInEvent(List<String> groupUsersList) {
    return participants
        ?.where(
          (part) => groupUsersList.any((user) => part == user),
        )
        .toList();
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
