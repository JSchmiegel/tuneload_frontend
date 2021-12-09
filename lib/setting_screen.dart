import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotiload/global_var.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              splashRadius: buttonSplashRadius),
        ),
        body: Container(
            margin: firstMargin,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    apiCall = true; // Set state like this
                  });
                  _callBackendApi();
                },
                child: const Text("Get Settings"),
              ),
              getProperWidget()
            ])));
  }

  void _callBackendApi() async {
    var url = 'http://localhost:32500/settings';
    Map<String, String> headers = HashMap();
    headers.putIfAbsent('Accept', () => 'application/json');

    // http.Response response = await http
    await http
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .then((response) {
      setState(() {
        apiCall = false; //Disable Progressbar
        // _currentSettings = weather.toString();
        _currentSettings = response.body;
      });
    }, onError: (error) {
      setState(() {
        apiCall = false; //Disable Progressbar
        _currentSettings = error.toString();
      });
    });

    // print('Response status: ${response.statusCode}');
    // if (response.statusCode == 200) {
    //   apiCall = false;
    // } else {
    //   apiCall = false;
    //   _currentSettings = "ERROR!!";
    // }
  }
  // var api = new OpenWeatherApi();
  // api.getCurrentWeather("Waldershof, Germany").then((weather) {
  //   setState(() {
  //     apiCall = false; //Disable Progressbar
  //     _currentSettings = weather.toString();
  //   });
  // }, onError: (error) {
  //   setState(() {
  //     apiCall = false; //Disable Progressbar
  //     _currentSettings = error.toString();
  //   });
  // });
  // }

  // probably better with async or await?!!
  Widget getProperWidget() {
    if (apiCall) {
      return CircularProgressIndicator();
    } else {
      var _currentSettingsJson = jsonDecode(_currentSettings);
      try {
        return Text(
          _currentSettingsJson['paths'],
        );
      } catch (e) {
        return const Text('There is an error with the answer from the server');
      }
    }
  }

  String _currentSettings = "{}";
  bool apiCall = false;
}
