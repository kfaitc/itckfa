// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.blue,
        elevation: 0 ,
        flexibleSpace: SafeArea(
            child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/KFA-Logo.png',
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // child: TextField(
          //   maxLines: 1,
          // ),
        )),
      ),
    );
  }
}
