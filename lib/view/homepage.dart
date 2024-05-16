import 'package:flutter/material.dart';
import 'package:maha_rto/modal/home_modal.dart';
import 'package:maha_rto/view/exam_question.dart';
import 'package:maha_rto/view/image_question.dart';
import 'package:maha_rto/view/loginpage.dart';
import 'package:maha_rto/view/practice_question.dart';
import 'package:maha_rto/view/text_question.dart';
import 'package:maha_rto/view/videotu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  // List<HomeModal> homeIcons = [
  //   HomeModal(
  //       image: "images/examquestion.webp",
  //       title: "Exam Question",
  //       onTap: () {
  //          Navigator.push(
  //               BuildContext, MaterialPageRoute(builder: (context) => ExamQuestion()));
  //       }),
  //   HomeModal(
  //       image: "images/imagesq.jpeg", title: "Images Question", onTap: () {}),
  //   HomeModal(
  //       image: "images/practiceq.png",
  //       title: "Practice Question",
  //       onTap: () {}),
  //   HomeModal(
  //       image: "images/textquestion.jpeg",
  //       title: "Text Question",
  //       onTap: () {}),
  //   HomeModal(
  //       image: "images/videotutorials.jpeg",
  //       title: "Video Tutorials",
  //       onTap: () {})
  // ];

  // List<Color> cardColors = [
  //   Colors.blue.shade200,
  //   Colors.red.shade200,
  //   Colors.green.shade200,
  //   Colors.orange.shade200,
  //   Colors.purple.shade200,
  // ];

  @override
  Widget build(BuildContext context) {
    List<HomeModal> homeIcons = [
      HomeModal(
          image: "images/examquestion.webp",
          title: "Exam Question",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExamQuestion()));
          }),
      HomeModal(
          image: "images/imagesq.jpeg",
          title: "Images Question",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ImagesQuestion()));
          }),
      HomeModal(
          image: "images/practiceq.png",
          title: "Practice Question",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PracticeQuestion()));
          }),
      HomeModal(
          image: "images/textquestion.jpeg",
          title: "Text Question",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TextQuestion()));
          }),
      HomeModal(
          image: "images/videotutorials.jpeg",
          title: "Video Tutorials",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VideoTutorials()));
          })
    ];

    List<Color> cardColors = [
      Colors.blue.shade200,
      Colors.red.shade200,
      Colors.green.shade200,
      Colors.orange.shade200,
      Colors.purple.shade200,
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              SharedPreferences clear = await SharedPreferences.getInstance();

              clear.clear();
              setState(() {});

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: Icon(Icons.logout)),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 244, 180, 180)),
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.blueGrey.shade100,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.8,
            ),
            itemCount: homeIcons.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  homeIcons[index].onTap();
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: cardColors[index % cardColors.length],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        homeIcons[index].image,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        homeIcons[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
