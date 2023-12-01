// ignore_for_file: prefer_const_constructors, camel_case_types, unused_import, depend_on_referenced_packages, non_constant_identifier_names, unused_local_variable, deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:itckfa/screen/Home/Body.dart';
import 'package:itckfa/screen/Promotion/PartnerList.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Screen_slider extends StatefulWidget {
  const Screen_slider({super.key});

  @override
  State<Screen_slider> createState() => _Screen_sliderState();
}

class _Screen_sliderState extends State<Screen_slider> {
  int a = 0;

  final imageList = [
    'assets/images/Partners/APD-Bank-1-1.jpg',
    'assets/images/Partners/KFAGroup.png',
    'assets/images/Partners/BIC-bank.png',
    'assets/images/Partners/Caltex.png',
    'assets/images/Partners/Maritime.png',
    //////////////1
    'assets/images/Partners/PPCB-bank.jpg',
    'assets/images/Partners/Angkor-capital-bank.jfif',
    'assets/images/Partners/Cam-Commercial.png',
    'assets/images/Partners/CAMPU_BANK.jpg',
    'assets/images/Partners/campu-lonpac.jpg',
    ////////////2
    'assets/images/Partners/cash-u-up.jpg',
    'assets/images/Partners/Chevron-logo.png',
    'assets/images/Partners/chief-bank.png',
    'assets/images/Partners/Chip-Mong-Bank.jpg',
    'assets/images/Partners/cimb-bank-logo.jpg',
    'assets/images/Partners/compu.png',
    'assets/images/Partners/first-bank.jfif',
    'assets/images/Partners/FTB-bank.png',
    'assets/images/Partners/J-Trust-Royal-Bank.jpg',
    'assets/images/Partners/mia-finacial.jfif',
    'assets/images/Partners/Ow-bank.jpg',
    'assets/images/Partners/RHB-bank.jpg',
    'assets/images/Partners/sathapana.png',
    'assets/images/Partners/sbi_lh_logo.png',
    'assets/images/Partners/TBB.jfif',
    'assets/images/Partners/union-bank.png',
    'assets/images/Partners/vattanac-bank.png',
    'assets/images/Partners/Worldbridge-Homes.jpg',
    'assets/images/Partners/wooribank.png',
    'assets/images/Partners/Heng Fung Bank.png',
    'assets/images/Partners/Shinhan Bank.png',
  ];

  final url_list = [
    'https://apdbank.com.kh/home/',
    'https://kfa.com.kh/',
    'https://www.bicbank.com.kh/',
    'https://www.caltex.com/kh/en/motorists/products-and-services/caltex-with-techron.html',
    'https://maritimebank.com.kh/',
    //////////1
    'https://www.ppcbank.com.kh/',
    'https://www.eurocham-cambodia.org/',
    'https://www.scb.co.th/ccb/corporate-banking.html',
    'https://www.cpbebank.com/Home',
    'https://www.cpbebank.com/GENERAL-INSURANCE/CAMPU-LONPAC-INSURANCE/About-Us',
    /////////2
    'https://www.cashuup.com/en',
    'https://www.chevron.com/',
    'https://www.chiefbank.com.kh/',
    'https://www.chipmongbank.com/en',
    'https://www.cimbbank.com.kh/kh/personal/home.html',

    'https://www.cpbebank.com/GENERAL-INSURANCE/CAMPU-LONPAC-INSURANCE/About-Us',
    'https://www.firstbank.com.tw/sites/fcb/1565683515177',
    'https://ftbbank.com/en/',
    'https://jtrustroyal.com/en/personal/',
    'https://miaplc.com/index.php/en/home/',
    'https://www.owbank.com.kh/',
    'https://www.rhbgroup.com/index.html',
    'https://www.sathapana.com.kh',
    'https://www.sbilhbank.com.kh/en/',
    'https://tbbmfi.com.kh/',
    'https://www.bicbank.com.kh/',
    'https://www.vattanacbank.com/',
    'https://www.worldbridge.com.kh/',
    'https://www.wooribank.com.kh/',
    'http://www.hfcommercialbank.com/',
    'https://www.shinhan.com.kh/en',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: double.infinity,
        child: Column(
          children: [
            CarouselSlider.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index, realIndex) {
                  final imageList1 = imageList[index];

                  return buildImage(imageList1, index);
                },
                options: CarouselOptions(
                  height: 80,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),

                  viewportFraction: 0.25,

                  autoPlayAnimationDuration: const Duration(milliseconds: 800),

                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      a = index;
                    });
                  },
                  // reverse: true,
                )),

            // buildIndicator(),
          ],
        ));
  }

  // Widget buildImage(String imageList1, int index) => Container(
  //       margin: EdgeInsets.symmetric(horizontal: 24),
  //       color: Colors.green,
  //       child: Image.asset(
  //         imageList1,
  //         fit: BoxFit.cover,
  //       ),
  //     );
  Widget buildImage(String imageList1, int index) => PartnersCard(
        img: imageList1,
        press: () async {
          final url = url_list;
          await launch(
            url.elementAt(index),
            forceSafariVC: false,
            forceWebView: false,
          );
        },
      );
  // Widget buildIndicator() => AnimatedSmoothIndicator(
  //       activeIndex: a,
  //       count: imageList.length,
  //       textDirection: TextDirection.rtl,
  //       // effect: WormEffect(dotWidth: 20, dotHeight: 20),
  //     );
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
          borderRadius: BorderRadius.circular(13),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(213, 204, 200, 200),
                blurRadius: 2,
                offset: Offset(0, 5))
          ],
          border: Border.all(
            // color: Color.fromARGB(255, 56, 52, 247),
            color: Color.fromARGB(255, 138, 137, 137),
            width: 1,
          ),
        ),
        height: 130,
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

    // PartnersCard(
    //         img: 'assets/images/Partners/APD-Bank-1-1.jpg',
    //         press: () async {
    //           const url = 'https://apdbank.com.kh/home/';
    //           await launch(
    //             url,
    //             forceSafariVC: false,
    //             forceWebView: false,
    //           );
    //         },
    //       ),