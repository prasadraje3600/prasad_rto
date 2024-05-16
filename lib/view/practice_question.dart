import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:maha_rto/modal/practice_model.dart';

class PracticeQuestion extends StatefulWidget {
  const PracticeQuestion({Key? key}) : super(key: key);

  @override
  State<PracticeQuestion> createState() => _PracticeQuestionState();
}

class _PracticeQuestionState extends State<PracticeQuestion> {
  List<PracticeModal>? practiceQuestions;

  @override
  void initState() {
    super.initState();
    getPracticeQuestions();
  }

  void getPracticeQuestions() async {
    try {
      var response = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/rto/practice_question_list'));

      if (response.statusCode == 200) {
        setState(() {
          practiceQuestions =
              PracticeModal.ofPractice(jsonDecode(response.body));
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
          "Practice Questions",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 240, 79, 197),
        elevation: 3,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 113, 234, 236),
              Color.fromARGB(255, 239, 105, 217),
            ],
            stops: [0.3, 0.7],
          ),
        ),
        child: practiceQuestions == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: practiceQuestions!.length,
                itemBuilder: (context, index) {
                  return _buildQuestionItem(practiceQuestions![index]);
                },
              ),
      ),
    );
  }

  Widget _buildQuestionItem(PracticeModal practiceQuestion) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          practiceQuestion.question ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Option 1: ${practiceQuestion.option1 ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Option 2: ${practiceQuestion.option2 ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Option 3: ${practiceQuestion.option3 ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Answer: ${practiceQuestion.answer ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
