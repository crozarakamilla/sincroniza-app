import 'package:http/http.dart' as http;

class EventRepository {
  Future<http.Response> fetchEvents() async {
    return await http.get(Uri.https('boredapi.com', '/api/activity'));
  }
}
