import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maha_rto/modal/image_modal.dart';
import 'package:http/http.dart' as http;

class ImagesQuestion extends StatefulWidget {
  const ImagesQuestion({Key? key}) : super(key: key);

  @override
  State<ImagesQuestion> createState() => _ImagesQuestionState();
}

class _ImagesQuestionState extends State<ImagesQuestion> {
  List<ImageModal>? imagesQuestions;

  void getImagesQuestion() async {
    try {
      var iQuestions = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/rto/image_question_list'));

      if (iQuestions.statusCode == 200) {
        setState(() {
          imagesQuestions = ImageModal.ofImage(jsonDecode(iQuestions.body));
        });
      } else {
        print("Something went Wrong");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getImagesQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Images Questions",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 251, 160, 227),
                  Color.fromARGB(255, 237, 167, 216)
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: imagesQuestions == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: imagesQuestions!.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return _buildItem(imagesQuestions![index], index);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(ImageModal, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 232, 147, 123)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), 
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 11,
              backgroundColor: Colors.blueAccent,
              child: Text(
                '${index + 1}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 4),
            Text(
              imagesQuestions![index].name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Image.network(
              imagesQuestions![index].image ?? '',
              height: 90,
              width: 200,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
