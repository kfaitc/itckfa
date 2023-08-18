// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, camel_case_types, unused_field, unused_import, prefer_final_fields, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Detail_Screen/Detail_all_list_sale.dart';

class List_Sale extends StatefulWidget {
  List_Sale({super.key, required this.listget});

  final List? listget;

  @override
  State<List_Sale> createState() => _Show_allState();
}

class _Show_allState extends State<List_Sale> {
  bool _isLoading = true;

  String selectedOption = 'Apartment Building';
  List<String> options = [
    'Apartment Building',
    'Aparment Unit',
    'Building',
    'Condo',
    'Flat',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 51, 27, 185),
        centerTitle: true,
        title: Text('For Sale'),
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
                    '(${widget.listget!.length})',
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: GridView.builder(
                    itemCount: widget.listget!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 9,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            verbal_ID =
                                widget.listget![index]['id_ptys'].toString();
                            // print(verbal_ID);
                          });
                          detail_property_sale(
                            index,
                            widget.listget![index]['id_ptys'].toString(),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      widget.listget![index]['url'].toString(),
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                                // child: Image.network(
                                //   '${obj.url.toString()}',
                                //   fit: BoxFit.cover,
                                // ),
                                ),
                            Positioned(
                              top: 132,
                              child: Container(
                                color: Color.fromARGB(255, 8, 103, 13),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Price :${widget.listget![index]['price'].toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 251, 250, 250),
                                                fontSize: 10),
                                          ),
                                          Text(
                                            '\$',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 119, 234, 5),
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Land :${widget.listget![index]['land'].toString()} sqm',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 250, 249, 249),
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'bed : ${widget.listget![index]['bed'].toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'bath : ${widget.listget![index]['bath'].toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 109, 160, 6),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'For Sale',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 250, 246, 245),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 80,
                                top: 105,
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 8, 48, 170),
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 25,
                                    width: 80,
                                    child: widget.listget![index]
                                                ['Name_cummune'] !=
                                            null
                                        ? Text(
                                            '${widget.listget![index]['Name_cummune'] ?? "N/A"}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )
                                        : Text('N/A'))),
                            (widget.listget != null)
                                ? Positioned(
                                    top: 105,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 106, 7, 86),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      height: 25,
                                      width: 50,
                                      child: Text(
                                        '${widget.listget![index]['urgent'].toString()}',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ))
                                : SizedBox()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? verbal_ID;
  Future<void> detail_property_sale(int index, String ID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: verbal_ID.toString(),
          list_get_sale: widget.listget!,
        ),
      ),
    );
  }
}
