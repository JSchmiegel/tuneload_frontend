import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotiload/global.dart';
import 'package:spotiload/helper/apihelper.dart';
import 'package:spotiload/pages/homepage.dart';
import 'package:spotiload/providers/initprovider.dart';
import 'package:spotiload/providers/matchingpageprovider.dart';

class MatchingPage extends StatefulWidget {
  final String urlArg;
  const MatchingPage({Key? key, required this.urlArg}) : super(key: key);

  static const routeName = '/matching';

  @override
  State<StatefulWidget> createState() {
    return _MatchingPageState();
  }
}

class _MatchingPageState extends State<MatchingPage> {
  int? radioGroupValue;

  _showSnackbar(String message, {Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor ?? Colors.red,
      ),
    );
  }

  _hideSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  _getMatchingResponse(id) async {
    var provider = Provider.of<MatchingPageProvider>(context, listen: false);
    var response = await APIHelper.getMatchingManual(id);
    if (response.isSuccessful) {
      provider.setMatchingResponse(response);
    } else {
      _showSnackbar(response.statusCode.toString());
    }
    provider.setIsProcessing(false);
  }

  _getInitResponse(urlArg) async {
    var provider = Provider.of<InitProvider>(context, listen: false);
    var response = await APIHelper.getInit(urlArg);
    if (response.isSuccessful) {
      provider.setInitResponse(response);
      _getMatchingResponse(provider.initResponse.data['id']);
    } else {
      _showSnackbar(response.statusCode.toString());
    }
    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();
    _getInitResponse(widget.urlArg);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InitProvider>(
        builder: (_, providerInit, __) => providerInit.isProcessing
            ? buildLoadingPage('Getting ready to download\n${widget.urlArg}')
            : Scaffold(
                appBar: AppBar(
                  title: Text('Matching: ${providerInit.initResponse.data['org_name']} (${providerInit.initResponse.data['songs'].length} songs)'),
                  leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      splashRadius: buttonSplashRadius),
                ),
                body: Consumer<MatchingPageProvider>(
                    builder: (_, providerMatching, __) => providerMatching.isProcessing
                        ? buildLoadingPage('Getting possible matchings for ${providerInit.initResponse.data['org_name']}')
                        : Container(
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
                                            title: Text(
                                                '${providerMatching.matchingResponse.data['matches'][0]['album']} (${providerMatching.matchingResponse.data['matches'][0]['num_of_songs']} songs)',
                                                style: Theme.of(context).textTheme.subtitle1),
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
                                            title: Text(
                                                '${providerMatching.matchingResponse.data['matches'][1]['album']} (${providerMatching.matchingResponse.data['matches'][1]['num_of_songs']} songs)',
                                                style: Theme.of(context).textTheme.subtitle1),
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
                                            title: Text(
                                                '${providerMatching.matchingResponse.data['matches'][2]['album']} (${providerMatching.matchingResponse.data['matches'][2]['num_of_songs']} songs)',
                                                style: Theme.of(context).textTheme.subtitle1),
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
                                            title: Text(
                                                '${providerMatching.matchingResponse.data['matches'][3]['album']} (${providerMatching.matchingResponse.data['matches'][3]['num_of_songs']} songs)',
                                                style: Theme.of(context).textTheme.subtitle1),
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
                                            title: Text(
                                                '${providerMatching.matchingResponse.data['matches'][4]['album']} (${providerMatching.matchingResponse.data['matches'][4]['num_of_songs']} songs)',
                                                style: Theme.of(context).textTheme.subtitle1),
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
                                        showDialog<void>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Please Confirm'),
                                            content: const Text('Are you sure you want to cancel the download'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('No')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                                                  },
                                                  child: const Text('Yes')),
                                            ],
                                          ),
                                        );
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
                                        // [ ] todo: right navigation
                                        Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                                      },
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          ))));
  }
}
