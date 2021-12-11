class Settings {
  final String host_address;
  final String host_port;
  final String host_user;
  final String host_passwd;
  final String host_token;
  final String path_music;

  Settings(
      {required this.host_address,
      required this.host_port,
      required this.host_user,
      required this.host_passwd,
      required this.host_token,
      required this.path_music});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
        host_address: json['address'],
        host_port: json['port'],
        host_user: json['user'],
        host_passwd: json['password'],
        host_token: json['token'],
        path_music: json['paths']['music']);
  }
}
