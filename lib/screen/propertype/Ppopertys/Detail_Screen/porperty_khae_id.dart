// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_import, unnecessary_new, unnecessary_brace_in_string_interps, unused_field, sized_box_for_whitespace, unused_element, must_be_immutable

import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'Detail_Property._sale.dart';
import 'package:http/http.dart' as http;

class Detail_khae_id extends StatefulWidget {
  Detail_khae_id(
      {super.key,
      required this.value,
      required this.list_image,
      required this.list_urgent,
      required this.list_value});
  String? value;
  List? list_urgent;
  List? list_image;
  List? list_value;
  @override
  State<Detail_khae_id> createState() => _Detail_khae_idState();
}

class _Detail_khae_idState extends State<Detail_khae_id> {
  // Future<void> _initData() async {
  //   await Future.wait([
  //     list2_Sale_khae1(),
  //     Property_Sale_image_1(widget.value),
  //     Urgent(widget.value),
  //     Property_Sale_image(widget.value),
  //     Property_Sale_value(widget.value),
  //   ]);
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await Future.delayed(Duration(seconds: 3));

  //   setState(() {
  //     _isLoading = false;
  //   });
  //   // All three functions have completed at this point
  //   // Do any additional initialization here
  // }

  int index2 = 0;
  @override
  void initState() {
    // _initData();

    property_type_id_province;
    super.initState();
  }

  String? property_type_id_province = '1';
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.value}'),
        // title: _isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : Text('${list2_Sale_khae[index2]['Name_cummune']}'),
        backgroundColor: Color.fromARGB(255, 30, 24, 131),
      ),
      // body: _isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Container(
      //                 height: MediaQuery.of(context).size.height,
      //                 width: double.infinity,
      //                 child: GridView.builder(
      //                   itemCount: list2_Sale_id5.length,
      //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                     crossAxisCount: 2,
      //                     crossAxisSpacing: 9,
      //                     mainAxisSpacing: 9,
      //                     childAspectRatio: 1,
      //                   ),
      //                   itemBuilder: (BuildContext context, int index) {
      //                     return InkWell(
      //                       onTap: () {
      //                         detail_property_sale(index,
      //                             list2_Sale2[index]['id_ptys'].toString());
      //                         setState(() {
      //                           print('ID = ${index.toString()}');
      //                           print(
      //                               'ID = ${list2_Sale2[index]['id_ptys'].toString()}');
      //                         });
      //                       },
      //                       child: Stack(
      //                         children: [
      //                           Container(
      //                               width:
      //                                   MediaQuery.of(context).size.width * 0.5,
      //                               child: CachedNetworkImage(
      //                                 imageUrl:
      //                                     list2_Sale322![index]['url'] ?? "N/A",
      //                                 fit: BoxFit.cover,
      //                                 progressIndicatorBuilder:
      //                                     (context, url, downloadProgress) =>
      //                                         Center(
      //                                   child: CircularProgressIndicator(
      //                                       value: downloadProgress.progress),
      //                                 ),
      //                                 errorWidget: (context, url, error) =>
      //                                     Icon(Icons.error),
      //                               )

      //                               // child: Image.network(
      //                               //   '${obj.url.toString()}',
      //                               //   fit: BoxFit.cover,
      //                               // ),
      //                               ),
      //                           Positioned(
      //                             top: 132,
      //                             child: Container(
      //                               color: Color.fromARGB(255, 8, 103, 13),
      //                               height: MediaQuery.of(context).size.height *
      //                                   0.05,
      //                               width:
      //                                   MediaQuery.of(context).size.width * 0.5,
      //                               child: Column(
      //                                 children: [
      //                                   Padding(
      //                                     padding:
      //                                         const EdgeInsets.only(left: 10),
      //                                     child: Row(
      //                                       children: [
      //                                         (list2_Sale2[index]['price'] !=
      //                                                 null)
      //                                             ? Text(
      //                                                 'Price :${list2_Sale2[index]['price'] ?? "N/A"}',
      //                                                 style: TextStyle(
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     color: Color.fromARGB(
      //                                                         255,
      //                                                         251,
      //                                                         250,
      //                                                         250),
      //                                                     fontSize: 10),
      //                                               )
      //                                             : Text('N/A'),
      //                                         Text(
      //                                           '\$',
      //                                           style: TextStyle(
      //                                               fontWeight: FontWeight.bold,
      //                                               color: Color.fromARGB(
      //                                                   255, 119, 234, 5),
      //                                               fontSize: 10),
      //                                         ),
      //                                         SizedBox(
      //                                           width: 5,
      //                                         ),
      //                                         (list2_Sale2[index]['land'] !=
      //                                                 null)
      //                                             ? Text(
      //                                                 'Land :${list2_Sale2[index]['land'] ?? "N/A"} sqm',
      //                                                 style: TextStyle(
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     color: Color.fromARGB(
      //                                                         255,
      //                                                         250,
      //                                                         249,
      //                                                         249),
      //                                                     fontSize: 10),
      //                                               )
      //                                             : Text('N/A'),
      //                                         SizedBox(
      //                                           width: 5,
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   SizedBox(
      //                                     height: 5,
      //                                   ),
      //                                   Padding(
      //                                     padding:
      //                                         const EdgeInsets.only(left: 10),
      //                                     child: Row(
      //                                       children: [
      //                                         (list2_Sale2[index]['bed'] !=
      //                                                 null)
      //                                             ? Text(
      //                                                 'bed : ${list2_Sale2[index]['bed'] ?? "N/A"}',
      //                                                 style: TextStyle(
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     color: Colors.white,
      //                                                     fontSize: 10),
      //                                               )
      //                                             : Text('N/A'),
      //                                         SizedBox(
      //                                           width: 5,
      //                                         ),
      //                                         (list2_Sale2[index]['bed'] !=
      //                                                 null)
      //                                             ? Text(
      //                                                 'bath : ${list2_Sale2[index]['bath'] ?? "N/A"}',
      //                                                 style: TextStyle(
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     color: Colors.white,
      //                                                     fontSize: 10),
      //                                               )
      //                                             : Text('N/A'),
      //                                       ],
      //                                     ),
      //                                   )
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           Positioned(
      //                               top: 105,
      //                               child: Container(
      //                                   alignment: Alignment.center,
      //                                   decoration: BoxDecoration(
      //                                       color:
      //                                           Color.fromARGB(255, 106, 7, 86),
      //                                       borderRadius:
      //                                           BorderRadius.circular(5)),
      //                                   height: 25,
      //                                   width: 50,
      //                                   child: list2_Sale_id5[index]
      //                                               ['urgent'] !=
      //                                           null
      //                                       ? Text(
      //                                           '${list2_Sale_id5[index]['urgent'] ?? "N/A"}',
      //                                           style: TextStyle(
      //                                               fontSize: 12,
      //                                               color: Colors.white),
      //                                         )
      //                                       : Text('N/A'))),
      //                           Positioned(
      //                             top: 10,
      //                             left: 10,
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 30,
      //                               width: 60,
      //                               decoration: BoxDecoration(
      //                                   color: Color.fromARGB(255, 109, 160, 6),
      //                                   borderRadius:
      //                                       BorderRadius.circular(10)),
      //                               child: Text(
      //                                 'For Sale',
      //                                 style: TextStyle(
      //                                     fontWeight: FontWeight.bold,
      //                                     color: Color.fromARGB(
      //                                         255, 250, 246, 245),
      //                                     fontSize: 12),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
    );
  }

  List list2_Sale1 = [];
  Future<void> Property_Sale_image_1(value) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get/${widget.value}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale1 = jsonData;
      setState(() {
        list2_Sale1;
      });
    }
  }

  Future<void> detail_property_sale(int index, String ID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale(
          property_type_id: property_type_id_province,
          id_image: list2_Sale1[index]['id_image'].toString(),
        ),
      ),
    );
  }
}
