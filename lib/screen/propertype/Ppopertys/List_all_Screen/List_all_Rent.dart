// ignore_for_file: prefer_const_constructors, camel_case_types, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, unnecessary_brace_in_string_interps, unused_local_variable, must_be_immutable, curly_braces_in_flow_control_structures, prefer_const_constructors_in_immutables, unnecessary_null_comparison, prefer_is_empty

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../contants.dart';
import '../Detail_Screen/Detail_all_list_sale.dart';
import '../Getx_api/for_rent.dart';
import '../Getx_api/vetbal_controller.dart';
import '../verval_property/edit_property _Rent.dart';
import '../verval_property/edit_property_sale.dart';

typedef OnChangeCallback = void Function(dynamic value);

class List_All_Rent extends StatefulWidget {
  List_All_Rent(
      {super.key,
      required this.list_get,
      required this.hometype_api,
      required this.controller_id_get});
  List? list_get;
  final OnChangeCallback controller_id_get;
  String? indexv;
  List? hometype_api;

  @override
  State<List_All_Rent> createState() => _List_Sale_AllState();
}

class _List_Sale_AllState extends State<List_All_Rent> {
  bool _isLoading = true;
  var controller_id = controller_for_Rent();
  int index = 0;
  bool _isLoading_pick = false;
  bool _isLoading_re = false;
  List? hometype_list;
  late PageController _pageController;
  fetchData() async {
    _isLoading_pick = true;
    hometype_get;
    _pageController = PageController(initialPage: 0);
    await Future.wait([
      controller_id.value_all_list_all(hometype_get),
    ]);
    setState(() {
      _isLoading_pick = false;
    });
  }

  Future<void> _refresh() async {
    _isLoading_re = true;
    await Future.wait([
      controller_id.value_all_list_Rent_a(),
    ]);

    setState(() {
      controller_id.list_value_all1.length;
      controller_id.list_value_all1;
      widget.controller_id_get(controller_id.list_value_all1);
      print('legnth = ${controller_id.list_value_all1.length.toString()}');
      print('value = ${controller_id.list_value_all1}');
      _isLoading_re = false;
    });
    // All three functions have completed at this point
    // Do any additional initialization here
  }

  //Delete
  int? id_ptys;

  final controller_list = controller_for_Rent();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    hometype_get;
    super.initState();

    _pageController = PageController(initialPage: 0);
  }

  void onchnage_edit() async {
    setState(() {
      if (dg_edit == 'Success Edit') {
        _refresh();
        print('Ok Edit ready');
        pro = 2023;
        print('Ok Edit ready');
      } else {
        print('No Edit');
      }
    });
  }

  bool _isLoading_pick_111 = false;

  String? dg_edit;
  String? hometype_get = 'dragon';
  String? hometype_id = 'HomeTpye';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 20, 20, 163),
          centerTitle: true,
          title: Text('List property For Rent'),
          // title: Text('$dg_edit'),
        ),
        // after delete and refresh data
        body: _isLoading_re
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (widget.list_get!.length != 0 &&
                    controller_id.list_value_all1.length != null &&
                    pro == 2023)
                ? SingleChildScrollView(
                    child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                onChanged: (newValue) {
                                  newValue!;

                                  hometype_get = newValue;
                                  setState(() {
                                    hometype_get;
                                    fetchData();
                                  });
                                },
                                validator: (String? value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please select bank';
                                  }
                                  return null;
                                },
                                items: widget.hometype_api!
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                        value: value["hometype"].toString(),
                                        child: Text(
                                          value["hometype"],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQuery.textScaleFactorOf(
                                                          context) *
                                                      13,
                                              height: 1),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                // add extra sugar..
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: kImageColor,
                                ),
                                //property_type_id
                                decoration: InputDecoration(
                                  fillColor: kwhite,
                                  filled: true,
                                  labelText: 'Hometpye',
                                  hintText: 'Select',
                                  prefixIcon: Icon(
                                    Icons.home_work,
                                    color: kImageColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: kPrimaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: kerror,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: kerror,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  //   decoration: InputDecoration(
                                  //       labelText: 'From',
                                  //       prefixIcon: Icon(Icons.business_outlined)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  hometype_get = 'dragon';
                                });
                                // controller_id.value_all_list_urgent(hometype);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 47, 11, 168),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'All List',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _isLoading_pick
                          ? Center(child: CircularProgressIndicator())
                          : (controller_id.list_value_all1.length != 0 ||
                                  controller_id.list_value_all1.length == 0)
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width: double.infinity,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount:
                                        (controller_id.list_value_all1.length /
                                                10)
                                            .ceil(),
                                    itemBuilder: (context, index) {
                                      int startIndex = index * 10;
                                      int endIndex = (startIndex + 10) >
                                              controller_id
                                                  .list_value_all1.length
                                          ? controller_id.list_value_all1.length
                                          : startIndex + 10;
                                      List<dynamic> items = controller_id
                                          .list_value_all1
                                          .sublist(startIndex, endIndex);
                                      return ListView.builder(
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Color.fromARGB(
                                                      255, 197, 195, 195)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              detail_property_id(
                                                                  index,
                                                                  items[index][
                                                                          'id_ptys']
                                                                      .toString());
                                                              setState(() {
                                                                verbal_ID = items[
                                                                            index]
                                                                        [
                                                                        'id_ptys']
                                                                    .toString();
                                                                // print(verbal_ID);
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom: 4,
                                                                      top: 4),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.23,
                                                                width: 130,
                                                                // decoration: BoxDecoration(
                                                                //   shape: BoxShape.circle,
                                                                //   image: DecorationImage(image: NetworkImage('${list2_Sale12[index]['url'].toString()}'))
                                                                // ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: items[
                                                                              index]
                                                                          [
                                                                          'url']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  progressIndicatorBuilder:
                                                                      (context,
                                                                              url,
                                                                              downloadProgress) =>
                                                                          Center(
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
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
                                                                      Alignment
                                                                          .center,
                                                                  height: 25,
                                                                  width: 50,
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          109,
                                                                          160,
                                                                          6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Text(
                                                                    'For Rent',
                                                                    style: TextStyle(
                                                                        // fontWeight: FontWeight.bold,
                                                                        color: Color.fromARGB(255, 250, 246, 245),
                                                                        fontSize: 12),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          29,
                                                                          7,
                                                                          174),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  height: 25,
                                                                  width: 50,
                                                                  child: Text(
                                                                    '${items[index]['urgent'].toString()}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 4,
                                                                top: 4),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.23,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    239,
                                                                    241,
                                                                    238),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'Price :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'Land :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'bed :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'bath :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
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
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['price'].toString()} \$',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['land'].toString()} ' +
                                                                              'm' +
                                                                              '\u00B2',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['bed'].toString()}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['bath'].toString()}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  height: 10,
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          40,
                                                                      width: 30,
                                                                      child: IconButton(
                                                                          onPressed: () async {
                                                                            // print(items[index]
                                                                            //         [
                                                                            //         'id_ptys']
                                                                            //     .toString());
                                                                            await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, items, index));
                                                                            // print(index
                                                                            //     .toString());
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.print,
                                                                            size:
                                                                                25,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                19,
                                                                                14,
                                                                                164),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          40,
                                                                      width: 30,
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            detail_property_id(index,
                                                                                items[index]['id_ptys'].toString());
                                                                            setState(() {
                                                                              verbal_ID = items[index]['id_ptys'].toString();
                                                                              // print(verbal_ID);
                                                                            });
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.details_outlined,
                                                                            size:
                                                                                25,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                64,
                                                                                132,
                                                                                9),
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
                                          );
                                        },
                                      );
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width: double.infinity,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount:
                                        (controller_id.list_value_urgent.length)
                                            .ceil(),
                                    itemBuilder: (context, index) {
                                      int startIndex = index * 10;
                                      int endIndex = (startIndex + 10) >
                                              controller_id
                                                  .list_value_urgent.length
                                          ? controller_id
                                              .list_value_urgent.length
                                          : startIndex + 10;
                                      List<dynamic> items = controller_id
                                          .list_value_urgent
                                          .sublist(startIndex, endIndex);
                                      return ListView.builder(
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Color.fromARGB(
                                                      255, 197, 195, 195)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              detail_property_id(
                                                                  index,
                                                                  items[index][
                                                                          'id_ptys']
                                                                      .toString());
                                                              setState(() {
                                                                verbal_ID = items[
                                                                            index]
                                                                        [
                                                                        'id_ptys']
                                                                    .toString();
                                                                // print(verbal_ID);
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom: 4,
                                                                      top: 4),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.23,
                                                                width: 130,
                                                                // decoration: BoxDecoration(
                                                                //   shape: BoxShape.circle,
                                                                //   image: DecorationImage(image: NetworkImage('${list2_Sale12[index]['url'].toString()}'))
                                                                // ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: items[
                                                                              index]
                                                                          [
                                                                          'url']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  progressIndicatorBuilder:
                                                                      (context,
                                                                              url,
                                                                              downloadProgress) =>
                                                                          Center(
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
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
                                                                      Alignment
                                                                          .center,
                                                                  height: 25,
                                                                  width: 50,
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          109,
                                                                          160,
                                                                          6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Text(
                                                                    'For Rent',
                                                                    style: TextStyle(
                                                                        // fontWeight: FontWeight.bold,
                                                                        color: Color.fromARGB(255, 250, 246, 245),
                                                                        fontSize: 12),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          29,
                                                                          7,
                                                                          174),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  height: 25,
                                                                  width: 50,
                                                                  child: Text(
                                                                    '${items[index]['urgent'].toString()}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 4,
                                                                top: 4),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.23,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    239,
                                                                    241,
                                                                    238),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'Price :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'Land :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'bed :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'bath :',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
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
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['price'].toString()} \$',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['land'].toString()} ' +
                                                                              'm' +
                                                                              '\u00B2',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['bed'].toString()}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${items[index]['bath'].toString()}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  height: 10,
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          40,
                                                                      width: 30,
                                                                      child: IconButton(
                                                                          onPressed: () async {
                                                                            await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, items, index));
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.print,
                                                                            size:
                                                                                25,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                19,
                                                                                14,
                                                                                164),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          40,
                                                                      width: 30,
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            detail_property_id(index,
                                                                                items[index]['id_ptys'].toString());
                                                                            setState(() {
                                                                              verbal_ID = items[index]['id_ptys'].toString();
                                                                              // print(verbal_ID);
                                                                            });
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.details_outlined,
                                                                            size:
                                                                                25,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                64,
                                                                                132,
                                                                                9),
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
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                    ],
                  ))
                // ? Text('ook')
                ////////////////////////////// Screen No delete
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.75,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    newValue!;

                                    hometype_get = newValue;
                                    setState(() {
                                      hometype_get;
                                      fetchData();
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please select bank';
                                    }
                                    return null;
                                  },
                                  items: widget.hometype_api!
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                          value: value["hometype"].toString(),
                                          child: Text(
                                            value["hometype"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    13,
                                                height: 1),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  // add extra sugar..
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: kImageColor,
                                  ),
                                  //property_type_id
                                  decoration: InputDecoration(
                                    fillColor: kwhite,
                                    filled: true,
                                    labelText: 'Hometpye',
                                    hintText: 'Select',
                                    prefixIcon: Icon(
                                      Icons.home_work,
                                      color: kImageColor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: kPrimaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: kerror,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: kerror,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    //   decoration: InputDecoration(
                                    //       labelText: 'From',
                                    //       prefixIcon: Icon(Icons.business_outlined)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    hometype_get = 'dragon';
                                  });
                                  // controller_id.value_all_list_urgent(hometype);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 47, 11, 168),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'All List',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        _isLoading_pick
                            ? Center(child: CircularProgressIndicator())
                            : (hometype_get == 'dragon')
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    width: double.infinity,
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount:
                                          (widget.list_get!.length / 10).ceil(),
                                      itemBuilder: (context, index) {
                                        int startIndex = index * 10;
                                        int endIndex = (startIndex + 10) >
                                                widget.list_get!.length
                                            ? widget.list_get!.length
                                            : startIndex + 10;
                                        List<dynamic> items = widget.list_get!
                                            .sublist(startIndex, endIndex);
                                        return ListView.builder(
                                          itemCount: items.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color.fromARGB(
                                                        255, 197, 195, 195)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                detail_property_id(
                                                                    index,
                                                                    items[index]
                                                                            [
                                                                            'id_ptys']
                                                                        .toString());
                                                                setState(() {
                                                                  verbal_ID = items[
                                                                              index]
                                                                          [
                                                                          'id_ptys']
                                                                      .toString();
                                                                  // print(verbal_ID);
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 4,
                                                                        bottom:
                                                                            4,
                                                                        top: 4),
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.23,
                                                                  width: 130,
                                                                  // decoration: BoxDecoration(
                                                                  //   shape: BoxShape.circle,
                                                                  //   image: DecorationImage(image: NetworkImage('${list2_Sale12[index]['url'].toString()}'))
                                                                  // ),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: items[index]
                                                                            [
                                                                            'url']
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    progressIndicatorBuilder: (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        Center(
                                                                      child: CircularProgressIndicator(
                                                                          value:
                                                                              downloadProgress.progress),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
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
                                                                        Alignment
                                                                            .center,
                                                                    height: 25,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            109,
                                                                            160,
                                                                            6),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child: Text(
                                                                      'For Rent',
                                                                      style: TextStyle(
                                                                          // fontWeight: FontWeight.bold,
                                                                          color: Color.fromARGB(255, 250, 246, 245),
                                                                          fontSize: 12),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            29,
                                                                            7,
                                                                            174),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    height: 25,
                                                                    width: 50,
                                                                    child: Text(
                                                                      '${items[index]['urgent'].toString()}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 4,
                                                                  top: 4),
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.23,
                                                            width: 200,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      239,
                                                                      241,
                                                                      238),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Property ID :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'Price :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'Land :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'bed :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'bath :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${items[index]['id_ptys'].toString()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['price'].toString()} \$',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['land'].toString()} ' +
                                                                                'm' +
                                                                                '\u00B2',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['bed'].toString()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['bath'].toString()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Divider(
                                                                    height: 10,
                                                                    thickness:
                                                                        2,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            30,
                                                                        child: IconButton(
                                                                            onPressed: () async {
                                                                              // print(items[index]
                                                                              //         [
                                                                              //         'id_ptys']
                                                                              //     .toString());
                                                                              await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, items, index));
                                                                              // print(index
                                                                              //     .toString());
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.print,
                                                                              size: 25,
                                                                              color: Color.fromARGB(255, 19, 14, 164),
                                                                            )),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            30,
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              detail_property_id(index, items[index]['id_ptys'].toString());
                                                                              setState(() {
                                                                                verbal_ID = items[index]['id_ptys'].toString();
                                                                                // print(verbal_ID);
                                                                              });
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.details_outlined,
                                                                              size: 25,
                                                                              color: Color.fromARGB(255, 64, 132, 9),
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
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ///// List Function
                                // : (_isLoading)
                                //     ? Center(
                                //         child: CircularProgressIndicator(),
                                //       )
                                //     : (controller_id.list_value_hometype.length != 0)
                                //         ?
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    width: double.infinity,
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: (controller_id
                                              .list_value_urgent.length)
                                          .ceil(),
                                      itemBuilder: (context, index) {
                                        int startIndex = index * 10;
                                        int endIndex = (startIndex + 10) >
                                                controller_id
                                                    .list_value_urgent.length
                                            ? controller_id
                                                .list_value_urgent.length
                                            : startIndex + 10;
                                        List<dynamic> items = controller_id
                                            .list_value_urgent
                                            .sublist(startIndex, endIndex);
                                        return ListView.builder(
                                          itemCount: items.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color.fromARGB(
                                                        255, 197, 195, 195)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                detail_property_id(
                                                                    index,
                                                                    items[index]
                                                                            [
                                                                            'id_ptys']
                                                                        .toString());
                                                                setState(() {
                                                                  verbal_ID = items[
                                                                              index]
                                                                          [
                                                                          'id_ptys']
                                                                      .toString();
                                                                  // print(verbal_ID);
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 4,
                                                                        bottom:
                                                                            4,
                                                                        top: 4),
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.23,
                                                                  width: 130,
                                                                  // decoration: BoxDecoration(
                                                                  //   shape: BoxShape.circle,
                                                                  //   image: DecorationImage(image: NetworkImage('${list2_Sale12[index]['url'].toString()}'))
                                                                  // ),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: items[index]
                                                                            [
                                                                            'url']
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    progressIndicatorBuilder: (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        Center(
                                                                      child: CircularProgressIndicator(
                                                                          value:
                                                                              downloadProgress.progress),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
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
                                                                        Alignment
                                                                            .center,
                                                                    height: 25,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            109,
                                                                            160,
                                                                            6),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child: Text(
                                                                      'For Rent',
                                                                      style: TextStyle(
                                                                          // fontWeight: FontWeight.bold,
                                                                          color: Color.fromARGB(255, 250, 246, 245),
                                                                          fontSize: 12),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            29,
                                                                            7,
                                                                            174),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    height: 25,
                                                                    width: 50,
                                                                    child: Text(
                                                                      '${items[index]['urgent'].toString()}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 4,
                                                                  top: 4),
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.23,
                                                            width: 200,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      239,
                                                                      241,
                                                                      238),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Property ID :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'Price :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'Land :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'bed :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'bath :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${items[index]['id_ptys'].toString()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['price'].toString()} \$',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['land'].toString()} ' +
                                                                                'm' +
                                                                                '\u00B2',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['bed'].toString()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${items[index]['bath'].toString()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Divider(
                                                                    height: 10,
                                                                    thickness:
                                                                        2,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            30,
                                                                        child: IconButton(
                                                                            onPressed: () async {
                                                                              await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, items, index));
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.print,
                                                                              size: 25,
                                                                              color: Color.fromARGB(255, 19, 14, 164),
                                                                            )),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            30,
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              detail_property_id(index, items[index]['id_ptys'].toString());
                                                                              setState(() {
                                                                                verbal_ID = items[index]['id_ptys'].toString();
                                                                                // print(verbal_ID);
                                                                              });
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.details_outlined,
                                                                              size: 25,
                                                                              color: Color.fromARGB(255, 64, 132, 9),
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
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  _pageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 36,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(255, 152, 33, 25)),
                                  child: Text(
                                    'Back',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 36,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(255, 18, 36, 142)),
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
  }

  String? verbal_ID;
  Future<void> detail_property_id(int index, String ID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: verbal_ID.toString(),
          list_get_sale: widget.list_get,
        ),
      ),
    );
  }

  String? dg;
  Future<void> detail_property_id_1(int index, String ID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: verbal_ID.toString(),
          list_get_sale: widget.list_get,
        ),
      ),
    );
  }

  int? pro;

  void delete_property({required String id_ptys}) async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal_property_rent/delete/$id_ptys'));
    if (response.statusCode == 200) {
      dg = 'Success Deleted';
    } else {
      throw Exception('Delete error occured!');
    }
    setState(() {
      print('Success Deleted');
      if (dg == 'Success Deleted') {
        _refresh();
        setState(() {
          pro = 2023;
          print('Ok Refresh ready');
        });
      } else {
        print('No Delete');
      }
    });
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, List items, int index) async {
    // Create a new PDF document
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    Uint8List bytes1 =
        (await NetworkAssetBundle(Uri.parse('${items[index]['url']}'))
                .load('${items[index]['url']}'))
            .buffer
            .asUint8List();
    Uint8List bytes2 =
        (await NetworkAssetBundle(Uri.parse('${items[index]['url_1']}'))
                .load('${items[index]['url_1']}'))
            .buffer
            .asUint8List();
    Uint8List bytes3 =
        (await NetworkAssetBundle(Uri.parse('${items[index]['url_2']}'))
                .load('${items[index]['url_2']}'))
            .buffer
            .asUint8List();
    // Uint8List bytes2 =
    //     (await NetworkAssetBundle(Uri.parse('$image_i')).load('$image_i'))
    //         .buffer
    //         .asUint8List();

    // Add a page to the PDF document
    pdf.addPage(pw.MultiPage(
      build: (context) {
        return [
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 0, bottom: 10),
            child: pw.Column(
              children: [
                pw.Container(
                  height: 70,
                  margin: pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        width: 80,
                        height: 50,
                        child: pw.Image(
                            pw.MemoryImage(
                              byteList,
                              // bytes1,
                            ),
                            fit: pw.BoxFit.fill),
                      ),
                      pw.Text('verbal ID = ${items[index]['id_ptys']}'),
                      pw.Text("Property Check",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.Container(
                        height: 50,
                        width: 79,
                        // child: pw.BarcodeWidget(
                        //     barcode: pw.Barcode.qrCode(),
                        //     data:
                        //         "https://www.latlong.net/c/?lat=${list[0]['latlong_log']}&long=${list[0]['latlong_la']}"),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                    alignment: pw.Alignment.center,
                    height: 30,
                    width: double.infinity,
                    child: (items[index]['Title'].toString() != null)
                        ? pw.Text('${items[index]['Title'] ?? "N/A"}')
                        : pw.SizedBox()),
                pw.Text('${items[index]['address'] ?? "N/A"}'),
                pw.SizedBox(height: 10),
                //Big image
                pw.Container(
                  height: 160,
                  width: double.infinity,
                  child: pw.Image(pw.MemoryImage(bytes1), fit: pw.BoxFit.fill),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(color: PdfColors.green),
                          child: pw.Image(pw.MemoryImage(bytes2),
                              fit: pw.BoxFit.fill),
                          height: 80,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.SizedBox(width: 5),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(
                              // border: pw.Border.all(),

                              ),
                          child: pw.Image(pw.MemoryImage(bytes3),
                              fit: pw.BoxFit.fill),
                          // name rest with api

                          height: 80,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child:
                              // name rest with api
                              pw.Text("Price",
                                  style: const pw.TextStyle(fontSize: 10)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('${items[index]['price'] ?? "N/A"} \$',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child:
                              // name rest with api
                              pw.Text("land",
                                  style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('${items[index]['land'] ?? "N/A"}',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child:
                              // name rest with api
                              pw.Text("sqm",
                                  style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text(
                              '${items[index]['sqm'] ?? "N/A"} ' +
                                  'm' +
                                  '\u00B2',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child:
                              // name rest with api
                              pw.Text("bed",
                                  style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('${items[index]['bed'] ?? "N/A"}',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child:
                              // name rest with api
                              pw.Text("bath",
                                  style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('${items[index]['bath'] ?? "N/A"}',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child:
                              // name rest with api
                              pw.Text("type",
                                  style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('${items[index]['type'] ?? "N/A"}',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('DESCRIPTION'),
                    ]),
                pw.Container(
                  padding: pw.EdgeInsets.all(8),
                  height: 110,
                  width: double.infinity,
                  color: PdfColors.grey200,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        (items[index]['description'].toString() != null)
                            ? pw.Text('${items[index]['description'] ?? "N/A"}')
                            : pw.SizedBox()
                      ]),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('CONTACT AGENT',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 7)),
                    ]),
                pw.SizedBox(height: 3),
                pw.Column(children: [
                  pw.Row(children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // pw.SizedBox(height: 3),
                          pw.Text('H/P :'),
                          pw.SizedBox(height: 3),
                          pw.Text('Email :'),
                          pw.SizedBox(height: 3),
                          pw.Text('Website :'),
                        ]),
                    pw.SizedBox(width: 10),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // pw.Text('sdfdsfsdf'),
                          // pw.SizedBox(height: 3),
                          pw.Text('+85599283588'),
                          pw.SizedBox(height: 3),
                          pw.Text('info@kfa.com.kh'),
                          pw.SizedBox(height: 3),
                          pw.Text('www.kfa.com.kh'),
                        ]),
                  ]),
                ])
              ],
            ),
          )
        ];
      },
    ));
    final Color_Test = Color.fromARGB(255, 131, 18, 10);
    // Get the bytes of the PDF document
    final pdfBytes = pdf.save();

    // Print the PDF document to the default printer
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    return pdf.save();
  }

  Color kImageColor = Color.fromRGBO(169, 203, 56, 1);
}
