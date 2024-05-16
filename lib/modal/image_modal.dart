class ImageModal {
  String? id;
  String? image;
  String? name;

  ImageModal({this.id, this.image, this.name});

  ImageModal.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["image"] = image;
    _data["name"] = name;
    return _data;
  }

  static List<ImageModal> ofImage(List imagequestion) {
    return imagequestion.map((e) => ImageModal.fromJson(e)).toList();
  }
}
