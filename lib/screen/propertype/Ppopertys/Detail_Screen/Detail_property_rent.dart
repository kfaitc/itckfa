// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itckfa/contants.dart';

import '../Model/Rent_model.dart';

class Detail_property_rent extends StatefulWidget {
  final String? property_type_id;
  final String? id_image;
  const Detail_property_rent(
      {super.key, required this.property_type_id, required this.id_image});

  @override
  State<Detail_property_rent> createState() => _Detail_propertyState();
}

class _Detail_propertyState extends State<Detail_property_rent> {
  @override
  void initState() {
    super.initState();
    // Property_Sale_image();

    Property_rent_image_id();
    Property_rent_image_all(widget.property_type_id);
    Property_Rent_image();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 51, 27, 185),
        centerTitle: true,
        title: Text('Detail'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: FutureBuilder<List<model_rent>>(
          future: Property_Rent_image(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: list2_Sale4.length,
                                  itemBuilder: (context, index) {
                                    final obj = snapshot.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Stack(children: [
                                            Container(
                                                height: 300,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: (obj.url != null)
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            obj.url.toString(),
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                Center(
                                                          child: CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      )
                                                    : SizedBox()
                                                // child: Image.network(
                                                //   '${list2_Sale4[index]['url'].toString()}',
                                                //   // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/propery_sale/22.jpg',
                                                //   fit: BoxFit.cover,
                                                // ),
                                                ),
                                            Positioned(
                                              top: 200,
                                              left: 15,
                                              bottom: 10,
                                              child: Container(
                                                height: 100,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: list2_Sale4.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Container(
                                                                child: Image
                                                                    .network(obj
                                                                        .url
                                                                        .toString()),
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
                                                                  color: Colors
                                                                      .white),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(obj
                                                                      .url
                                                                      .toString()),
                                                                  fit: BoxFit
                                                                      .cover)),
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.37,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    255, 248, 247, 247)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .price_change_outlined,
                                                          size: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Price :',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                          Icons
                                                              .landslide_outlined,
                                                          size: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'land :',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                          Icons
                                                              .square_foot_outlined,
                                                          size: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'sqm :',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                          Icons
                                                              .bathroom_outlined,
                                                          size: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'bath :',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                          Icons
                                                              .type_specimen_outlined,
                                                          size: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'type :',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                      '${list2_Sale3[index]['price'].toString()} \$',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      '${list2_Sale3[index]['land'].toString()}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      '${list2_Sale3[index]['sqm'].toString()} ' +
                                                          'm' +
                                                          '\u00B2',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      '${list2_Sale3[index]['bed'].toString()}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      '${list2_Sale3[index]['bath'].toString()}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      '${list2_Sale3[index]['type'].toString()}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                          Container(
                                            color: Color.fromARGB(
                                                255, 251, 251, 251),
                                            height: 100,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons
                                                          .add_home_work_sharp),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'address :',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${list2_Sale3[index]['address'].toString()}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                              )
                            ],
                          ))
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  // List list2_Sale2 = [];
  // void Property_Sale_image() async {
  //   var jsonData;
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get/${widget.property_type_id}'));

  //   if (response.statusCode == 200) {
  //     jsonData = jsonDecode(response.body);
  //     list2_Sale2 = jsonData;
  //     setState(() {
  //       list2_Sale2;
  //       // print('${list2_Sale1[0]['url'].toString()}');
  //     });
  //   }
  // }

  List list2_Sale3 = [];
  void Property_rent_image_id() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_id/${widget.id_image}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale3 = jsonData;
      setState(() {
        list2_Sale3;
        print('${list2_Sale3}');
      });
    }
  }

  Future<List<model_rent>> Property_Rent_image() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_rent_Image_id/${widget.id_image}'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => model_rent.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  List list2_Sale4 = [];
  void Property_rent_image_all(property_type_id) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_rent_Image_id/${widget.id_image}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale4 = jsonData;
      setState(() {
        list2_Sale4;
        print('${list2_Sale4[0]['url'].toString()}');
      });
    }
  }
}
