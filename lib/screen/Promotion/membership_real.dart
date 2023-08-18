// ignore_for_file: prefer_const_constructors, camel_case_types, unused_import, depend_on_referenced_packages, non_constant_identifier_names, unused_local_variable, deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:itckfa/screen/Home/Body.dart';
import 'package:itckfa/screen/Promotion/PartnerList.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Membership_real extends StatefulWidget {
  const Membership_real({super.key});

  @override
  State<Membership_real> createState() => _Screen_sliderState();
}

class _Screen_sliderState extends State<Membership_real> {
  int a = 0;

  final imageList = [
    'assets/images/Membership/fasmec.jfif',
    'assets/images/Membership/land-plan-construction-ministry.jpg',
    'assets/images/Membership/MEF-Logo.png',
    'assets/images/Membership/cambodia chamer.jfif',
  ];

  final url_list = [
    'https://www.ccc-cambodia.org/en/ngodb/ngo-information/324',
    'https://www.mlmupc.gov.kh/',
    'https://mef.gov.kh/',
    'https://www.ccc.org.kh/kh/home'
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