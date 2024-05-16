class VideoModal {
  String? id;
  String? image;
  String? title;
  String? url;

  VideoModal({this.id, this.image, this.title, this.url});

  VideoModal.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    title = json["title"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["image"] = image;
    _data["title"] = title;
    _data["url"] = url;
    return _data;
  }

  static List<VideoModal> ofVideo(List videotutorial) {
    return videotutorial.map((e) => VideoModal.fromJson(e)).toList();
  }
}
