import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotiload/pages/homepage.dart';
import 'package:spotiload/pages/matchingpage.dart';
import 'package:spotiload/pages/progresspageauto.dart';
import 'package:spotiload/pages/settingpage.dart';
import 'package:spotiload/providers/initprovider.dart';
import 'package:spotiload/providers/matchingpageprovider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<InitProvider>(create: (_) => InitProvider()),
    ChangeNotifierProvider<MatchingPageProvider>(create: (_) => MatchingPageProvider()),
  ], child: const MyApp()));
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
        // ProgressPage.routeName: (context) => ChangeNotifierProvider<ProgressPageProvider>(
        //     create: (context) => ProgressPageProvider(),
        //     child: const ProgressPage(
        //       urlArg: '',
        //     )),
        SettingPage.routeName: (context) => const SettingPage(),
        // MatchingPage.routeName: (context) => const MatchingPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ProgressPageAuto.routeName) {
          final String args = settings.arguments.toString();
          return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<InitProvider>(
                  create: (context) => InitProvider(),
                  child: ProgressPageAuto(
                    urlArg: args,
                  )));
        } else if (settings.name == MatchingPage.routeName) {
          final String args = settings.arguments.toString();
          return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<InitProvider>(
                  create: (context) => InitProvider(),
                  child: MatchingPage(
                    urlArg: args,
                  )));
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: HomeScreen(),
    );
  }
}
