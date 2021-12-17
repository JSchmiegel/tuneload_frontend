import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotiload/helper/apihelper.dart';
import 'package:spotiload/global_var.dart';
import 'package:spotiload/settings.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<StatefulWidget> createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController txtCtrHostAddress = TextEditingController();
  TextEditingController txtCtrHostPort = TextEditingController();
  TextEditingController txtCtrHostUser = TextEditingController();
  TextEditingController txtCtrHostPasswd = TextEditingController();
  TextEditingController txtCtrHostToken = TextEditingController();
  TextEditingController txtCtrPathMusic = TextEditingController();

  bool passEnable = true;
  bool tokenEnable = true;

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
                        future: _callBackendApiGet(),
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
                                      controller: txtCtrHostAddress..text = snapshot.data!.hostAddress,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  spacerTableSettings
                                ]),
                                TableRow(children: [
                                  Text('Host-port:', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: txtCtrHostPort..text = snapshot.data!.hostPort,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  spacerTableSettings
                                ]),
                                TableRow(children: [
                                  Text('User:', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: txtCtrHostUser..text = snapshot.data!.hostUser,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  spacerTableSettings
                                ]),
                                TableRow(children: [
                                  Text('Password:', style: Theme.of(context).textTheme.subtitle1),
                                  spacerTableSettings,
                                  Padding(
                                    padding: paddingSettingInput,
                                    child: TextField(
                                      controller: txtCtrHostPasswd..text = snapshot.data!.hostPasswd,
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
                                      controller: txtCtrHostToken..text = snapshot.data!.hostToken,
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
                                      controller: txtCtrPathMusic..text = snapshot.data!.pathMusic,
                                      decoration: decorationSettingInput,
                                      style: styleSettingInput,
                                    ),
                                  ),
                                  spacerTableSettings
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
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      _callBackendApiPut();
                                      // Navigator.of(context).pop();
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

  Future<Settings> _callBackendApiGet() async {
    var api = Api();
    final response = await api.getSettings();
    if (response.statusCode == 200) {
      return Settings.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load settings');
    }
  }

  Future<Settings> _callBackendApiPut() async {
    var settings = Settings(
        hostAddress: txtCtrHostAddress.text,
        hostPort: txtCtrHostPort.text,
        hostUser: txtCtrHostUser.text,
        hostPasswd: txtCtrHostPasswd.text,
        hostToken: txtCtrHostToken.text,
        pathMusic: txtCtrPathMusic.text);

    var api = Api();
    final response = await api.putSettings(settings);
    if (response.statusCode == 200) {
      return Settings.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load settings');
    }
  }
}
