// ignore_for_file: prefer_const_constructors, camel_case_types, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, unnecessary_brace_in_string_interps, unused_local_variable, must_be_immutable, curly_braces_in_flow_control_structures, prefer_const_constructors_in_immutables, unnecessary_null_comparison, prefer_is_empty, unrelated_type_equality_checks, unused_element

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../contants.dart';
import '../Detail_Screen/Detail_all_list_Screen.dart';
import '../Getx_api/controller_hometype.dart';
import '../Getx_api/for_screen.dart';
import '../Getx_api/vetbal_controller.dart';

import '../companent/_await_list.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Home_Type_use extends StatefulWidget {
  Home_Type_use({
    super.key,
    required this.hometype_api,
  });

  String? indexv;
  List? hometype_api;

  @override
  State<Home_Type_use> createState() => _List_Sale_AllState();
}

class _List_Sale_AllState extends State<Home_Type_use> {
  bool _isLoading = true;
  String? hometype_wait;
  final controller_2 = controller_for_hometype();
  int index = 0;
  bool _isLoading_pick = false;
  bool value_2SR = false;
  List? hometype_list;
  late PageController _pageController;
  fetchData() async {
    _isLoading_pick = true;
    hometype_get;
    _pageController = PageController(initialPage: 0);
    await Future.wait([
      controller_2.value_all_list_hometype(hometype_get),
    ]);
    setState(() {
      _isLoading_pick = false;
    });
  }

  Future<void> _value_2SR() async {
    value_2SR = true;
    await Future.wait([
      controller_2.value_all_list_2(),
    ]);

    setState(() {
      value_2SR = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    hometype_get;
    _value_2SR();
    super.initState();

    _pageController = PageController(initialPage: 0);
  }

  String? hometype_get = 'All';
  String? hometype_id = 'HomeTpye';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 248, 248), body: body(),);
  }

  var font_icon = Color.fromARGB(255, 114, 114, 113);

  Widget _container(text) {
    var font = TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.045,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1, color: Color.fromARGB(255, 150, 151, 150),),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (text == 'Delect')
                ? Icon(
                    Icons.delete,
                    size: MediaQuery.of(context).size.height * 0.03,
                  )
                : Icon(
                    Icons.edit,
                    size: MediaQuery.of(context).size.height * 0.03,
                  ),
            Text(
              '$text',
              style: font,
            ),
          ],
        ),
      ),
    );
  }

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

  Widget body() {
    return SingleChildScrollView(
        child: Column(
      children: [
        dropdown_hometype(),
        (hometype_get == "All")
            ? listview(controller_2.list_value_all_2SR, 'Hometype', 'No', 'All',
                value_2SR,)
            : listview(controller_2.list_value_all_hometype, 'Hometype', 'No',
                'No', _isLoading_pick,),
        page_next(),
      ],
    ),);
  }

  Widget listview(List list, hometype, type, all, bool await) {
    return await ? Await_list() : container_list(list);
  }

  Widget container_list(List list) {
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
      height: MediaQuery.of(context).size.height * 0.8,
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
            child: Container(
              alignment: Alignment.center,
              height: 36,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Icon(Icons.arrow_back_ios_rounded),
            ),
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

  String? verbal_ID;

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

  String? dg;

  int? pro;

  void delete_property(url, id) async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$url/$id',),);
    if (response.statusCode == 200) {
      dg = 'Success Deleted';
    } else {
      throw Exception('Delete error occured!');
    }
    setState(() {
      // print('Success Deleted');
      if (dg == 'Success Deleted') {
        setState(() {
          pro = 2023;
          // print('Ok Refresh ready');
        });
      } else {
        // print('No Delete');
      }
    });
  }

  void delete_property_rent({required String id_ptys}) async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal_property_rent/delete/$id_ptys',),);
    if (response.statusCode == 200) {
      dg = 'Success Deleted';
    } else {
      throw Exception('Delete error occured!');
    }
    setState(() {
      // print('Success Deleted');
    });
  }

  Color kImageColor = Color.fromRGBO(169, 203, 56, 1);
}
