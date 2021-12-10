class Settings {
  final String path_music;

  Settings({required this.path_music});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(path_music: json['paths']['musicserver']);
  }
}
