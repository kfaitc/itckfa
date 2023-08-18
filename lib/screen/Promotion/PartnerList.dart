// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerList extends StatefulWidget {
  const PartnerList({Key? key}) : super(key: key);

  @override
  State<PartnerList> createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          PartnersCard(
            img: 'assets/images/Partners/APD-Bank-1-1.jpg',
            press: () async {
              const url = 'https://apdbank.com.kh/home/';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard(
            img: 'assets/images/Partners/ABA_Logo.png',
            press: () async {
              const url =
                  'https://www.ababank.com/?gclid=CjwKCAjwkaSaBhA4EiwALBgQaP0MV-5iGu_ICbjomRngEn_YxlDjWtE9gemNlMKxYbBwrZZypgdFJRoCeggQAvD_BwE';
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
          // PartnersCard(
          //   img: 'assets/images/Partners/abc.jfif',
          //   press: () async {
          //     // const url = '';
          //     // await launch(
          //     //   url,
          //     //   forceSafariVC: false,
          //     //   forceWebView: false,
          //     // );
          //   },
          // ),
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

class PartnersCard extends StatelessWidget {
  final String img;
  final press;
  const PartnersCard({
    Key? key,
    required this.img,
    // required this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        height: 110,
        child: InkWell(
          onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              img,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
