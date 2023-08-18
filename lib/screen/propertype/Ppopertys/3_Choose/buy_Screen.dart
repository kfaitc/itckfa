// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Buy_Screen extends StatefulWidget {
  const Buy_Screen({super.key});

  @override
  State<Buy_Screen> createState() => _Buy_ScreenState();
}

class _Buy_ScreenState extends State<Buy_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 20, 163),
        centerTitle: true,
        title: Text(
          'Buy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
