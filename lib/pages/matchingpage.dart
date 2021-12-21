import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotiload/global.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({Key? key}) : super(key: key);

  static const routeName = '/matching';

  @override
  State<StatefulWidget> createState() {
    return _MatchingPageState();
  }
}

class _MatchingPageState extends State<MatchingPage> {
  int? radioGroupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Matching: Title (x songs)'),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      SizedBox(
                        width: pixelwidthRadio,
                        height: pixelheightRadio,
                        child: ListTile(
                          title: Text('First match (x songs)', style: Theme.of(context).textTheme.subtitle1),
                          leading: Radio<int>(
                            groupValue: radioGroupValue,
                            value: 0,
                            onChanged: (int? value) {
                              setState(() {
                                radioGroupValue = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: pixelwidthRadio,
                        height: pixelheightRadio,
                        child: ListTile(
                          title: Text('First match (x songs)', style: Theme.of(context).textTheme.subtitle1),
                          leading: Radio<int>(
                            groupValue: radioGroupValue,
                            value: 1,
                            onChanged: (int? value) {
                              setState(() {
                                radioGroupValue = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: pixelwidthRadio,
                        height: pixelheightRadio,
                        child: ListTile(
                          title: Text('First match (x songs)', style: Theme.of(context).textTheme.subtitle1),
                          leading: Radio<int>(
                            groupValue: radioGroupValue,
                            value: 2,
                            onChanged: (int? value) {
                              setState(() {
                                radioGroupValue = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: pixelwidthRadio,
                        height: pixelheightRadio,
                        child: ListTile(
                          title: Text('First match (x songs)', style: Theme.of(context).textTheme.subtitle1),
                          leading: Radio<int>(
                            groupValue: radioGroupValue,
                            value: 3,
                            onChanged: (int? value) {
                              setState(() {
                                radioGroupValue = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: pixelwidthRadio,
                        height: pixelheightRadio,
                        child: ListTile(
                          title: Text('First match (x songs)', style: Theme.of(context).textTheme.subtitle1),
                          leading: Radio<int>(
                            groupValue: radioGroupValue,
                            value: 4,
                            onChanged: (int? value) {
                              setState(() {
                                radioGroupValue = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              ]),
              blankLine,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.circular(6)),
                  child: TextButton(
                    child: const Text(
                      'Cancel',
                      style: styleButton,
                    ),
                    onPressed: () {
                      // Validate the form by getting the FormState from the GlobalKey
                      // and calling validate() on it.
                      // var valid = _formKey.currentState!.validate();
                      // if (!valid) {
                      //   return;
                      // }
                      // Map<String, dynamic> response = await _callBackendApiGetInit();
                      // _callBackendApiGetInit();
                      // Navigator.pushNamed(context, '/progress', arguments: url);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.circular(6)),
                  child: TextButton(
                    child: const Text(
                      'Confirm',
                      style: styleButton,
                    ),
                    onPressed: () {
                      // Validate the form by getting the FormState from the GlobalKey
                      // and calling validate() on it.
                      // var valid = _formKey.currentState!.validate();
                      // if (!valid) {
                      //   return;
                      // }
                      // Map<String, dynamic> response = await _callBackendApiGetInit();
                      // _callBackendApiGetInit();
                      // Navigator.pushNamed(context, '/progress', arguments: url);
                    },
                  ),
                ),
              ])
            ],
          ),
        ));
  }
}
