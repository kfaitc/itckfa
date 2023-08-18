// // ignore_for_file: prefer_const_constructors, camel_case_types, unused_import, depend_on_referenced_packages, non_constant_identifier_names, unused_local_variable, deprecated_member_use, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:kfa_project/screen/Home/Body.dart';
// import 'package:kfa_project/screen/Promotion/PartnerList.dart';
// // import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Property_25 extends StatefulWidget {
//   const Property_25({super.key});

//   @override
//   State<Property_25> createState() => _Screen_sliderState();
// }

// class _Screen_sliderState extends State<Property_25> {
//   int a = 0;

//   final imageList = [
//     'assets/images/25_commune/Battambang.jpg',
//     'assets/images/25_commune/Bonteaymeanchey.jpg',
//     'assets/images/25_commune/KamponChnang.jpg',
//     'assets/images/25_commune/KampongThom.jpg',

//     // ///
//     'assets/images/25_commune/kampot.jpg',
//     'assets/images/25_commune/Kandal.jpg',
//     'assets/images/25_commune/Kep.jpg',
//     'assets/images/25_commune/Kracheh.jpg',

//     ///
//     'assets/images/25_commune/Oudormeanchey.jpg',
//     'assets/images/25_commune/PhnomPenh.jpg',
//     'assets/images/25_commune/Preah_Vihea.jpg',
//     'assets/images/25_commune/PreyVeng.jpeg',

//     ///
//     'assets/images/25_commune/Rathanakiri.jpg',
//     'assets/images/25_commune/Siehanuk.jpg',
//     'assets/images/25_commune/Siemreab.jpg',
//     'assets/images/25_commune/Steng_Treng.jpg',

//     ///
//     'assets/images/25_commune/SvangRieng.jpg',
//     'assets/images/25_commune/takao.jpg',
//     'assets/images/25_commune/tbongKhmom.jpeg',
//     'assets/images/25_commune/Pursat.jpg',
//     /////////
//     'assets/images/25_commune/Pailin.jpg',
//     'assets/images/25_commune/munduolmiri.jpg',
//     'assets/images/25_commune/Kohkong.jpg'
//   ];

//   final url_list = [
//     '1',
//     '2',
//     '3',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 140,
//         width: double.infinity,
//         child: Column(
//           children: [
//             CarouselSlider.builder(
//                 itemCount: imageList.length,
//                 itemBuilder: (context, index, realIndex) {
//                   final imageList1 = imageList[index];

//                   return buildImage(imageList1, index);
//                 },
//                 options: CarouselOptions(
//                   height: 120,
//                   autoPlay: true,
//                   autoPlayInterval: Duration(seconds: 2),

//                   viewportFraction: 0.4,

//                   autoPlayAnimationDuration: const Duration(milliseconds: 800),

//                   enlargeCenterPage: true,
//                   enlargeStrategy: CenterPageEnlargeStrategy.height,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       a = index;
//                     });
//                   },
//                   // reverse: true,
//                 )),

//             // buildIndicator(),
//           ],
//         ));
//   }

//   // Widget buildImage(String imageList1, int index) => Container(
//   //       margin: EdgeInsets.symmetric(horizontal: 24),
//   //       color: Colors.green,
//   //       child: Image.asset(
//   //         imageList1,
//   //         fit: BoxFit.cover,
//   //       ),
//   //     );
//   Widget buildImage(String imageList1, int index) => PartnersCard2(
//         img: imageList1,
//         press: () async {
//           final url = url_list;
//           await launch(
//             url.elementAt(index),
//             forceSafariVC: false,
//             forceWebView: false,
//           );
//         },
//       );
//   // Widget buildIndicator() => AnimatedSmoothIndicator(
//   //       activeIndex: a,
//   //       count: imageList.length,
//   //       textDirection: TextDirection.rtl,
//   //       // effect: WormEffect(dotWidth: 20, dotHeight: 20),
//   //     );
// }

// class PartnersCard2 extends StatelessWidget {
//   final Fruitlist = [
//     'Battambang',
//     'Bonteaymeanchey',
//     'KamponChnang',
//     'KampongThom',

//     // ///
//     // 'kampot',
//     // 'Kandal',
//     // 'Kep',
//     // 'Kracheh',
//     // //
//     // 'Oudormeanchey',
//     // 'PhnomPenh',
//     // 'Preah_Vihea',
//     // 'PreyVeng',
//     // //
//     // 'Rathanakiri',
//     // 'Siehanuk',
//     // 'Siemreab',
//     // 'Steng_Treng',
//     // //
//     // 'SvangRieng',
//     // 'takao',
//     // 'tbongKhmom',
//     // 'Pursat',
//     // 'Pailin',
//     // 'munduolmiri',
//     // 'Kohkong',
//   ];
//   final String img;
//   final press;
//   PartnersCard2({
//     Key? key,
//     required this.img,
//     // required this.icon,
//     this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(13),
//           // ignore: prefer_const_literals_to_create_immutables
//           boxShadow: [
//             BoxShadow(
//                 color: Color.fromARGB(212, 248, 243, 243),
//                 blurRadius: 1,
//                 offset: Offset(0, 5))
//           ],
//           border: Border.all(
//             // color: Color.fromARGB(255, 56, 52, 247),
//             color: Color.fromARGB(255, 138, 137, 137),
//             width: 1,
//           ),
//         ),
//         // height: 130,
//         child: InkWell(
//             onTap: press,
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     img,
//                     fit: BoxFit.fitWidth,
//                     width: 100,
//                     height: 60,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 if (img == 'assets/images/25_commune/Battambang.jpg')
//                   Text(
//                     '${Fruitlist[0]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Bonteaymeanchey.jpg')
//                   Text(
//                     '${Fruitlist[1]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/KamponChnang.jpg')
//                   Text(
//                     '${Fruitlist[2]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/KampongThom.jpg')
//                   Text(
//                     '${Fruitlist[3]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
// ////////////
//                 if (img == 'assets/images/25_commune/kampot.jpg')
//                   Text(
//                     '${Fruitlist[4]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Kandal.jpg')
//                   Text(
//                     '${Fruitlist[5]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Kep.jpg')
//                   Text(
//                     '${Fruitlist[6]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Kracheh.jpg')
//                   Text(
//                     '${Fruitlist[7]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 // ////////
//                 if (img == 'assets/images/25_commune/Oudormeanchey.jpg')
//                   Text(
//                     '${Fruitlist[8]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/PhnomPenh.jpg')
//                   Text(
//                     '${Fruitlist[9]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Preah_Vihea.jpg')
//                   Text(
//                     '${Fruitlist[10]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/PreyVeng.jpeg')
//                   Text(
//                     '${Fruitlist[11]}',
//                     style: TextStyle(fontSize: 10),
//                   ),

//                 if (img == 'assets/images/25_commune/Rathanakiri.jpg')
//                   Text(
//                     '${Fruitlist[12]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Siehanuk.jpg')
//                   Text(
//                     '${Fruitlist[13]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Siemreab.jpg')
//                   Text(
//                     '${Fruitlist[14]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Steng_Treng.jpg')
//                   Text(
//                     '${Fruitlist[15]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 // ////////////////
//                 if (img == 'assets/images/25_commune/SvangRieng.jpg')
//                   Text(
//                     '${Fruitlist[16]}',
//                     style: TextStyle(fontSize: 10),
//                   ),

//                 if (img == 'assets/images/25_commune/takao.jpg')
//                   Text(
//                     '${Fruitlist[17]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/tbongKhmom.jpeg')
//                   Text(
//                     '${Fruitlist[18]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Pursat.jpg')
//                   Text(
//                     '${Fruitlist[19]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Pailin.jpg')
//                   Text(
//                     '${Fruitlist[20]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/munduolmiri.jpg')
//                   Text(
//                     '${Fruitlist[21]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Kohkong.jpg')
//                   Text(
//                     '${Fruitlist[22]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//               ],
//             )),
//       ),
//     );
//   }
// }

// class PartnersCard_khae extends StatelessWidget {
//   final Fruitlist = [
//     'Battambang',
//     'Bonteaymeanchey',
//     // 'KamponChnang',
//     // 'KampongThom',

//     // ///
//     // 'kampot',
//     // 'Kandal',
//     // 'Kep',
//     // 'Kracheh',
//     // //
//     // 'Oudormeanchey',
//     // 'PhnomPenh',
//     // 'Preah_Vihea',
//     // 'PreyVeng',
//     // //
//     // 'Rathanakiri',
//     // 'Siehanuk',
//     // 'Siemreab',
//     // 'Steng_Treng',
//     // //
//     // 'SvangRieng',
//     // 'takao',
//     // 'tbongKhmom',
//     // 'Pursat',
//     // 'Pailin',
//     // 'munduolmiri',
//     // 'Kohkong',
//   ];
//   final String img;
//   final press;
//   PartnersCard_khae({
//     Key? key,
//     required this.img,
//     // required this.icon,
//     this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(13),
//           // ignore: prefer_const_literals_to_create_immutables
//           boxShadow: [
//             BoxShadow(
//                 color: Color.fromARGB(212, 248, 243, 243),
//                 blurRadius: 1,
//                 offset: Offset(0, 5))
//           ],
//           border: Border.all(
//             // color: Color.fromARGB(255, 56, 52, 247),
//             color: Color.fromARGB(255, 138, 137, 137),
//             width: 1,
//           ),
//         ),
//         // height: 130,
//         child: InkWell(
//             onTap: press,
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     img,
//                     fit: BoxFit.fitWidth,
//                     width: 100,
//                     height: 60,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 if (img == 'assets/images/25_commune/Battambang.jpg')
//                   Text(
//                     '${Fruitlist[0]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 if (img == 'assets/images/25_commune/Bonteaymeanchey.jpg')
//                   Text(
//                     '${Fruitlist[1]}',
//                     style: TextStyle(fontSize: 10),
//                   ),
// //                 if (img == 'assets/images/25_commune/KamponChnang.jpg')
// //                   Text(
// //                     '${Fruitlist[2]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/KampongThom.jpg')
// //                   Text(
// //                     '${Fruitlist[3]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// // ////////////
// //                 if (img == 'assets/images/25_commune/kampot.jpg')
// //                   Text(
// //                     '${Fruitlist[4]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Kandal.jpg')
// //                   Text(
// //                     '${Fruitlist[5]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Kep.jpg')
// //                   Text(
// //                     '${Fruitlist[6]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Kracheh.jpg')
// //                   Text(
// //                     '${Fruitlist[7]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 // ////////
// //                 if (img == 'assets/images/25_commune/Oudormeanchey.jpg')
// //                   Text(
// //                     '${Fruitlist[8]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/PhnomPenh.jpg')
// //                   Text(
// //                     '${Fruitlist[9]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Preah_Vihea.jpg')
// //                   Text(
// //                     '${Fruitlist[10]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/PreyVeng.jpeg')
// //                   Text(
// //                     '${Fruitlist[11]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),

// //                 if (img == 'assets/images/25_commune/Rathanakiri.jpg')
// //                   Text(
// //                     '${Fruitlist[12]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Siehanuk.jpg')
// //                   Text(
// //                     '${Fruitlist[13]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Siemreab.jpg')
// //                   Text(
// //                     '${Fruitlist[14]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Steng_Treng.jpg')
// //                   Text(
// //                     '${Fruitlist[15]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 // ////////////////
// //                 if (img == 'assets/images/25_commune/SvangRieng.jpg')
// //                   Text(
// //                     '${Fruitlist[16]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),

// //                 if (img == 'assets/images/25_commune/takao.jpg')
// //                   Text(
// //                     '${Fruitlist[17]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/tbongKhmom.jpeg')
// //                   Text(
// //                     '${Fruitlist[18]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Pursat.jpg')
// //                   Text(
// //                     '${Fruitlist[19]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Pailin.jpg')
// //                   Text(
// //                     '${Fruitlist[20]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/munduolmiri.jpg')
// //                   Text(
// //                     '${Fruitlist[21]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
// //                 if (img == 'assets/images/25_commune/Kohkong.jpg')
// //                   Text(
// //                     '${Fruitlist[22]}',
// //                     style: TextStyle(fontSize: 10),
// //                   ),
//               ],
//             )),
//       ),
//     );
//   }
// }

//     // PartnersCard(
//     //         img: 'assets/images/Partners/APD-Bank-1-1.jpg',
//     //         press: () async {
//     //           const url = 'https://apdbank.com.kh/home/';
//     //           await launch(
//     //             url,
//     //             forceSafariVC: false,
//     //             forceWebView: false,
//     //           );
//     //         },
//     //       ),