import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:sincroniza/models/user.dart';

import 'enums.dart';

part 'event.freezed.dart';
part 'event.g.dart';

final formatter = DateFormat('dd/MM/yyyy', 'pt_BR');

@freezed
class Event with _$Event {
  factory Event({
    required String id,
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime eventDay,
    required DateTime startTime,
    required String location,
    required Category category,
    List<String>? eventDetails,
    String? conductor,
    String? soloist,
    List<User>? participants,
  }) = _Event;

  const Event._();

  String get formattedStartDate {
    return formatter.format(startDate);
  }

  String get formattedEndDate {
    return formatter.format(endDate);
  }

  String get formattedEventDay {
    return formatter.format(eventDay);
  }

  List<User>? participantsInEvent(List<String> groupUsersList) {
    return participants
        ?.where(
          (part) => groupUsersList.any((user) => part == user),
        )
        .toList();
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
