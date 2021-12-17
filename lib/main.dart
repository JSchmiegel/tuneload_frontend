import 'package:flutter/material.dart';
import 'package:spotiload/pages/homepage.dart';
import 'package:spotiload/pages/progresspage.dart';
import 'package:spotiload/pages/settingpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotiload',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        ProgressPage.routeName: (context) => const ProgressPage(),
        SettingPage.routeName: (context) => const SettingPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: HomeScreen(),
    );
  }
}
