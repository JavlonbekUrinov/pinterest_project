import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:pinterest_project/models/printerest_model.dart';
import 'package:pinterest_project/services/hhtp_service.dart';

class DetailPage extends StatefulWidget {
  late Welcome obj;

  DetailPage({Key? key, required this.obj}) : super(key: key);
  static String id = "Pinterest";

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Welcome> note = [];
  late Welcome photoget;

  String category = "For you";
  int selectedIndex = 0;
  bool isLoadMore = false;

  @override
  void initState() {
    super.initState();
    getPhotos();
    apiGet();
  }

  void _showResponse(String response) {
    List<Welcome> list = ServerPinterest.getParseList(response);
    setState(() {
      note = list;
    });
  }

  void apiGet() {
    ServerPinterest.GET(ServerPinterest.API_LIST, ServerPinterest.paramEmpty())
        .then((value) {
      _showResponse(value!);
    });
  }

  void getPhotos() {
    ServerPinterest.GET(ServerPinterest.API_LIST, ServerPinterest.paramEmpty())
        .then((value) => {
              note = List.from(ServerPinterest.parseUnsplashList(value!)),

              /// Switch off Loading lottie after Get data from Server
              isLoadMore = false,
              setState(() {}),
            });
  }

  void searchCategory(String category) {
    setState(() {
      isLoadMore = true;
    });
    ServerPinterest.GET(ServerPinterest.API_SEARCH,
            ServerPinterest.paramsSearch(category, (note.length ~/ 10) + 1))
        .then((value) => {
              note.addAll(List.from(ServerPinterest.parseSearchParse(value!))),
              setState(() {
                isLoadMore = false;
              }),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children:[
          SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Image.network(widget.obj.urls.regular)),
              Container(
                // height: 300,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 23,
                                  backgroundImage: NetworkImage(
                                      widget.obj.user.profileImage.small)),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.obj.user.name,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " ${widget.obj.likes}k followers  "
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.grey),
                            child: MaterialButton(
                                child: Text("Follow"), onPressed: () {}),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: widget.obj.altDescription.toString() != 'null'
                            ? Text(
                                widget.obj.altDescription.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 26),
                              )
                            : SizedBox.shrink()),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/images/img_9.png")),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 80,
                            child: Center(
                              child: Text(
                                "Visit",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey.shade300),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 80,
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/images/img_10.png")),
                        ),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
              ),

            ],
          ),
        ),
          Container(
            height: 1000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoadMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  searchCategory(category);
                  // start loading data
                  setState(() {});
                }
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MasonryGridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemCount: note.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  obj: note[index],
                                ),
                              ));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  height: note[index].height.toDouble() /
                                      note[index].width.toDouble() *
                                      190,
                                  color: Color.fromARGB(
                                    Random().nextInt(256),
                                    Random().nextInt(256),
                                    Random().nextInt(256),
                                    Random().nextInt(256),
                                  ),
                                ),
                                imageUrl: note[index].urls.regular,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color.fromARGB(
                                  Random().nextInt(256),
                                  Random().nextInt(256),
                                  Random().nextInt(256),
                                  Random().nextInt(256),
                                ),
                                backgroundImage:
                                NetworkImage(note[index].urls.regular),
                              ),
                              Flexible(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(note[index].user.username,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz_outlined))
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
