// ignore_for_file: prefer_const_constructors, unused_import, camel_case_types, unused_label

import 'package:flutter/material.dart';
import 'package:itckfa/afa/screens/AutoVerbal/Add.dart';
import 'package:itckfa/afa/screens/AutoVerbal/List.dart';

import 'Page_list.dart';

class Screen_add extends StatefulWidget {
  final String? id;
  const Screen_add({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<Screen_add> createState() => _Screen_addState();
}

class _Screen_addState extends State<Screen_add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 33, 202),
        centerTitle: true,
        title: Text('Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 8, 17, 99),
                  borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  // 'assets/images/KFA-Logo.png',
                  'assets/images/KFA-Logo.png',
                  height: 80,
                  width: 100,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  onTap:
                  () {
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return Add(id: '22');
                    //   },
                    // ));
                  };
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 105, 60, 9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Add verbal',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return List_verbal1();
                    },
                  ));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 114, 7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'List verbal',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
