import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotiload/models/httpresponse.dart';
import 'package:spotiload/pages/errorpage.dart';
import 'package:spotiload/pages/homepage.dart';
import 'package:spotiload/pages/matchingpage.dart';
import 'package:spotiload/pages/progresspageauto.dart';
import 'package:spotiload/pages/progresspagemanual.dart';
import 'package:spotiload/pages/settingpage.dart';
import 'package:spotiload/providers/errorpageprovider.dart';
import 'package:spotiload/providers/initprovider.dart';
import 'package:spotiload/providers/matchingpageprovider.dart';
import 'package:spotiload/providers/progresspagemanualprovider.dart';
import 'package:spotiload/providers/progressprovider.dart';
// import 'package:spotiload/themes/tuneloadTheme.dart';
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
        // theme: tuneloadTheme,
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
            // brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
            ))
        //     primaryColor: const Color(0xFFd4a473) //, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF5c706f)),
        // home: HomeScreen(),
        );
  }
}
