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
                          const Text('HTTP-Error Code:', style: styleTextErrorKey),
                          spacerTableError,
                          Text('${response.statusCode}', style: styleTextErrorValue)
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('HTTP-Request was successfull:', style: styleTextErrorKey),
                          spacerTableError,
                          Text('${response.isSuccessful}', style: styleTextErrorValue)
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('HTTP-Message:', style: styleTextErrorKey),
                          spacerTableError,
                          Expanded(child: Text('${response.message}', style: styleTextErrorValue))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('HTTP-Body:', style: styleTextErrorKey),
                          spacerTableError,
                          Expanded(child: Text('${response.data}', style: styleTextErrorValue))
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
