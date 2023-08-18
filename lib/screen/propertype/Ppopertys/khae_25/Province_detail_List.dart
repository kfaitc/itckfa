// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types, body_might_complete_normally_nullable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, unused_import

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Province_detail_List extends StatefulWidget {
  List? value_province;
  String? property_id;
  List? urgent_list;
  Province_detail_List(
      {super.key,
      required this.value_province,
      required this.property_id,
      required this.urgent_list});

  @override
  State<Province_detail_List> createState() => _HHHHSSsState();
}

class _HHHHSSsState extends State<Province_detail_List> {
  String? indexn;
  int? indexN;
  @override
  void initState() {
    // indexn = widget.value_province!.toString();
    super.initState();
    // for (int i = 0; i < widget.value_province!.length; i++) {
    //   // print(widget.value_province!);
    //   if (widget.value_province![i]['property_type_id'].toString() ==
    //       '${widget.property_id}') {
    //     print('${widget.value_province![i]}');
    //     indexN = i;
    //     // Get.to(HHHHSSs(value_province: list2_Sale2[i]));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: Text('${widget.property_id}'),
          // title: Text('${widget.urgent_list}'),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              for (int i = 0; i < widget.value_province!.length; i++)
                Column(
                  children: [
                    (widget.value_province![i]['property_type_id'].toString() ==
                            widget.property_id)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Color.fromARGB(255, 197, 195, 195)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // detail_property_sale(
                                                //     index,
                                                //     list2_Sale_id222[
                                                //                 index]
                                                //             ['id_ptys']
                                                //         .toString());
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4, top: 4),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.23,
                                                  width: 130,
                                                  // decoration: BoxDecoration(
                                                  //   shape: BoxShape.circle,
                                                  //   image: DecorationImage(image: NetworkImage('${list2_Sale12[index]['url'].toString()}'))
                                                  // ),
                                                  // child: CachedNetworkImage(
                                                  //   imageUrl:
                                                  //     widget.value_province![i]
                                                  //               ['url']
                                                  //           .toString(),
                                                  //   fit: BoxFit.cover,
                                                  //   progressIndicatorBuilder:
                                                  //       (context, url,
                                                  //               downloadProgress) =>
                                                  //           Center(
                                                  //     child: CircularProgressIndicator(
                                                  //         value:
                                                  //             downloadProgress
                                                  //                 .progress),
                                                  //   ),
                                                  //   errorWidget:
                                                  //       (context, url, error) =>
                                                  //           Icon(Icons.error),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 140,
                                              left: 10,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 109, 160, 6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      '${widget.value_province![i]['type']}',
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Color.fromARGB(
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
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 29, 7, 174),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    height: 25,
                                                    width: 50,
                                                    child: Text(
                                                      '${widget.value_province![i]['urgent'].toString()}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.51,
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
                                                        children: [
                                                          Text(
                                                            'Property ID :',
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                            '${widget.value_province![i]['id_ptys'].toString()}',
                                                            style: TextStyle(
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
                                                            '${widget.value_province![i]['price'].toString()} \$',
                                                            style: TextStyle(
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
                                                            '${widget.value_province![i]['land'].toString()} ' +
                                                                'm' +
                                                                '\u00B2',
                                                            style: TextStyle(
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
                                                            '${widget.value_province![i]['bed'].toString()}',
                                                            style: TextStyle(
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
                                                            '${widget.value_province![i]['bath'].toString()}',
                                                            style: TextStyle(
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
                                                              // detail_property_sale(
                                                              //     index,
                                                              //     list2_Sale_id222[
                                                              //                 index]
                                                              //             [
                                                              //             'id_ptys']
                                                              //         .toString());
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
                                                              // setState(
                                                              //     () {
                                                              //   if (list2_Sale_id222[index]['type'] ==
                                                              //       'For Sale') {
                                                              //     // print('For Sale');
                                                              //     Get.to(Edit_verbal_property(
                                                              //       get_all_homeytpe: hometype_api,
                                                              //       list2_Sale12: list2_Sale12,
                                                              //       indexv: index.toString(),
                                                              //       list2_Sale_id5: list2_Sale_id5,
                                                              //       list2_Sale_id: list2_Sale_id222,
                                                              //     ));
                                                              //   } else {
                                                              //     // print('For Rent');
                                                              //     Get.to(Edit_verbal_property_Rent(
                                                              //       get_all_homeytpe: hometype_api,
                                                              //       list2_Sale12: list2_Sale12,
                                                              //       indexv: index.toString(),
                                                              //       list2_Sale_id5: list2_Sale_id5,
                                                              //       list2_Sale_id: list2_Sale_id222,
                                                              //     ));
                                                              //   }
                                                              // });
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
                                                                btnOkColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        72,
                                                                        157,
                                                                        11),
                                                                btnCancelText:
                                                                    'No',
                                                                btnCancelColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            133,
                                                                            8,
                                                                            8),
                                                                btnOkOnPress:
                                                                    () {
                                                                  // delete_property(
                                                                  //     id_ptys: list2_Sale_id222[index]
                                                                  //             [
                                                                  //             'id_ptys']
                                                                  //         .toString());
                                                                  Navigator.pop(
                                                                      context);
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .push(
                                                                  //         MaterialPageRoute(builder: (context) => List_Sale_All()));
                                                                },
                                                                btnCancelOnPress:
                                                                    () {
                                                                  print('No');
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
                            ))
                        : SizedBox(),
                  ],
                ),
            ],
          ),
        ));
  }
}
