import 'package:flutter/material.dart';
import 'package:pinterest_project/models/printerest_model.dart';
import 'package:pinterest_project/services/hhtp_service.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);
  static const String id = "/message_page";
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  List<Welcome> note = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

int selectedIndx=0;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 40,
    flexibleSpace: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TabBar(
          tabs:const [
            Tab(text: "Update", height: 35,),
            Tab(text: "Messages",height: 35,),
          ],
          controller: _tabController,
          isScrollable: true,
          unselectedLabelColor: Colors.black,
          padding: const EdgeInsets.all(0),
          labelPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.shortestSide / 15,
              vertical: 0),
          labelColor: Colors.white,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // Creates border
              color: Colors.black),
        ),
      ],
    ),
  ),

      body: TabBarView(
        controller: _tabController,
        children: [
    ListView(
      children: [
        Row(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/Снимок экрана 2022-01-28 110308.png"
                    )
                  )
                ),
              ),
            ),
           const Text("data"),

          ],
        )
      ],
    ),
      Container(),
        ],

      ),

    );
  }
}
