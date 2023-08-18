// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Detail_property extends StatefulWidget {
  final String? id;
  const Detail_property({super.key, required this.id});

  @override
  State<Detail_property> createState() => _Detail_propertyState();
}

class _Detail_propertyState extends State<Detail_property> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Property_Sale_image();
    Property_Sale_image_id();
    Property_Sale_image_all(property_type_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail222'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              '${list2_Sale3[index]['url'].toString()}',
                              // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/propery_sale/22.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 200,
                            left: 15,
                            bottom: 10,
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: list2_Sale4.length,
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
                                                  '${list2_Sale4[index]['url'].toString()}'),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.white),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${list2_Sale4[index]['url'].toString()}'),
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
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'price :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'land :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'sqm :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'bed :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'bath :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'type :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'address :',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            //  list[index]["verbal_address"] !=
                            //                     null
                            //                 ? list[index]["verbal_address"]
                            //                 : "N/A",
                            Column(
                              children: [
                                Text(
                                  '${list2_Sale2[index]['price'].toString()} \$',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${list2_Sale2[index]['land'].toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${list2_Sale2[index]['sqm'].toString()} ' +
                                      'm' +
                                      '\u00B2',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${list2_Sale2[index]['bed'].toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${list2_Sale2[index]['bath'].toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${list2_Sale2[index]['type'].toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${list2_Sale2[index]['address'].toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List list2_Sale2 = [];
  void Property_Sale_image() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_id/${widget.id}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale2 = jsonData;
      setState(() {
        list2_Sale2;
        // print('${list2_Sale1[0]['url'].toString()}');
      });
    }
  }

  List list2_Sale3 = [];
  void Property_Sale_image_id() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get_id/${widget.id}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale3 = jsonData;
      setState(() {
        list2_Sale3;
        // print('${list2_Sale1[0]['url'].toString()}');
      });
    }
  }

  int property_type_id = 55;
  List list2_Sale4 = [];
  void Property_Sale_image_all(property_type_id) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get/$property_type_id'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale4 = jsonData;
      setState(() {
        list2_Sale4;
        // print('${list2_Sale1[0]['url'].toString()}');
      });
    }
  }
}
