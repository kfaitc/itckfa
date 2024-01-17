// ignore_for_file: prefer_const_constructors, camel_case_types, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, unnecessary_brace_in_string_interps, unused_local_variable, must_be_immutable, curly_braces_in_flow_control_structures, prefer_const_constructors_in_immutables, unnecessary_null_comparison, prefer_is_empty, unused_element

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shimmer/shimmer.dart';

import '../../../contants.dart';
import '../Getx_api/for_screen.dart';
import '../companent/_await.dart';
import '../companent/_await_list.dart';
import '../companent/gridview.dart';

import 'Detail_all_list_Screen.dart';

typedef OnChangeCallback = void Function(dynamic value);

class List_All extends StatefulWidget {
  List_All({
    super.key,
    required this.list_get,
    required this.hometype_api,
    required this.controller_id_get,
    this.price_dropdown_max,
    this.price_dropdown_min,
    this.list_bathrooms,
    this.url,
    this.province_list,
    this.option,
    this.list_price,
    this.list_bedrooms,
  });
  List? list_get;
  final OnChangeCallback controller_id_get;
  String? indexv;
  String? price_dropdown_min;
  String? price_dropdown_max;
  List? hometype_api;
  List? list_bedrooms;
  List? list_bathrooms;
  List? province_list;
  List? list_hometype;
  List? list_price;

  //Value

  String? option;
  String? url;
  @override
  State<List_All> createState() => _List_Sale_AllState();
}

class _List_Sale_AllState extends State<List_All> {
  var controller_id = controller_for_sale();

  bool _isLoading_pick = false;
  List? hometype_list;
  late PageController _pageController;
  fetchData() async {
    _isLoading_pick = true;
    hometype_get;
    _pageController = PageController(initialPage: 0);
    await Future.wait([
      controller_id.value_all_list_hometype(hometype_get),
    ]);
    setState(() {
      _isLoading_pick = false;
    });
  }

  String? min, max;
  void Min() {
    if (widget.price_dropdown_min == '1k') {
      min = '1000';
    } else if (widget.price_dropdown_min == '2k') {
      min = '2000';
    } else if (widget.price_dropdown_min == '5k') {
      min = '5000';
    } else if (widget.price_dropdown_min == '10k') {
      min = '10000';
    } else if (widget.price_dropdown_min == '20k') {
      min = '20000';
    } else if (widget.price_dropdown_min == '50k') {
      min = '50000';
    } else if (widget.price_dropdown_min == '100k') {
      min = '100000';
    } else if (widget.price_dropdown_min == '200k') {
      min = '200000';
    } else if (widget.price_dropdown_min == '500k') {
      min = '500000';
    }
  }

  void Max() {
    if (widget.price_dropdown_max == '1k') {
      max = '1000';
    } else if (widget.price_dropdown_max == '2k') {
      max = '2000';
    } else if (widget.price_dropdown_max == '5k') {
      max = '5000';
    } else if (widget.price_dropdown_max == '10k') {
      max = '10000';
    } else if (widget.price_dropdown_max == '20k') {
      max = '20000';
    } else if (widget.price_dropdown_max == '50k') {
      max = '50000';
    } else if (widget.price_dropdown_max == '100k') {
      max = '100000';
    } else if (widget.price_dropdown_max == '200k') {
      max = '200000';
    } else if (widget.price_dropdown_max == '500k') {
      max = '500000';
    }
  }

  String? hometype;
  String? bathroom_dropdown;
  String? bedhroom_dropdown;
  String? price_dropdown_min;
  String? price_dropdown_max;
  String? type_dropdown;
  String? province_dropdown;
  Widget dropdown_option() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.385,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),),),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 10, 18, 119),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),),),
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.height * 0.04,
                            ),),
                        Text(
                          'More Option',
                          style: TextStyle(color: Colors.white),
                        ),
                        GFButton(
                          textStyle: TextStyle(color: Colors.white),
                          onPressed: () {
                            setState(() {
                              option_await();
                            });
                          },
                          text: "Search",
                          icon: Icon(Icons.search),
                          color: Colors.white,
                          type: GFButtonType.outline,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropdown('Bedrooms', bedhroom_dropdown,
                            widget.list_bedrooms!, 'value', 'id',),
                        dropdown('bathrooms', bathroom_dropdown,
                            widget.list_bathrooms!, 'value', 'id',),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropdown('Hometype', hometype, widget.hometype_api!,
                            'hometype', 'hometype',),
                        dropdown(
                            'Province/City',
                            province_dropdown,
                            widget.province_list!,
                            'property_type_id',
                            'Name_cummune',),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropdown('Pirce Min', price_dropdown_min,
                            widget.list_price!, 'value', 'id',),
                        dropdown('Pirce Max', price_dropdown_max,
                            widget.list_price!, 'value', 'id',),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool _option_await = false;
  Future option_await() async {
    _option_await = true;
    _pageController = PageController(initialPage: 0);
    await Future.wait([
      option_more(),
    ]);
    setState(() {
      _option_await = false;
    });
  }

  List list = [];
//query
  Future<void> option_more() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option$optin_firest${(option_ == 'Province/City') ? "" : province_id}${(option_ == 'Pirce Min') ? "" : min_p}${(option_ == 'Pirce Max') ? "" : max_p}${(option_ == 'Bedrooms') ? "" : bed_p}${(option_ == 'Bathrooms') ? "" : bath_p}${(option_ == 'Hometype') ? "" : hometype_p}',),);
    // '${widget.url}'));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list = jsonData;
      setState(() {
        list;
        // print(list.toString());
      });
    }
  }

  //Delete
  int? id_ptys;

  final controller_list = controller_for_sale();

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

  String? hometype_get = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 238, 238), body: body(),);
  }

  Widget dropdown_hometype() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 107, 105, 105),
              ),),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.13,
                width: MediaQuery.of(context).size.width * 0.67,
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
                                    MediaQuery.textScaleFactorOf(context) * 11,),
                          ),
                        ),
                      )
                      .toList(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 84, 83, 83),
                  ),
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Hometpye',
                    hintText: 'Select',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.textScaleFactorOf(context) * 11,),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 84, 83, 83),
                      size: MediaQuery.of(context).size.height * 0.035,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              setState(() {
                hometype_get = 'All';
              });
              // controller_id.value_all_list_urgent(hometype);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 55, 95, 170),
              ),
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.06,
                      child: Image.asset('assets/icons/all.png'),),
                  Text(
                    'All List',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.013,
                        color: Colors.white,),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
        child: Column(
      children: [
        (widget.option == 'Option')
            ? dropdown_option()
            : (widget.option == 'No_app')
                ? Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 10, 8, 123),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),),
                          ),
                        ),
                      ),
                    ],
                  )
                : dropdown_hometype(),
        (widget.option == 'Option')
            // ? listview(list)
            ? Column(
                children: [
                  (widget.option == 'Option')
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10, bottom: 10,),
                          child: Row(
                            children: [
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return List_All(
                                            list_get: list,
                                            hometype_api: [],
                                            controller_id_get: (value) {},
                                            option: 'No_app',
                                          );
                                        },
                                      ),);
                                    });
                                  },
                                  child: Text(
                                    'View all',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 101, 100, 100),),
                                  ),)
                            ],
                          ),
                        )
                      : SizedBox(),
                  (_option_await)
                      ? Center(
                          child: Await_value(more: '2'),
                        )
                      : GridView_More(list: list),
                ],
              )
            // ? Text('${list.length.toString()}')
            : _isLoading_pick
                ? Center(child: Await_list())
                : (hometype_get == 'All')
                    ? listview(widget.list_get!)
                    : listview(controller_id.list_value_hometype),
        page_next(),
      ],
    ),);
  }

  Future<void> detail(int index, List list_get) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: verbal_ID.toString(),
          list_get_sale: list_get,
        ),
      ),
    );
  }

  Widget page_next() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,);
            },
            child: Icon(Icons.arrow_back_ios_rounded),
          ),
          InkWell(
            onTap: () {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,);
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  var font_icon = Color.fromARGB(255, 114, 114, 113);
  Widget listview(List list) {
    var font_value = TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.015,
      color: Color.fromARGB(255, 64, 65, 64),
    );
    var font_value_b = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.height * 0.015,
      color: Color.fromARGB(255, 64, 65, 64),
    );
    var font_price = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.height * 0.025,
      color: Color.fromARGB(255, 3, 4, 3),
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: (list.length / 10).ceil(),
        itemBuilder: (context, index) {
          int startIndex = index * 10;
          int endIndex =
              (startIndex + 10) > list.length ? list.length : startIndex + 10;
          List<dynamic> items = list.sublist(startIndex, endIndex);
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.43,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 00, left: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                detail(index, items);
                                setState(() {
                                  verbal_ID =
                                      items[index]['id_ptys'].toString();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, bottom: 4, top: 0, right: 0,),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),),
                                    child: CachedNetworkImage(
                                      imageUrl: items[index]['url'].toString(),
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress,),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$ ${items[index]['price']}',
                                    style: font_price,
                                  ),
                                  Text(
                                    '  ${items[index]['hometype']},',
                                    style: font_value_b,
                                  ),
                                  Text('  ${items[index]['type']},',
                                      style: font_value,),
                                  Text(
                                    ' ${(items[index]['urgent'] ?? "")}',
                                    style: font_value,
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Column(
                                children: [
                                  Text(
                                    '${items[index]['address'] ?? ""}, ${items[index]['Name_cummune'] ?? ""} ,Cambodia',
                                    style: font_value,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Divider(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _icon('bed.png',
                                      '   ${items[index]['bed'] ?? ""}', 'Bed',),
                                  _icon(
                                      'bath.png',
                                      '   ${items[index]['bath'] ?? ""}',
                                      'bath',),
                                  _icon(
                                      'parking.png',
                                      '   ${items[index]['Parking'] ?? ""}',
                                      'Parking',),
                                  _icon(
                                      'lot.png',
                                      '   ${items[index]['land'] ?? ""}',
                                      'Size Land',),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String? min_p;
  String? max_p;
  String? bed_p;
  String? bath_p;
  String? hometype_p;

  String? optin_firest = '';
  Widget _icon(icon, value, text) {
    var font_value = TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.011,
      color: Color.fromARGB(255, 64, 65, 64),
    );
    return Row(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.06,
            child: Image.asset('assets/icons/$icon'),),
        Text(
          value,
          style: font_value,
        ),
        SizedBox(width: 2),
        Text(
          text,
          style: font_value,
        ),
      ],
    );
  }

  Widget awiat_reload() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.033,
                width: MediaQuery.of(context).size.width,
                child: Shimmer.fromColors(
                  baseColor: Color.fromARGB(255, 151, 150, 150),
                  highlightColor: Color.fromARGB(255, 221, 221, 219),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.033,
                        width: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 73, 72, 69),),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.033,
                        width: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 73, 72, 69),),
                      ),
                    ],
                  ),
                ),),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Shimmer.fromColors(
                baseColor: Color.fromARGB(255, 151, 150, 150),
                highlightColor: Color.fromARGB(255, 221, 221, 219),
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 2)),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.186,
                          child: Container(
                            color: Color.fromARGB(255, 8, 103, 13),
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromARGB(
                                                255, 73, 72, 69,),),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromARGB(
                                                255, 73, 72, 69,),),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            left: MediaQuery.of(context).size.width * 0.01,
                            top: MediaQuery.of(context).size.height * 0.15,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 106, 7, 86),
                                  borderRadius: BorderRadius.circular(5),),
                              height: 25,
                              width: 50,
                            ),),
                        Positioned(
                            left: MediaQuery.of(context).size.width * 0.25,
                            top: MediaQuery.of(context).size.height * 0.15,
                            right: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 8, 48, 170),
                                  borderRadius: BorderRadius.circular(5),),
                              height: 25,
                              width: 80,
                            ),),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.02,
                          top: MediaQuery.of(context).size.height * 0.02,
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 109, 160, 6),
                                borderRadius: BorderRadius.circular(10),),
                            child: Text(
                              'For Rent',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 250, 246, 245),
                                  fontSize: 12,),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),),
          ),
        ],
      ),
    );
  }

  String? province_id;
  String? option = '';
  String? option_ = '';
  bool _option = false;
  Widget dropdown(text, values, List list, value_drop, name_dropdown) {
    var color = Color.fromARGB(255, 94, 93, 93);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10),),
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.height * 0.2,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: kwhite,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            filled: true,
            labelText: text,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 11,),
            hintText: text,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 103, 101, 101), width: 2.0,),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 127, 127, 127),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: InputBorder.none,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: color,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: kerror,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          value: values,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 18,
          ),
          style: TextStyle(
            fontSize: 3,
            color: Colors.black,
          ),
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["$value_drop"].toString(),
                  child: Center(
                    child: Text(
                      value["$name_dropdown"],
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 11,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (String? value) {
            setState(() {
              if (text == 'Province/City') {
                if (_option == false) {
                  option_ = 'Province';
                  _option = true;
                  optin_firest = '?property_type_id=$value';
                } else if (option_ == 'Province') {
                  optin_firest = '?property_type_id=$value';
                  // print(optin_firest);
                } else {
                  province_id = '&property_type_id=$value';
                }

                ///Price Min
              } else if (text == 'Pirce Min') {
                if (_option == false) {
                  option_ = 'Pirce Min';
                  _option = true;
                  optin_firest = '?min=$value';
                } else if (option_ == 'Pirce Min') {
                  optin_firest = '?min=$value';
                } else {
                  min_p = '&min=$value';
                }

                ///Price Max
              } else if (text == 'Pirce Max') {
                if (_option == false) {
                  option_ = 'Pirce Max';
                  _option = true;
                  optin_firest = '?max=$value';
                } else if (option_ == 'Pirce Max') {
                  optin_firest = '?max=$value';
                } else {
                  max_p = '&max=$value';
                }
                //Bedrooms
              } else if (text == 'Bedrooms') {
                if (_option == false) {
                  option_ = 'Bedrooms';
                  _option = true;
                  optin_firest = '?bed=$value';
                } else if (option_ == 'Bedrooms') {
                  optin_firest = '?bed=$value';
                } else {
                  bed_p = '&bed=$value';
                }
              }
              //Bathrooms
              else if (text == 'bathrooms') {
                if (_option == false) {
                  option_ = 'bathrooms';
                  _option = true;
                  optin_firest = '?bath=$value';
                } else if (option_ == 'bathrooms') {
                  optin_firest = '?bath=$value';
                } else {
                  bath_p = '&bath=$value';
                }
              }
              //Hometype
              else if (text == 'Hometype') {
                if (_option == false) {
                  option_ = 'Hometype';
                  _option = true;
                  optin_firest = '?hometype=$value';
                } else if (option_ == 'Hometype') {
                  optin_firest = '?hometype=$value';
                } else {
                  hometype_p = '&hometype=$value';
                }
              }
            });
          },
        ),
      )
    ],);
  }

  String? verbal_ID;
  void delete_property(url, id) async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$url/$id',),);
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      throw Exception('Delete error occured!');
    }
  }
}
