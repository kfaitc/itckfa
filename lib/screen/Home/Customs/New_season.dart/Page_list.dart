import 'package:flutter/material.dart';

class List_verbal1 extends StatefulWidget {
  const List_verbal1({super.key});

  @override
  State<List_verbal1> createState() => _List_verbalState();
}

class _List_verbalState extends State<List_verbal1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            for (int i = 0; i < 20; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.red,
                  height: 100,
                  width: 100,
                  child: Text('verbal${i}'),
                ),
              ),
          ],
        ));
  }
}
