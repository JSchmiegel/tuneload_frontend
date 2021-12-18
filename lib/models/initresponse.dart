class InitResponse {
  String? id;
  String? file;
  String? plattform;
  String? type;
  String? orgName;
  List<Songs>? songs;

  InitResponse({this.id, this.file, this.plattform, this.type, this.orgName, this.songs});

  InitResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    plattform = json['plattform'];
    type = json['type'];
    orgName = json['org_name'];
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs?.add(Songs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['plattform'] = plattform;
    data['type'] = type;
    data['org_name'] = orgName;
    if (songs != null) {
      data['songs'] = songs?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Songs {
  String? name;
  String? ytLink;

  Songs({this.name, this.ytLink});

  Songs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ytLink = json['yt_link'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['yt_link'] = ytLink;
    return data;
  }
}
