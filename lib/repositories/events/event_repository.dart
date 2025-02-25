import 'package:http/http.dart' as http;

import '../../models/event.dart';

//part 'event_repository.g.dart';

class EventRepository {
  Future<http.Response> fetchEvents() async {
    return await http.get(Uri.https('boredapi.com', '/api/activity'));
  }

  Future<http.Response> createEvent(Event event) async {
    return await http.get(Uri.https('boredapi.com', '/api/activity'));
  }
}
