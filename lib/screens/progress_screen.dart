import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotiload/api.dart';
import 'package:spotiload/global_var.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  static const routeName = '/progress';

  // Map<String, dynamic> responseInit = await

  @override
  State<StatefulWidget> createState() {
    return _ProgressScreenState();
  }
}

class _ProgressScreenState extends State<ProgressScreen> {
  String? urlArg;

  @override
  Widget build(BuildContext context) {
    double progress = 1;
    urlArg = ModalRoute.of(context)!.settings.arguments as String;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          // appBar: AppBar(title: const Text('Spotiload')),
          body: FutureBuilder<Map>(
              future: _callBackendApiGetInit(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      margin: firstMargin,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Progress of downloading "${snapshot.data!['org_name']}" (${snapshot.data!['songs'].length} songs):',
                              style: styleText),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Doing blablabla ....'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 500,
                                    child: LinearProgressIndicator(
                                      value: progress,
                                    ),
                                  ),
                                  // const Text('Here should be a LinearProgressIndicator'),
                                  IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: redColor,
                                    ),
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Please Confirm'),
                                          content: const Text('Are you sure to cancel the download?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  // Close the dialog
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No')),
                                            TextButton(
                                                onPressed: () {
                                                  // Close the dialog
                                                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                                                },
                                                child: const Text('Yes')),
                                          ],
                                        ),
                                      );
                                    },
                                    splashRadius: buttonSplashRadius,
                                    // hoverColor: Colors.red[500],
                                  )
                                ],
                              ),
                              Text('${progress * 100} %')
                            ],
                          ),
                        ],
                      ));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }

  Future<Map<String, dynamic>> _callBackendApiGetInit() async {
    var api = Api();
    final response = await api.getInit(urlArg);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get /spotiload/init');
    }
  }
}
