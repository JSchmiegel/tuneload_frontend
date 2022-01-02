import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:spotiload/global.dart';
import 'package:spotiload/models/httpresponse.dart';
import 'package:spotiload/pages/homepage.dart';

class ErrorPage extends StatelessWidget {
  final HTTPResponse response;
  const ErrorPage({Key? key, required this.response}) : super(key: key);

  static const routeName = '/error';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ERROR'),
        automaticallyImplyLeading: false, // removes the back button
        backgroundColor: HexColor("#b71b1c"),
      ),
      body: Container(
        margin: firstMargin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('HTTP-Error Code:', style: generalTextStyle(20.0)),
                          spacerTableError,
                          Text('${response.statusCode}', style: generalTextStyle(20.0))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('HTTP-Request was successfull:', style: generalTextStyle(18.0)),
                          spacerTableError,
                          Text('${response.isSuccessful}', style: styleTextErrorContent)
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('HTTP-Message:', style: generalTextStyle(18.0)),
                          spacerTableError,
                          Text('${response.message}', style: styleTextErrorContent)
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('HTTP-Body:', style: generalTextStyle(18.0)),
                          spacerTableError,
                          Text('${response.data}', style: styleTextErrorContent)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#b71b1c")),
                    borderRadius: BorderRadius.circular(6),
                    color: HexColor("#ef534f"),
                  ),
                  child: TextButton(
                    child: const Text(
                      'Restart',
                      style: styleButton,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
