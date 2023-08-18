// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/Rent_model.dart';

class Detail_property_sale extends StatefulWidget {
  final String? property_type_id;
  final String? id_image;
  const Detail_property_sale(
      {super.key, required this.property_type_id, required this.id_image});

  @override
  State<Detail_property_sale> createState() => _Detail_propertyState();
}

class _Detail_propertyState extends State<Detail_property_sale> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await Future.wait([
      Property_Sale_image(),
      Property_Sale_value(),
      Urgent(),
    ]);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
    // All three functions have completed at this point
    // Do any additional initialization here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 51, 27, 185),
        centerTitle: true,
        title: Text('Detail'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: list2_Sale22!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(children: [
                            Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                imageUrl:
                                    list2_Sale22![index]['url'].toString(),
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),

                              // child: Image.network(
                              //   '${list2_Sale4[index]['url'].toString()}',
                              //   // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/propery_sale/22.jpg',
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            (list2_Sale2 != null)
                                ? Positioned(
                                    top: 105,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 106, 7, 86),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      height: 50,
                                      width: 100,
                                      child: Text(
                                        "${(list2_Sale_id5![index]['urgent']) ?? "N/A"} ",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ))
                                : SizedBox(),
                            Positioned(
                              top: 200,
                              left: 15,
                              bottom: 10,
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: list2_Sale2!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                child: Image.network(
                                                  list2_Sale22![index]['url']
                                                      .toString(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      list2_Sale22![index]
                                                              ['id_image']
                                                          .toString()),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.37,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 248, 247, 247)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.price_change_outlined,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Price :',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.landslide_outlined,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'land :',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.square_foot_outlined,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'sqm :',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bed_outlined,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'bed :',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bathroom_outlined,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'bath :',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.type_specimen_outlined,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'type :',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  //  list[index]["verbal_address"] !=
                                  //                     null
                                  //                 ? list[index]["verbal_address"]
                                  //                 : "N/A",
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${list2_Sale2![index]['price'] ?? "N/A"} \$',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${list2_Sale2![index]['land'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${list2_Sale2![index]['sqm'] ?? "N/A"} ' +
                                            'm' +
                                            '\u00B2',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${list2_Sale2![index]['bed'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${list2_Sale2![index]['bath'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${list2_Sale2![index]['type'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   height: 40,
                                  //   width: 300,
                                  //   color: Colors.red,
                                  // ),
                                  //  Text(
                                  //       'address :',
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         fontWeight:
                                  //             FontWeight
                                  //                 .bold,
                                  //       ),
                                  //     ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Color.fromARGB(255, 251, 251, 251),
                            height: 100,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.add_home_work_sharp),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'address :',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${list2_Sale2![index]['address'] ?? "N/A"}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  List? list2_Sale22 = [];
  Future<void> Property_Sale_image() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get_id/${widget.id_image}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale22 = jsonData;
      setState(() {
        list2_Sale22;
      });
    }
  }

  List? list2_Sale2 = [];
  Future<void> Property_Sale_value() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale/${widget.id_image}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale2 = jsonData;
      setState(() {
        list2_Sale2;
      });
    }
  }

  List? list2_Sale_id5 = [];
  Future<void> Urgent() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgent/${widget.id_image}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale_id5 = jsonData;
      setState(() {
        list2_Sale_id5;
      });
    }
  }
}
