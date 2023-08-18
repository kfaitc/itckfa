// ignore_for_file: prefer_const_constructors, camel_case_types, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/screen/Promotion/membership_real.dart';
import 'package:url_launcher/url_launcher.dart';

class All_membership extends StatefulWidget {
  const All_membership({super.key});

  @override
  State<All_membership> createState() => _All_partnerState();
}

class _All_partnerState extends State<All_membership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        centerTitle: true,
        title: Text('Partner'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          PartnersCard(
            img: 'assets/images/Membership/fasmec.jfif',
            press: () async {
              const url =
                  'https://www.ccc-cambodia.org/en/ngodb/ngo-information/324';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Membership/land-plan-construction-ministry.jpg',
            press: () async {
              const url = 'https://www.mlmupc.gov.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Membership/MEF-Logo.png',
            press: () async {
              const url = 'https://mef.gov.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Membership/cambodia chamer.jfif',
            press: () async {
              const url = 'https://www.ccc.org.kh/kh/home';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
