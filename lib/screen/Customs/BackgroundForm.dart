// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
class BackgroundForm extends StatelessWidget {
  const BackgroundForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            //color: Color.fromRGBO(169, 203, 56, 1),
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //   // topLeft: Radius.circular(20),
              //   // topRight: Radius.circular(20),
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              //---Profile---//
              children: [
                //Promotion(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
