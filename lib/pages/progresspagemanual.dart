import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuneload/helper/apihelper.dart';
import 'package:tuneload/global.dart';
import 'package:tuneload/models/jumpingdotsindicator.dart';
import 'package:tuneload/pages/errorpage.dart';
import 'package:tuneload/pages/finishpage.dart';
import 'package:tuneload/pages/homepage.dart';
import 'package:tuneload/providers/progresspagemanualprovider.dart';
import 'package:tuneload/providers/progressprovider.dart';

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
  bool error = false;

  _getProgressPageManualResponse(String userId, String spotifyIdArg) async {
    var provider = Provider.of<ProgressPageManualProvider>(context, listen: false);
    var response = await APIHelper.putMatching(userId, spotifyIdArg);
    if (response.isSuccessful) {
      provider.setProgressManualResponse(response);
      _getProgressResponse(userId, response.data['songs']);
      provider.setIsProcessing(false);
    } else {
      // ERROR
      Navigator.pushReplacementNamed(context, ErrorPage.routeName, arguments: response);
    }
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
        provider.setIsProcessing(false);
      } else {
        // ERROR
        Navigator.pushReplacementNamed(context, ErrorPage.routeName, arguments: response);
        error = true;
        break;
      }
    }
    if (cancel == false && error == false) {
      var responseFinish = await APIHelper.putUpload(userId);
      if (responseFinish.isSuccessful) {
        Navigator.pushReplacementNamed(context, FinishPage.routeName, arguments: responseFinish.data);
      } else {
        // ERROR
        Navigator.pushReplacementNamed(context, ErrorPage.routeName, arguments: responseFinish);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProgressPageManualResponse(widget.userId, widget.spotifyId);
  }

  @override
  Widget build(BuildContext context) {
    int addProgress = 0;
    addProgress = 1;

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
                                      Text('Downloading and Tagging "${providerProgressManual.progressManualResponse.data['songs'][0]['title']}"'),
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
                                          value: ((1) / (providerProgressManual.progressManualResponse.data['songs'].length + addProgress)),
                                        ),
                                      ),
                                      createCancelButton(),
                                    ],
                                  ),
                                  Text('Process:  ${1}/${providerProgressManual.progressManualResponse.data['songs'].length + addProgress}'),
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
                                          providerProgress.progressResponse.index = -1;
                                          return Row(
                                            children: const [
                                              Text('Uploading songs'),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              JumpingDotsProgressIndicator(
                                                numberOfDots: 3,
                                                fontSize: 20.0,
                                              ),
                                            ],
                                          );
                                        } else if (providerProgress.progressResponse.index + 1 >=
                                            providerProgressManual.progressManualResponse.data['songs'].length) {
                                          return Container();
                                        } else {
                                          return Row(
                                            children: [
                                              Text(
                                                  'Downloading and Tagging "${providerProgressManual.progressManualResponse.data['songs'][providerProgress.progressResponse.index + 1]['title']}"'),
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
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 500,
                                        child: LinearProgressIndicator(
                                          value: ((providerProgress.progressResponse.index + 2) /
                                              (providerProgressManual.progressManualResponse.data['songs'].length + addProgress)),
                                        ),
                                      ),
                                      createCancelButton(),
                                    ],
                                  ),
                                  Text(
                                      'Process:  ${providerProgress.progressResponse.index + 2}/${providerProgressManual.progressManualResponse.data['songs'].length + addProgress}'),
                                ],
                              ),
                      )
                    ],
                  ))),
    );
  }

  Widget createCancelButton() {
    return IconButton(
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
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    cancel = true;
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text('Yes')),
            ],
          ),
        );
      },
      splashRadius: buttonSplashRadius,
    );
  }
}
