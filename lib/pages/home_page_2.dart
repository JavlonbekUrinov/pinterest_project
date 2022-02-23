import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest_project/pages/profile_page.dart';
import 'home_page.dart';
import 'messages_pages.dart';
import 'other_scrren.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);
  static const String id = "ControlPage";

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  PageController pageController = PageController(initialPage: 0);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),

        child: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: true,
              padEnds: false,
              children: const[
                HomePage(),
                SearchPage(),
                MessagesPage(),
                ProfilePage(),
              ],
            ),
             Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Container(
                   height: 50,
                   margin: const EdgeInsets.only(
                     left: 100,
                   ),
                   width: MediaQuery.of(context).size.width / 2,
                   decoration: BoxDecoration(
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.5),
                           spreadRadius: 10,
                           blurRadius: 10,
                           offset: const Offset(0, 5), // changes position of shadow
                         ),
                       ],
                       borderRadius: BorderRadius.circular(40),
                       color: Colors.white),
                   child: Row(
                     children: [
                       Expanded(
                         child: IconButton(
                           onPressed: () {
                             _selectedIndex = 0;
                             pageController.animateToPage(0,
                                 duration: const Duration(milliseconds: 250),
                                 curve: Curves.fastOutSlowIn);
                             setState(() {});
                           },
                           icon: Icon(Icons.home,
                               color: _selectedIndex == 0
                                   ? Colors.black
                                   : Colors.grey),
                         ),
                       ),
                       Expanded(
                         child: IconButton(
                           onPressed: () {
                             _selectedIndex = 1;
                             pageController.animateToPage(1,
                                 duration: const Duration(milliseconds: 250),
                                 curve: Curves.fastOutSlowIn);
                             setState(() {});
                           },
                           icon: Icon(
                             Icons.search,
                             color: _selectedIndex == 1
                                 ? Colors.black
                                 : Colors.grey,
                           ),
                         ),
                       ),
                       Expanded(
                         child: IconButton(
                           onPressed: () {
                             _selectedIndex = 2;
                             pageController.animateToPage(2,
                                 duration: const Duration(milliseconds: 250),
                                 curve: Curves.fastOutSlowIn);
                             setState(() {});
                           },
                           icon: Icon(Icons.message_outlined,
                               color: _selectedIndex == 2
                                   ? Colors.black
                                   : Colors.grey),
                         ),
                       ),
                       Expanded(
                         child: MaterialButton(
                           onPressed: () {
                             _selectedIndex = 3;
                             pageController.animateToPage(3,
                                 duration: const Duration(milliseconds: 250),
                                 curve: Curves.fastOutSlowIn);
                             setState(() {});
                           },
                           child: const CircleAvatar(
                             child: CircleAvatar(
                               radius: 30,
                               backgroundColor: Colors.grey,
                               child: Text("J",style: TextStyle(color: Colors.black),),
                             ),
                             radius: 12,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(
                   height: 30,
                 ),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
