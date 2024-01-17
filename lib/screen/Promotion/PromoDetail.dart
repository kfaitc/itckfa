// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:itckfa/screen/Promotion/Detail.dart';
import 'package:itckfa/screen/Promotion/Title_promo.dart';

class PromoDetail extends StatefulWidget {
  const PromoDetail({Key? key}) : super(key: key);

  @override
  State<PromoDetail> createState() => _PromoDetailState();
}

class _PromoDetailState extends State<PromoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'All Promotion',
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
        padding: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),

          //image: 'assets/images/kfa.jpg',
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  // topLeft: Radius.circular(25),
                  // topRight: Radius.circular(25),
                  ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Title_promotion(
                  title_promo: 'All Promotion',
                  title_promo1: '',
                ),
                // SizedBox(
                //   height: 5,
                // ),
                // Detail(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
