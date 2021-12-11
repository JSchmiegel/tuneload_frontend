import 'dart:collection';
import 'package:http/http.dart' as http;

class BackendCommunicator {
  final String host = "http://127.0.0.1:32500";

  // [ ] better return direct the json?
  // [ ] error catching when server down!
  Future<http.Response> getSettings() async {
    final String uri = "$host/settings";
    Map<String, String> headers = HashMap();
    headers.putIfAbsent('Accept', () => 'application/json');
    // try {
    http.Response response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );
    return response;
    // } catch (e) {
    //   return "test";
    // }
  }
}
