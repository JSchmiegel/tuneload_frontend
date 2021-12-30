import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotiload/helper/apihelper.dart';
import 'package:spotiload/global.dart';
import 'package:spotiload/models/jumpingdotsindicator.dart';
import 'package:spotiload/pages/homepage.dart';
import 'package:spotiload/providers/progresspagemanualprovider.dart';
import 'package:spotiload/providers/progressprovider.dart';
import "package:intl/intl.dart";

class ProgressPageManual extends StatefulWidget {
  final String spotifyId;
  final String userId;

  // bool cancel;
  const ProgressPageManual({Key? key, required this.spotifyId, required this.userId}) : super(key: key);

  static const routeName = '/progressmanual';

  @override
  State<StatefulWidget> createState() {
    return _ProgressPageManualState();
  }
}

class _ProgressPageManualState extends State<ProgressPageManual> {
  bool cancel = false;

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

  _getProgressPageManualResponse(String userId, String spotifyIdArg) async {
    var provider = Provider.of<ProgressPageManualProvider>(context, listen: false);
    var response = await APIHelper.putMatching(userId, spotifyIdArg);
    if (response.isSuccessful) {
      provider.setProgressManualResponse(response);
      _getProgressResponse(userId, response.data['songs']);
    } else {
      _showSnackbar(response.statusCode.toString());
    }
    provider.setIsProcessing(false);
  }

  _getProgressResponse(String userId, List<dynamic> songs) async {
    var provider = Provider.of<ProgressProvider>(context, listen: false);
    for (var i = 0; i < songs.length; i++) {
      if (cancel) {
        break;
      }
      var response = await APIHelper.getDownload(userId, i.toString());
      if (response.isSuccessful) {
        provider.setProgressResponse(response, i);
      } else {
        _showSnackbar(response.statusCode.toString());
      }
      provider.setIsProcessing(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _getProgressPageManualResponse(widget.userId, widget.spotifyId);
  }

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#0.0#", "en_US");

    return Scaffold(
      body: Consumer<ProgressPageManualProvider>(
          builder: (_, providerProgressManual, __) => providerProgressManual.isProcessing
              ? buildLoadingPage('Getting ready to download\n${widget.spotifyId}')
              : Container(
                  margin: firstMargin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          'Progress of downloading "${providerProgressManual.progressManualResponse.data['org_name']}" (${providerProgressManual.progressManualResponse.data['songs'].length} songs):',
                          style: styleText),
                      Consumer<ProgressProvider>(
                        builder: (_, providerProgress, __) => providerProgress.isProcessing
                            // page before first notification from provider
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Downloading and Tagging "${providerProgressManual.progressManualResponse.data['songs'][0]['title']}.mp3"'),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      const JumpingDotsProgressIndicator(
                                        numberOfDots: 3,
                                        fontSize: 20.0,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 500,
                                        child: LinearProgressIndicator(
                                          value: ((1) / (providerProgressManual.progressManualResponse.data['songs'].length + 1)),
                                        ),
                                      ),
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
                                                      Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                                                    },
                                                    child: const Text('Yes')),
                                              ],
                                            ),
                                          );
                                        },
                                        splashRadius: buttonSplashRadius,
                                      )
                                    ],
                                  ),
                                  Text('${f.format(((1) / (providerProgressManual.progressManualResponse.data['songs'].length + 1)) * 100)} %'),
                                ],
                              )
                            // page after first notification from provider
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      LayoutBuilder(builder: (context, constraints) {
                                        if (providerProgress.progressResponse.index + 1 >=
                                            providerProgressManual.progressManualResponse.data['songs'].length) {
                                          return const Text('ende');
                                        } else {
                                          return Row(
                                            children: [
                                              Text(
                                                  'Downloading and Tagging "${providerProgressManual.progressManualResponse.data['songs'][providerProgress.progressResponse.index + 1]['title']}.mp3"'),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              const JumpingDotsProgressIndicator(
                                                numberOfDots: 3,
                                                fontSize: 20.0,
                                              ),
                                            ],
                                          );
                                        }
                                      })
                                      // const SizedBox(height: 10, width: 10, child: CircularProgressIndicator()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 500,
                                        child: LinearProgressIndicator(
                                          value: ((providerProgress.progressResponse.index + 1) /
                                              (providerProgressManual.progressManualResponse.data['songs'].length + 1)),
                                        ),
                                      ),
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
                                                      cancel = true;
                                                      Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                                                    },
                                                    child: const Text('Yes')),
                                              ],
                                            ),
                                          );
                                        },
                                        splashRadius: buttonSplashRadius,
                                      )
                                    ],
                                  ),
                                  Text(
                                      '${f.format(((providerProgress.progressResponse.index + 1) / (providerProgressManual.progressManualResponse.data['songs'].length + 1)) * 100)} %')
                                ],
                              ),
                      )
                    ],
                  ))),
    );
  }
}
