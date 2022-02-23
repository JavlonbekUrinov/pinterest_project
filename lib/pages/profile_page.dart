import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String id = "/profile_page";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 3;
  final int _followers=0;
  final int _following=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const[
          Icon(Icons.ios_share,color: Colors.black,),
          SizedBox(width: 10,),
          Icon(Icons.more_horiz_outlined,color: Colors.black,),
          SizedBox(width: 10,),

        ],
      ),

      body: ListView(
        children: [
          const SizedBox(height: 20,),
          Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade300,
                child: const Center(
                  child: Text("J",style: TextStyle(fontSize: 25,color: Colors.black),),
                ),
              ),
              const SizedBox(height: 10,),
               Text("Javlonbek Urinov\n   Nodirbekovich",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$_followers followers"),
                  const SizedBox(width: 10,),
                  Text("$_following following",style:const TextStyle(fontSize: 15,fontWeight:FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(40)
                          ),

                          child: const TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search your Pins",
                              border: InputBorder.none
                            ),
                          ),
                        )
                    ),
                    const SizedBox(width: 10,),
                    const Icon(Icons.settings_rounded),
                    const SizedBox(width: 10,),
                    const Icon(Icons.add,size: 30),

                  ],
                ),
              )
            ],
          ),

        ],
      ),

    );
  }
}
