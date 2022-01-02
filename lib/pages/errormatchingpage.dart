import 'package:flutter/material.dart';
import 'package:spotiload/global.dart';
import 'package:spotiload/pages/homepage.dart';

// [ ] TODO!!

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  static const routeName = '/error';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: firstMargin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  child: Text(
                    'Done',
                    style: styleTextFinish,
                  ),
                )
              ],
            ),
            // IDEA [ ] insert image of playlist and finish overview
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.circular(6)),
                  child: TextButton(
                    child: const Text(
                      'Confirm',
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
