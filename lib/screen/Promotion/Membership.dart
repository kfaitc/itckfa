// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, deprecated_member_use, prefer_typing_uninitialized_variables

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MembershipList extends StatefulWidget {
//   const MembershipList({Key? key}) : super(key: key);

//   @override
//   State<MembershipList> createState() => _MembershipListState();
// }

// class _MembershipListState extends State<MembershipList> {
//   // bool automaticSystemUiAdjustment = true;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 80,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           MembershipCard(
//             img: 'assets/images/Membership/fasmec.jfif',
//             press: () async {
//               final url =
//                   'https://www.ccc-cambodia.org/en/ngodb/ngo-information/324';
//               await launch(
//                 url,
//                 forceSafariVC: false,
//                 forceWebView: false,
//               );
//               print('Can get Url');
//             },
//           ),
//           MembershipCard(
//             img: 'assets/images/Membership/land-plan-construction-ministry.jpg',
//             press: () async {
//               final url = 'https://www.mlmupc.gov.kh/';
//               await launch(
//                 url,
//                 forceSafariVC: false,
//                 forceWebView: false,
//               );
//             },
//           ),
//           MembershipCard(
//             img: 'assets/images/Membership/MEF-Logo.png',
//             press: () async {
//               final url = 'https://mef.gov.kh/';
//               await launch(
//                 url,
//                 forceSafariVC: false,
//                 forceWebView: false,
//               );
//             },
//           ),
//           MembershipCard(
//             img: 'assets/images/Membership/cambodia chamer.jfif',
//             press: () async {
//               final url = 'https://www.ccc.org.kh/kh/home';
//               await launch(
//                 url,
//                 forceSafariVC: false,
//                 forceWebView: false,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MembershipCard extends StatelessWidget {
//   final String img;
//   final press;
//   const MembershipCard({
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
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.white, width: 3),
//         ),
//         height: 110,
//         child: InkWell(
//           onTap: press,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.asset(
//               img,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
