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
  bool passEnable = false;
  bool tokenEnable = false;

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
        body: SingleChildScrollView(
          child: Container(
              margin: firstMargin,
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: const [
                    Text(
                      'PLEX:',
                      style: styleText,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    FutureBuilder<Settings>(
                        future: _callBackendApi(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Table(
                              columnWidths: const <int, TableColumnWidth>{
                                0: IntrinsicColumnWidth(),
                                1: IntrinsicColumnWidth(),
                                2: FixedColumnWidth(300),
                                3: IntrinsicColumnWidth(),
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(children: [
                                  Text('Host-address: ', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: TextEditingController()..text = snapshot.data!.hostAddress,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  )
                                ]),
                                TableRow(children: [
                                  Text('Host-port:', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: TextEditingController()..text = snapshot.data!.hostPort,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  )
                                ]),
                                TableRow(children: [
                                  Text('User:', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: TextEditingController()..text = snapshot.data!.hostUser,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  )
                                ]),
                                TableRow(children: [
                                  Text('Password:', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: TextEditingController()..text = snapshot.data!.hostPasswd,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                      obscureText: passEnable,
                                    ),
                                  ),
                                  IconButton(
                                      iconSize: 18.0,
                                      splashRadius: buttonSplashRadius,
                                      onPressed: () {
                                        setState(() {
                                          if (passEnable) {
                                            passEnable = false;
                                          } else {
                                            passEnable = true;
                                          }
                                        });
                                      },
                                      icon: Icon(passEnable == true ? Icons.remove_red_eye : Icons.password)),
                                ]),
                                TableRow(children: [
                                  Text('Token:', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: TextEditingController()..text = snapshot.data!.hostToken,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                      obscureText: tokenEnable,
                                    ),
                                  ),
                                  IconButton(
                                      iconSize: 18.0,
                                      splashRadius: buttonSplashRadius,
                                      onPressed: () {
                                        setState(() {
                                          if (tokenEnable) {
                                            tokenEnable = false;
                                          } else {
                                            tokenEnable = true;
                                          }
                                        });
                                      },
                                      icon: Icon(tokenEnable == true ? Icons.remove_red_eye : Icons.password)),
                                ]),
                                TableRow(children: [
                                  Text('Path music: ', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: TextEditingController()..text = snapshot.data!.pathMusic,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  )
                                ]),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.circular(6)),
                      child: TextButton(
                        child: const Text(
                          'Confirm',
                          style: styleButton,
                        ),
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Please Confirm'),
                              content: const Text('Are you sure you want to save the settings?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                                    },
                                    child: const Text('Yes')),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ])),
        ));
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
