// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, dead_code, avoid_print, unnecessary_string_interpolations, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, unnecessary_new, avoid_unnecessary_containers, unused_import, camel_case_types, must_be_immutable, unnecessary_null_comparison, prefer_const_constructors_in_immutables, unnecessary_brace_in_string_interps, empty_statements, curly_braces_in_flow_control_structures, prefer_function_declarations_over_variables, unused_element, prefer_is_empty

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itckfa/models/search_model.dart';
import '../Getx_api/for_screen.dart';
import '../Getx_api/vetbal_controller.dart';
import '../List_all_Screen/List__Sale_all.dart';
import '../map_property/Google_Sale_just_Screen.dart';
import '../verval_property/Verbal_add.dart';
import '../Detail_Screen/Detail_all_list_sale.dart';
import '../map_property/Google_Sale_map.dart';
import '../map_property/Google_Sale_map_full.dart';
import 'package:http/http.dart' as http;

typedef OnChangeCallback = void Function(dynamic value);
List<String> list1 = <String>[
  'Banteay Meanchey',
  'Siem reap',
  'Phnom penh',
  'Takae'
];
List<String> list = <String>['Sort', 'Price', 'Beds', 'Baths', 'B-Size'];

class For_Sale extends StatefulWidget {
  For_Sale({super.key, required this.listget_homescreen});
  OnChangeCallback? listget_homescreen;
  @override
  State<For_Sale> createState() => SearchPropertyState();
}

class SearchPropertyState extends State<For_Sale> {
  int? indexNN;
  var controller_verbal = Controller_verbal();
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  List? list_get;
  late SearchRequestModel requestModel;
  double? lat, log;
  final List<Marker> _markers = <Marker>[];
  CameraPosition? cameraPosition;
  int num = 0;
  List<MapType> style_map = [
    MapType.hybrid,
    MapType.normal,
  ];
  final ScrollController _scrollController = new ScrollController();
  // int? property_type_id;
  bool _isLoading = true;

  @override
  void initState() {
    _initData();
    super.initState();
    print('list get');
  }

  String? jj;
  final controller_list = controller_for_sale();

  Future<void> _initData() async {
    _isLoading = true;
    await Future.wait([
      controller_list.value_all_list_sale(),
      controller_verbal.verbal_Hometype(),
    ]);

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
        backgroundColor: Color.fromARGB(255, 20, 20, 163),
        centerTitle: true,
        title: Text('For Sale'),
        leading: IconButton(
          onPressed: () {
            setState(() {
              if (list_get != null &&
                  controller_list.list_value_all.length == 0) {
                jj = 'khae data';
                // print('1');
                widget.listget_homescreen!(jj);
                Get.back();
              } else if (controller_list.list_value_all.length != 0 &&
                  list_get != null) {
                jj = 'khae data';
                // print('2');

                widget.listget_homescreen!(jj);
                Get.back();
              } else {
                jj = 'no data';
                print('Back');
                widget.listget_homescreen!(jj);
                Get.back();
              }
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      // body: Column(
      //   children: [
      //     Text(list_get.toString()),
      //     TextButton(
      //         onPressed: () {
      //           Get.to(List_Sale_All(
      //             list_get: controller_list.list_value_all,
      //             hometype_api: controller_verbal.list_hometype,
      //             controller_id_get: (value) {
      //               setState(() {
      //                 list_get = value;
      //               });
      //             },
      //           ));
      //         },
      //         child: Text('Go'))
      //   ],
      // ),

      ///////////// after Delete or update or do something//////////////////////////////////////////////////////////////////////////////
      body: (list_get != null)
          ? SafeArea(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // for (int i = 0; i < _items!.length; i++)
                      //   Text('cummune  = ${cummune_a![i]}'),
                      // TextButton(
                      //     onPressed: () {
                      //       Property_Sale_id();
                      //       // Commune_25_all(propery_index);
                      //     },
                      //     child: Text('Go')),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          child: Map_Sale_Screen(
                            get_commune: (value) {},
                            get_district: (value) {},
                            get_lat: (value) {},
                            get_log: (value) {},
                            get_max1: (value) {},
                            get_min1: (value) {},
                            get_min2: (value) {},
                            get_province: (value) {},
                            get_max2: (value) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(Map_Sale_full(
                              get_commune: (value) {},
                              get_district: (value) {},
                              get_lat: (value) {},
                              get_log: (value) {},
                              get_max1: (value) {},
                              get_min1: (value) {},
                              get_min2: (value) {},
                              get_province: (value) {},
                              get_max2: (value) {},
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 71, 13, 158)),
                            height: 40,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Full Map',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                  Icon(
                                    Icons.map_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'List For Sale (${list_get!.length})',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    // property_type_id = random.nextInt(10000);
                                    // print('oooooooooooooo$property_type_id');
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return List_Sale_All(
                                      controller_id_get: (value) {
                                        setState(() {
                                          list_get = value;
                                        });
                                      },
                                      hometype_api:
                                          controller_verbal.list_hometype,
                                      list_get: list_get,
                                    );
                                  }));
                                },
                                child: Text('Show all')),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: double.infinity,
                          child: GridView.builder(
                            itemCount: list_get!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                        list_get![index]['id_ptys'].toString();
                                    // print(verbal_ID);
                                  });
                                  detail_property_sale(index, list_get!);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: CachedNetworkImage(
                                          imageUrl: list_get![index]['url']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
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
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Price :${list_get![index]['price'].toString()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 251, 250, 250),
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    '\$',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 119, 234, 5),
                                                        fontSize: 10),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Land :${list_get![index]['land'].toString()} sqm',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'bed : ${list_get![index]['bed'].toString()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'bath : ${list_get![index]['bath'].toString()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            color: Color.fromARGB(
                                                255, 109, 160, 6),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'For Sale',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 250, 246, 245),
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    (list_get! != null)
                                        ? Positioned(
                                            top: 105,
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 106, 7, 86),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              height: 25,
                                              width: 50,
                                              child: Text(
                                                '${list_get![index]['urgent'].toString()}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
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
            )
          // SingleChildScrollView(
          //     child: SafeArea(
          //         child: Container(
          //       width: double.infinity,
          //       height: double.infinity,
          //       child: Column(
          //         children: [
          //           Text(list_get.toString()),
          //           TextButton(
          //               onPressed: () {
          //                 Get.to(List_Sale_All(
          //                   list_get: controller_list.list_value_all,
          //                   hometype_api: controller_verbal.list_hometype,
          //                   controller_id_get: (value) {
          //                     setState(() {
          //                       list_get = value;
          //                     });
          //                   },
          //                 ));
          //               },
          //               child: Text('Go'))
          //         ],
          //       ),
          //     )),
          //   )
          : _isLoading
              ? Center(child: CircularProgressIndicator())
              : (controller_list.list_value_all.length != 0 &&
                      controller_list.list_value_all != null)
                  ? SafeArea(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // for (int i = 0; i < _items!.length; i++)
                              //   Text('cummune  = ${cummune_a![i]}'),
                              // TextButton(
                              //     onPressed: () {
                              //       Property_Sale_id();
                              //       // Commune_25_all(propery_index);
                              //     },
                              //     child: Text('Go')),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 10),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: double.infinity,
                                  child: Map_Sale_Screen(
                                    get_commune: (value) {},
                                    get_district: (value) {},
                                    get_lat: (value) {},
                                    get_log: (value) {},
                                    get_max1: (value) {},
                                    get_min1: (value) {},
                                    get_min2: (value) {},
                                    get_province: (value) {},
                                    get_max2: (value) {},
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(Map_Sale_full(
                                      get_commune: (value) {},
                                      get_district: (value) {},
                                      get_lat: (value) {},
                                      get_log: (value) {},
                                      get_max1: (value) {},
                                      get_min1: (value) {},
                                      get_min2: (value) {},
                                      get_province: (value) {},
                                      get_max2: (value) {},
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 71, 13, 158)),
                                    height: 40,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Full Map',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          Icon(
                                            Icons.map_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'List For Sale (${controller_list.list_value_all.length})',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            // property_type_id = random.nextInt(10000);
                                            // print('oooooooooooooo$property_type_id');
                                          });
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return List_Sale_All(
                                              controller_id_get: (value) {
                                                setState(() {
                                                  list_get = value;
                                                });
                                              },
                                              hometype_api: controller_verbal
                                                  .list_hometype,
                                              list_get: controller_list
                                                  .list_value_all,
                                            );
                                          }));
                                        },
                                        child: Text('Show all')),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width: double.infinity,
                                  child: GridView.builder(
                                    itemCount:
                                        controller_list.list_value_all.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 9,
                                      mainAxisSpacing: 9,
                                      childAspectRatio: 1,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            verbal_ID = controller_list
                                                .list_value_all[index]
                                                    ['id_ptys']
                                                .toString();
                                            // print(verbal_ID);
                                          });
                                          detail_property_sale(index,
                                              controller_list.list_value_all);
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: CachedNetworkImage(
                                                  imageUrl: controller_list
                                                      .list_value_all[index]
                                                          ['url']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
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
                                                color: Color.fromARGB(
                                                    255, 8, 103, 13),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Price :${controller_list.list_value_all[index]['price'].toString()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        251,
                                                                        250,
                                                                        250),
                                                                fontSize: 10),
                                                          ),
                                                          Text(
                                                            '\$',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        119,
                                                                        234,
                                                                        5),
                                                                fontSize: 10),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Land :${controller_list.list_value_all[index]['land'].toString()} sqm',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        250,
                                                                        249,
                                                                        249),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'bed : ${controller_list.list_value_all[index]['bed'].toString()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'bath : ${controller_list.list_value_all[index]['bath'].toString()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
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
                                                    color: Color.fromARGB(
                                                        255, 109, 160, 6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'For Sale',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 250, 246, 245),
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            (controller_list.list_value_all !=
                                                    null)
                                                ? Positioned(
                                                    top: 105,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 106, 7, 86),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      height: 25,
                                                      width: 50,
                                                      child: Text(
                                                        '${controller_list.list_value_all[index]['urgent'].toString()}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
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
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 45, 20, 173),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'No Data',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
    );
  }

  String? verbal_ID;
  Future<void> detail_property_sale(index, widget_list) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: verbal_ID.toString(),
          list_get_sale: widget_list,
        ),
      ),
    );
  }
  //   Future<void> detail_property_sale_c(int index, String ID) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Detail_property_sale_all(
  //         verbal_ID: verbal_ID.toString(),
  //         list_get_sale:widget_list ,
  //       ),
  //     ),
  //   );
  // }
}
