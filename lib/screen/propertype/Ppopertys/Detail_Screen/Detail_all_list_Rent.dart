// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, prefer_adjacent_string_concatenation, avoid_print, unused_local_variable, must_be_immutable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Detail_property_rent_all extends StatefulWidget {
  // final String? id_image;
  // String? property_id;
  List? list2_Sale12;
  List? list2_Sale_id5;
  List? list2_Sale_id;
  String? indexv;
  Detail_property_rent_all(
      {super.key,
      required this.indexv,
      required this.list2_Sale12,
      required this.list2_Sale_id,
      required this.list2_Sale_id5});

  @override
  State<Detail_property_rent_all> createState() => _Detail_propertyState();
}

class _Detail_propertyState extends State<Detail_property_rent_all> {
  // bool _isLoading = true;
  // @override
  // void initState() {
  //   super.initState();
  //   _initData();
  // }
  int? indexN;
  @override
  void initState() {
    super.initState();
    indexN = int.parse(widget.indexv.toString());
  }

  // Future<void> _initData() async {
  //   await Future.wait([
  //     Commune_25_all(),
  //     Property_Sale_image(),
  //     Property_Sale_value(),
  //     Urgent(),
  //   ]);
  //   await Future.delayed(Duration(seconds: 2));
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   // All three functions have completed at this point
  //   // Do any additional initialization here
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 51, 27, 185),
        centerTitle: true,
        // title: Text('${indexN}'),${widget.list2_Sale_id![indexN!]['price']
        title: Text('ID = ${widget.list2_Sale_id![indexN!]['id_ptys']}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              int id_pa = index;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(children: [
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(width: 5),
                          borderRadius:
                              BorderRadius.circular(20), //<-- SEE HERE
                        ),
                        // child: Image.network(
                        //   '${list2_Sale223![index]['url']}',
                        //   fit: BoxFit.cover,
                        // )
                        child: CachedNetworkImage(
                          imageUrl:
                              widget.list2_Sale12![indexN!]['url'].toString(),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 8, 111, 129),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          // child: Text(
                          //   '${_items![index]['Name_cummune']}',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 15,
                          //       color: Colors.white),
                          // ),
                        ),
                      ),
                      (widget.list2_Sale_id5 != null)
                          ? Positioned(
                              top: 90,
                              left: 10,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    color: Color.fromARGB(255, 23, 8, 123),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 35,
                                width: 90,
                                child: Text(
                                  "${(widget.list2_Sale_id5![indexN!]['urgent']) ?? "N/A"} ",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ))
                          : SizedBox(),
                      Positioned(
                          top: 50,
                          left: 10,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Color.fromARGB(255, 25, 127, 13),
                                borderRadius: BorderRadius.circular(5)),
                            height: 35,
                            width: 90,
                            child: Text(
                              "For Sale",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          )),
                      Positioned(
                        top: 200,
                        left: 15,
                        bottom: 10,
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.list2_Sale_id!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            // child: Image.network(
                                            //   list2_Sale223![index]['url']
                                            //       .toString(),
                                            // ),
                                            child: CachedNetworkImage(
                                              imageUrl: widget
                                                  .list2_Sale12![indexN!]['url']
                                                  .toString(),
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
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
                                          color: Color.fromARGB(
                                              255, 235, 227, 227)),
                                      // image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         list2_Sale22![index]['url']
                                      //             .toString()),
                                      //     fit: BoxFit.cover),
                                    ),
                                    // child: Image.network(
                                    //   '${list2_Sale223![index]['url']}',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.list2_Sale12![indexN!]
                                              ['url']
                                          .toString(),
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
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
                      height: MediaQuery.of(context).size.height * 0.47,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 248, 247, 247)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    Row(
                                      children: [
                                        Icon(Icons.add_home_work_sharp),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'address',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
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
                                      '${widget.list2_Sale_id![indexN!]['price'] ?? "N/A"} \$',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '${widget.list2_Sale_id![indexN!]['land'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '${widget.list2_Sale_id![indexN!]['sqm'] ?? "N/A"} ' +
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
                                      '${widget.list2_Sale_id![indexN!]['bed'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '${widget.list2_Sale_id![indexN!]['bath'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '${widget.list2_Sale_id![indexN!]['type'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 4,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${widget.list2_Sale_id![indexN!]['address'] ?? "N/A"}',
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

  List? _items;
  String? provice_pd;

  // List? list2_Sale223 = [];
  // Future<void> Property_Sale_image() async {
  //   var jsonData;
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_image_Sale_last/${widget.id_image}'));

  //   if (response.statusCode == 200) {
  //     jsonData = jsonDecode(response.body);
  //     list2_Sale223 = jsonData;
  //     setState(() {
  //       list2_Sale223;
  //       // print('list2_Sale22 $list2_Sale223');
  //     });
  //   }
  // }

  // int? id_p;
  // List? list2_Sale2 = [];
  // Future<void> Property_Sale_value() async {
  //   var jsonData;
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_id_ptys/${widget.id_image}'));

  //   if (response.statusCode == 200) {
  //     jsonData = jsonDecode(response.body);
  //     list2_Sale2 = jsonData;
  //     setState(() {
  //       list2_Sale2;
  //       id_p = list2_Sale2![0]['property_type_id'];
  //     });
  //   }
  // }

  // List? list2_Sale_id5 = [];
  // Future<void> Urgent() async {
  //   var jsonData;
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgent/${widget.id_image}'));

  //   if (response.statusCode == 200) {
  //     jsonData = jsonDecode(response.body);
  //     list2_Sale_id5 = jsonData;
  //     setState(() {
  //       list2_Sale_id5;
  //     });
  //   }
  // }
}
