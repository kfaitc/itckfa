// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class List_Sale extends StatefulWidget {
  const List_Sale({super.key});

  @override
  State<List_Sale> createState() => _Show_allState();
}

class _Show_allState extends State<List_Sale> {
  @override
  void initState() {
    super.initState();
    Property_Sale_image(property_type_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('List of Sale'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${list2_Sale1.length}',
                    style: TextStyle(
                        color: Color.fromARGB(255, 188, 25, 225), fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Listings for sale',
                    style: TextStyle(
                        color: Color.fromARGB(255, 69, 55, 55), fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                    height: 560,
                    width: double.infinity,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 9,
                        childAspectRatio: 2.0,
                      ),
                      itemCount: list2_Sale1.length,
                      itemBuilder: (BuildContext context, index) {
                        return GridTile(
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Image.network(
                                  '${list2_Sale1[index]['url'].toString()}',
                                  // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/properysale/Example1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 55, 152, 10)),
                                    child: Text(
                                      '${list2_Sale1[index]['type'].toString()}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              Positioned(
                                  left: 120,
                                  top: 60,
                                  child: Text(
                                    '\$${list2_Sale1[index]['value'].toString()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  )),
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int property_type_id = 123;
  List list2_Sale1 = [];
  void Property_Sale_image(property_type_id) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get/$property_type_id'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale1 = jsonData;
      setState(() {
        list2_Sale1;
        // print('${list2_Sale1[0]['url'].toString()}');
      });
    }
  }

  List list2_Sale_id = [];
  int? id;
  // void Property_Sale_id(id) async {
  //   var jsonData;
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_get/$id'));

  //   if (response.statusCode == 200) {
  //     jsonData = jsonDecode(response.body);
  //     list2_Sale_id = jsonData;
  //     setState(() {
  //       list2_Sale2;
  //       // print('$list2_Sale2');
  //     });
  //   }
  // }
}
