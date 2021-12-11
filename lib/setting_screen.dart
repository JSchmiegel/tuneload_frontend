import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotiload/backen_communicator.dart';
import 'package:spotiload/global_var.dart';
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
        body: Container(
            margin: firstMargin,
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                children: const [Text('PLEX:')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Host-address:'),
                      Text('Host-port:'),
                      Text('User:'),
                      Text('Password:'),
                      Text('Token:'),
                      Text('Path music: ')
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  FutureBuilder<Settings>(
                      future: _callBackendApi(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(snapshot.data!.hostAddress),
                              Text(snapshot.data!.hostPort),
                              Text(snapshot.data!.hostUser),
                              Text(snapshot.data!.hostPasswd),
                              Text(snapshot.data!.hostToken),
                              Text(snapshot.data!.pathMusic)
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      }),
                  const Spacer(
                    flex: 5,
                  ),
                ],
              ),
            ])));
  }

  Future<Settings> _callBackendApi() async {
    var api = BackendCommunicator();
    final response = await api.getSettings();
    if (response.statusCode == 200) {
      return Settings.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load settings');
    }
  }
}
