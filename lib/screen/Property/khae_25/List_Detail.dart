// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, camel_case_types, unused_field, unused_import, prefer_final_fields, prefer_const_constructors_in_immutables, unused_local_variable, must_be_immutable, unnecessary_null_comparison

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../Detail_Screen/Detail_all_list_Screen.dart';
import '../Getx_api/controller_api.dart';
import '../Getx_api/for_rent.dart';

class List_detail extends StatefulWidget {
  List_detail(
      {super.key,
      this.index_P,
      required this.listget,
      this.type,
      this.add,
      this.province_id,
      this.reloard});
  String? province_id;
  final List? listget;
  String? reloard;
  String? type;
  String? add;
  String? index_P;
  @override
  State<List_detail> createState() => _Show_allState();
}

class _Show_allState extends State<List_detail> {
  @override
  void initState() {
    super.initState();
    slider_ds();
    province(widget.province_id.toString());
  }

  final controller_value = controller_api();
  final controller_rent = controller_for_Rent();
  bool isLoading25 = true;

  Future<void> province(property_id) async {
    isLoading25 = true;
    await Future.wait([
      controller_value.value_all_list(property_id.toString()),
      controller_rent.value_all_list_property_id(property_id.toString()),
    ]);
    setState(() {
      isLoading25 = false;
    });
  }

  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 232),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appbar(),
              (imageList.length == 0)
                  ? SizedBox()
                  : (widget.add.toString() == 'add')
                      ? add()
                      : SizedBox(),
              SizedBox(height: 5),
              (isLoading25 && widget.reloard.toString() == "No")
                  ? Center(child: awiat_reload())
                  : (widget.reloard.toString() == "No")
                      // ? Text('body')
                      // : Text('list')
                      ? body_girdview()
                      : _body(widget.listget!),
            ],
          ),
        ),
      ),
    );
  }

  List imageList = [];
  Future<void> slider_ds() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/image/province_get/slider/${widget.index_P}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      setState(() {
        imageList = jsonDecode(json.encode(response.data))['data'];
        print(imageList.toString());
      });
    } else {
      print(response.statusMessage);
    }
  }

  int a = 0;

  Widget add() {
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

  Widget _appbar() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.17,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: Colors.white,
          ),
        ),
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.145,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Color.fromARGB(255, 20, 13, 113),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                  title: Center(
                    child: Text(
                      '${widget.type}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                  ),
                  trailing: Text('')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _body(List list) {
    var color_texts = Color.fromARGB(255, 0, 0, 0);
    var color_text = Color.fromARGB(255, 83, 83, 83);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            child: GridView.builder(
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      verbal_ID = list[index]['id_ptys'].toString();
                      // print(verbal_ID);
                    });
                    detail_property_sale(
                      list,
                      list[index]['id_ptys'].toString(),
                    );
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
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: list[index]['url'].toString(),
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.175,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Price : ${list[index]['price'].toString()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: color_text,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      '\$',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 48, 92, 5),
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Land : ${list[index]['land'].toString()} sqm',
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
                                padding: const EdgeInsets.only(left: 10),
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
                          left: MediaQuery.of(context).size.width * 0.02,
                          top: MediaQuery.of(context).size.height * 0.02,
                          child: Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 74, 108, 6),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '${list[index]['type'].toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 185, 182, 182),
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.143,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.height * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                (list != null)
                                    ? Text(
                                        '${list[index]['urgent'].toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: color_texts,
                                        ),
                                      )
                                    : SizedBox(),
                                list[index]['Name_cummune'] != null
                                    ? Text(
                                        '${list[index]['Name_cummune'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: color_texts,
                                        ),
                                      )
                                    : Text('N/A'),
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
      ),
    );
  }

  String? verbal_ID;
  Future<void> detail_property_sale(List list, String ID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          list_get_sale: list,
          verbal_ID: ID.toString(),
        ),
      ),
    );
  }

  Widget body_girdview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            // height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: gridview(
                controller_value.list_value_all, 'Sale', 'Show all', 'Sale')),
        Container(
            color: Colors.white,
            width: double.infinity,
            child: gridview(
                controller_rent.list_value_pid, 'Rent', 'Show all', 'Rent')),
      ],
    );
  }

  Widget _Text(text, text1, List list, type) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Text(
            '$text',
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.height * 0.02),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return List_detail(
                      listget: list,
                      type: type,
                      add: 'No',
                    );
                  },
                ));
              });
            },
            child: Text(
              '$text1',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.height * 0.02),
            ),
          ),
        ],
      ),
    );
  }

  var color_texts = Color.fromARGB(255, 0, 0, 0);
  var color_text = Color.fromARGB(255, 83, 83, 83);
  Widget gridview(List list, text1, text2, type) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SizedBox(height: 20),
          _Text('$text1', '$text2', list, type),
          SizedBox(height: 7),
          Container(
            height: MediaQuery.of(context).size.height * 0.235,
            width: double.infinity,
            child: Obx(() {
              return ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final item = list[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // print(verbal_ID);
                        });
                        detail_property_sale(
                            list, list[index]['id_ptys'].toString());
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
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    // bottomLeft: Radius.circular(20.0),
                                    // bottomRight: Radius.circular(20.0),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: item['url'].toString(),
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
                              top: MediaQuery.of(context).size.height * 0.186,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Price : ${item['price']}',
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
                                          'Land : ${item['land'] ?? ""} sqm',
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
                                  // Text(obj_controller_value['price']
                                  //     .toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        (item['bed'] != null)
                                            ? Text(
                                                'bed : ${item['bed'].toString()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: color_text,
                                                    fontSize: 10),
                                              )
                                            : Text(''),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        (item['bed'] != null)
                                            ? Text(
                                                'bath : ${item['bath'] ?? ""}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: color_text,
                                                    fontSize: 10),
                                              )
                                            : Text(''),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.width * 0.01,
                                top: MediaQuery.of(context).size.height * 0.15,
                                child: Container(
                                    alignment: Alignment.center,
                                    // decoration: BoxDecoration(
                                    //     color: Color.fromARGB(255, 230, 227, 230),
                                    //     borderRadius: BorderRadius.circular(5)),
                                    height: 25,
                                    width: 50,
                                    child: item['urgent'] != null
                                        ? Text(
                                            '${item['urgent'] ?? ""}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color_texts,
                                                fontSize: 12),
                                          )
                                        : Text(''))),
                            Positioned(
                                left: MediaQuery.of(context).size.width * 0.25,
                                top: MediaQuery.of(context).size.height * 0.15,
                                right: 1,
                                child: Container(
                                    alignment: Alignment.center,
                                    // decoration: BoxDecoration(
                                    //     color: Color.fromARGB(255, 8, 48, 170),

                                    // borderRadius: BorderRadius.circular(5)),
                                    height: 25,
                                    width: 80,
                                    child: item['Name_cummune'] != null
                                        ? Text(
                                            '${item['Name_cummune'] ?? ""}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color_texts,
                                                fontSize: 10),
                                          )
                                        : Text(''))),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.02,
                              top: MediaQuery.of(context).size.height * 0.02,
                              child: Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 74, 108, 6),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  '${item['type']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 185, 182, 182),
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget awiat_reload() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          _reload(),
          _reload(),
        ],
      ),
    );
  }

  Widget _reload() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Shimmer.fromColors(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),
            baseColor: Color.fromARGB(255, 151, 150, 150),
            highlightColor: Color.fromARGB(255, 221, 221, 219),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.55,
          child: Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 151, 150, 150),
              highlightColor: Color.fromARGB(255, 221, 221, 219),
              child: GridView.builder(
                itemCount: 4,
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
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5)),
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
                                          color:
                                              Color.fromARGB(255, 73, 72, 69)),
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
                                          color:
                                              Color.fromARGB(255, 73, 72, 69)),
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
                                borderRadius: BorderRadius.circular(5)),
                            height: 25,
                            width: 50,
                          )),
                      Positioned(
                          left: MediaQuery.of(context).size.width * 0.25,
                          top: MediaQuery.of(context).size.height * 0.15,
                          right: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 8, 48, 170),
                                borderRadius: BorderRadius.circular(5)),
                            height: 25,
                            width: 80,
                          )),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.02,
                        top: MediaQuery.of(context).size.height * 0.02,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 109, 160, 6),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'For Rent',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 250, 246, 245),
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
        ),
      ],
    );
  }
}
