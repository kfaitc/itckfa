// ignore_for_file: prefer_const_constructors, camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:itckfa/Option/components/contants.dart';
import 'package:itckfa/screen/Promotion/membership_real.dart';
import 'package:url_launcher/url_launcher.dart';

class All_partner extends StatefulWidget {
  const All_partner({super.key});

  @override
  State<All_partner> createState() => _All_partnerState();
}

class _All_partnerState extends State<All_partner> {
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
        crossAxisCount: 3,
        children: <Widget>[
          PartnersCard(
            img: 'assets/images/Partners/APD-Bank-1-1.jpg',
            press: () async {
              const url = 'https://kfa.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/KFAGroup.png',
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
            img: 'assets/images/Partners/BIC-bank.png',
            press: () async {
              const url = 'https://www.bicbank.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Caltex.png',
            press: () async {
              const url =
                  'https://www.caltex.com/kh/en/motorists/products-and-services/caltex-with-techron.html';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Maritime.png',
            press: () async {
              const url = 'https://maritimebank.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/PPCB-bank.jpg',
            press: () async {
              const url = 'https://www.ppcbank.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Angkor-capital-bank.jfif',
            press: () async {
              const url = 'https://www.eurocham-cambodia.org/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Cam-Commercial.png',
            press: () async {
              const url = 'https://www.scb.co.th/ccb/corporate-banking.html';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/CAMPU_BANK.jpg',
            press: () async {
              const url = 'https://www.cpbebank.com/Home';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/campu-lonpac.jpg',
            press: () async {
              const url =
                  'https://www.cpbebank.com/GENERAL-INSURANCE/CAMPU-LONPAC-INSURANCE/About-Us';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/cash-u-up.jpg',
            press: () async {
              const url = 'https://www.cashuup.com/en';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Chevron-logo.png',
            press: () async {
              const url = 'https://www.chevron.com/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/chief-bank.png',
            press: () async {
              const url = 'https://www.chiefbank.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Chip-Mong-Bank.jpg',
            press: () async {
              const url = 'https://www.chipmongbank.com/en';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/cimb-bank-logo.jpg',
            press: () async {
              const url = 'https://www.cimbbank.com.kh/kh/personal/home.html';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/compu.png',
            press: () async {
              const url =
                  'https://www.cpbebank.com/GENERAL-INSURANCE/CAMPU-LONPAC-INSURANCE/About-Us';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/first-bank.jfif',
            press: () async {
              const url =
                  'https://www.firstbank.com.tw/sites/fcb/1565683515177';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/FTB-bank.png',
            press: () async {
              const url = 'https://ftbbank.com/en/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/J-Trust-Royal-Bank.jpg',
            press: () async {
              const url = 'https://jtrustroyal.com/en/personal/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/mia-finacial.jfif',
            press: () async {
              const url = 'https://miaplc.com/index.php/en/home/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Ow-bank.jpg',
            press: () async {
              const url = 'https://www.owbank.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/RHB-bank.jpg',
            press: () async {
              const url = 'https://www.rhbgroup.com/index.html';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/sathapana.png',
            press: () async {
              const url = 'https://www.sathapana.com.kh';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/sbi_lh_logo.png',
            press: () async {
              const url = 'https://www.sbilhbank.com.kh/en/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/TBB.jfif',
            press: () async {
              const url = 'https://tbbmfi.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/union-bank.png',
            press: () async {
              const url = 'https://www.bicbank.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/vattanac-bank.png',
            press: () async {
              const url = 'https://www.vattanacbank.com/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Worldbridge-Homes.jpg',
            press: () async {
              const url = 'https://www.worldbridge.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/wooribank.png',
            press: () async {
              const url = 'https://www.wooribank.com.kh/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Heng Fung Bank.png',
            press: () async {
              const url = 'http://www.hfcommercialbank.com/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/Shinhan Bank.png',
            press: () async {
              const url = 'https://www.shinhan.com.kh/en';
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
