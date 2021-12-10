import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotiload/backen_communicator.dart';
import 'package:spotiload/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:spotiload/settings.dart';

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
        body: FutureBuilder<Settings>(
            future: _callBackendApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    children: <Widget>[Text(snapshot.data!.path_music)],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
    // getProperWidget()
    // ])));
  }

  Future<Settings> _callBackendApi() async {
    var api = BackendCommunicator();
    final response = await api.getSettings()
        // .then((response) {
        //   setState(() {
        //     apiCall = false; //Disable Progressbar
        //     // _currentSettings = weather.toString();
        //     _currentSettings = response.body;
        //   });
        // }, onError: (error) {
        //   setState(() {
        //     apiCall = false; //Disable Progressbar
        //     _currentSettings = error.toString();
        //   });
        ;
    if (response.statusCode == 200) {
      return Settings.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load settings');
    }

    // print('Response status: ${response.statusCode}');
    // if (response.statusCode == 200) {
    //   apiCall = false;
    // } else {
    //   apiCall = false;
    //   _currentSettings = "ERROR!!";
    // }
  }

  // [ ] probably better with async or await?!!
  // Widget getProperWidget() {
  //   if (apiCall) {
  //     return CircularProgressIndicator();
  //   } else {
  //     var _currentSettingsJson = jsonDecode(_currentSettings);
  //     try {
  //       return Text(
  //         _currentSettingsJson['paths'],
  //       );
  //     } catch (e) {
  //       return const Text('There is an error with the answer from the server');
  //     }
  //   }
  // }

  // String _currentSettings = "{}";
  // bool apiCall = false;
}
