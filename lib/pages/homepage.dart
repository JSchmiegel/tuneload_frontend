import 'package:flutter/material.dart';
import 'package:tuneload/global.dart';
import 'package:tuneload/pages/matchingpage.dart';
import 'package:tuneload/pages/settingpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String? url;

  Map<String, dynamic>? initResponse;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TuneLoad'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingPage.routeName);
            },
            splashRadius: buttonSplashRadius,
          )
        ],
      ),
      body: Container(
        margin: firstMargin,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    String pattern =
                        r'^https?:\/\/((open\.spotify\.com\/(playlist|album)\/)|((www\.youtube\.com)\/(playlist\?list|watch\?.*list))|(test\.dummy))';
                    RegExp regex = RegExp(pattern);
                    if (value!.isEmpty) {
                      return 'Please enter an url.';
                    } else if (!regex.hasMatch(value)) {
                      return 'Enter a valide url';
                    }
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'e.g. https://open.spotify.com/playlist/0MXkk6SXVipi7RRLW7GYze',
                    labelText: 'Enter a album or playlist url',
                  ),
                  onChanged: (value) {
                    url = value;
                  },
                  onFieldSubmitted: (value) {
                    url = value;
                    Navigator.pushNamed(context, MatchingPage.routeName, arguments: url);
                  },
                ),
                const Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(6)),
                      child: TextButton(
                        child: const Text(
                          'Download',
                          style: styleButton,
                        ),
                        onPressed: () {
                          // Validate the form by getting the FormState from the GlobalKey
                          // and calling validate() on it.
                          var valid = _formKey.currentState!.validate();
                          if (!valid) {
                            return;
                          }

                          Navigator.pushNamed(context, MatchingPage.routeName, arguments: url);
                        },
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 6),
              ],
            )),
      ),
    );
  }
}
