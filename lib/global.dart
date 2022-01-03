import 'package:flutter/material.dart';

// uplaoding?
bool? uplaoding = true;

const firstMargin = EdgeInsets.all(33);
double buttonSplashRadius = 15;
final mainColor = Color(0xFFd4a373);
final redColor = Colors.red[300];

const styleButton = TextStyle(color: Colors.white, fontSize: 16);
const styleText = TextStyle(color: Colors.black, fontSize: 20);
const styleTextGreat = TextStyle(color: Colors.black, fontSize: 35);

TextStyle generalTextStyle(fontSize) {
  return TextStyle(color: Colors.black, fontSize: fontSize);
}

// Settingspage
const decorationSettingInput = InputDecoration(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  isDense: true,
);
const styleSettingInput = TextStyle(color: Colors.black, fontSize: 15);
const paddingSettingInput = EdgeInsets.all(3.0);

const spacerTableSettings = SizedBox(
  width: 20,
);

// Matchingpage
const double pixelwidthRadio = 550;
const double pixelheightRadio = 30;
Widget blankLine = Row(
  children: const [
    SizedBox(
      height: 30,
    ),
  ],
);
const styleButtonManualMatch = TextStyle(color: Colors.black, fontSize: 12);

// api
const String globalHost = '127.0.0.1:32500';
const String apiVersion = '/1.0.0';

// Loading Page
Widget buildLoadingPage(String message) {
  return Scaffold(
    body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const CircularProgressIndicator(),
        SizedBox(
          width: 500,
          child: Text(
            message,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        )
      ],
    )),
  );
}

// Error Page
const spacerTableError = SizedBox(
  width: 20,
);
const styleTextErrorKey = TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);
const styleTextErrorValue = TextStyle(color: Colors.black, fontSize: 18.0);
