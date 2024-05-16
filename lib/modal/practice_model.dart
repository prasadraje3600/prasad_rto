class PracticeModal {
  String? id;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? answer;

  PracticeModal(
      {this.id,
      this.question,
      this.option1,
      this.option2,
      this.option3,
      this.answer});

  PracticeModal.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
    option1 = json["option_1"];
    option2 = json["option_2"];
    option3 = json["option_3"];
    answer = json["answer"];
  }

  get selectedOption => null;

  get selectedOptions => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["question"] = question;
    _data["option_1"] = option1;
    _data["option_2"] = option2;
    _data["option_3"] = option3;
    _data["answer"] = answer;
    return _data;
  }

  static List<PracticeModal> ofPractice(List practicequestion) {
    return practicequestion.map((e) => PracticeModal.fromJson(e)).toList();
  }
}
