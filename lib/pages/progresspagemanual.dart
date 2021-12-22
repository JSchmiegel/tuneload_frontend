import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotiload/helper/apihelper.dart';
import 'package:spotiload/global.dart';
import 'package:spotiload/pages/homepage.dart';
import 'package:spotiload/providers/progresspagemanualprovider.dart';

class ProgressPageManual extends StatefulWidget {
  final String spotifyId;
  final String userId;
  const ProgressPageManual({Key? key, required this.spotifyId, required this.userId}) : super(key: key);

  static const routeName = '/progressmanual';

  @override
  State<StatefulWidget> createState() {
    return _ProgressPageManualState();
  }
}

class _ProgressPageManualState extends State<ProgressPageManual> {
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

  _getProgressResponse(userId, spotifyIdArg) async {
    var provider = Provider.of<ProgressPageManualProvider>(context, listen: false);
    var response = await APIHelper.putMatching(userId, spotifyIdArg);
    if (response.isSuccessful) {
      provider.setProgressManualResponse(response);
    } else {
      _showSnackbar(response.statusCode.toString());
    }
    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();
    _getProgressResponse(widget.userId, widget.spotifyId);
  }

  @override
  Widget build(BuildContext context) {
    double progress = 1;

    return Scaffold(
      body: Consumer<ProgressPageManualProvider>(
          builder: (_, provider, __) => provider.isProcessing
              ? buildLoadingPage('Getting ready to download\n${widget.spotifyId}')
              : Container(
                  margin: firstMargin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          'Progress of downloading "${provider.progressManualResponse.data['org_name']}" (${provider.progressManualResponse.data['songs'].length} songs):',
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
                          Text('${progress * 100} %')
                        ],
                      ),
                    ],
                  ))),
    );
  }
}
