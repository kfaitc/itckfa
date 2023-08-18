// // ignore_for_file: prefer_const_constructors, non_constant_identifier_names, override_on_non_overriding_member, prefer_final_fields, unnecessary_import, unused_import, avoid_print, avoid_unnecessary_containers

// import 'dart:convert';

// import 'package:flutter/services.dart';

// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'package:kfa_project/afa/screens/AutoVerbal/search/Model_List.dart';


// // import 'user_model.dart';

// class SearchUser extends SearchDelegate {
//   String? id;
//   SearchUser({Key? key, required this.id});
//   // getuserList _userList = getuserList();
//   var data = [];
//   // String? id;
//   List<AutoVerbal_List> results = [];
//   // String urlList =
//   // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list';
//   // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=22';
//   // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=$id';

//   Future<List<AutoVerbal_List>> getuserList({String? query}) async {
//     var url = Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=$id');
//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         data = json.decode(response.body);
//         results = data.map((e) => AutoVerbal_List.fromJson(e)).toList();
//         if (query != null) {
//           results = results
//               .where((element) => element.verbalId!
//                   .toLowerCase()
//                   .contains((query.toLowerCase())))
//               .toList();
//         }
//       } else {
//         print("fetc.h error");
//       }
//     } on Exception catch (e) {
//       print('error: $e');
//     }
//     return results;
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = '';
//           },
//           icon: Icon(Icons.close))
//     ];
//   }

// //   @override
// //  Widget buildResults(BuildContext context) {
// //     return [Text('sd')];
// //   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back_ios),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//       child: FutureBuilder<List<AutoVerbal_List>>(
//         future: getuserList(query: query),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data?.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final cdt = snapshot.data![index];

//                   return Container(
//                       height: MediaQuery.of(context).size.height * 0.47,
//                       margin: const EdgeInsets.all(10),
//                       padding: const EdgeInsets.all(20),
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               bottomRight: Radius.circular(25)),
//                           boxShadow: [
//                             BoxShadow(color: Colors.black, blurRadius: 5)
//                           ]),
//                       child: Column(children: [
//                         Expanded(
//                             flex: 4,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(top: 4, bottom: 4),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       // Text(id.toString()),
//                                       Text("Code :",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   15)),
//                                       Text(cdt.verbalId.toString(),
//                                           style: TextStyle(
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   15)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 4, bottom: 4),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Property Type :",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   15)),
//                                       Text(cdt.propertyTypeName.toString(),
//                                           style: TextStyle(
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   15)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 4, bottom: 4),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Address :",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   15)),
//                                       Text(cdt.verbalAddress.toString(),
//                                           style: TextStyle(
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   14)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 4, bottom: 4),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text("Bank :",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: MediaQuery.of(context)
//                                                         .textScaleFactor *
//                                                     15)),
//                                       ),
//                                       Expanded(
//                                         flex: 3,
//                                         child: Text(cdt.bankName.toString(),
//                                             style: TextStyle(
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   12,
//                                               fontWeight: FontWeight.bold,
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 4, bottom: 4),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Agency :",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   15)),
//                                       Text(cdt.agenttypeName.toString(),
//                                           style: TextStyle(
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   14)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 4, bottom: 4),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Create date :",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   15)),
//                                       Text(cdt.verbalCreatedDate.toString(),
//                                           style: TextStyle(
//                                               fontSize: MediaQuery.of(context)
//                                                       .textScaleFactor *
//                                                   14)),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ]));
//                 });
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Server is not responding"));
//           } else {
//             return Container(
//                 alignment: Alignment.center,
//                 height: MediaQuery.of(context).size.height * 1,
//                 decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   image: const DecorationImage(
//                     alignment: Alignment.center,
//                     image: ExactAssetImage('assets/images/New_KFA_Logo.png'),
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ),
//                 child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Center(
//       child: Text(
//         'Please Enter UserID',
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//       ),
//     );
//   }

//   void setState(Null Function() param0) {}
// }
// // List<AutoVerbal_List>? data = snapshot.data;
// //     return ListView.builder(
// //         itemCount: data?.length,
// //         itemBuilder: (context, index) {
// //           final cdt = snapshot.data![index];
// //           return ListTile(
// //             title: Row(
// //               children: [
// //                 Container(
// //                   width: 60,
// //                   height: 60,
// //                   decoration: BoxDecoration(
// //                     color: Colors.deepPurpleAccent,
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: Center(
// //                     child: Text(cdt.verbalId.toString()),
// //                   ),
// //                 ),
// //                 SizedBox(width: 20),
// //                 Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(cdt.verbalAddress.toString()),
// //                       SizedBox(height: 10),
// //                       Text(cdt.verbalBankOfficer.toString())
// //                     ])
// //               ],
// //             ),
// //           );
// //         });
