// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:printing/printing.dart';

class dfdf extends StatefulWidget {
  @override
  State<dfdf> createState() => _dfdfState();
}

class _dfdfState extends State<dfdf> {
  final String apiUrl =
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_all_2';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PageViewBuilderExample(apiUrl: apiUrl),
    );
  }
}

class PageViewBuilderExample extends StatefulWidget {
  final String apiUrl;

  PageViewBuilderExample({required this.apiUrl});

  @override
  _PageViewBuilderExampleState createState() => _PageViewBuilderExampleState();
}

class _PageViewBuilderExampleState extends State<PageViewBuilderExample> {
  late Future<List<dynamic>> _futureItems;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _futureItems = fetchItems();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PageView Example')),
      body: FutureBuilder<List<dynamic>>(
        future: _futureItems,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: (snapshot.data!.length / 10).ceil(),
                    itemBuilder: (context, index) {
                      int startIndex = index * 10;
                      int endIndex = (startIndex + 10) > snapshot.data!.length
                          ? snapshot.data!.length
                          : startIndex + 10;
                      List<dynamic> items =
                          snapshot.data!.sublist(startIndex, endIndex);
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.27,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color:
                                            Color.fromARGB(255, 197, 195, 195)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // detail_property_id(
                                                    //     index,
                                                    //     widget.list_get![i]
                                                    //             ['id_ptys']
                                                    //         .toString());
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4,
                                                            bottom: 4,
                                                            top: 4),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.23,
                                                      width: 130,
                                                      // decoration: BoxDecoration(
                                                      //   shape: BoxShape.circle,
                                                      //   image: DecorationImage(image: NetworkImage('${list2_Sale12[index]['url'].toString()}'))
                                                      // ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: items[index]
                                                                ['url']
                                                            .toString(),
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
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 140,
                                                  left: 10,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    109,
                                                                    160,
                                                                    6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Text(
                                                          'For Sale',
                                                          style: TextStyle(
                                                              // fontWeight: FontWeight.bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      250,
                                                                      246,
                                                                      245),
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    29,
                                                                    7,
                                                                    174),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        height: 25,
                                                        width: 50,
                                                        child: Text(
                                                          '${items[index]['urgent'].toString()}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 4, top: 4),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.23,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Color.fromARGB(
                                                      255, 239, 241, 238),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            // ignore: prefer_const_literals_to_create_immutables
                                                            children: [
                                                              Text(
                                                                'Property ID :',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Price :',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Land :',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'bed :',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'bath :',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${items[index]['id_ptys'].toString()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                '${items[index]['price'].toString()} \$',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                '${items[index]['land'].toString()} ' +
                                                                    'm' +
                                                                    '\u00B2',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                '${items[index]['bed'].toString()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                '${items[index]['bath'].toString()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        height: 10,
                                                        thickness: 2,
                                                        color: Colors.black,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            width: 30,
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  // await Printing.layoutPdf(
                                                                  //     onLayout: (format) =>
                                                                  //         _generatePdf(
                                                                  //             format));
                                                                },
                                                                icon: Icon(
                                                                  Icons.print,
                                                                  size: 25,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          19,
                                                                          14,
                                                                          164),
                                                                )),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: 30,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  // detail_property_id(
                                                                  //     index,
                                                                  //     widget
                                                                  //         .list_get![
                                                                  //             i][
                                                                  //             'id_ptys']
                                                                  //         .toString());
                                                                  // setState(() {
                                                                  //   print(
                                                                  //       'ID = ${widget.list_get![i]['id_ptys'].toString()}');
                                                                  // });
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .details_outlined,
                                                                  size: 25,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          64,
                                                                          132,
                                                                          9),
                                                                )),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: 30,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    // print(
                                                                    //     'id_ptys =${widget.list2_Sale_value![index]['id_ptys'].toString()} ');
                                                                  });
                                                                  // Get.to(
                                                                  //     Edit_verbal_property(
                                                                  //   get_all_homeytpe:
                                                                  //       items[index],
                                                                  //   indexv: i
                                                                  //       .toString(),
                                                                  // ));
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .edit_calendar_outlined,
                                                                  size: 25,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          147,
                                                                          8,
                                                                          59),
                                                                )),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: 30,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    title:
                                                                        'Confirmation',
                                                                    desc:
                                                                        'Are you sure you want to delete this item?',
                                                                    btnOkText:
                                                                        'Yes',
                                                                    btnOkColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            72,
                                                                            157,
                                                                            11),
                                                                    btnCancelText:
                                                                        'No',
                                                                    btnCancelColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            133,
                                                                            8,
                                                                            8),
                                                                    btnOkOnPress:
                                                                        () {
                                                                      // delete_property(
                                                                      //     id_ptys: widget
                                                                      //         .list_get![i]['id_ptys']
                                                                      //         .toString());
                                                                      // Navigator.pop(
                                                                      //     context);
                                                                      // // Navigator.of(context).push(
                                                                      // //     MaterialPageRoute(
                                                                      // //         builder:
                                                                      // //             (context) =>
                                                                      // //                 List_Sale_All(list2_Sale_id5: [],)));
                                                                    },
                                                                    btnCancelOnPress:
                                                                        () {
                                                                      print(
                                                                          'No');
                                                                    },
                                                                  ).show();
                                                                },
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  size: 25,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          147,
                                                                          8,
                                                                          59),
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      child: Text('Prev'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<dynamic>> fetchItems() async {
    final response = await http.get(Uri.parse(widget.apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch items');
    }
  }
}
