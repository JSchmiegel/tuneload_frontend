// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:spotiload/global.dart';
import 'package:spotiload/pages/homepage.dart';

class FinishPage extends StatelessWidget {
  final String album_name;
  final String album_artist;
  final String image;
  final int num_of_songs;

  const FinishPage({
    Key? key,
    required this.album_name,
    required this.album_artist,
    required this.image,
    required this.num_of_songs,
  }) : super(key: key);

  static const routeName = '/finish';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  image,
                  width: 180.0,
                ),
                Column(
                  children: [
                    Text(
                      'Downlaoded:',
                      style: generalTextStyle(20.0),
                    ),
                    Text(
                      '${album_name} - ${album_artist} (${num_of_songs} songs)',
                      style: generalTextStyle(18.0),
                    ),
                  ],
                ),
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
