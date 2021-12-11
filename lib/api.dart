import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String _host = "http://127.0.0.1:32500";

  // [ ] better return direct the json?
  // [ ] error catching when server down!
  Future<http.Response> getSettings() async {
    final String uri = "$_host/settings";
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

  Future<http.Response> putSettings(settings) async {
    final String uri = "$_host/settings";
    Map<String, String> headers = HashMap();
    headers.putIfAbsent('Content-type', () => 'application/json');
    headers.putIfAbsent('Accept', () => 'application/json');
    http.Response response = await http.put(
      Uri.parse(uri),
      headers: headers,
      body: jsonEncode(settings),
    );
    return response;
  }
}
