import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuneload/models/httpresponse.dart';
import 'package:tuneload/pages/errorpage.dart';
import 'package:tuneload/pages/homepage.dart';
import 'package:tuneload/pages/matchingpage.dart';
import 'package:tuneload/pages/progresspageauto.dart';
import 'package:tuneload/pages/progresspagemanual.dart';
import 'package:tuneload/pages/settingpage.dart';
import 'package:tuneload/providers/errorpageprovider.dart';
import 'package:tuneload/providers/initprovider.dart';
import 'package:tuneload/providers/matchingpageprovider.dart';
import 'package:tuneload/providers/progresspagemanualprovider.dart';
import 'package:tuneload/providers/progressprovider.dart';
import 'pages/finishpage.dart';
import 'providers/finishpageprovider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<InitProvider>(create: (_) => InitProvider()),
    ChangeNotifierProvider<MatchingPageProvider>(create: (_) => MatchingPageProvider()),
    ChangeNotifierProvider<ProgressPageManualProvider>(create: (_) => ProgressPageManualProvider()),
    ChangeNotifierProvider<ProgressProvider>(create: (_) => ProgressProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TuneLoad',
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SettingPage.routeName: (context) => const SettingPage(),
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
          } else if (settings.name == ProgressPageManual.routeName) {
            var args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<ProgressPageManualProvider>(
                    create: (context) => ProgressPageManualProvider(),
                    child: ProgressPageManual(
                      spotifyId: args['spotifyId'],
                      userId: args['userId'],
                    )));
          } else if (settings.name == FinishPage.routeName) {
            var args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<FinishPageProvider>(
                    create: (context) => FinishPageProvider(),
                    child: FinishPage(
                      album_name: args['album'],
                      album_artist: args['album_artist'],
                      image: args['image'],
                      num_of_songs: args['num_of_songs'],
                    )));
          } else if (settings.name == ErrorPage.routeName) {
            var args = settings.arguments as HTTPResponse;
            return MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<ErrorPageProvider>(
                    create: (context) => ErrorPageProvider(),
                    child: ErrorPage(
                      response: args,
                    )));
          }
        },
        theme: ThemeData(
            primarySwatch: const MaterialColor(4292125811, {
              50: Color(0xfff9f2eb),
              100: Color(0xfff3e6d8),
              200: Color(0xffe7ccb1),
              300: Color(0xffdbb38a),
              400: Color(0xffcf9a63),
              500: Color(0xffc3803c),
              600: Color(0xff9c6730),
              700: Color(0xff754d24),
              800: Color(0xff4e3318),
              900: Color(0xff271a0c),
            }),
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
            )));
  }
}
