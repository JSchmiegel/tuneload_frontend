import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tuneload/global.dart';
import 'package:tuneload/models/httpresponse.dart';
import 'package:tuneload/models/settings.dart';

class APIHelper {
  // settings api
  static Future<HTTPResponse> getSettings() async {
    const String uri = '/settings';
    var headers = {'Accept': 'application/json'};
    try {
      http.Response response = await http.get(
        Uri.http(globalHost, apiVersion + uri),
        headers: headers,
      );
      if (response.statusCode != 200) {
        return HTTPResponse(
          false,
          null,
          message: json.decode(response.body),
          statusCode: response.statusCode,
        );
      }
      return HTTPResponse(
        true,
        json.decode(response.body),
        message: 'Request Successful',
        statusCode: response.statusCode,
      );
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse(
        false,
        null,
        message: 'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }

  static Future<HTTPResponse> putSettings(Settings settings) async {
    const String uri = '/settings';
    var headers = {'Content-type': 'application/json', 'Accept': 'application/json'};
    try {
      http.Response response = await http.put(
        Uri.http(globalHost, apiVersion + uri),
        headers: headers,
        body: jsonEncode(settings),
      );
      if (response.statusCode != 200) {
        return HTTPResponse(
          false,
          null,
          message: json.decode(response.body),
          statusCode: response.statusCode,
        );
      }
      return HTTPResponse(
        true,
        json.decode(response.body),
        message: 'Request Successful',
        statusCode: response.statusCode,
      );
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Unable to reach the internet! Please try again in a moment.');
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Invalid data received from the server! Please try again in a moment.');
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse(false, null, message: 'Something went wrong! Please try again in a moment!');
    }
  }

  // general api

  static Future<HTTPResponse> getInit(String urlParam) async {
    const String uri = '/tuneload/init';
    var headers = {'Accept': 'application/json'};
    var queryParameters = {'url': urlParam};
    try {
      http.Response response = await http.get(
        Uri.http(globalHost, apiVersion + uri, queryParameters),
        headers: headers,
      );
      if (response.statusCode != 200) {
        return HTTPResponse(
          false,
          null,
          message: json.decode(response.body),
          statusCode: response.statusCode,
        );
      }
      return HTTPResponse(
        true,
        json.decode(response.body),
        message: 'Request Successful',
        statusCode: response.statusCode,
      );
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Unable to reach the internet! Please try again in a moment.');
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Invalid data received from the server! Please try again in a moment.');
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse(false, null, message: 'Something went wrong! Please try again in a moment!');
    }
  }

  static Future<HTTPResponse> getMatchingManual(String id) async {
    String uri = '/tuneload/matching/$id';
    var headers = {'Accept': 'application/json'};
    try {
      http.Response response = await http.get(
        Uri.http(globalHost, apiVersion + uri),
        headers: headers,
      );
      if (response.statusCode != 200) {
        return HTTPResponse(
          false,
          null,
          message: json.decode(response.body),
          statusCode: response.statusCode,
        );
      }
      return HTTPResponse(
        true,
        json.decode(response.body),
        message: 'Request Successful',
        statusCode: response.statusCode,
      );
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Unable to reach the internet! Please try again in a moment.');
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Invalid data received from the server! Please try again in a moment.');
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse(false, null, message: 'Something went wrong! Please try again in a moment!');
    }
  }

  static Future<HTTPResponse> putMatching(String id, String spotifyId) async {
    String uri = '/tuneload/matching/$id';
    var headers = {'Accept': 'application/json'};
    var body = {'matching': spotifyId};
    try {
      http.Response response = await http.put(
        Uri.http(globalHost, apiVersion + uri),
        headers: headers,
        body: body,
      );
      if (response.statusCode != 200) {
        return HTTPResponse(
          false,
          null,
          message: json.decode(response.body),
          statusCode: response.statusCode,
        );
      }
      return HTTPResponse(
        true,
        json.decode(response.body),
        message: 'Request Successful',
        statusCode: response.statusCode,
      );
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Unable to reach the internet! Please try again in a moment.');
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Invalid data received from the server! Please try again in a moment.');
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse(false, null, statusCode: 500, message: 'Something went wrong! Please try again in a moment!');
    }
  }

  static Future<HTTPResponse> getDownload(String id, String numOfSong) async {
    String uri = '/tuneload/downloading/$id';
    var headers = {'Accept': 'application/json'};
    var queryParameters = {'num_of_song': numOfSong};
    try {
      http.Response response = await http.get(
        Uri.http(globalHost, apiVersion + uri, queryParameters),
        headers: headers,
      );
      if (response.statusCode != 200) {
        return HTTPResponse(
          false,
          null,
          message: json.decode(response.body),
          statusCode: response.statusCode,
        );
      }
      return HTTPResponse(
        true,
        json.decode(response.body),
        message: 'Request Successful',
        statusCode: response.statusCode,
      );
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Unable to reach the internet! Please try again in a moment.');
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Invalid data received from the server! Please try again in a moment.');
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse(false, null, message: 'Something went wrong! Please try again in a moment!');
    }
  }

  static Future<HTTPResponse> putUpload(String id) async {
    String uri = '/tuneload/uploading/$id';
    var headers = {'Accept': 'application/json'};
    try {
      http.Response response = await http.put(
        Uri.http(globalHost, apiVersion + uri),
        headers: headers,
      );
      if (response.statusCode != 200) {
        return HTTPResponse(
          false,
          null,
          message: json.decode(response.body),
          statusCode: response.statusCode,
        );
      }
      return HTTPResponse(
        true,
        json.decode(response.body),
        message: 'Request Successful',
        statusCode: response.statusCode,
      );
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Unable to reach the internet! Please try again in a moment.');
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse(false, null, message: 'Invalid data received from the server! Please try again in a moment.');
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse(false, null, message: 'Something went wrong! Please try again in a moment!');
    }
  }
}
