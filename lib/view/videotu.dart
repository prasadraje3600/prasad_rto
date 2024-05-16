import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maha_rto/modal/video_tutorials_modal.dart';
import 'package:http/http.dart' as http;
import 'package:maha_rto/view/videoplay.dart';

class VideoTutorials extends StatefulWidget {
  const VideoTutorials({Key? key}) : super(key: key);

  @override
  State<VideoTutorials> createState() => _VideoTutorialsState();
}

class _VideoTutorialsState extends State<VideoTutorials> {
  List<VideoModal>? videotutorial;

  void getVideoTuto() async {
    try {
      var response = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/rto/all_video_tutorials'));

      if (response.statusCode == 200) {
        setState(() {
          videotutorial = VideoModal.ofVideo(jsonDecode(response.body));
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
    getVideoTuto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 190, 208, 244),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Video Tutorials',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Explore our collection of video tutorials',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              videotutorial![index].image ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  videotutorial![index].title ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  videotutorial![index].url ?? '',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayVideo(
                                            videos: VideoModal(),
                                          )));
                            },
                            icon: Icon(Icons.play_arrow),
                            label: Text('Play'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: videotutorial?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
