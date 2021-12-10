import 'dart:collection';
import 'package:http/http.dart' as http;

class BackendCommunicator {
  final String host = "http://localhost:32500";

  // [ ] better return direct the json?
  Future<http.Response> getSettings() async {
    final String uri = "$host/settings";
    Map<String, String> headers = HashMap();
    headers.putIfAbsent('Accept', () => 'application/json');

    http.Response response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );
    return response;
  }
}
