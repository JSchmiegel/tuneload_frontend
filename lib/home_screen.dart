import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String? url;
  bool? upload = true;
  bool? deleteJson = true;
  bool? searchLyrics = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spotiload')),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    String pattern =
                        r'^https?:\/\/((open.spotify.com\/(playlist|album)\/)|((www.youtube.com)\/(playlist\?list|watch\?.*list)))';
                    RegExp regex = RegExp(pattern);
                    if (value!.isEmpty) {
                      return 'Please enter an url.';
                    } else if (!regex.hasMatch(value)) {
                      return 'Enter a valide url';
                    }
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText:
                        'e.g. https://open.spotify.com/playlist/0MXkk6SXVipi7RRLW7GYze',
                    labelText: 'Enter a Album/Playlist URL',
                  ),
                  onChanged: (value) {
                    url = value;
                  },
                ),
                const Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormField<bool>(
                      initialValue: true,
                      builder: (formFieldState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: upload,
                                  onChanged: (value) {
                                    // When the value of the checkbox changes,
                                    // update the FormFieldState so the form is
                                    // re-validated.
                                    formFieldState.didChange(value);
                                    setState(() {
                                      upload = value;
                                    });
                                  },
                                ),
                                Text(
                                  'direct upload to plex server',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: searchLyrics,
                                  onChanged: (value) {
                                    // When the value of the checkbox changes,
                                    // update the FormFieldState so the form is
                                    // re-validated.
                                    formFieldState.didChange(value);
                                    setState(() {
                                      searchLyrics = value;
                                    });
                                  },
                                ),
                                Text(
                                  'search for "... Lyrics"',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: deleteJson,
                                  onChanged: (value) {
                                    // When the value of the checkbox changes,
                                    // update the FormFieldState so the form is
                                    // re-validated.
                                    formFieldState.didChange(value);
                                    setState(() {
                                      deleteJson = value;
                                    });
                                  },
                                ),
                                Text(
                                  'delete .json after download',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.circular(6)),
                      child: TextButton(
                        child: const Text(
                          'Download',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          // Validate the form by getting the FormState from the GlobalKey
                          // and calling validate() on it.
                          var valid = _formKey.currentState!.validate();
                          if (!valid) {
                            return;
                          }

                          showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Test'),
                              content: Text('The url was $url'),
                              actions: [
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
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
