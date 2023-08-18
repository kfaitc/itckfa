import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itckfa/Pov_Test/test_dro.dart';

class nananan extends StatefulWidget {
  const nananan({super.key});

  @override
  State<nananan> createState() => _nanananState();
}

class _nanananState extends State<nananan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
            onPressed: () {
              Get.to(MyDropdown111());
            },
            child: Text('GO')),
      ),
    );
  }
}
