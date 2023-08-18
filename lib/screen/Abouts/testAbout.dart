// ignore_for_file: file_names, library_private_types_in_public_api, unnecessary_new, prefer_const_constructors, sort_child_properties_last, avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  List<String> navBarItem = [
    "Top News",
    "India",
    "World",
    "Finacnce",
    "Health"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ARNE NEWS"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            //Search Wala Container

            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if ((searchController.text).replaceAll(" ", "") == "") {
                      print("Blank search");
                    } else {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                    }
                  },
                  child: Container(
                    child: Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Search Health"),
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: navBarItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(navBarItem[index]);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(navBarItem[index],
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  })),
          CarouselSlider(
            options: CarouselOptions(
                height: 200, autoPlay: true, enlargeCenterPage: true),
            items: items.map((item) {
              return Builder(builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    print("MUJHE MARRO MAT");
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 14),
                    child: Image.asset(item),
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }

  List items = [
    "assets/images/kfa.jpg",
    'assets/images/Awards2020--.jpg',
    'assets/images/Awards2020.jpg',
    'assets/images/kfa1.png',
    'assets/images/slide15.jpg',
    'assets/images/forweb4.jpg',
    'assets/images/Real Estate Award 2019.jpg',
  ];
}
