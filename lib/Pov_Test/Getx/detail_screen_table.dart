// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class Screen_detail extends StatefulWidget {
  Screen_detail({super.key, required this.listget});
  List? listget;

  @override
  State<Screen_detail> createState() => _Screen_detailState();
}

class _Screen_detailState extends State<Screen_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
