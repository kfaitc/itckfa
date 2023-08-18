// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'Home_Screen_property.dart';

class MenuProperty extends StatefulWidget {
  MenuProperty({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MenuProperty> createState() => _MenuPropertyState();
}

class _MenuPropertyState extends State<MenuProperty> {
  List<Text> option = const [
    Text("New Property",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Property List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.add_circle),
    Icon(Icons.list_alt_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: const Text(
          "Property",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assets/images/New_KFA_Logo.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < option.length; i++)
              InkWell(
                onTap: () {
                   if (i == 0) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home_Screen_property(
                            //id: widget.id,
                          )));
                }
                if (i == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home_Screen_property(
                            //id: widget.id,
                          )));
                }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.indigo,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 2,
                            color: Colors.black,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: optionIconList.elementAt(i),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: option.elementAt(i),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
