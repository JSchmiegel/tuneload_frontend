import 'package:flutter/material.dart';
import 'package:spotiload/screens/home_screen.dart';
import 'package:spotiload/screens/progress_screen.dart';
import 'package:spotiload/screens/setting_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/progress': (context) => const ProgressScreen(),
        '/settings': (context) => const SettingScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: HomeScreen(),
    );
  }
}
