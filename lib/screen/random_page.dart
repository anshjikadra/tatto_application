import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

import 'package:tatto_application/api/recent_model.dart';
import 'package:tatto_application/screen/applay_screen/origional_image.dart';
import 'package:tatto_application/screen/popular_page.dart';

class random_page extends StatefulWidget {
  const random_page({Key? key}) : super(key: key);

  @override
  State<random_page> createState() => _random_pageState();
}

class _random_pageState extends State<random_page> {



  final _controller = ScrollController();
  int pagenumber=1;
  bool isloadmore=false;

  List colectdata=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    random_api();


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
          random_api();
        }
      }


    });


  }

  recent_data? data_random;
  List<recent_Posts> datalist = [];

  Future random_api() async {
    final response = await http.get(Uri.parse(
        "https://necktattoo.emozzydev.xyz//api/v1/api.php?get_wallpapers&page=${pagenumber}&count=20&filter=%28g.image_extension%20%21%3D%20%27image%2Fgif%27%20AND%20g.image_extension%20%21%3D%20%27application%2Foctet-stream%27%29&order=ORDER%20BY%20RAND%28%29"));
    print("Random api=========>>>>>>${response.body}====");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      data_random = recent_data.fromJson(data);
      print("+++++++${data_random!.posts}+++++++++++");
      datalist.addAll(data_random!.posts!);
      print("+++++++${datalist}+++++++++++");

      setState(() {
        isloadmore=false;
      });
    } else {
      throw Exception('Failed.....!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data_random==null? Center(child: CircularProgressIndicator(),):GridView.builder(controller: _controller,
          itemCount: datalist.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    print("${datalist[index].imageUpload.toString()}");
                    Navigator.push(context,MaterialPageRoute(builder: (context) {
                      return origional_image(index:index,recentlist: datalist,);
                    },));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("https://necktattoo.emozzydev.xyz//upload/thumbs/${datalist[index].imageUpload.toString()}",),fit: BoxFit.cover
                      )
                    ),

                  ),
                ),
                if(isloadmore==true)Center(child: CircularProgressIndicator(),)
              ],
            );
          },
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 2,mainAxisSpacing: 2)),
    );
  }
}
