// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:drop_shadow/drop_shadow.dart';
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
      appBar: AppBar(
        title: const Text('Downloaded:'),
        automaticallyImplyLeading: false, // removes the back button
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(33, 0, 33, 31),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     SizedBox(
            //       child: Text(
            //         'Done',
            //         style: styleTextGreat,
            //       ),
            //     )
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album_name,
                        style: generalTextStyle(20.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' - ${album_artist} (${num_of_songs} songs)',
                        style: generalTextStyle(20.0),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropShadow(
                  child: Image.network(
                    image,
                    width: 180.0,
                  ),
                  blurRadius: 7.0,
                ),
              ],
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
