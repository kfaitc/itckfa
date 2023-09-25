// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:itckfa/afa/components/contants.dart';
// import 'package:itckfa/screen/components/payment/get_qrcode/UPay_qr.dart';
// import 'package:itckfa/screen/components/payment/get_qrcode/Wing_qr.dart';

// class TopUp extends StatefulWidget {
//   const TopUp(
//       {super.key, this.set_email, this.set_phone, this.up_point, this.id_user});
//   final String? set_email;
//   final String? set_phone;
//   final String? up_point;
//   final String? id_user;
//   @override
//   State<TopUp> createState() => _TopUpState();
// }

// class _TopUpState extends State<TopUp> {
//   int count_time = 0;
//   List list_User_by_id = [];
//   var set_id_user;
//   Future get_control_user(String id) async {
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
//     if (rs.statusCode == 200) {
//       setState(() {
//         var jsonData = jsonDecode(rs.body);
//         list_User_by_id = jsonData;
//         set_id_user = list_User_by_id[0]['control_user'].toString();
//       });
//     }
//   }

//   int v_point = 0;
//   void get_count() async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_count?id_user_control=${set_id_user}'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         v_point = jsonData;
//         print(v_point);
//       });
//     }
//   }

//   Future<void> check() async {
//     await get_control_user(widget.id_user.toString());
//     get_count();
//   }

//   @override
//   void initState() {
//     super.initState();
//     check();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kwhite_new,
//         title: const Text(
//           "V-Point",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 15,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.chevron_left,
//             size: 35,
//             color: Colors.white,
//           ),
//         ),
//         elevation: 0.0,
//         actions: [
//           GFIconButton(
//             padding: const EdgeInsets.all(1),
//             onPressed: () {},
//             icon: const Icon(
//               Icons.question_mark,
//               color: Colors.white,
//               size: 20,
//             ),
//             color: Colors.white,
//             type: GFButtonType.outline2x,
//             size: 10,
//             iconSize: 30.0,
//             disabledColor: Colors.white,
//             shape: GFIconButtonShape.circle,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.178,
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     tileMode: TileMode.mirror,
//                     colors: [kwhite_new, kwhite_new, Colors.blue],
//                   ),
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10))),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(left: 15),
//                           height: 30,
//                           width: 30,
//                           child: Image.asset("assets/images/v.png"),
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           ' $v_point',
//                           style: TextStyle(
//                             fontSize: 30,
//                             color: Colors.amber[800],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             const Icon(
//                               Icons.account_circle_outlined,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               widget.set_email!,
//                               style: const TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.white,
//                               ),
//                             )
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 15),
//                           child: GFButton(
//                             onPressed: () {},
//                             text: "Transaction history",
//                             textColor: Colors.white,
//                             textStyle: const TextStyle(
//                                 fontSize: 10, color: Colors.white),
//                             type: GFButtonType.outline,
//                             shape: GFButtonShape.pills,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 1,
//               child: Stack(
//                 alignment: Alignment.bottomRight,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 20),
//                     height: MediaQuery.of(context).size.height * 0.35,
//                     width: MediaQuery.of(context).size.width * 1,
//                     decoration: BoxDecoration(
//                       color: kImageColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Container(
//                       margin: const EdgeInsets.all(5),
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 2,
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const [
//                               Text(
//                                 "Tariff Plans for ",
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                               Text(
//                                 "ONE DAY",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue,
//                                     fontSize: 17,
//                                     decorationStyle: TextDecorationStyle.dashed,
//                                     decoration: TextDecoration.underline),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   BottomSheet(context, '1.00',
//                                       widget.set_email!, '1  V / Day');
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.all(6),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   width:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(80),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 7,
//                                           offset: Offset(1.0, 7.0))
//                                     ],
//                                     border: Border.all(
//                                         width: 1,
//                                         color: const Color.fromRGBO(
//                                             255, 111, 0, 1)),
//                                   ),
//                                   alignment: Alignment.topCenter,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                               width: 15,
//                                               height: 15,
//                                               child: Image.asset(
//                                                   "assets/images/v.png")),
//                                           Text(
//                                             "1",
//                                             style: TextStyle(
//                                               fontSize: 17,
//                                               color: Colors.amber[800],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       const Text(
//                                         "\$1.0",
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             color: Color.fromARGB(
//                                                 255, 242, 11, 134),
//                                             decorationStyle:
//                                                 TextDecorationStyle.solid,
//                                             decoration:
//                                                 TextDecoration.underline),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   BottomSheet(context, '2.50',
//                                       widget.set_email!, '3  V / Day');
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.all(6),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   width:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(80),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 7,
//                                           offset: Offset(1.0, 7.0))
//                                     ],
//                                     border: Border.all(
//                                         width: 1,
//                                         color: const Color.fromRGBO(
//                                             255, 111, 0, 1)),
//                                   ),
//                                   alignment: Alignment.topCenter,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                               width: 15,
//                                               height: 15,
//                                               child: Image.asset(
//                                                   "assets/images/v.png")),
//                                           Text(
//                                             "3",
//                                             style: TextStyle(
//                                               fontSize: 17,
//                                               color: Colors.amber[800],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       const Text(
//                                         "\$2.5",
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             color: Color.fromARGB(
//                                                 255, 242, 11, 134),
//                                             decorationStyle:
//                                                 TextDecorationStyle.solid,
//                                             decoration:
//                                                 TextDecoration.underline),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   BottomSheet(context, '3.00',
//                                       widget.set_email!, '5  V / Day');
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.all(6),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   width:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(80),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 7,
//                                           offset: Offset(1.0, 7.0))
//                                     ],
//                                     border: Border.all(
//                                         width: 1,
//                                         color: const Color.fromRGBO(
//                                             255, 111, 0, 1)),
//                                   ),
//                                   alignment: Alignment.topCenter,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                               width: 15,
//                                               height: 15,
//                                               child: Image.asset(
//                                                   "assets/images/v.png")),
//                                           Text(
//                                             "5",
//                                             style: TextStyle(
//                                               fontSize: 17,
//                                               color: Colors.amber[800],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       const Text(
//                                         "\$3.0",
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             color: Color.fromARGB(
//                                                 255, 242, 11, 134),
//                                             decorationStyle:
//                                                 TextDecorationStyle.solid,
//                                             decoration:
//                                                 TextDecoration.underline),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   BottomSheet(context, '5.00',
//                                       widget.set_email!, '6  V / Day');
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.all(6),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   width:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(80),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 7,
//                                           offset: Offset(1.0, 7.0))
//                                     ],
//                                     border: Border.all(
//                                         width: 1,
//                                         color: const Color.fromRGBO(
//                                             255, 111, 0, 1)),
//                                   ),
//                                   alignment: Alignment.topCenter,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                               width: 15,
//                                               height: 15,
//                                               child: Image.asset(
//                                                   "assets/images/v.png")),
//                                           Text(
//                                             "6",
//                                             style: TextStyle(
//                                               fontSize: 17,
//                                               color: Colors.amber[800],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       const Text(
//                                         "\$5.0",
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             color: Color.fromARGB(
//                                                 255, 242, 11, 134),
//                                             decorationStyle:
//                                                 TextDecorationStyle.solid,
//                                             decoration:
//                                                 TextDecoration.underline),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   BottomSheet(context, '6.50',
//                                       widget.set_email!, '8  V / Day');
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.all(6),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   width:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(80),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 7,
//                                           offset: Offset(1.0, 7.0))
//                                     ],
//                                     border: Border.all(
//                                         width: 1,
//                                         color: const Color.fromRGBO(
//                                             255, 111, 0, 1)),
//                                   ),
//                                   alignment: Alignment.topCenter,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                               width: 15,
//                                               height: 15,
//                                               child: Image.asset(
//                                                   "assets/images/v.png")),
//                                           Text(
//                                             "8",
//                                             style: TextStyle(
//                                               fontSize: 17,
//                                               color: Colors.amber[800],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       const Text(
//                                         "\$6.5",
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             color: Color.fromARGB(
//                                                 255, 242, 11, 134),
//                                             decorationStyle:
//                                                 TextDecorationStyle.solid,
//                                             decoration:
//                                                 TextDecoration.underline),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   BottomSheet(context, '8.00',
//                                       widget.set_email!, '10  V / Day');
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.all(6),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   width:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(80),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 7,
//                                           offset: Offset(1.0, 7.0))
//                                     ],
//                                     border: Border.all(
//                                         width: 1,
//                                         color: const Color.fromRGBO(
//                                             255, 111, 0, 1)),
//                                   ),
//                                   alignment: Alignment.topCenter,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                               width: 15,
//                                               height: 15,
//                                               child: Image.asset(
//                                                   "assets/images/v.png")),
//                                           Text(
//                                             "10",
//                                             style: TextStyle(
//                                               fontSize: 17,
//                                               color: Colors.amber[800],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       const Text(
//                                         "\$8.0",
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             color: Color.fromARGB(
//                                                 255, 242, 11, 134),
//                                             decorationStyle:
//                                                 TextDecorationStyle.solid,
//                                             decoration:
//                                                 TextDecoration.underline),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       right: 15,
//                       bottom: -1,
//                       child: Image.asset(
//                         "assets/images/pay.png",
//                         width: 125,
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 1,
//               child: Stack(
//                 alignment: Alignment.bottomRight,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 20),
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     width: MediaQuery.of(context).size.width * 1,
//                     decoration: BoxDecoration(
//                       color: kImageColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Container(
//                       margin: const EdgeInsets.all(5),
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 2,
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               const SizedBox(width: 10),
//                               const Text(
//                                 "Tariff Plans for",
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                               SizedBox(
//                                 height: 25,
//                                 width: 90,
//                                 child: DefaultTextStyle(
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.blue,
//                                       fontSize: 17,
//                                       decorationStyle:
//                                           TextDecorationStyle.dashed,
//                                       decoration: TextDecoration.underline),
//                                   child: AnimatedTextKit(
//                                     animatedTexts: [
//                                       RotateAnimatedText('WEEK '),
//                                       RotateAnimatedText('MOUNT'),
//                                     ],
//                                     pause: const Duration(milliseconds: 500),
//                                     repeatForever: true,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                             ],
//                           ),
//                           InkWell(
//                             onTap: () {
//                               BottomSheet(context, '10.00', widget.set_email!,
//                                   '5  V / Week');
//                             },
//                             child: Card(
//                               color: Colors.white,
//                               elevation: 5,
//                               child: ListTile(
//                                 minVerticalPadding: 5,
//                                 title: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: const [
//                                     Text(
//                                       "Use ",
//                                       style: TextStyle(
//                                           fontSize: 13, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "5 VERBAL CKECK",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.blue,
//                                           fontSize: 13,
//                                           decorationStyle:
//                                               TextDecorationStyle.dotted,
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                     Text(
//                                       " for ",
//                                       style: TextStyle(
//                                           fontSize: 13, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "1 week",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red,
//                                           fontSize: 13,
//                                           decorationStyle:
//                                               TextDecorationStyle.dashed,
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                   ],
//                                 ),
//                                 subtitle: const Text("10 \$"),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               BottomSheet(context, '30.00', widget.set_email!,
//                                   '30  V / Week');
//                             },
//                             child: Card(
//                               color: Colors.white,
//                               elevation: 5,
//                               child: ListTile(
//                                 minVerticalPadding: 5,
//                                 title: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: const [
//                                     Text(
//                                       "Use ",
//                                       style: TextStyle(
//                                           fontSize: 13, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "40 VERBAL CKECK",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.blue,
//                                           fontSize: 13,
//                                           decorationStyle:
//                                               TextDecorationStyle.dotted,
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                     Text(
//                                       " for ",
//                                       style: TextStyle(
//                                           fontSize: 13, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "1 month",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red,
//                                           fontSize: 13,
//                                           decorationStyle:
//                                               TextDecorationStyle.dashed,
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                   ],
//                                 ),
//                                 subtitle: const Text("30 \$"),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       right: 15,
//                       child: Image.asset(
//                         "assets/images/pay.png",
//                         width: 125,
//                       ))
//                 ],
//               ),
//             ),
//             Image.asset("assets/images/mobile_payment.png")
//           ],
//         ),
//       ),
//     );
//   }

//   // ignore: non_constant_identifier_names
//   Future BottomSheet(
//       BuildContext context, String price, String account, String option) {
//     return showModalBottomSheet(
//       context: context,
//       backgroundColor: Color.fromARGB(0, 33, 149, 243),
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.2,
//           padding: const EdgeInsets.all(10),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Choose bank for payment',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black),
//               ),
//               const Divider(
//                 height: 5,
//                 color: Colors.black,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(10),
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               blurRadius: 5,
//                               offset: Offset(3, -3),
//                               color: kwhite_new)
//                         ]),
//                     child: InkWell(
//                       onTap: () {
//                         _dialogBuilder(
//                             context, price, widget.set_email!, option, 0);
//                       },
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 65,
//                             width: 65,
//                             child: Image.asset(
//                               'assets/images/UPAY-logo.png',
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           const Text(
//                             'U-PAY',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(10),
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               blurRadius: 5,
//                               offset: Offset(3, -3),
//                               color: kwhite_new)
//                         ]),
//                     child: InkWell(
//                       onTap: () {
//                         _dialogBuilder(
//                             context, price, widget.set_email!, option, 1);
//                       },
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 65,
//                             width: 65,
//                             child: Image.asset(
//                               'assets/images/wing.png',
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           const Text(
//                             'Wing',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(10),
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               blurRadius: 5,
//                               offset: Offset(3, -3),
//                               color: kwhite_new)
//                         ]),
//                     child: InkWell(
//                       onTap: () {
//                         _dialogBuilder(
//                             context, price, widget.set_email!, option, 2);
//                       },
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 65,
//                             width: 65,
//                             child: Image.asset(
//                               'assets/images/Partners/ABA_Logo.png',
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           const Text(
//                             'ABA',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(10),
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               blurRadius: 5,
//                               offset: Offset(3, -3),
//                               color: kwhite_new)
//                         ]),
//                     child: InkWell(
//                       onTap: () async {
//                         await Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => Qr_Wing(
//                                     price: price,
//                                     accont: account,
//                                     phone: widget.set_phone!,
//                                     option: option,
//                                     id: widget.id_user ?? 'set',
//                                     control_user: set_id_user,
//                                   )),
//                         );
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pop();
//                       },
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 65,
//                             width: 65,
//                             child: Image.asset(
//                               'assets/images/bakong.png',
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           const Text(
//                             'Bakong',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _dialogBuilder(BuildContext context, String price,
//       String account, String option, int index) {
//     List<Image> set_images = [
//       Image.asset(
//         'assets/images/UPAY-logo.png',
//         fit: BoxFit.scaleDown,
//       ),
//       Image.asset(
//         'assets/images/wing.png',
//         fit: BoxFit.scaleDown,
//       ),
//       Image.asset(
//         'assets/images/Partners/ABA_Logo.png',
//         fit: BoxFit.scaleDown,
//       ),
//     ];
//     List<Text> set_title = [
//       const Text(
//         'U-Pay Pay',
//         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//       ),
//       const Text(
//         'Wing Pay',
//         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//       ),
//       const Text(
//         'PayWay',
//         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//       ),
//     ];
//     List<String> set_Subtitle = [
//       'U-Pay',
//       'Wing',
//       'ABA',
//     ];
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('PLease choose option'),
//           titleTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
//           content: Container(
//             height: MediaQuery.of(context).size.height * 0.25,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     setState(() {
                      
//                     });
//                   },
//                   child: Card(
//                     elevation: 10,
//                     child: Row(
//                       children: [
//                         Card(
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 50,
//                                 width: 60,
//                                 child: set_images.elementAt(index),
//                               ),
//                               set_title.elementAt(index),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           "Tap to pay with ${set_Subtitle.elementAt(index)} App",
//                           style: TextStyle(
//                               overflow: TextOverflow.visible,
//                               color: Color.fromRGBO(158, 158, 158, 1),
//                               fontWeight: FontWeight.w500,
//                               fontSize:
//                                   MediaQuery.textScaleFactorOf(context) * 10),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     await Navigator.of(context).push(
//                       MaterialPageRoute(
//                           builder: (context) => Qr_UPay(
//                                 price: price,
//                                 accont: account,
//                                 phone: widget.set_phone!,
//                                 option: option,
//                                 id: widget.id_user ?? 'set',
//                                 control_user: set_id_user,
//                               )),
//                     );
//                     Navigator.of(context).pop();
//                     Navigator.of(context).pop();
//                   },
//                   child: Card(
//                     elevation: 10,
//                     child: Row(
//                       children: [
//                         Card(
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 50,
//                                 width: 60,
//                                 child: Image.asset(
//                                   'assets/images/KHQR.jpg',
//                                   fit: BoxFit.scaleDown,
//                                 ),
//                               ),
//                               const Text(
//                                 'KHQR',
//                                 style: TextStyle(
//                                     fontSize: 12, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           "Tap to pay with KHQR",
//                           style: TextStyle(
//                               overflow: TextOverflow.visible,
//                               color: Color.fromRGBO(158, 158, 158, 1),
//                               fontWeight: FontWeight.w500,
//                               fontSize:
//                                   MediaQuery.textScaleFactorOf(context) * 10),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
