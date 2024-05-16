import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maha_rto/modal/text_modal.dart';
import 'package:http/http.dart' as http;

class TextQuestion extends StatefulWidget {
  const TextQuestion({Key? key}) : super(key: key);

  @override
  State<TextQuestion> createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {
  List<TextModel>? textQuestions;

  @override
  void initState() {
    super.initState();
    getTextQuestions();
  }

  Future<void> getTextQuestions() async {
    try {
      var response = await http.post(
          Uri.parse('https://mapi.trycatchtech.com/v3/rto/text_question_list'));

      if (response.statusCode == 200) {
        setState(() {
          textQuestions = TextModel.ofText(jsonDecode(response.body));
        });
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text Question',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 3,
        centerTitle: true,
      ),
      backgroundColor:
          Color.fromARGB(255, 187, 237, 242), 
      body: textQuestions == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: textQuestions!.length,
              itemBuilder: (context, index) {
                return _buildTextQuestionItem(textQuestions![index]);
              },
            ),
    );
  }

  Widget _buildTextQuestionItem(TextModel textQuestion) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          textQuestion.question ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Answer: ${textQuestion.answer ?? ""}',
          ),
        ),
      ),
    );
  }
}
