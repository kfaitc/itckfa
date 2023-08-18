// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, unused_field, prefer_final_fields, unnecessary_new, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unnecessary_null_comparison, prefer_is_empty, unused_local_variable, unrelated_type_equality_checks, override_on_non_overriding_member, unnecessary_string_interpolations, empty_statements, unused_element, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'package:itckfa/screen/propertype/Ppopertys/Getx_api/controller_api.dart';
import 'package:itckfa/screen/propertype/Ppopertys/Getx_api/hometype.dart';
import 'package:itckfa/screen/propertype/Ppopertys/verval_property/Verbal_add.dart';

import '../../../contants.dart';
import 'Screen_Page/Search_Screen.dart';
import '3_Choose/List_Property/List_Rent.dart';
import '3_Choose/List_Property/List_Sale.dart';
import 'Detail_Screen/Detail_all_list_Rent.dart';
import 'Detail_Screen/Detail_all_list_sale.dart';
import 'Getx_api/controller_hometype.dart';
import 'Getx_api/for_rent.dart';
import 'Getx_api/for_screen.dart';
import 'Screen_Page/For_Rent.dart';
import 'Screen_Page/For_Sale.dart';
import 'Screen_Page/Home_type.dart';
import 'Search_button/Screen_search.dart';
import 'Search_homepage/search_link_all.dart';

import 'khae_25/All_khae_cambodia.dart';
import 'khae_25/Propert_khae.dart';

class Home_Screen_property extends StatefulWidget {
  const Home_Screen_property({super.key});

  @override
  State<Home_Screen_property> createState() => _Home_Screen_propertyState();
}

class _Home_Screen_propertyState extends State<Home_Screen_property> {
  String? value = '1';
  bool isLoading = true;
  String? data;
  var index222;
  String? refresh_hometype;
  String? property_type_id_province = '1';
  String? property_type_id;
  bool _isLoading = true;
  final controller_value = controller_api();
  final controller_rent = controller_for_Rent();
  final controller_2 = controller_for_hometype();
  final controller_hometype = Controller_hometype();
  String? property_type_id_province_0 = '0';

  @override
  void initState() {
    first_time();
    button();
    query = '';
    _search(query);
    super.initState();
  }

  String? searchFromVerbalDate;

  String? hometype;
  String? list_get_ForSale;
  @override
  Future<void> first_time() async {
    property_type_id_province_0;
    isLoading = true;
    await Future.wait([
      controller_hometype.verbal_Hometype(),
      controller_2.value_all_list_2(),
      controller_value.value_all_list(property_type_id_province_0),
      controller_rent.value_all_list_property_id(property_type_id_province_0),
    ]);
    setState(() {
      isLoading = false;
    });
  }

  bool _isLoading_re = false;
  Future<void> _search(query) async {
    _isLoading_re = true;
    await Future.wait([proerty_search(query)]);

    setState(() {
      _isLoading_re = false;
    });
    // All three functions have completed at this point
    // Do any additional initialization here
  }

  int? delete_refresh;
  String? list_get_ForRent = 'no data';
  bool isLoading25 = true;
  bool _isLoading_reloard = true;
  Future<void> first_time_reloard() async {
    // print('NNNNNNNNNNNNNN');
    property_type_id_province_0;
    _isLoading_reloard = true;
    await Future.wait([
      controller_hometype.verbal_Hometype(),
      controller_2.value_all_list_2(),
      controller_value.value_all_list(property_type_id_province_0),
      controller_rent.value_all_list_property_id(property_type_id_province_0),
    ]);
    setState(() {
      _isLoading_reloard = false;
    });
  }

  @override
  Future<void> button() async {
    property_type_id_province_0;
    isLoading25 = true;
    await Future.wait([
      controller_value.value_all_list(property_type_id_province),
      controller_rent.value_all_list_property_id(property_type_id_province),
    ]);
    setState(() {
      isLoading25 = false;
    });
  }

  String? _selectedLocation; // Option 2
  String? selectedValue;
  String? bedrooms;
  List<String> list_bathrooms = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  List<String> list_bedrooms = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  List<String> list_price = <String>[
    '1k',
    '2k',
    '5k',
    '10k',
    '20k',
    '50k',
    '100k',
    '200k',
    '500k',
  ];
  List<String> list_hometype = <String>[
    'Agircultural Land',
    'Apartment Building',
    'Apartment Unit',
    'Borey Development',
    'Building',
    'Commercial Land',
    'Condo',
    'Factory',
    'Flat',
    'Guesthouse',
    /////////
    'Hotel',
    'House',
    'Industrial Land',
    'Land',
    'Link House',
    'Link House - LB',
    'Link House - LD1',
    'Link House - LD2',
    'Link House - LE',
    'Link House New - LA',
    ////////
    'Link House New - LC1',
    'Link House New - LC2',
    'Link House Old - LA',
    'Link House Old - LC1',
    'Link House Old - LC2',
    'Mix Use Development',
    'Office',
    'Office Building',
    'Office Space',
    'Residential Land',
    ////////////
    'Resort',
    'Retail',
    'Retail Space',
    'Shop House1',
    'Shop House A',
    'Shop House B',
    'Shopping Center',
    'SOHO',
    'Studio',
    'Super Market',
    ////////////
    'Townhouse',
    'Villa',
    'Villa jasmina',
    'Villa King',
    'Villa King A',
    'Villa King B',
    'Villa Prince',
    'Villa Queen',
    'Villa Queen A',
    'Villa Queen B',
    ////////////
    'Villa Rosana',
    'Villa Twin',
    'Villa Twin B',
    'Villa Twin C',
    'Villa Twin New',
    'Villa Twin Old',
    'Warehouse',
  ];
  List<String> list_province = <String>[
    'Battambong',
    'Phnom Penh',
    'Bonteaymeanchey',
    'KamponChnang',
    'KampongThom',
    'Kandal',
    'kam pot',
    'Kep',
    'Kracheh',
    'Oudormeanchey',
    /////////
    'Preah Vihea',
    'Prey Veng',
    'Rathanakiri',
    'Siehanuk',
    'Siem reab',
    'Steng Treng',
    'Svang Rieng',
    'Ta kao',
    'TbongKhmom',
    'Pur sat',
    ////////
    'Pai lin',
    'Mun duolmiri',
    'Kohkong',
  ];
  String? bathroom_dropdown;
  String? bedhroom_dropdown;
  String? price_dropdown_min;
  String? price_dropdown_max;
  String? type_dropdown;
  String? province_dropdown;
  String? dropdownValue;
  Future<void> detail_property_id_1(List list, String ID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: ID.toString(),
          list_get_sale: list,
        ),
      ),
    );
  }

  void showConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color.fromARGB(255, 239, 239, 244),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'More Option',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    GFButton(
                      color: Color.fromARGB(255, 160, 41, 32),
                      onPressed: () {
                        setState(() {
                          bathroom_dropdown = null;
                          bedhroom_dropdown = null;
                          price_dropdown_min = null;
                          price_dropdown_max = null;
                          type_dropdown = null;
                          province_dropdown = null;
                          dropdownValue = null;
                        });
                        Navigator.pop(context);
                      },
                      text: "Clear",
                      icon: Icon(
                        Icons.do_not_disturb_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.22,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: 'Bedrooms',
                            hintText: 'Bedrooms',
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
                          value: bedhroom_dropdown,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          items: list_bedrooms
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              value;
                              bedhroom_dropdown = value;
                              bedhroom_dropdown;
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.22,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: 'bathrooms',
                            hintText: 'bathrooms',
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
                          value: bathroom_dropdown,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          items: list_bathrooms
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              value;
                              bathroom_dropdown = value;
                              bathroom_dropdown;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.22,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: 'Province/City',
                            hintText: 'Province/City',
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
                          value: province_dropdown,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          items: list_province
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              value;
                              province_dropdown = value;
                              province_dropdown;
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.22,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: 'PropertyType',
                            hintText: 'ProepertyType',
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
                          value: type_dropdown,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          items: list_hometype
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              value;
                              type_dropdown = value;
                              type_dropdown;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.22,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: 'Pirce Min',
                            hintText: 'Pirce Min',
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
                          value: price_dropdown_min,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          items: list_price
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              value;
                              price_dropdown_min = value;
                              price_dropdown_min;
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.22,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: 'Pirce Max',
                            hintText: 'Pirce Max',
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
                          value: price_dropdown_max,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          items: list_price
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              value;
                              price_dropdown_max = value;
                              price_dropdown_max;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Note* ',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.017,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(172, 143, 10, 10)),
                      ),
                      Text(
                        'Price Min and Price Max You need select Min and Max',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.017,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(173, 158, 158, 158)),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Screen_detail_Search(
                          province: province_dropdown,
                          hometype: type_dropdown,
                          bathroom: bathroom_dropdown,
                          bedhroom: bedhroom_dropdown,
                          max: price_dropdown_max,
                          min: price_dropdown_min,
                        );
                      },
                    ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 18, 26, 136),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: MediaQuery.of(context).size.height * 0.04,
                            color: Colors.white,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? query;
  String? re_hometype;
  final controller_list = controller_for_sale();
  int index2 = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 20, 20, 163),
          centerTitle: true,
          title: Text('Property Listing'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Find Your New House',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.022),
                        ),
                        InkWell(
                          onTap: () {
                            showConfirmationBottomSheet(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.33,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 100, 98, 106),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.menu_open,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Text(
                                    'More Option',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.017,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    query = value;
                                    _search(query);
                                  });
                                  // if (value != null) {
                                  //   searchFromVerbalDate = value;
                                  //   print('1');
                                  // } else if (value == 0) {
                                  //   searchFromVerbalDate = null;
                                  //   print('2');
                                  // } else {
                                  //   print('3');
                                  //   searchFromVerbalDate = null;
                                  // }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(),
                                  hintText: 'Search listing here...',
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _search(query);
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 20, 20, 163),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Search',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (_isLoading_re)
                      ? Center(child: CircularProgressIndicator())
                      : (search_list!.length != 0)
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 221, 220, 220),
                                    borderRadius: BorderRadius.circular(10)),
                                height: h,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: search_list!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        // print(
                                        //     'ID = ${search_list![index]['id_ptys']}');
                                        detail_property_id_1(
                                            search_list!,
                                            search_list![index]['id_ptys']
                                                .toString());
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20, top: 15),
                                          child: Text(
                                            '${search_list![index]['address']} / ${search_list![index]['hometype']} / ${search_list![index]['urgent']} / ${search_list![index]['type']} / ${search_list![index]['id_ptys']}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    );
                                  },
                                ),
                              ),
                            )
                          : (search_list.toString() == '[]')
                              ? SizedBox()
                              : SizedBox(),

                  SizedBox(
                    height: 10,
                  ),

                  // Padding(
                  //   padding: EdgeInsets.all(8),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       InkWell(
                  //         onTap: () {},
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 30,
                  //           width: MediaQuery.of(context).size.width * 0.22,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Color.fromARGB(255, 54, 54, 246),
                  //               border: Border.all(
                  //                   width: 2,
                  //                   color:
                  //                       Color.fromARGB(255, 139, 128, 128))),
                  //           child: Text(
                  //             'Buy',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           Get.to(List_All_Rent(
                  //             hometype_api: [],
                  //             controller_id_get: (value) {},
                  //             list_get: [],
                  //           ));
                  //         },
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 30,
                  //           width: MediaQuery.of(context).size.width * 0.22,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Color.fromARGB(255, 54, 54, 246),
                  //               border: Border.all(
                  //                   width: 2,
                  //                   color:
                  //                       Color.fromARGB(255, 139, 128, 128))),
                  //           child: Text(
                  //             'Rent',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           // Get.to(List_Sale_All(
                  //           //   get_all_homeytpe: list2_Sale_id_hometype,
                  //           //   hometype_api: list2_Sale_id_hometype,
                  //           //   list2_Sale12: list2_Sale1,
                  //           //   list2_Sale_id5: list2_Sale_id5,
                  //           //   list2_Sale_id: list2_Sale2,
                  //           // ));
                  //           // Navigator.push(context, MaterialPageRoute(
                  //           //   builder: (context) {
                  //           //     return List_Sale(
                  //           //       property_type_id:
                  //           //           property_type_id_province.toString(),
                  //           //       id_image: list2_Sale1[0]['id_image'].toString(),
                  //           //     );
                  //           //   },
                  //           // ));
                  //         },
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 30,
                  //           width: MediaQuery.of(context).size.width * 0.22,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Color.fromARGB(255, 54, 54, 246),
                  //               border: Border.all(
                  //                   width: 2,
                  //                   color:
                  //                       Color.fromARGB(255, 139, 128, 128))),
                  //           child: Text(
                  //             'Sell',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Location In Combodia',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),

                          //color: Colors.blue,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ALl_Khae_cambodia(
                                    property_type_id: property_type_id,
                                  );
                                },
                              ));

                              print(property_type_id);
                            },
                            child: Text('View All')),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      child: Property_25(
                        get_index_province: (value) {
                          // fetchData(value);

                          setState(() {
                            controller_value.province;
                            property_type_id_province = value.toString();

                            button();
                          });
                        },
                        property_type_id: value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.house_outlined,
                                    size: 28,
                                    color: Colors.blue,
                                  )),
                              Text(
                                "Home",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(For_Sale(
                                      listget_homescreen: (value) {
                                        list_get_ForSale = value;
                                        setState(() {
                                          list_get_ForSale;
                                          print(
                                              'list of For Sale : ${list_get_ForSale.toString()}');
                                          if (list_get_ForSale == 'no data') {
                                            print('khae data');
                                          } else {
                                            setState(() {
                                              first_time();
                                            });
                                            print('khae data`111');
                                          }
                                        });
                                      },
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.real_estate_agent_outlined,
                                    size: 28,
                                  )),
                              Text(
                                "For Sale",
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => For_Rent(
                                                  listget_homescreen: (value) {
                                                    list_get_ForRent = value;
                                                    setState(() {
                                                      list_get_ForRent;
                                                      print(list_get_ForRent
                                                          .toString());
                                                      if (list_get_ForRent ==
                                                          'no data') {
                                                        print('khae data');
                                                      } else {
                                                        setState(() {
                                                          first_time();
                                                        });
                                                        print('khae data`111');
                                                      }
                                                    });
                                                  },
                                                )),
                                      );
                                    });
                                  },
                                  icon: Icon(
                                    Icons.night_shelter_outlined,
                                    size: 28,
                                  )),
                              Text(
                                "For Rent",
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (list_get_ForSale == 'no data' ||
                                        list_get_ForRent == 'no data') {
                                      re_hometype = 'No khae data';
                                      print('no data');
                                    } else if (list_get_ForSale ==
                                            'have data' ||
                                        list_get_ForRent == 'have data') {
                                      re_hometype = '202301';
                                      print('have data');
                                    } else {
                                      re_hometype = 'No khae data';
                                    }
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home_Type_use(
                                                  delete_refresh: (value) {
                                                    delete_refresh = value;
                                                    setState(() {
                                                      delete_refresh;
                                                    });
                                                    if (delete_refresh ==
                                                        2023) {
                                                      print('deleced');
                                                      first_time();
                                                    } else {
                                                      print('No delet');
                                                    }
                                                  },
                                                  refresh: re_hometype,
                                                  refresh_homescreen: (value) {
                                                    refresh_hometype = value;
                                                    setState(() {
                                                      refresh_hometype;
                                                      if (refresh_hometype ==
                                                          '202301') {
                                                        first_time();
                                                        print('refresh');
                                                      } else {
                                                        // print(
                                                        //     'ssssssssssssss = ${refresh_hometype.toString()}');
                                                        print('nononono');
                                                      }
                                                    });
                                                  },
                                                  controller_id_get: (value) {},
                                                  hometype_api:
                                                      controller_hometype
                                                          .list_hometype,
                                                  list_get: controller_2
                                                      .list_value_all_2SR,
                                                )),
                                      );
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_home_work_outlined,
                                    size: 28,
                                  )),
                              Text(
                                "Home Type",
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Add_verbal_property(
                                                  refresh_homeScreen: (value) {
                                                    refresh_hometype = value;
                                                    setState(() {
                                                      refresh_hometype;
                                                      // print(refresh_hometype
                                                      //     .toString());
                                                      if (refresh_hometype!
                                                              .length !=
                                                          0) {
                                                        setState(() {
                                                          first_time();
                                                          // print(
                                                          //     'pov = ${refresh_hometype}');
                                                        });
                                                      }
                                                    });
                                                  },
                                                )),
                                      );
                                    });
                                  },
                                  icon: Icon(
                                    Icons.post_add,
                                    size: 28,
                                  )),
                              Text(
                                "Add Property",
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(Map_List_search(
                                      get_province: (value) {},
                                      get_district: (value) {},
                                      get_commune: (value) {},
                                      get_log: (value) {},
                                      get_lat: (value) {},
                                      get_min1: (value) {},
                                      get_max1: (value) {},
                                      get_min2: (value) {},
                                      get_max2: (value) {},
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    size: 28,
                                  )),
                              Text(
                                "Search",
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Property For Sale',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(List_Sale(
                              listget: controller_value.list_value_all,
                            ));
                          },
                          child: Text(
                              'View All (${controller_value.list_value_all.length.toString()}) Listings'),
                        ),
                      ],
                    ),
                  ),

                  // Text(controller_value.province.toString()),
                  isLoading25
                      ? Center(child: CircularProgressIndicator())
                      : (controller_value.list_value_all.length != 0 &&
                              controller_value.list_value_all != null)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: (controller_value
                                            .list_value_all.length <
                                        3)
                                    ? MediaQuery.of(context).size.height * 0.25
                                    : MediaQuery.of(context).size.height * 0.5,
                                width: double.infinity,
                                child: Obx(() {
                                  if (controller_value.list_value_all.length !=
                                      0) {
                                    return GridView.builder(
                                      itemCount: (controller_value
                                                  .list_value_all.length <
                                              4)
                                          ? controller_value
                                              .list_value_all.length
                                          : 4,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 1,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final obj_controller_value =
                                            controller_value
                                                .list_value_all[index];
                                        index222 = obj_controller_value;

                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              verbal_ID = controller_value
                                                  .list_value_all[index]
                                                      ['id_ptys']
                                                  .toString();
                                              // print(verbal_ID);
                                            });
                                            detail_property_sale(
                                                index,
                                                controller_value
                                                    .list_value_all);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  // child: Image.network(
                                                  //     '${list2_Sale322![index]['url'].toString()}'),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        obj_controller_value[
                                                                'url'] ??
                                                            "N/A",
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
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.186,
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
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Row(
                                                          children: [
                                                            (obj_controller_value[
                                                                        'price'] !=
                                                                    null)
                                                                ? Text(
                                                                    'Price :${obj_controller_value['price'] ?? "N/A"}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            251,
                                                                            250,
                                                                            250),
                                                                        fontSize:
                                                                            10),
                                                                  )
                                                                : Text('N/A'),
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
                                                            (obj_controller_value[
                                                                        'land'] !=
                                                                    null)
                                                                ? Text(
                                                                    'Land :${obj_controller_value['land'] ?? "N/A"} sqm',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            250,
                                                                            249,
                                                                            249),
                                                                        fontSize:
                                                                            10),
                                                                  )
                                                                : Text('N/A'),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Text(obj_controller_value['price']
                                                      //     .toString()),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Row(
                                                          children: [
                                                            (obj_controller_value[
                                                                        'bed'] !=
                                                                    null)
                                                                ? Text(
                                                                    'bed : ${obj_controller_value['bed'].toString()}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10),
                                                                  )
                                                                : Text('N/A'),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            (obj_controller_value[
                                                                        'bed'] !=
                                                                    null)
                                                                ? Text(
                                                                    'bath : ${obj_controller_value['bath'] ?? "N/A"}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10),
                                                                  )
                                                                : Text('N/A'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
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
                                                      child: obj_controller_value[
                                                                  'urgent'] !=
                                                              null
                                                          ? Text(
                                                              '${obj_controller_value['urgent'] ?? "N/A"}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text('N/A'))),
                                              Positioned(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  right: 1,
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 8, 48, 170),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      height: 25,
                                                      width: 80,
                                                      child: obj_controller_value[
                                                                  'Name_cummune'] !=
                                                              null
                                                          ? Text(
                                                              '${obj_controller_value['Name_cummune'] ?? "N/A"}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text('N/A'))),
                                              Positioned(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
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
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Text('No Data');
                                  }
                                }),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Properties For Rent',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(List_Rent(
                              listget: controller_rent.list_value_pid,
                            ));
                          },
                          child: Text(
                              'View All (${controller_rent.list_value_pid.length.toString()}) Listings'),
                        ),
                      ],
                    ),
                  ),

                  ///////////// For Rent

                  isLoading25
                      ? Center(child: CircularProgressIndicator())
                      : (controller_rent.list_value_pid.length != 0)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: (controller_rent.list_value_pid.length <
                                        3)
                                    ? MediaQuery.of(context).size.height * 0.25
                                    : MediaQuery.of(context).size.height * 0.5,
                                width: double.infinity,
                                child: Obx(() {
                                  if (controller_rent.list_value_pid.length !=
                                          0 &&
                                      controller_rent.list_value_pid.length !=
                                          0) {
                                    return GridView.builder(
                                      itemCount: (controller_rent
                                                  .list_value_pid.length <
                                              4)
                                          ? controller_rent
                                              .list_value_pid.length
                                          : 4,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 1,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final list_value_rent = controller_rent
                                            .list_value_pid[index];
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              verbal_ID = controller_rent
                                                  .list_value_pid[index]
                                                      ['id_ptys']
                                                  .toString();
                                              // print(verbal_ID);
                                            });
                                            detail_property_sale(index,
                                                controller_rent.list_value_pid);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  // child: Image.network(
                                                  //     '${list2_Sale322![index]['url'].toString()}'),
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller_rent
                                                                .list_value_pid[
                                                            index]['url'] ??
                                                        "N/A",
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
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.186,
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
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Price :${list_value_rent['price']}',
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
                                                              'Land :${list_value_rent['land'] ?? "N/A"} sqm',
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
                                                      // Text(obj_controller_value['price']
                                                      //     .toString()),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Row(
                                                          children: [
                                                            (list_value_rent[
                                                                        'bed'] !=
                                                                    null)
                                                                ? Text(
                                                                    'bed : ${list_value_rent['bed'].toString()}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10),
                                                                  )
                                                                : Text('N/A'),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            (list_value_rent[
                                                                        'bed'] !=
                                                                    null)
                                                                ? Text(
                                                                    'bath : ${list_value_rent['bath'] ?? "N/A"}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10),
                                                                  )
                                                                : Text('N/A'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
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
                                                      child: controller_rent
                                                                      .list_value_pid[
                                                                  index]['urgent'] !=
                                                              null
                                                          ? Text(
                                                              '${controller_rent.list_value_pid[index]['urgent'] ?? "N/A"}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text('N/A'))),
                                              Positioned(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  right: 1,
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 8, 48, 170),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      height: 25,
                                                      width: 80,
                                                      child: controller_rent
                                                                      .list_value_pid[index]
                                                                  ['Name_cummune'] !=
                                                              null
                                                          ? Text(
                                                              '${controller_rent.list_value_pid[index]['Name_cummune'] ?? "N/A"}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text('N/A'))),
                                              Positioned(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
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
                                                    'For Rent',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 250, 246, 245),
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Text('No Data');
                                  }
                                }),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                  ////////////////// write at this
                  // (lis)
                ],
              ));
  }

  List list2_Sale_khae = [];
  Future<void> list2_Sale_khae1() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Commune_25/$property_type_id_province'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale_khae = jsonData;
      setState(() {
        list2_Sale_khae;
      });
    }
  }

  // List list2_Sale1 = [];

  Random random = new Random();
  List list2_Sale2 = [];

  List? list2_Sale322;

  List list2_Sale_id5 = [];

///////////////// For Rent
  var image_rent;
  List? list2_rent_image = [];
  Future<void> Property_rent_image(value) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_rent_property_type_id/${value}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_rent_image = jsonData;
      setState(() {
        list2_rent_image;
        for (int i = 0; i < list2_rent_image!.length; i++) {
          image_rent = list2_rent_image![i]['url'].toString();
        }
      });
    }
  }

  List list2_rent_id = [];
  List list2_Sale3 = [];
  Future<void> Property_Rent_id(value) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/rent_id_value/${value}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale3 = jsonData;
      setState(() {
        list2_Sale3;
      });
    }
  }

  List? list2_Sale_id_hometype;
  Future<void> Hometype() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_homeytpe'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)['data'];
      list2_Sale_id_hometype = jsonData;

      setState(() {
        list2_Sale_id_hometype;
        // print('$list2_Sale2');
      });
    }
  }

  List list2_rent_ur = [];
  Future<void> Ugrent_rent(value) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgen_rent/$value'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_rent_ur = jsonData;
      setState(() {
        list2_rent_ur;
      });
    }
  }

  List? List_value_rent;
  Future<void> proerty_rent_value(value) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_get/$value'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      List_value_rent = jsonData;
      setState(() {
        List_value_rent;
      });
    }
  }

//0
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

  Future<void> detail_property_rent(int index, String ID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_rent_all(
          indexv: index.toString(),
          list2_Sale12: list2_rent_image,
          list2_Sale_id5: list2_rent_ur,
          list2_Sale_id: List_value_rent,
          // property_id: list2_Sale_id[index]['property_type_id'].toString(),
          // id_image: list2_Sale_id[index]['id_ptys'].toString(),
        ),
      ),
    );
  }

  double h = 0;
  int i22 = 0;
  List? search_list;
  Future<void> proerty_search(query) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/link_all_search_down?search=$query'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      search_list = jsonData;

      setState(() {
        search_list;

        if (h == 0 || h < 250) {
          for (int i = 0; i < search_list!.length; i++) {
            if (search_list!.length == 1) {
              print('1');
              h = MediaQuery.of(context).size.height * 0.09;
            } else if (search_list!.length == 2) {
              h = MediaQuery.of(context).size.height * 0.19;
              print('2');
            } else if (search_list!.length == 3 || search_list!.length > 3) {
              h = MediaQuery.of(context).size.height * 0.28;
              print('3');
            }
          }
        }
      });
    }
  }
}
