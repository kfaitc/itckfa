// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import '../../../../models/autoVerbal.dart';
import '../../screen/Profile/components/Drop.dart';
import 'colors.dart';

class PDfButton extends StatefulWidget {
  PDfButton(
      {super.key,
      required this.check,
      required this.title,
      required this.list,
      required this.i,
      required this.imagelogo,
      required this.type,
      required this.listUser,
      required this.iconpdfcolor,
      required this.position,
      this.verbalID});
  final List list;
  final int i;
  final String imagelogo;
  final OnChangeCallback check;
  final String title;
  final Color iconpdfcolor;
  final OnChangeCallback type;
  final bool position;
  final List listUser;
  String? verbalID;

  @override
  State<PDfButton> createState() => _PDfButtonState();
}

class _PDfButtonState extends State<PDfButton> {
  Future<void> mainwaiting(id) async {
    await Printing.layoutPdf(
      onLayout: (format) => _generatePdf(format, id),
      format: PdfPageFormat.a4,
    );
    setState(() {
      click = false;
    });
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();
  Future<void> submitAgent() async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/submit_agents/${widget.list[0]['verbal_id']}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );
    // if (response.statusCode == 200) {
    //   _firestore.collection('submitAgent').add({
    //     'verbal_id': widget.verbalID,
    //     'client_Name': widget.listUser[0]['username'].toString(),
    //     'clientID': widget.listUser[0]['control_user'].toString(),
    //     'agent_id': "",
    //     'agent_name': "",
    //     'create_Date': now.toString(),
    //     'submit': 3,
    //   });
    //   Get.snackbar(
    //     "Done",
    //     "Please wait from agent 1hour/1day",
    //     colorText: Colors.black,
    //     padding:
    //         const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
    //     borderColor: const Color.fromARGB(255, 48, 47, 47),
    //     borderWidth: 1.0,
    //     borderRadius: 5,
    //     backgroundColor: const Color.fromARGB(255, 235, 242, 246),
    //     icon: const Icon(Icons.add_alert),
    //   );
    //   Navigator.pop(context);
    // } else {
    //   print(response.statusMessage);
    // }
  }

  var formatter = NumberFormat("##,###,###,###", "en_US");
  double totalMIN = 0;
  double totalMAX = 0;
  List<AutoVerbal_List> dataPdf = [];
  List land = [];
  double? fsvM, fsvN, fx, fn;
  Future<void> landBuilding(id) async {
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=$id'));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      if (land.isNotEmpty) {
        for (int i = 0; i < land.length; i++) {
          totalMIN = totalMIN +
              int.parse(land[i]["verbal_land_minvalue"].toStringAsFixed(0));
          totalMAX = totalMAX +
              int.parse(land[i]["verbal_land_maxvalue"].toStringAsFixed(0));
          // address = land[i]["address"];
          String x1 = land[i]["verbal_land_maxsqm"].toStringAsFixed(0);
          String n1 = land[i]["verbal_land_maxsqm"].toStringAsFixed(0);
          x = x + int.parse(x1);
          n = n + int.parse(n1);
        }
        setState(() {
          fsvM = (totalMAX *
                  double.parse(
                      widget.list[widget.i]["verbal_con"].toString())) /
              100;
          fsvN = (totalMIN *
                  double.parse(
                      widget.list[widget.i]["verbal_con"].toString())) /
              100;

          if (land.length < 1) {
            totalMIN = 0;
            totalMAX = 0;
          } else {
            fx = x *
                (double.parse(widget.list[widget.i]["verbal_con"].toString()) /
                    100);
            fn = n *
                (double.parse(widget.list[widget.i]["verbal_con"].toString()) /
                    100);
          }
          for (int i = 0; i < land.length - 1; i++) {
            for (int j = i + 1; j < land.length; j++) {
              if (land[i]['verbal_land_type'] == 'LS') {
                var t = land[i];
                land[i] = land[j];
                land[j] = t;
              }
            }
          }
        });
      }
    }
  }

  Uint8List? getbytes1;
  bool checkimage = false;
  String? bytes2;
  List listImage = [];

  Future<void> getimage(id) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=$id',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List list = jsonDecode(json.encode(response.data));
      setState(() {
        bytes2 = list[0]['verbal_image'].toString();
        print("===> Image Sucess : $id");
      });
    }
  }

  Future<void> getimageMap(double lat, double log) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${(log > lat) ? "$lat,$log" : "$log,$lat"}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(log > lat) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      getbytes1 = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return click
        ? const Center(child: CircularProgressIndicator())
        : (widget.title != "")
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 90),
                        Card(
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: whiteColor,
                            ),
                            height: 320,
                            width: 280,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.highlight_remove_outlined,
                                          size: 30,
                                        )),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Specail Option',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color:
                                          Color.fromARGB(255, 105, 103, 103)),
                                ),

                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/save_image.png',
                                            height: 35,
                                            fit: BoxFit.fitHeight),
                                        const SizedBox(height: 20),
                                        Image.asset(
                                            'assets/images/icon_pdf.png',
                                            height: 35,
                                            fit: BoxFit.fitHeight),
                                        const SizedBox(height: 20),
                                        Image.asset(
                                            'assets/images/agent_icon.png',
                                            height: 35,
                                            fit: BoxFit.fitHeight),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              click = true;
                                            });
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute<void>(
                                            //     builder: (BuildContext
                                            //             context) =>
                                            //         save_image_after_add_verbal(
                                            //       listUser: widget.listUser,
                                            //       type: (value) {
                                            //         setState(() {
                                            //           widget.type(value);
                                            //         });
                                            //         // Navigator.pop(context);
                                            //       },
                                            //       //set_data_verbal: '',
                                            //       verbalId: widget
                                            //           .list[widget.i]
                                            //               ['verbal_id']
                                            //           .toString(),
                                            //       i: 0,
                                            //       list: widget.list,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 7, 142, 227),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Text(
                                              "Save Image",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              click = true;
                                            });

                                            await getimage(widget.list[widget.i]
                                                    ['verbal_id']
                                                .toString());

                                            await getimageMap(
                                                widget.list[widget.i]
                                                    ['latlong_la'],
                                                widget.list[widget.i]
                                                    ['latlong_log']);
                                            checkimage = true;

                                            await landBuilding(widget
                                                .list[widget.i]['verbal_id']
                                                .toString());
                                            if (checkimage == true) {
                                              await mainwaiting(widget
                                                  .list[widget.i]['verbal_id']
                                                  .toString());
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 197, 9, 9),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Text(
                                              "PDF",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            submitAgent();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 6, 31, 223),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Text(
                                              "Submit to agent",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       Navigator.pop(context);
                                //       widget.type(100);
                                //     });
                                //   },
                                //   child: Container(
                                //     alignment: Alignment.center,
                                //     height: 35,
                                //     width: 100,
                                //     decoration: BoxDecoration(
                                //       color: const Color.fromARGB(
                                //           255, 83, 83, 83),
                                //       border: Border.all(
                                //           width: 1, color: Colors.black),
                                //       borderRadius:
                                //           BorderRadius.circular(10),
                                //     ),
                                //     child: const Text(
                                //       "Add New",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 14,
                                //           color: Colors.white),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : InkWell(
                onTap: () async {
                  setState(() {
                    click = true;
                  });

                  await getimage(widget.list[widget.i]['verbal_id'].toString());

                  await getimageMap(widget.list[widget.i]['latlong_la'],
                      widget.list[widget.i]['latlong_log']);
                  checkimage = true;

                  await landBuilding(
                      widget.list[widget.i]['verbal_id'].toString());
                  if (checkimage == true) {
                    await mainwaiting(
                        widget.list[widget.i]['verbal_id'].toString());
                  }
                },
                child: Icon(
                  size: 25,
                  Icons.picture_as_pdf,
                  color: widget.iconpdfcolor,
                ));
  }

  bool click = false;
  Future<Uint8List> _generatePdf(PdfPageFormat format, id) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);

    // final pageTheme = await _myPageTheme(format);
    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Column(
          children: [
            pw.Column(
              children: [
                pw.Container(
                  height: 70,
                  margin: const pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Estimate Property",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          )),
                      pw.Row(
                        children: [
                          // pw.Column(
                          //   mainAxisAlignment: pw.MainAxisAlignment.center,
                          //   children: [
                          //     pw.Stack(
                          //       alignment: pw.Alignment.center,
                          //       children: [
                          //         pw.BarcodeWidget(
                          //           barcode: pw.Barcode.qrCode(
                          //             errorCorrectLevel:
                          //                 pw.BarcodeQRCorrectionLevel.high,
                          //           ),
                          //           data:
                          //               "https://oneclickonedollar.com/#/KFA_Security_PDF/$id",
                          //           width: 50,
                          //           height: 50,
                          //         ),
                          //         if (bytesLogo != null)
                          //           pw.Container(
                          //             color: PdfColors.white,
                          //             width: 10,
                          //             height: 10,
                          //             child: pw.Image(
                          //                 pw.MemoryImage(
                          //                   bytesLogo,
                          //                   // bytes1,
                          //                 ),
                          //                 fit: pw.BoxFit.fill),
                          //           ),
                          //       ],
                          //     ),
                          //     pw.Text(
                          //       'Verify Pdf',
                          //       style: const pw.TextStyle(fontSize: 10),
                          //     )
                          //   ],
                          // ),
                          pw.SizedBox(width: 30),
                          pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Stack(
                                alignment: pw.Alignment.center,
                                children: [
                                  pw.BarcodeWidget(
                                    barcode: pw.Barcode.qrCode(
                                      errorCorrectLevel:
                                          pw.BarcodeQRCorrectionLevel.high,
                                    ),
                                    data:
                                        "https://www.latlong.net/c/?lat=${widget.list[widget.i]['latlong_log']}&long=${widget.list[widget.i]['latlong_la']}",
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              pw.Text(
                                'location map',
                                style: pw.TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
                          )
                          // pw.Column(
                          //   mainAxisAlignment: pw.MainAxisAlignment.center,
                          //   children: [
                          //     pw.Stack(
                          //       alignment: pw.Alignment.center,
                          //       children: [
                          //         pw.BarcodeWidget(
                          //           barcode: pw.Barcode.qrCode(
                          //             errorCorrectLevel:
                          //                 pw.BarcodeQRCorrectionLevel.high,
                          //           ),
                          //           data:
                          //               "https://www.latlong.net/c/?lat=${widget.list[widget.i]['latlong_log']}&long=${widget.list[widget.i]['latlong_la']}",
                          //           width: 50,
                          //           height: 50,
                          //         ),
                          //         if (bytesLogo != null)
                          //           pw.Container(
                          //             color: PdfColors.white,
                          //             width: 10,
                          //             height: 10,
                          //             child: pw.Image(
                          //                 pw.MemoryImage(
                          //                   bytesLogo,
                          //                   // bytes1,
                          //                 ),
                          //                 fit: pw.BoxFit.fill),
                          //           ),
                          //       ],
                          //     ),
                          //     pw.Text(
                          //       'Location Map',
                          //       style: const pw.TextStyle(fontSize: 10),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  child: pw.Column(children: [
                    pw.Column(children: [
                      pw.Container(
                          child: pw.Row(children: [
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                                color: PdfColor.fromInt(
                                    const Color.fromRGBO(22, 72, 130, 1)
                                        .value)),
                            //color: Colors.red,
                            child: pw.Text(
                              "DATE: ${widget.list[widget.i]['verbal_created_date'].toString()}",
                              style: const pw.TextStyle(
                                  fontSize: 11,
                                  //fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                            height: 20,
                            //color: Colors.white,
                          ),
                        ),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                                color: PdfColor.fromInt(
                                    const Color.fromRGBO(22, 72, 130, 1)
                                        .value)),
                            child: pw.Text(
                                "CODE: ${widget.list[widget.i]['verbal_id'].toString()}",
                                style: const pw.TextStyle(
                                    fontSize: 11,
                                    //fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.white)),
                            height: 20,
                            //color: Colors.yellow,
                          ),
                        ),
                      ]))
                    ])
                  ]),
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              "Latitude: ${widget.list[widget.i]['latlong_la'].toString()}",
                              style: const pw.TextStyle(
                                fontSize: 11,
                              )),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              "Longtitude: ${widget.list[widget.i]['latlong_log'].toString()}",
                              style: const pw.TextStyle(
                                fontSize: 11,
                              )),
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
                        flex: 12,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(width: 0.4)),
                          child: pw.Text(
                              " ${widget.list[widget.i]['verbal_address'] ?? ""}.${widget.list[widget.i]['verbal_khan'] ?? ""}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 11,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                if (bytes2.toString() != "No")
                  // pw.Text('bytes2 != null')
                  pw.Row(
                    children: [
                      pw.Container(
                        height: 150,
                        width: 240,
                        child: pw.Image(
                            pw.MemoryImage(
                              getbytes1!,
                            ),
                            fit: pw.BoxFit.cover),
                      ),
                      pw.SizedBox(width: 2),
                      pw.Container(
                        width: 240,
                        height: 150,
                        child: pw.Image(
                            pw.MemoryImage(
                              base64Decode(bytes2.toString()),
                            ),
                            fit: pw.BoxFit.cover),
                      ),
                    ],
                  )
                else
                  // pw.Text('bytes2 == null'),
                  pw.Row(children: [
                    pw.Container(
                      height: 150,
                      width: 480,
                      child: pw.Image(
                          pw.MemoryImage(
                            getbytes1!,
                          ),
                          fit: pw.BoxFit.cover),
                    ),
                  ]),
                pw.SizedBox(height: 5),
                pw.Container(
                    child: pw.Column(children: [
                  pw.Container(
                      child: pw.Row(children: [
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                              color: PdfColor.fromInt(
                                  const Color.fromRGBO(22, 72, 130, 1).value)),
                          child: pw.Text("DESCRIPTION ",
                              style: const pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 11,
                                //fontWeight: pw.FontWeight.bold,
                              )),
                          height: 20,
                        )),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("AREA/sqm ",
                            style: const pw.TextStyle(
                                fontSize: 11,
                                // fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MIN/sqm ",
                            style: const pw.TextStyle(
                                fontSize: 11,
                                //fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MAX/sqm ",
                            style: const pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 11,
                              //fontWeight: pw.FontWeight.bold,
                            )),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MIN-VALUE ",
                            style: const pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 11,
                              //fontWeight: pw.FontWeight.bold,
                            )),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MAX-VALUE ",
                            style: const pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 11,
                              // fontWeight: pw.FontWeight.bold,
                            )),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                  ])),
                  if (land.length >= 1)
                    for (int index = land.length - 1; index >= 0; index--)
                      pw.Row(children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child:
                                pw.Text(land[index]["verbal_land_des"] ?? "N/A",

                                    // "NNNNNN",
                                    style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                '${formatter.format(double.parse(land[index]["verbal_land_area"].toString()))}/sqm',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_maxsqm"].toString()))}',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_maxvalue"].toString()))}',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                      ]),
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 8,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerRight,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Property Value(Estimate) ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ]),

                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              'USD ${formatter.format(double.parse(totalMIN.toString()))}',
                              style: const pw.TextStyle(fontSize: 9)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              'USD ${formatter.format(double.parse(totalMAX.toString()))}',
                              style: const pw.TextStyle(fontSize: 9)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                  ),
                ])),
              ],
            ),
            pw.SizedBox(height: 30),
          ],
        ),
      ];
    }));

    return pdf.save();
  }
}
