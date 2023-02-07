import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tatto_application/api/recent_model.dart';
import 'package:tatto_application/screen/applay_screen/origional_image.dart';

class recent_page extends StatefulWidget {
  const recent_page({Key? key}) : super(key: key);

  @override
  State<recent_page> createState() => _recent_pageState();
}

class _recent_pageState extends State<recent_page> {
  final _controller = ScrollController();
  int pagenumber = 1;
  bool isloadmore = false;

  recent_data? data_recent;
  List<recent_Posts> alldata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recent_api();

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
            CircularProgressIndicator();
          });
          recent_api();
        }
      }
    });
  }

  Future recent_api() async {
    final respose = await http.get(Uri.parse(
        "https://necktattoo.emozzydev.xyz//api/v1/api.php?get_wallpapers&page=${pagenumber}&count=20&filter=%28g.image_extension%20%21%3D%20%27image%2Fgif%27%20AND%20g.image_extension%20%21%3D%20%27application%2Foctet-stream%27%29&order=ORDER%20BY%20g.id%20DESC"));
    print("Recent image: ${respose.body}");
    if (respose.statusCode == 200) {
      Map<String, dynamic> r_data = jsonDecode(respose.body);
      data_recent = recent_data.fromJson(r_data);
      alldata.addAll(data_recent!.posts!);
      setState(() {});
    } else {
      throw Exception("Failed.....!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data_recent == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              controller: _controller,
              itemCount: alldata.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print('Hello recent');

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return origional_image(
                            index: index, recentlist: alldata);
                      },
                    ));
                  },
                  child: Container(
                    child: Image.network(
                      "https://necktattoo.emozzydev.xyz//upload/thumbs/${alldata[index].imageUpload.toString()}",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 2,mainAxisSpacing: 2),
            ),
    );
  }
}
