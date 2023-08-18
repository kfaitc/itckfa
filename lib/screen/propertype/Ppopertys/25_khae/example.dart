// // ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_new, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_import, unnecessary_string_interpolations, avoid_print, avoid_unnecessary_containers

// import 'dart:convert';
// import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:kfa_project/screen/components/map_all/map_in_list_search.dart';

// import '../3_Choose/List_Property/List_Rent.dart';
// import '../3_Choose/List_Property/List_Sale.dart';
// import '../Detail_Screen/Detail_Property._sale.dart';
// import '../Detail_Screen/Detail_property_rent.dart';
// import '../Screen_Page/For_Rent.dart';
// import '../Screen_Page/For_Sale.dart';
// import '../Screen_Page/Home_type.dart';
// import '../Model/Sale_model.dart';
// import '../More.dart';

// import 'package:http/http.dart' as http;

// import '../Screen_Page/Price.dart';

// class Home_Screen_propert2222222y extends StatefulWidget {
//   const Home_Screen_propert2222222y({super.key});

//   @override
//   State<Home_Screen_propert2222222y> createState() =>
//       _Home_Screen_propertyState();
// }

// class _Home_Screen_propertyState extends State<Home_Screen_propert2222222y> {
//   @override
//   void initState() {
//     Property_Sale_image();
//     Property_Sale();
//     Property_Sale_image_1();
//     Urgent();
//     Property_Rent_id(property_type_id);
//     super.initState();
//   }

//   String? property_type_id = '1';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 20, 20, 163),
//         centerTitle: true,
//         title: Text('Property'),
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Find Your New House',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
//             child: Row(
//               children: [
//                 Container(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   child: Padding(
//                     padding: const EdgeInsets.all(1.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(),
//                         hintText: 'Search listing here...',
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Get.to(Map_List_search(
//                       get_province: (value) {},
//                       get_district: (value) {},
//                       get_commune: (value) {},
//                       get_log: (value) {},
//                       get_lat: (value) {},
//                       get_min1: (value) {},
//                       get_max1: (value) {},
//                       get_min2: (value) {},
//                       get_max2: (value) {},
//                     ));
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => SearchProperty()),
//                     // );
//                   },
//                   child: Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width * 0.3,
//                     decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 20, 20, 163),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.search,
//                             color: Colors.white,
//                           ),
//                           Text(
//                             'Search',
//                             style: TextStyle(color: Colors.white),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 30,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Color.fromARGB(255, 54, 54, 246),
//                         border: Border.all(
//                             width: 2,
//                             color: Color.fromARGB(255, 139, 128, 128))),
//                     child: Text(
//                       'Buy',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return List_Rent(
//                           property_type_id: property_type_id,
//                           id_image: list2_Sale1[0]['id_image'].toString(),
//                         );
//                       },
//                     ));
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 30,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Color.fromARGB(255, 54, 54, 246),
//                         border: Border.all(
//                             width: 2,
//                             color: Color.fromARGB(255, 139, 128, 128))),
//                     child: Text(
//                       'Rent',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return List_Sale(
//                           property_type_id: property_type_id,
//                           id_image: list2_Sale1[0]['id_image'].toString(),
//                         );
//                       },
//                     ));
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 30,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Color.fromARGB(255, 54, 54, 246),
//                         border: Border.all(
//                             width: 2,
//                             color: Color.fromARGB(255, 139, 128, 128))),
//                     child: Text(
//                       'Sell',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Location In Combodia',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 // TextButton(
//                 //     onPressed: () {
//                 //       Navigator.push(context, MaterialPageRoute(
//                 //         builder: (context) {
//                 //           return ALl_Khae_cambodia();
//                 //         },
//                 //       ));
//                 //     },
//                 //     child: Text('View All')),
//               ],
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.only(left: 10, right: 10),
//           //   child: Container(
//           //     height: 120,
//           //     width: double.infinity,
//           //     child: Property_25(),
//           //   ),
//           // ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 70,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   Column(
//                     children: [
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.home,
//                             color: Colors.blue,
//                           )),
//                       Text(
//                         "Home",
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Column(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(
//                               builder: (context) {
//                                 return For_Sale();
//                                 // return For_Sale(
//                                 //     property_type_id: property_type_id,
//                                 //     id_image:
//                                 //         list2_Sale1[0]['id_image'].toString());
//                               },
//                             ));
//                           },
//                           icon: Icon(Icons.home)),
//                       Text(
//                         "For Sale",
//                         style: TextStyle(fontSize: 10),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => For_Rent(
//                                           property_type_id: property_type_id,
//                                           id_image: list2_Sale1[0]['id_image']
//                                               .toString(),
//                                         )),
//                               );
//                             });
//                           },
//                           icon: Icon(Icons.home)),
//                       Text(
//                         "For Rent",
//                         style: TextStyle(fontSize: 10),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Home_Type()),
//                               );
//                             });
//                           },
//                           icon: Icon(Icons.type_specimen)),
//                       Text(
//                         "Home Type",
//                         style: TextStyle(fontSize: 10),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Price()),
//                               );
//                             });
//                           },
//                           icon: Icon(Icons.price_change)),
//                       Text(
//                         "Price",
//                         style: TextStyle(fontSize: 10),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => More()),
//                               );
//                             });
//                           },
//                           icon: Icon(Icons.more)),
//                       Text(
//                         "More",
//                         style: TextStyle(fontSize: 10),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Properties For Sale',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       // property_type_id = random.nextInt(10000);
//                       // print('oooooooooooooo$property_type_id');
//                     });
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return List_Sale(
//                           property_type_id: property_type_id,
//                           id_image: list2_Sale1[0]['id_image'].toString(),
//                         );
//                       },
//                     ));
//                   },
//                   child: Text(
//                       'View All ${list2_Sale1.length.toString()} Listings'),
//                 ),
//               ],
//             ),
//           ),
//           ////////////////// For sale
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.5,
//               width: double.infinity,
//               child: FutureBuilder<List<Model_sale_image>>(
//                 future: Property_Sale_image(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return GridView.builder(
//                       itemCount: 4,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 9,
//                         mainAxisSpacing: 9,
//                         childAspectRatio: 1,
//                       ),
//                       itemBuilder: (BuildContext context, int index) {
//                         final obj = snapshot.data![index];
//                         return InkWell(
//                           onTap: () {
//                             detail_property_sale(index,
//                                 list2_Sale2[index]['id_ptys'].toString());
//                             setState(() {
//                               print(
//                                   'ID = ${list2_Sale2[index]['id_ptys'].toString()}');
//                             });
//                           },
//                           child: Stack(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width * 0.5,
//                                 child: CachedNetworkImage(
//                                   imageUrl: obj.url.toString(),
//                                   fit: BoxFit.cover,
//                                   progressIndicatorBuilder:
//                                       (context, url, downloadProgress) =>
//                                           Center(
//                                     child: CircularProgressIndicator(
//                                         value: downloadProgress.progress),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Icon(Icons.error),
//                                 ),
//                                 // child: Image.network(
//                                 //   '${obj.url.toString()}',
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                               ),
//                               Positioned(
//                                 top: 132,
//                                 child: Container(
//                                   color: Color.fromARGB(255, 8, 103, 13),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.05,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.5,
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               'Price :${list2_Sale2[index]['price'].toString()}',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromARGB(
//                                                       255, 251, 250, 250),
//                                                   fontSize: 10),
//                                             ),
//                                             Text(
//                                               '\$',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromARGB(
//                                                       255, 119, 234, 5),
//                                                   fontSize: 10),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               'Land :${list2_Sale2[index]['land'].toString()} sqm',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromARGB(
//                                                       255, 250, 249, 249),
//                                                   fontSize: 10),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               'bed : ${list2_Sale2[index]['bed'].toString()}',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                   fontSize: 10),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               'bath : ${list2_Sale2[index]['bath'].toString()}',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                   fontSize: 10),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               (list2_Sale_id5 != null)
//                                   ? Positioned(
//                                       top: 105,
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             color:
//                                                 Color.fromARGB(255, 106, 7, 86),
//                                             borderRadius:
//                                                 BorderRadius.circular(5)),
//                                         height: 25,
//                                         width: 50,
//                                         child: Text(
//                                           '${list2_Sale_id5[index]['urgent'].toString()}',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.white),
//                                         ),
//                                       ))
//                                   : SizedBox(),
//                               Positioned(
//                                 top: 10,
//                                 left: 10,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 30,
//                                   width: 60,
//                                   decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 109, 160, 6),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Text(
//                                     'For Sale',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color:
//                                             Color.fromARGB(255, 250, 246, 245),
//                                         fontSize: 12),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Properties For Rent',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       // property_type_id = random.nextInt(10000);
//                       // print('oooooooooooooo$property_type_id');
//                     });
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return List_Rent(
//                           property_type_id: property_type_id,
//                           id_image: list2_Sale1[0]['id_image'].toString(),
//                         );
//                       },
//                     ));
//                   },
//                   child: Text(
//                       'View All ${list2_Sale1.length.toString()} Listings'),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 380,
//               width: double.infinity,
//               child: FutureBuilder<List<Model_sale_image>>(
//                 future: Property_rent_image(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return GridView.builder(
//                       itemCount: 4,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 9,
//                         mainAxisSpacing: 9,
//                         childAspectRatio: 1,
//                       ),
//                       itemBuilder: (BuildContext context, int index) {
//                         final obj = snapshot.data![index];
//                         return InkWell(
//                           onTap: () {
//                             detail_property_rent(index,
//                                 list2_Sale3[index]['id_ptys'].toString());
//                             setState(() {
//                               print(
//                                   'ID = ${list2_Sale3[index]['id_ptys'].toString()}');
//                             });
//                           },
//                           child: Stack(
//                             children: [
//                               Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.5,
//                                   child: (obj.url != null)
//                                       ? CachedNetworkImage(
//                                           imageUrl: obj.url.toString(),
//                                           fit: BoxFit.cover,
//                                           progressIndicatorBuilder: (context,
//                                                   url, downloadProgress) =>
//                                               Center(
//                                             child: CircularProgressIndicator(
//                                                 value:
//                                                     downloadProgress.progress),
//                                           ),
//                                           errorWidget: (context, url, error) =>
//                                               Icon(Icons.error),
//                                         )
//                                       : SizedBox()
//                                   // child: Image.network(
//                                   //   '${obj.url.toString()}',
//                                   //   fit: BoxFit.cover,
//                                   // ),
//                                   ),
//                               Positioned(
//                                 top: 132,
//                                 child: Container(
//                                   color: Color.fromARGB(255, 8, 103, 13),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.05,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.5,
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               'Price :${list2_Sale3[index]['price'].toString()}',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromARGB(
//                                                       255, 251, 250, 250),
//                                                   fontSize: 10),
//                                             ),
//                                             Text(
//                                               '\$',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromARGB(
//                                                       255, 119, 234, 5),
//                                                   fontSize: 10),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               'Land :${list2_Sale3[index]['land'].toString()} sqm',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromARGB(
//                                                       255, 250, 249, 249),
//                                                   fontSize: 10),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               'bed : ${list2_Sale3[index]['bed'].toString()}',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                   fontSize: 10),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               'bath : ${list2_Sale3[index]['bath'].toString()}',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                   fontSize: 10),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 10,
//                                 left: 10,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 30,
//                                   width: 60,
//                                   decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 109, 160, 6),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Text(
//                                     'For Sale',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color:
//                                             Color.fromARGB(255, 250, 246, 245),
//                                         fontSize: 12),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),
//             ),
//           ),
//           ////////////////// For Rent
//         ],
//       ),
//     );
//   }

//   List list2_Sale1 = [];
//   void Property_Sale_image_1() async {
//     var jsonData;
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get/$property_type_id'));

//     if (response.statusCode == 200) {
//       jsonData = jsonDecode(response.body);
//       list2_Sale1 = jsonData;
//       setState(() {
//         list2_Sale1;
//         // print('Image = ${list2_Sale1[0]['url'].toString()}');
//       });
//     }
//   }

//   Future<List<Model_sale_image>> Property_Sale_image() async {
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get/$property_type_id'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Model_sale_image.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<List<Model_sale_image>> Property_rent_image() async {
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_rent_Image/$property_type_id'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Model_sale_image.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Random random = new Random();
//   List list2_Sale2 = [];
//   void Property_Sale() async {
//     var jsonData;
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_get/$property_type_id'));

//     if (response.statusCode == 200) {
//       jsonData = jsonDecode(response.body);
//       list2_Sale2 = jsonData;
//       setState(() {
//         list2_Sale2;
//         // print('$list2_Sale2');
//       });
//     }
//   }

//   List list2_Sale_id = [];
//   int? id_ptys;
//   void Property_Sale_id(property_type_id) async {
//     var jsonData;
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_get/$property_type_id'));

//     if (response.statusCode == 200) {
//       jsonData = jsonDecode(response.body);
//       list2_Sale_id = jsonData;
//       setState(() {
//         list2_Sale2;
//         //  var id_ptys= list2_Sale_id[index]['id_ptys'].toString();
//         // print('$list2_Sale2');
//       });
//     }
//   }

//   /////////////////////////////////// Property_Rent
//   List list2_rent_id = [];
//   List list2_Sale3 = [];
//   void Property_Rent_id(property_type_id) async {
//     var jsonData;
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/rent_id_value/$property_type_id'));

//     if (response.statusCode == 200) {
//       jsonData = jsonDecode(response.body);
//       list2_Sale3 = jsonData;
//       setState(() {
//         list2_Sale3;
//         //  var id_ptys= list2_Sale_id[index]['id_ptys'].toString();
//         // print('$list2_Sale2');
//       });
//     }
//   }

//   Future<void> detail_property_sale(int index, String ID) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Detail_property_sale(
//           property_type_id: property_type_id,
//           id_image: list2_Sale1[index]['id_image'].toString(),
//         ),
//       ),
//     );
//   }

//   Future<void> detail_property_rent(int index, String ID) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Detail_property_rent(
//           property_type_id: property_type_id,
//           id_image: list2_Sale1[index]['id_image'].toString(),
//         ),
//       ),
//     );
//   }

//   List list2_Sale_id5 = [];

//   void Urgent() async {
//     var jsonData;
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgent_pro/${property_type_id}'));

//     if (response.statusCode == 200) {
//       jsonData = jsonDecode(response.body);
//       list2_Sale_id5 = jsonData;
//       setState(() {
//         list2_Sale_id5;
//         print('Urgent = $list2_Sale_id5');
//         //  var id_ptys= list2_Sale_id[index]['id_ptys'].toString();
//         // print('$list2_Sale2');
//       });
//     }
//   }
// }
