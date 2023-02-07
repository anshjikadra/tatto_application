import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tatto_application/api/recent_model.dart';

class origional_image extends StatefulWidget {
  List<recent_Posts> recentlist;
  int index;

  origional_image({required this.recentlist, required this.index});

  @override
  State<origional_image> createState() => _origional_imageState();
}

class _origional_imageState extends State<origional_image> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.index);

  }


  // String dr_path = "";
  // bool downloading = false;

  // folder() async {
  //   var path = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS) +
  //       "/Tattoimg";
  //   Directory dr = Directory(path);
  //   print("${dr_path}");
  //
  //   if (await dr.exists()) {
  //     print("Already create");
  //   } else {
  //     //jo file create ny hoy to thashe
  //     dr.create();
  //   }
  //   dr_path = dr.path;
  // }

  //Downloading.......








  PageController controller = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Your Tattos"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 700,
            // color: Colors.red,
            child: PageView.builder(
              itemCount: widget.recentlist.length,
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  widget.index=value;
                  print(widget.index);
                });
              },
              itemBuilder: (context, index) {
                print("https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[index].imageUpload}");
                return Container(
                  child: PhotoView(
                      imageProvider: NetworkImage(
                          "https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[index].imageUpload}")),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
           // TextButton(onPressed: () async{
           //
           //   String wallpeaeper="https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}";
           //
           //   int location = WallpaperManager.BOTH_SCREEN;
           //   var file=await DefaultCacheManager().getSingleFile(wallpeaeper);
           //   bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
           //
           //
           // }, child: Text("Apply",style: TextStyle(color: Colors.white,fontSize: 20),)),

              GFButton(
                onPressed: () async {
                  String wallpeaeper="https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}";

                  int location = WallpaperManager.HOME_SCREEN;
                  var file=await DefaultCacheManager().getSingleFile(wallpeaeper);
                  bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);

                },
                text: "Apply",
                icon: Icon(Icons.wallpaper),
              ),
              GFButton(
                onPressed: () async {
                  print("+++++++++${widget.index}+++++++++++");
                  String imgurl="https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}";
                  print("Image dowoinloading    ${imgurl}");
                  //
                  final tempDir = await getTemporaryDirectory();
                  final path = '${tempDir.path}/myfile.jpg' ;
                  await Dio().download(imgurl,path);

                  await GallerySaver.saveImage("https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}");


                },
                text: "Download",
                icon: Icon(Icons.download),
              ),

              //
              // TextButton(onPressed: () async {
              //   print("+++++++++${widget.index}+++++++++++");
              //   String imgurl="https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}";
              //   print("Image dowoinloading    ${imgurl}");
              //   //
              //   final tempDir = await getTemporaryDirectory();
              //   final path = '${tempDir.path}/myfile.jpg' ;
              //   await Dio().download(imgurl,path);
              //
              //   await GallerySaver.saveImage("https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}");
              //
              //
              // }, child:Text("Download",style: TextStyle(color: Colors.white,fontSize: 20),)),
            ],
          ),
        ],
      ),
    );
  }
}


