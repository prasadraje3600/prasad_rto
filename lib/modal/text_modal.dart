class TextModel {
  String? id;
  String? question;
  String? answer;

  TextModel({this.id, this.question, this.answer});

  TextModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
    answer = json["answer"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["question"] = question;
    _data["answer"] = answer;
    return _data;
  }

  static List<TextModel> ofText(List textquestion) {
    return textquestion.map((e) => TextModel.fromJson(e)).toList();
  }
}
