import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maha_rto/modal/exam_modal.dart';
import 'package:http/http.dart' as http;

class ExamQuestion extends StatefulWidget {
  const ExamQuestion({Key? key}) : super(key: key);

  @override
  State<ExamQuestion> createState() => _ExamQuestionState();
}

class _ExamQuestionState extends State<ExamQuestion> {
  List<ExamModal>? examQuestions;

  @override
  void initState() {
    super.initState();
    getExamQuestions();
  }

  void getExamQuestions() async {
    try {
      var response = await http.post(
          Uri.parse('https://mapi.trycatchtech.com/v3/rto/exam_question_list'));

      if (response.statusCode == 200) {
        setState(() {
          examQuestions = ExamModal.ofExam(jsonDecode(response.body));
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
          "Exam Question",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF2196F3),
        elevation: 3,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBBDEFB),
              Color.fromARGB(255, 241, 142, 235),
            ],
            stops: [0.3, 0.7],
          ),
        ),
        child: examQuestions == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: examQuestions!.length,
                itemBuilder: (context, index) {
                  return _buildQuestionItem(examQuestions![index], index);
                },
              ),
      ),
    );
  }

  Widget _buildQuestionItem(ExamModal examQuestion, int index) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: Text(
            '${index + 1}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          examQuestion.question ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Option 1: ${examQuestion.option1 ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Option 2: ${examQuestion.option2 ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Option 3: ${examQuestion.option3 ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Answer: ${examQuestion.answer ?? ""}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
