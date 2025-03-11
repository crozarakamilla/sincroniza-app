import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/ai_utils/ai_utils_repository.dart';
import 'package:uuid/uuid.dart';

import '../../models/event.dart';

part 'ai_utils_event_controller.g.dart';

@riverpod
class AiUtilsEventController extends _$AiUtilsEventController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

  FutureOr<List<Event>> getEventsFromList(
      String unstructuredText, String groupId) async {
    List<Event> events = [];
    if (unstructuredText != '') {
      var listStruct = await ref
          .read(aiUtilsRepositoryProvider)
          .processText(unstructuredText);
      events = listStruct.map((event) {
        return eventConverter(event, groupId);
      }).toList();
    }

    return events;
  }
}

var uuid = const Uuid();

Event eventConverter(Map<String, dynamic> mappedEvent, String groupId) {
  //data, título, subtítulo (optional), obras executadas, solista (optional), maestro, local, horário
  Event newEvent = Event(
    id: uuid.v4(),
    title: mappedEvent['título'] != null ? mappedEvent['título'] : '',
    eventDay: mappedEvent['data'] != null
        ? mappedEvent['data'] + '/' + DateTime.now().year.toString()
        : '',
    startTime: mappedEvent['horário'] != null ? mappedEvent['horário'] : '',
    location: mappedEvent['local'] != null ? mappedEvent['local'] : '',
    category: 'oficial',
    groupId: groupId,
    eventDetails: mappedEvent['obras executadas'] != null
        ? mappedEvent['obras executadas'].cast<String>()
        : [],
    conductor: mappedEvent['maestro'] != null ? mappedEvent['maestro'] : '',
    soloist: mappedEvent['solista'] != null ? mappedEvent['solista'] : '',
  );
  return newEvent;
}
