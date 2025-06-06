import 'dart:ui';

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(
      {required this.eventName,
      required this.from,
      required this.to,
      required this.background,
      required this.isAllDay,
      required this.eventId});

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

  String eventId;
}
