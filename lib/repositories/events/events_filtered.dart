import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/controllers/configs/filters_controller.dart';
import 'package:sincroniza/controllers/events/event_controller.dart';
import 'package:sincroniza/models/enums.dart';

import '../../models/event.dart';

part 'events_filtered.g.dart';

@riverpod
Future<List<Event>> filteredEvents(Ref ref) async {
  try {
    final List<Event> events = await ref.watch(eventControllerProvider.future);
    List<Event> filteredEvents = events;
    final filters = ref.watch(filtersControllerProvider);

    for (String filter in filters.keys) {
      if (filter == FilterType.endDate.name) {
        if (filters[FilterType.endDate.name] != '') {
          filteredEvents = filteredEvents
              .where((event) => event.eventDate!
                  .isBefore(filters[FilterType.endDate.name] as DateTime))
              .toList();
        }
      }
      if (filter == FilterType.startDate.name) {
        if (filters[FilterType.startDate.name] != '') {
          filteredEvents = filteredEvents
              .where((event) => event.eventDate!
                  .isAfter(filters[FilterType.startDate.name] as DateTime))
              .toList();
        }
      }
      if (filter == FilterType.category.name) {
        if (filters[FilterType.category.name] != '') {
          filteredEvents = filteredEvents
              .where((event) =>
                  event.category ==
                  (filters[FilterType.category.name] as String))
              .toList();
        }
      }
      if (filter == FilterType.byUserId.name) {
        if (filters[FilterType.byUserId.name] != '') {
          filteredEvents = filteredEvents.where((event) {
            if (event.participants != null) {
              return event.participants!
                  .contains(filters[FilterType.byUserId.name]);
            }
            return false;
          }).toList();
        }
      }
    }

    return filteredEvents.isNotEmpty ? filteredEvents : events;
  } on Exception catch (e) {
    print(e);
    return [];
  }
}
