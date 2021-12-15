import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotiload/global_var.dart';

class Api {
  final String _host = globalHost;

  // [ ] better return direct the json?
  // [ ] error catching when server down!
  Future<http.Response> getSettings() async {
    const String uri = '/settings';
    var headers = {'Accept': 'application/json'};
    // try {
    http.Response response = await http.get(
      Uri.http(_host, uri),
      headers: headers,
    );
    return response;
    // } catch (e) {
    //   return "test";
    // }
  }

  Future<http.Response> putSettings(settings) async {
    const String uri = '/settings';
    var headers = {'Content-type': 'application/json', 'Accept': 'application/json'};
    http.Response response = await http.put(
      Uri.http(_host, uri),
      headers: headers,
      body: jsonEncode(settings),
    );
    return response;
  }

  Future<http.Response> getInit(url) async {
    const String uri = '/settings';
    var queryParameters = {'url': url};
    var headers = {'Accept': 'application/json'};
    http.Response response = await http.get(
      Uri.http(_host, uri, queryParameters),
      headers: headers,
    );
    return response;
  }
}
