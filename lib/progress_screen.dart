import 'package:flutter/material.dart';
import 'package:spotiload/global_var.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgressScreenState();
  }
}

class _ProgressScreenState extends State<ProgressScreen> {
  double? progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: firstMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Progress of downloading X titles:', style: styleText),
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
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Cancel'),
                              content: const Text(
                                  'You clicked the button to cancel the acction'),
                              actions: [
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        splashRadius: 20,
                        hoverColor: Colors.red[500],
                      )
                    ],
                  ),
                  Text('x %')
                ],
              ),
            ],
          )),
    );
  }
}
