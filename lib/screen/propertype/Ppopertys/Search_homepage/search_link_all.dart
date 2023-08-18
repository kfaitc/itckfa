// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_is_empty, unused_element, unused_field, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

import '../Detail_Screen/Detail_all_list_sale.dart';

class Homepage_search extends StatefulWidget {
  Homepage_search({super.key, required this.searchFromVerbalDate});

  String? searchFromVerbalDate;

  @override
  State<Homepage_search> createState() => _Homepage_searchState();
}

class _Homepage_searchState extends State<Homepage_search> {
  List<dynamic> _searchResults = [];
  Future<void> _search_all() async {
    var url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/link_all_search?search=${widget.searchFromVerbalDate}');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = json.decode(response.body);
        _searchResults;
      });
    } else {
      throw 'Erorr';
    }
  }

  @override
  void initState() {
    first_time();
    super.initState();
  }

  bool isLoading = true;
  Future<void> first_time() async {
    _pageController = PageController(initialPage: 0);
    isLoading = true;
    await Future.wait([_search_all()]);
    setState(() {
      isLoading = false;
    });
  }

  late PageController _pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Search'),
          backgroundColor: Color.fromARGB(255, 20, 20, 163),
        ),
        body: (isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (_searchResults.length != 0)
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: (_searchResults.length / 10).ceil(),
                            itemBuilder: (context, index) {
                              int startIndex = index * 10;
                              int endIndex =
                                  (startIndex + 10) > _searchResults.length
                                      ? _searchResults.length
                                      : startIndex + 10;
                              List<dynamic> items =
                                  _searchResults.sublist(startIndex, endIndex);
                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  // return Container(
                                  //   height: 100,
                                  //   width: 300,
                                  //   color: Colors.red,
                                  //   child: Text('post${items[index]}'),
                                  // );
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                                          index, items);
                                                      setState(() {
                                                        verbal_ID = items[index]
                                                                ['id_ptys']
                                                            .toString();
                                                        // print(verbal_ID);
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              bottom: 4,
                                                              top: 4),
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.23,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    '${items[index]['url']}'))),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: items[index]
                                                                  ['url']
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
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
                                                              Alignment.center,
                                                          height: 25,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      109,
                                                                      160,
                                                                      6),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Text(
                                                            '${items[index]['type'].toString()}',
                                                            style: TextStyle(
                                                                // fontWeight: FontWeight.bold,
                                                                color: Color
                                                                    .fromARGB(
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
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      29,
                                                                      7,
                                                                      174),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          height: 25,
                                                          width: 50,
                                                          child: Text(
                                                            '${items[index]['urgent'].toString()}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 10,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.15,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              160,
                                                              159,
                                                              168),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      height: 25,
                                                      width: 50,
                                                      child: Text(
                                                        '${items[index]['Name_cummune'].toString()}',
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.015,
                                                            color:
                                                                Colors.white),
                                                      ),
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
                                                      0.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color.fromARGB(
                                                        255, 239, 241, 238),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Price :',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Land :',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'bed :',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'bath :',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  '${items[index]['price'].toString()} \$',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  '${items[index]['land'].toString()} ' +
                                                                      'm' +
                                                                      '\u00B2',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  '${items[index]['bed'].toString()}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  '${items[index]['bath'].toString()}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                                    await Printing.layoutPdf(
                                                                        onLayout: (format) => _generatePdf(
                                                                            format,
                                                                            items,
                                                                            index));
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
                                                                  onPressed:
                                                                      () {
                                                                    detail_property_id(
                                                                        index,
                                                                        items);
                                                                    setState(
                                                                        () {
                                                                      verbal_ID =
                                                                          items[index]['id_ptys']
                                                                              .toString();
                                                                      // print(verbal_ID);
                                                                    });
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
                  )
                : Center(
                    child: Text(
                    'No data',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03),
                  )));
  }

  String? verbal_ID;
  Future<void> detail_property_id(int index, List list) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: verbal_ID.toString(),
          list_get_sale: list,
        ),
      ),
    );
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
                      // pw.Container(
                      //   width: 80,
                      //   height: 50,
                      //   child: pw.Image(
                      //       pw.MemoryImage(
                      //         byteList,
                      //         // bytes1,
                      //       ),
                      //       fit: pw.BoxFit.fill),
                      // ),

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
                    child: pw.Text('${items[index]['Title'] ?? "N/A"}')),
                pw.Text('${items[index]['address'] ?? "N/A"}'),
                pw.SizedBox(height: 10),
                //Big image
                pw.Container(
                  height: 160,
                  width: double.infinity,
                  color: PdfColors.blue100,
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
                          decoration: pw.BoxDecoration(color: PdfColors.red),

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
                            color: PdfColors.yellow,
                          ),

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
                        pw.Text('${items[index]['description'] ?? "N/A"}')
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
