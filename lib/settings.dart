class Settings {
  final String hostAddress;
  final String hostPort;
  final String hostUser;
  final String hostPasswd;
  final String hostToken;
  final String pathMusic;

  Settings(
      {required this.hostAddress,
      required this.hostPort,
      required this.hostUser,
      required this.hostPasswd,
      required this.hostToken,
      required this.pathMusic});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
        hostAddress: json['address'],
        hostPort: json['port'],
        hostUser: json['user'],
        hostPasswd: json['password'],
        hostToken: json['token'],
        pathMusic: json['paths']['music']);
  }
}
