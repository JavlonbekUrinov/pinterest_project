import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pinterest_project/models/printerest_model.dart';
import 'package:pinterest_project/services/hhtp_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
            child: Container(
              height: 45,
              width: 85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.black),
              child: const Center(child: Text("For you")),
            ),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
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
                                backgroundImage: NetworkImage(
                                note[index].urls.regular
                            ),
                          ),
                          Flexible(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(note[index].user.username,
                                    overflow: TextOverflow.ellipsis)),
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30),
                                    )),
                                    context: context,
                                    builder: (context) {
                                      return bottomFunct(context);
                                    });
                              },
                              icon: const Icon(Icons.more_horiz_outlined))
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ));
  }

  Widget bottomFunct(BuildContext context) {
    return Container(
      height: 400,
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Share to",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 17, left: 5),
                  child: MaterialButton(
                    onPressed: () => launch("https://www.pinterest.com/"),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 17,
                  ),
                  child: MaterialButton(
                    onPressed: () => launch("https://t.me/by_javlon"),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/img_2.png"),
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: MaterialButton(
                    onPressed: () => launch("https://www.pinterest.com/"),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/img_5.png"),
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: MaterialButton(
                    onPressed: () => launch("https://www.pinterest.com/"),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/img_6.png",
                      ),
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: MaterialButton(
                    onPressed: () => launch("https://www.pinterest.com/"),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.email_outlined,
                          color: Colors.black, size: 27),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: MaterialButton(
                    onPressed: () => launch("https://www.pinterest.com/"),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/img_8.png"),
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: MaterialButton(
                    onPressed: () => launch("https://www.pinterest.com/"),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/img_1.png"),
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: MaterialButton(
                    onPressed: () => launch("https://www.pinterest.com/"),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade400,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "This Pin was inspired by your recent activity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Hide",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Report",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Container(
              child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close")),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(30)),
            ),
          )
        ],
      ),
    );
  }
}
