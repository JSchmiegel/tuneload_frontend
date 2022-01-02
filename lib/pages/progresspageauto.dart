import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotiload/helper/apihelper.dart';
import 'package:spotiload/global.dart';
import 'package:spotiload/pages/errormatchingpage.dart';
import 'package:spotiload/providers/initprovider.dart';

class ProgressPageAuto extends StatefulWidget {
  final String urlArg;
  const ProgressPageAuto({Key? key, required this.urlArg}) : super(key: key);

  static const routeName = '/progress';

  @override
  State<StatefulWidget> createState() {
    return _ProgressPageAutoState();
  }
}

class _ProgressPageAutoState extends State<ProgressPageAuto> {
  _getInitResponse(urlArg) async {
    var provider = Provider.of<InitProvider>(context, listen: false);
    var response = await APIHelper.getInit(urlArg);
    if (response.isSuccessful) {
      provider.setInitResponse(response);
      provider.setIsProcessing(false);
    } else {
      // ERROR
      Navigator.pushReplacementNamed(context, ErrorPage.routeName, arguments: response);
    }
  }

  @override
  void initState() {
    super.initState();
    _getInitResponse(widget.urlArg);
  }

  @override
  Widget build(BuildContext context) {
    double progress = 1;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          // appBar: AppBar(title: const Text('Spotiload')),
          body: Consumer<InitProvider>(
              builder: (_, provider, __) => provider.isProcessing
                  ? buildLoadingPage('Getting ready to download\n${widget.urlArg}')
                  : Container(
                      margin: firstMargin,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              'Progress of downloading "${provider.initResponse.data['org_name']}" (${provider.initResponse.data['songs'].length} songs):',
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
                      ))),
        ));
  }

  // Future<Map<String, dynamic>> _callBackendApiGetInit() async {
  //   var api = APIHelper();
  //   final response = await api.getInit(urlArg);
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to get /spotiload/init');
  //   }
  // }
}
