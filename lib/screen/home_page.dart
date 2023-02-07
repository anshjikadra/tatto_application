import 'package:flutter/material.dart';
import 'package:tatto_application/screen/popular_page.dart';
import 'package:tatto_application/screen/random_page.dart';
import 'package:tatto_application/screen/recent_page.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tatto Collection"),
          centerTitle: true,

          bottom: TabBar(
              tabs:[
                Tab(text: "Popular",),
                Tab(text: "Recent",),
                Tab(text: "Random",),
              ]
          ),
        ),

        body:TabBarView(children:[
          popular_page(),
          recent_page(),
         random_page(),
        ]),
      ),
    );
  }
}
