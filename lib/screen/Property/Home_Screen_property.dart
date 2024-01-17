// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, unused_field, prefer_final_fields, unnecessary_new, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unnecessary_null_comparison, prefer_is_empty, unused_local_variable, unrelated_type_equality_checks, override_on_non_overriding_member, unnecessary_string_interpolations, empty_statements, unused_element

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;

import 'Detail_Screen/Detail_all_list_Screen.dart';
import 'Detail_Screen/List_all.dart';
import 'Getx_api/vetbal_controller.dart';
import 'Getx_api/controller_api.dart';
import 'Getx_api/for_rent.dart';
import 'Getx_api/for_screen.dart';
import 'Getx_api/hometype.dart';
import 'Map/Search_Screen.dart';
import 'Screen_Page/For_Rent.dart';
import 'Screen_Page/For_Sale.dart';
import 'Screen_Page/Home_type.dart';
import 'add_new/Verbal_add.dart';
import 'companent/_await.dart';
import 'companent/discount.dart';
import 'companent/gridview.dart';
import 'khae_25/All_khae_cambodia.dart';
import 'khae_25/List_Detail.dart';
import 'khae_25/Propert_khae.dart';

class Home_Screen_property extends StatefulWidget {
  const Home_Screen_property({super.key});

  @override
  State<Home_Screen_property> createState() => _Home_Screen_propertyState();
}

class _Home_Screen_propertyState extends State<Home_Screen_property> {
  String? value = '1';
  // bool isLoading = true;
  String? data;
  var index222;
  String? refresh_hometype;
  String? property_type_id_province = '1';
  String? property_type_id;
  bool _isLoading = true;
  final controller_value = controller_api();
  final controller_rent = controller_for_Rent();

  final controller_hometype = Controller_hometype();
  String? property_type_id_province_0 = '0';

  @override
  void initState() {
    button();
    slider_ds();
    query = '';
    _search(query);
    controller_hometype.verbal_Hometype();
    controller_verbal.verbal_Commune_25_all();
    super.initState();
  }

  String? hometype;
  String? list_get_ForSale;
  @override
  int? delete_refresh;
  String? list_get_ForRent = 'no data';
  bool isLoading25 = true;
  bool _isLoading_reloard = true;

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

  List list_bathrooms = [
    {'id': '1', 'value': '1'},
    {'id': '2', 'value': '2'},
    {'id': '3', 'value': '3'},
    {'id': '4', 'value': '4'},
    {'id': '5', 'value': '5'},
    {'id': '6', 'value': '6'},
    {'id': '7', 'value': '7'},
    {'id': '8', 'value': '8'},
    {'id': '9', 'value': '9'},
    {'id': '10', 'value': '10'}
  ];

  List list_bedrooms = [
    {'id': '1', 'value': '1'},
    {'id': '2', 'value': '2'},
    {'id': '3', 'value': '3'},
    {'id': '4', 'value': '4'},
    {'id': '5', 'value': '5'},
    {'id': '6', 'value': '6'},
    {'id': '7', 'value': '7'},
    {'id': '8', 'value': '8'},
    {'id': '9', 'value': '9'},
    {'id': '10', 'value': '10'}
  ];

  List list_price = [
    {'id': '1k', 'value': '1000'},
    {'id': '2k', 'value': '2000'},
    {'id': '5k', 'value': '5000'},
    {'id': '10k', 'value': '10000'},
    {'id': '20k', 'value': '20000'},
    {'id': '50k', 'value': '50000'},
    {'id': '100k', 'value': '100000'},
    {'id': '200k', 'value': '200000'},
    {'id': '500k', 'value': '500000'},
  ];
  var controller_verbal = Controller_verbal();

  double h = 0;
  int i22 = 0;
  List? search_list;
  Future<void> proerty_search(query) async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/link_all_search_down?search=$query',),);

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      search_list = jsonData;

      setState(() {
        search_list;

        if (h == 0 || h < 250) {
          for (int i = 0; i < search_list!.length; i++) {
            if (search_list!.length == 1) {
              // print('1');
              h = MediaQuery.of(context).size.height * 0.09;
            } else if (search_list!.length == 2) {
              h = MediaQuery.of(context).size.height * 0.19;
              // print('2');
            } else if (search_list!.length == 3 || search_list!.length > 3) {
              h = MediaQuery.of(context).size.height * 0.28;
              // print('3');
            }
          }
        }
      });
    }
  }

  bool? _search_reloard = false;
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

  bool _isLoading_re = false;
  Future<void> _search(query) async {
    _search_reloard = true;
    await Future.wait([proerty_search(query)]);

    setState(() {
      _search_reloard = false;
    });
  }

  int a = 0;
  Widget slider() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 15, left: 0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: imageList.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.only(left: 15),
              child: InkWell(
                onTap: () {
                  setState(() {
                    print('one');
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/earth.gif',
                    image: imageList[index]['url'].toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            viewportFraction: 1,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                a = index;
              });
            },
          ),
        ),
      ),
    );
  }

  String? query;

  String? dropdownValue;

  String? re_hometype;
  final controller_list = controller_for_sale();
  int index2 = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 20, 20, 163),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,),
          actions: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            query = value;
                            _search(query);
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          hintText: 'Search listing here...',
                        ),),
                  ),
                ),
                SizedBox(width: 5),
                GFButton(
                  textStyle: TextStyle(color: Colors.white),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return List_All(
                          list_bathrooms: list_bathrooms,
                          controller_id_get: (value) {},
                          hometype_api: controller_hometype.list_hometype,
                          list_get: [],
                          province_list: controller_verbal.list_cummone,
                          list_price: list_price,
                          option: 'Option',
                          list_bedrooms: list_bedrooms,
                        );
                      },
                    ),);
                  },
                  text: "Optoin",
                  icon: Icon(Icons.menu_open_outlined),
                  color: Colors.white,
                  type: GFButtonType.outline,
                ),
                SizedBox(width: 5),
              ],
            ),
          ],
        ),
        body: ListView(
          children: [
            (_search_reloard!)
                ? Center(child: CircularProgressIndicator())
                : (search_list!.length != 0)
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),),
                          height: h,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: search_list!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  detail_property_id_1(
                                      search_list!,
                                      search_list![index]['id_ptys']
                                          .toString(),);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, top: 15,),
                                    child: Text(
                                      '${search_list![index]['id_ptys'] ?? ""}  ${search_list![index]['address'] ?? ""}  ${search_list![index]['hometype'] ?? ""}  ${search_list![index]['urgent'] ?? ""}   ${search_list![index]['type'] ?? ""}',
                                      style: TextStyle(color: Colors.black),
                                    ),),
                              );
                            },
                          ),
                        ),
                      )
                    : (search_list.toString() == '[]')
                        ? SizedBox()
                        : SizedBox(),
            // slider(),
            (imageList.length == 0)
                ? Discount_Url(
                    list: imageList,
                    a: a,
                  )
                : slider(),
            search_map(),
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location In Combodia',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),

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
                        ),);

                        // print(property_type_id);
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12,),
                      ),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.19,
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

            _Icons_class(),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Properties For Sale',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(List_detail(
                        add: 'No',
                        type: 'Sale',
                        listget: controller_value.list_value_all,
                      ),);
                    },
                    child: Text(
                      'View All',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            isLoading25
                ? Center(child: Await_value())
                : (controller_value.list_value_all.length != 0 &&
                        controller_value.list_value_all != null)
                    // ? gridview(controller_value.list_value_all)
                    ? GridView_More(
                        list: controller_value.list_value_all,
                      )
                    : no_data(),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Properties For Rent',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(List_detail(
                        add: 'No',
                        type: 'Rent',
                        listget: controller_rent.list_value_pid,
                      ),);
                    },
                    child: Text(
                      'View All',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            ///////////// For Rent

            isLoading25
                ? Center(child: Await_value())
                : (controller_rent.list_value_pid.length != 0)
                    // ? gridview(controller_rent.list_value_pid)
                    ? GridView_More(list: controller_rent.list_value_pid)
                    : no_data(),
          ],
        ),);
  }

  Widget Icons_(text, Widget icon) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(-0.2, 5),)
          ],
          borderRadius: BorderRadius.circular(5),),
      child: Column(
        children: [
          icon,
          Divider(
            height: 0.5,
            color: Colors.black,
            endIndent: 5,
            indent: 5,
          ),
          Text(
            "$text",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.013),
          ),
        ],
      ),
    );
  }

  Widget _Icons_class() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return For_Sale(
                      listget_homescreen: (value) {
                        list_get_ForSale = value;
                      },
                    );
                  },
                ),);
              },
              child: Icons_(
                  'For Sale', Icon(Icons.real_estate_agent_outlined, size: 30),),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => For_Rent(
                                listget_homescreen: (value) {
                                  list_get_ForRent = value;
                                },
                              ),),
                    );
                  });
                },
                child: Icons_(
                    'For Rent', Icon(Icons.night_shelter_outlined, size: 30),),),
            InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home_Type_use(
                                hometype_api: controller_hometype.list_hometype,
                              ),),
                    );
                  });
                },
                child: Icons_(
                    'Home Type', Icon(Icons.add_home_work_outlined, size: 30),),),
            InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Add_verbal_property(
                                refresh_homeScreen: (value) {
                                  refresh_hometype = value;
                                  setState(() {
                                    refresh_hometype;
                                    // print(refresh_hometype
                                    //     .toString());
                                    if (refresh_hometype!.length != 0) {
                                      setState(() {});
                                    }
                                  });
                                },
                              ),),
                    );
                  });
                },
                child: Icons_('Add Property', Icon(Icons.post_add, size: 30)),),
          ],
        ),
      ),
    );
  }

  Widget search_map() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Map_List_search_property(
                get_province: (value) {},
                get_district: (value) {},
                get_commune: (value) {},
                get_log: (value) {},
                get_lat: (value) {},
                get_min1: (value) {},
                get_max1: (value) {},
                get_min2: (value) {},
                get_max2: (value) {},
              );
            },
          ),);
        },
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 28, 7, 132),
              borderRadius: BorderRadius.circular(5),),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Property Search Google map (Click here)',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.016,),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.097,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/earth.gif',
                      image:
                          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/icon_map.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List imageList = [];
  Future<void> slider_ds() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/image/get/slider',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      setState(() {
        imageList = jsonDecode(json.encode(response.data))['data'];
      });
    } else {
      print(response.statusMessage);
    }
  }
  // List imageList = [
  //   {
  //     'image':
  //         'https://media.blogto.com/listings/20160127-2048-DoubleDs6.jpg?w=2048&cmd=resize_then_crop&height=1365&quality=70',
  //   }
  // ];

  // int a = 0;
  // Widget slider() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 15, right: 15, left: 0),
  //     child: Container(
  //       height: MediaQuery.of(context).size.height * 0.25,
  //       width: double.infinity,
  //       child: CarouselSlider.builder(
  //         itemCount: imageList.length,
  //         itemBuilder: (context, index, realIndex) {
  //           return Padding(
  //             padding: const EdgeInsets.only(left: 15),
  //             child: InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   // print('one');
  //                 });
  //               },
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: FadeInImage.assetNetwork(
  //                   placeholder: 'assets/earth.gif',
  //                   image: imageList[index]['image'].toString(),
  //                   fit: BoxFit.cover,
  //                   width: double.infinity,
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //         options: CarouselOptions(
  //           autoPlay: true,
  //           autoPlayInterval: Duration(seconds: 2),
  //           viewportFraction: 1,
  //           autoPlayAnimationDuration: const Duration(milliseconds: 800),
  //           enlargeCenterPage: true,
  //           enlargeStrategy: CenterPageEnlargeStrategy.height,
  //           onPageChanged: (index, reason) {
  //             setState(() {
  //               a = index;
  //             });
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget no_data() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GFShimmer(
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
            child: const Text(
              'No Data',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget note() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: [
          Text(
            'Note* ',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.017,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(172, 143, 10, 10),),
          ),
          Text(
            'Price Min and Price Max You need select Min and Max',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.017,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(173, 158, 158, 158),),
          ),
        ],
      ),
    );
  }

  List list2_Sale_khae = [];
  Future<void> list2_Sale_khae1() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Commune_25/$property_type_id_province',),);

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale_khae = jsonData;
      setState(() {
        list2_Sale_khae;
      });
    }
  }
}
