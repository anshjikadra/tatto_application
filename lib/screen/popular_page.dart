import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

import 'package:tatto_application/screen/applay_screen/origional_image.dart';

import '../api/recent_model.dart';
import '../main.dart';

class popular_page extends StatefulWidget {
  const popular_page({Key? key}) : super(key: key);

  @override
  State<popular_page> createState() => _popular_pageState();
}

class _popular_pageState extends State<popular_page> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _controller = ScrollController();
  int pagenumber = 1;
  bool isloadmore = false;

  recent_data? data_popular;
  List<recent_Posts> alldata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popular_api();

    _controller.addListener(() {
      print("lodaer");
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print("id top : $pagenumber");
        } else {
          print("id bottom : ${pagenumber + 1}");
          print('aaaaaaa');
          setState(() {
            pagenumber = pagenumber + 1;
            isloadmore = true;
          });
          // if (isloadmore == false) {
          //   print("Progress indicator");
          //   Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Center(child: CircularProgressIndicator()));
          //   setState(() {});
          // }
          popular_api();
        }
      }
    });
  }

  Future popular_api() async {
    final response = await http.get(
      Uri.parse(
          'https://necktattoo.emozzydev.xyz//api/v1/api.php?get_wallpapers&page=${pagenumber}&count=20&filter=%28g.image_extension%20%21%3D%20%27image%2Fgif%27%20AND%20g.image_extension%20%21%3D%20%27application%2Foctet-stream%27%29&order=ORDER%20BY%20g.view_count%20DESC'),
    );
    print("Popular==============${response.body}=============");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      data_popular = recent_data.fromJson(data);
      alldata.addAll(data_popular!.posts!);

      setState(() {
        isloadmore = false;
      });
    } else {
      throw Exception('Failed.......');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data_popular == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              controller: _controller,
              itemCount: alldata!.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        // print("${data_popular!.posts![index].imageUpload.toString()}");
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return origional_image(
                              index: index,
                              recentlist: alldata,
                            );
                          },
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image:DecorationImage(image: NetworkImage("https://necktattoo.emozzydev.xyz//upload/thumbs/${alldata[index].imageUpload.toString()}"),fit: BoxFit.cover
                            )

                        ),

                      ),
                    ),
                    if (isloadmore == true)
                      Center(
                        child: CircularProgressIndicator(),
                      )
                  ],
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2)),
    );
  }
}
//Image.network("https://necktattoo.emozzydev.xyz//upload/thumbs/${alldata[index].imageUpload.toString()}",fit: BoxFit.fitWidth)
//Image.network("https://necktattoo.emozzydev.xyz//upload/thumbs/${alldata[index].imageUpload.toString()}", loadingBuilder: (context, child, loadingProgress) {
//               print(loadingProgress!.cumulativeBytesLoaded);
//               return Center(
//                 child: const CircularProgressIndicator(),
//               );
//             }),
