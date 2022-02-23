import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest_project/pages/home_page_2.dart';
import 'package:pinterest_project/pages/profile_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ControlPage(),
      routes: {
        ProfilePage.id: (context)=> ProfilePage(),
      },
    );
  }
}
