// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, prefer_adjacent_string_concatenation, avoid_print, unused_local_variable, must_be_immutable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Detail_property_sale_all extends StatefulWidget {
  List? list_get_sale;

  String? verbal_ID;
  Detail_property_sale_all({
    super.key,
    required this.verbal_ID,
    required this.list_get_sale,
  });

  @override
  State<Detail_property_sale_all> createState() => _Detail_propertyState();
}

class _Detail_propertyState extends State<Detail_property_sale_all> {
  int? myMatch;
  String? verbal;
  late Map<String, dynamic> myElement;
  @override
  void initState() {
    super.initState();

    List<int> myNumbers = widget.verbal_ID!.split(',').map(int.parse).toList();
    int myId = int.parse(widget.verbal_ID!);
    for (int num in myNumbers) {
      if (num == myId) {
        myMatch = num;
        break;
      }
    }
    print(myMatch);

    myElement = widget.list_get_sale!
        .firstWhere((element) => element['id_ptys'] == myMatch);

    print(myElement);

    // print('verbal : ${myElement['id_ptys'].toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 51, 27, 185),
        centerTitle: true,
        // title: Text('${indexN}'),${widget.list2_Sale_id![indexN!]['price']
        // title: Text('ID = ${widget.list_get_sale![indexN!]['id_ptys']}'),
        title: Text('VerbalID = ${myMatch.toString()}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              int id_pa = index;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  // child: Image.network(
                                  //   list2_Sale223![index]['url']
                                  //       .toString(),
                                  // ),
                                  child: CachedNetworkImage(
                                    imageUrl: myElement['url'].toString(),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(width: 5),
                            borderRadius:
                                BorderRadius.circular(20), //<-- SEE HERE
                          ),
                          // child: Image.network(
                          //   '${list2_Sale223![index]['url']}',
                          //   fit: BoxFit.cover,
                          // )
                          child: CachedNetworkImage(
                            imageUrl: myElement['url'].toString(),
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          // child: Image.network(
                          //   '${list2_Sale4[index]['url'].toString()}',
                          //   // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/propery_sale/22.jpg',
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 8, 111, 129),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: Text(
                            '${myElement['Name_cummune']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      (myElement != null)
                          ? Positioned(
                              top: MediaQuery.of(context).size.height * 0.13,
                              left: 10,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    color: Color.fromARGB(255, 23, 8, 123),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 35,
                                width: 90,
                                child: Text(
                                  "${(myElement['urgent']) ?? "N/A"} ",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                      color: Colors.white),
                                ),
                              ))
                          : SizedBox(),
                      Positioned(
                          top: 50,
                          left: 10,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Color.fromARGB(255, 25, 127, 13),
                                borderRadius: BorderRadius.circular(5)),
                            height: 35,
                            width: 90,
                            child: Text(
                              "${myElement['type']}",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.019,
                                  color: Colors.white),
                            ),
                          )),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.22,
                        left: 15,
                        bottom: 10,
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              // child: Image.network(
                                              //   list2_Sale223![index]['url']
                                              //       .toString(),
                                              // ),
                                              child: CachedNetworkImage(
                                                imageUrl: myElement['url_1']
                                                    .toString(),
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
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 235, 227, 227)),
                                        // image: DecorationImage(
                                        //     image: NetworkImage(
                                        //         list2_Sale22![index]['url']
                                        //             .toString()),
                                        //     fit: BoxFit.cover),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: myElement['url_1'].toString(),
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              // child: Image.network(
                                              //   list2_Sale223![index]['url']
                                              //       .toString(),
                                              // ),
                                              child: CachedNetworkImage(
                                                imageUrl: myElement['url_2']
                                                    .toString(),
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
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 235, 227, 227)),
                                        // image: DecorationImage(
                                        //     image: NetworkImage(
                                        //         list2_Sale22![index]['url']
                                        //             .toString()),
                                        //     fit: BoxFit.cover),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: myElement['url_2'].toString(),
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ]),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      // height: MediaQuery.of(context).size.height * 0.47,
                      // width: double.infinity,
                      // decoration: BoxDecoration(
                      //     border: Border.all(width: 2),
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Color.fromARGB(255, 248, 247, 247)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.price_change_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Price :',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.landslide_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'land :',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.square_foot_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'sqm :',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bed_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'bed :',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bathroom_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'bath :',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.type_specimen_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'type :',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    // SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.019,
                                    // ),
                                  ],
                                ),

                                //  list[index]["verbal_address"] !=
                                //                     null
                                //                 ? list[index]["verbal_address"]
                                //                 : "N/A",
                                Column(
                                  children: [
                                    Text(
                                      '${myElement['price'] ?? "N/A"} \$',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.023,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.024,
                                    ),
                                    Text(
                                      '${myElement['land'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.023,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Text(
                                      '${myElement['sqm'] ?? "N/A"} ' +
                                          'm' +
                                          '\u00B2',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.023,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Text(
                                      '${myElement['bed'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.023,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Text(
                                      '${myElement['bath'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.023,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                    Text(
                                      '${myElement['type'] ?? "N/A"}',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.023,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.019,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.019,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.add_home_work_sharp,
                                  size:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'address',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 4,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${myElement['address'] ?? "N/A"}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
