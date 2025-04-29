import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/controllers/configs/category_provider.dart';

import '../../controllers/events/events_filtered_by_date_controller.dart';
import '../../models/category.dart';
import '../../models/event.dart';
import '../../models/meeting.dart';

part 'meeting_repository.g.dart';

@riverpod
Future<List<Meeting>> meetingList(Ref ref) async {
  final events = await ref.watch(eventsFilteredByDateControllerProvider.future);
  final categories = ref.read(categoriesProvider);
  return eventsToMeeting(events, categories);
}

List<Meeting> eventsToMeeting(
    List<Event> events, Map<String, Category> categories) {
  List<Meeting> meetings = [];
  for (Event event in events) {
    meetings.add(
      Meeting(
          eventName: event.title!,
          from: event.category! != 'oficial'
              ? event.eventDate!
              : event.eventDate!.subtract(
                  Duration(days: 3),
                ),
          to: event.eventDate!,
          background: categories[event.category]!.color,
          isAllDay: false,
          eventId: event.id!),
    );
  }
  return meetings;
}
