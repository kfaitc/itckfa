import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnChangeCallback = void Function(dynamic value);

class HHHHHHHHHHHHHHHss extends StatefulWidget {
  HHHHHHHHHHHHHHHss({super.key, required this.kkaa});
  OnChangeCallback? kkaa;
  @override
  State<HHHHHHHHHHHHHHHss> createState() => _HHHHHHHHHHHHHHHssState();
}

class _HHHHHHHHHHHHHHHssState extends State<HHHHHHHHHHHHHHHss> {
  String? dd = 'dragon flsssyxxxx';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                widget.kkaa!(dd);
                Get.back();
              },
              child: Text('back')),
        ],
      ),
    );
  }
}
