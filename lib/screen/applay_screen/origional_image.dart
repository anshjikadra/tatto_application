import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:tatto_application/api/recent_model.dart';

import '../../main.dart';

class origional_image extends StatefulWidget {
  List<recent_Posts> recentlist;
  int index;

  origional_image({required this.recentlist, required this.index});

  @override
  State<origional_image> createState() => _origional_imageState();
}

class _origional_imageState extends State<origional_image> {
// DOWNLOAD IMAGE
//   void showNotification() async {
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//         "notifications-NeckTatto",
//         "YouTube Notifications",
//         priority: Priority.max,
//         importance: Importance.max
//     );
//
//     DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     NotificationDetails notiDetails = NotificationDetails(
//         android: androidDetails,
//         iOS: iosDetails
//     );
//     notificationsPlugin.show(
//         0,
//         "${widget.recentlist[widget.index].imageUpload}",
//         "Complete Download",
//       notiDetails);
//
//
//   }
//
//   void checkForNotification() async {
//     NotificationAppLaunchDetails? details = await notificationsPlugin.getNotificationAppLaunchDetails();
//
//     if(details != null) {
//       if(details.didNotificationLaunchApp) {
//         NotificationResponse? response = details.notificationResponse;
//
//         if(response != null) {
//           String? payload = response.payload;
//           log("Notification Payload: $payload");
//         }
//       }
//     }
//   }
//
//   //APPLYE NOTIFICATION...
//
//   void wallpaper_Notification() async {
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//         "notifications-NeckTatto",
//         "YouTube Notifications",
//         priority: Priority.max,
//         importance: Importance.max
//     );
//
//     DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     NotificationDetails notiDetails = NotificationDetails(
//         android: androidDetails,
//         iOS: iosDetails
//     );
//     notificationsPlugin.show(
//         0,
//         "${widget.recentlist[widget.index].imageUpload}",
//         "wallpaper set succesfully!.",
//         notiDetails);
//
//
//   }
//
//   void w_checkForNotification() async {
//     NotificationAppLaunchDetails? details = await notificationsPlugin.getNotificationAppLaunchDetails();
//
//     if(details != null) {
//       if(details.didNotificationLaunchApp) {
//         NotificationResponse? response = details.notificationResponse;
//
//         if(response != null) {
//           String? payload = response.payload;
//           log("Notification Payload: $payload");
//         }
//       }
//     }
//   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.index);
    // checkForNotification();
    // w_checkForNotification();
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
      body: Stack(
        children: [
          Expanded(
            child: Container(
              child: PageView.builder(
                itemCount: widget.recentlist.length,
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    widget.index = value;
                    print(widget.index);
                  });
                },
                itemBuilder: (context, index) {
                  print(
                      "https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[index].imageUpload}");
                  return Container(
                    child: PhotoView(
                        imageProvider: NetworkImage(
                            "https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[index].imageUpload}")),
                  );
                },
              ),
            ),
          ),
          /*
            * Align(
              alignment: Alignment.bottomCenter,
              child: Row(
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
                      String wallpeaeper = "https://necktattoo.emozzydev.xyz//upload/${widget
                          .recentlist[widget.index].imageUpload}";

                      int location = WallpaperManager.HOME_SCREEN;
                      var file = await DefaultCacheManager().getSingleFile(
                          wallpeaeper);
                      bool result = await WallpaperManager.setWallpaperFromFile(
                          file.path, location).then((value) =>
                          wallpaper_toast());
                    },
                    text: "Apply", size: 40,
                    icon: Icon(Icons.wallpaper, color: Colors.white, size: 30,),
                  ),
                  GFButton(
                    onPressed: () async {
                      print("+++++++++${widget.index}+++++++++++");
                      String imgurl = "https://necktattoo.emozzydev.xyz//upload/${widget
                          .recentlist[widget.index].imageUpload}";
                      print("Image dowoinloading    ${imgurl}");
                      //
                      final tempDir = await getTemporaryDirectory();
                      final path = '${tempDir.path}/myfile.jpg';
                      await Dio().download(imgurl, path);

                      await GallerySaver.saveImage(
                          "https://necktattoo.emozzydev.xyz//upload/${widget
                              .recentlist[widget.index].imageUpload}").then((
                          value) => download_toast());
                    },
                    text: "Download", size: 40,
                    icon: Icon(Icons.download, color: Colors.white, size: 30,),
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
            ),
            * */
        ],
      ),
      floatingActionButton: SpeedDialFabWidget(

        secondaryIconsList: [
          Icons.download,
          Icons.wallpaper,
        ],
        secondaryIconsText: [
          "Download",
          "Apply as wallpaper",
        ],

        secondaryIconsOnPress: [
          () async {
            String imgurl =
                "https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}";
            // print("Image dowoinloading    ${imgurl}"),
            //
            final tempDir = await getTemporaryDirectory();
            final path = '${tempDir.path}/myfile.jpg';
            await Dio().download(imgurl, path);

            await GallerySaver.saveImage(
                    "https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}")
                .then((value) => download_toast());
          },
          () async {
            String wallpeaeper =
                "https://necktattoo.emozzydev.xyz//upload/${widget.recentlist[widget.index].imageUpload}";

            int location = WallpaperManager.BOTH_SCREEN;
            var file = await DefaultCacheManager().getSingleFile(wallpeaeper);
            bool result =
                await WallpaperManager.setWallpaperFromFile(file.path, location)
                    .then((value) => wallpaper_toast());
          },
        ],
        secondaryBackgroundColor: Colors.grey,
        secondaryForegroundColor: Colors.black,
        primaryBackgroundColor: Colors.blue,
        primaryForegroundColor: Colors.white,
      ),
    );
  }

  download_toast() {
    Fluttertoast.showToast(
        msg: "Download Succesfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black26,
        textColor: Colors.white,
        fontSize: 13.0);
  }

  wallpaper_toast() {
    Fluttertoast.showToast(
        msg: "Succesfully applied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black26,
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
