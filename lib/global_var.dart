import 'package:flutter/material.dart';

const firstMargin = EdgeInsets.all(33);
double buttonSplashRadius = 15;
final greenColor = Colors.green[500];
final redColor = Colors.red[300];

const styleButton = TextStyle(color: Colors.white, fontSize: 16);
const styleText = TextStyle(color: Colors.black, fontSize: 20);

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

// api
const String globalHost = "127.0.0.1:32500";
