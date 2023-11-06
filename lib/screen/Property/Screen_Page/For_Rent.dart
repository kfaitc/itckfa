// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, dead_code, avoid_print, unnecessary_string_interpolations, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, unnecessary_new, avoid_unnecessary_containers, unused_import, camel_case_types, must_be_immutable, unnecessary_null_comparison, prefer_const_constructors_in_immutables, unnecessary_brace_in_string_interps, empty_statements, curly_braces_in_flow_control_structures, prefer_function_declarations_over_variables, unused_element, prefer_is_empty, unused_local_variable

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/search_model.dart';
import '../Detail_Screen/List_all.dart';
import '../Getx_api/for_rent.dart';
import '../Getx_api/for_screen.dart';
import '../Getx_api/vetbal_controller.dart';
import '../companent/_await.dart';
import '../Detail_Screen/Detail_all_list_Screen.dart';
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

class For_Rent extends StatefulWidget {
  For_Rent({super.key, required this.listget_homescreen});
  OnChangeCallback? listget_homescreen;
  @override
  State<For_Rent> createState() => SearchPropertyState();
}

class SearchPropertyState extends State<For_Rent> {
  int? indexNN;
  var controller_verbal = Controller_verbal();
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  List list_get = [];
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
  bool _isLoading = true;

  @override
  void initState() {
    _initData();
    _getCurrentPosition();
    super.initState();
    // print('list get');
  }

  String? commune;
  String? district;
  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      log = position.longitude;
    });
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);

      List ls = jsonResponse['results'];
      List ac;
      bool check_sk = false, check_kn = false;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (check_kn == false || check_sk == false) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "political") {
              setState(() {
                check_kn = true;
                district = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
          }
        }
      }
    }
  }

  Widget Image_select(text) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        decoration: BoxDecoration(
            // color: Color.fromARGB(255, 158, 20, 20),
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholderFit: BoxFit.contain,
            placeholder: 'assets/earth.gif',
            image: text,
          ),
        ),
      ),
    );
  }

  String? jj;
  final controller_list = controller_for_Rent();
  Future<void> _initData() async {
    _isLoading = true;
    await Future.wait([
      controller_list.value_all_list_Rent(),
      controller_verbal.verbal_Hometype(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 235, 235), body: gridview());
  }

  Widget no_data() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GFShimmer(
            child: const Text(
              'No Data',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            showGradient: true,
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.centerLeft,
              stops: const <double>[0, 0.3, 0.6, 0.9, 1],
              colors: [
                Color.fromARGB(255, 44, 37, 182).withOpacity(0.1),
                Color.fromARGB(255, 35, 28, 181).withOpacity(0.3),
                Color.fromARGB(255, 27, 19, 180).withOpacity(0.5),
                Color.fromARGB(255, 21, 13, 178),
                Color.fromARGB(255, 14, 5, 182),
              ],
            ),
          ),
        ],
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

  Widget gridview() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
              ),
              Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.145,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 13, 113),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            )),
                        title: Center(
                          child: Text(
                            'For Rent',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02),
                          ),
                        ),
                        trailing: Text('')),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            (list_get != null && controller_list.list_value_all.length == 0)
                ? gridview_body(list_get)
                : gridview_body(controller_list.list_value_all)
          ],
        ),
      ),
    );
  }

  Widget gridview_body(List list) {
    var color_texts = Color.fromARGB(255, 0, 0, 0);
    var color_text = Color.fromARGB(255, 83, 83, 83);
    return (_isLoading)
        ? Center(
            child: Await_value(hometype: 'No', type: 'Yes'),
          )
        : Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015,
                            color: Color.fromARGB(255, 94, 94, 94)),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              // property_type_id = random.nextInt(10000);
                              // print('oooooooooooooo$property_type_id');
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return List_All(
                                controller_id_get: (value) {
                                  setState(() {
                                    list_get = value;
                                  });
                                },
                                hometype_api: controller_verbal.list_hometype,
                                list_get: controller_list.list_value_all,
                              );
                            }));
                          },
                          child: Text(
                            'Show all',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                color: Color.fromARGB(255, 94, 94, 94)),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: GridView.builder(
                      itemCount: list.length,
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
                              verbal_ID = list[index]['id_ptys'].toString();
                              // verbal_ID = controller_list.list_value_all[index]
                              //         ['id_ptys']
                              //     .toString();
                              // print(verbal_ID);
                            });
                            detail_property_sale(index, list);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Color.fromARGB(255, 251, 250, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(20.0),
                                        // bottomRight: Radius.circular(20.0),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: list[index]['url'].toString(),
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )),
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).size.height *
                                      0.186,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Price :${list[index]['price'].toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: color_text,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              '\$',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 48, 92, 5),
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Land :${list[index]['land'].toString()} sqm',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: color_text,
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
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              'bed : ${list[index]['bed'].toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: color_text,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'bath : ${list[index]['bath'].toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: color_text,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 20,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 74, 108, 6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'For Rent',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 185, 182, 182),
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).size.height *
                                      0.143,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    width: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${list[index]['urgent'].toString()}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: color_texts,
                                          ),
                                        ),
                                        Text(
                                          '${list[index]['Name_cummune'].toString()}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: color_texts,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
