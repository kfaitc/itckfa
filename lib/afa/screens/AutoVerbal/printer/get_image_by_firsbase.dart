// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_const_constructors, unnecessary_null_comparison, unused_local_variable, unused_field, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../contants.dart';
import '../../../../screen/Customs/responsive.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Get_Image_By_Firbase extends StatefulWidget {
  final int i;
  final String? com_id;
  final String? fsv;
  final String? image;
  final String? image_map;
  final String property_check;
  const Get_Image_By_Firbase({
    super.key,
    required this.fsv,
    required this.i,
    required this.com_id,
    required this.property_check,
    this.image,
    this.image_map,
  });
  @override
  State<Get_Image_By_Firbase> createState() => _Get_Image_By_FirbaseState();
}

class _Get_Image_By_FirbaseState extends State<Get_Image_By_Firbase> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var list = [];

  bool isApiCallProcess = false;
  void Load1() async {
    setState(() {});
    var code = widget.com_id.toString();
    print("Load 1  = " + code);
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list?verbal_id=$code'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;

        getUser();
      });
    }
  }

  void Load2() async {
    var code = widget.com_id;
    print("Load 2  = " + code!);
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbals/list?verbal_id=$code'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;

        getUser();
      });
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var name_user, tel, get_user = [];
  void getUser() async {
    var id;
    setState(() {
      id = list[0]["verbal_user"];
    });
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        get_user = jsonData;
        name_user = get_user[0]['username'];
        tel = get_user[0]['tel_num'];
      });
    }
  }

  var image_i = '';

  var image_m = '';

  int i = 0;
  static int? total_MIN = 0;
  static int? total_MAX = 0;
  List land = [];
  late double fsvM, fsvN, fx, fn;
  late int k;
  @override
  void initState() {
    // _stream = Get_Image_Map.snapshots();
    // _stream1 = Get_Image_Pho.snapshots();
    if (widget.property_check == '1') {
      image_i = widget.image!;
      image_m = widget.image_map!;
      Load1();
    } else {
      image_i = widget.image!;
      image_m = widget.image_map!;
      Load2();
    }

    // Get_land();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(235, 8, 11, 161),
        centerTitle: true,
        title: const Text("Printing to PDF..."),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  total_MAX = 0;
                  total_MIN = 0;
                  fsvM = 0;
                  fsvN = 0;
                  fx = 0;
                  fn = 0;
                });
                generatePdf(widget.i, widget.fsv!);
              },
              icon: Icon(
                Icons.print_outlined,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Responsive(
          mobile: print_pdf(context),
          tablet: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: print_pdf(context),
                    ),
                  ],
                ),
              )
            ],
          ),
          desktop: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: print_pdf(context),
                    ),
                  ],
                ),
              )
            ],
          ),
          phone: print_pdf(context),
        ),
      ),
    );
  }

  Column print_pdf(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
      children: [
        list.length > 0
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 40),
                          Icon(
                            Icons.qr_code,
                            color: kImageColor,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.com_id!,
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),

                      // ignore: sized_box_for_whitespace
                      //dropdown(),
                      // PropertyDropdown(),

                      Box(
                        label: "Property",
                        iconname: Icon(
                          Icons.business_outlined,
                          color: kImageColor,
                        ),
                        value: list[0]["property_type_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Bank",
                        iconname: Icon(
                          Icons.home_work,
                          color: kImageColor,
                        ),
                        value: list[0]["bank_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Branch",
                        iconname: Icon(
                          Icons.account_tree_rounded,
                          color: kImageColor,
                        ),
                        value: list[0]["bank_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Owner",
                        iconname: Icon(
                          Icons.person,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_owner"] ?? "N/A",
                      ),
                      Box(
                        label: "Contact",
                        iconname: Icon(
                          Icons.phone,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_contact"] ?? "N/A",
                      ),
                      Box(
                        label: "Date",
                        iconname: Icon(
                          Icons.calendar_today,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_created_date"].split(" ")[0] ??
                            "N/A",
                      ),
                      Box(
                        label: "Bank Officer",
                        iconname: Icon(
                          Icons.work,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_bank_officer"] ?? "N/A",
                      ),
                      Box(
                        label: "Contact",
                        iconname: Icon(
                          Icons.phone,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_bank_contact"] ?? "N/A",
                      ),

                      Box(
                        label: "Comment",
                        iconname: Icon(
                          Icons.comment_sharp,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_comment"] ?? "N/A",
                      ),
                      Box(
                        label: "Verify by",
                        iconname: Icon(
                          Icons.person_sharp,
                          color: kImageColor,
                        ),
                        value: list[0]["agenttype_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Approve by",
                        iconname: Icon(
                          Icons.person_outlined,
                          color: kImageColor,
                        ),
                        value: list[0]["approve_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Address",
                        iconname: Icon(
                          Icons.location_on_rounded,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_address"] ?? "N/A",
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      (widget.image != null)
                          ? Container(
                              // color: Colors.blue[50],
                              margin: EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.network(widget.image!),
                            )
                          : SizedBox(),
                      (widget.image_map != null)
                          ? Container(
                              margin: EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.network(widget.image_map!),
                            )
                          : SizedBox(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            total_MAX = 0;
                            total_MIN = 0;
                            fsvM = 0;
                            fsvN = 0;
                            fx = 0;
                            fn = 0;
                            image_i;
                            image_m;
                          });
                          generatePdf(widget.i, widget.fsv!);
                        },
                        child: Container(
                            height: 50,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.print,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Print Now...',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),

                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50.0),
                child: CircularProgressIndicator(),
              )
      ],
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String fsv) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final ByteData bytes_image =
        await rootBundle.load('assets/images/message-banner3.jpg');
    final Uint8List byteList_image = bytes_image.buffer.asUint8List();
    Uint8List bytes1 = (await NetworkAssetBundle(Uri.parse(widget.image_map!))
            .load(widget.image_map!))
        .buffer
        .asUint8List();
    Uint8List bytes2 =
        (await NetworkAssetBundle(Uri.parse(widget.image!)).load(widget.image!))
            .buffer
            .asUint8List();
    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Column(
          children: [
            pw.Container(
              color: PdfColors.blue100,
              height: 70,
              margin: pw.EdgeInsets.only(bottom: 5),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    width: 80,
                    height: 70,
                    child: pw.Image(
                        pw.MemoryImage(
                          byteList,
                          // bytes1,
                        ),
                        fit: pw.BoxFit.fill),
                  ),
                  pw.Text("VERBAL CHECK",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 26)),
                  pw.Container(
                    height: 50,
                    width: 79,
                    child: pw.BarcodeWidget(
                        barcode: pw.Barcode.qrCode(),
                        data:
                            "https://www.latlong.net/c/?lat=${list[0]['latlong_log']}&long=${list[0]['latlong_la']}"),
                  ),
                ],
              ),
            ),
            pw.Container(
              // pw.padding: const EdgeInsets.all(9),
              child: pw.Column(
                children: [
                  pw.Container(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            //color: Colors.red,
                            child: pw.Text(
                                "DATE: ${list[0]['verbal_created_date']}",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold)),
                            height: 25,
                            //color: Colors.white,
                          ),
                        ),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                "CODE: ${list[0]['verbal_id'].toString()}",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold)),
                            height: 25,
                            //color: Colors.yellow,
                          ),
                        )
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 8,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                "Requested Date :${list[0]['verbal_created_date'].toString()} ",
                                style: pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(2),
                    alignment: pw.Alignment.centerLeft,
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Text(
                        "Referring to your request letter for verbal check by ${list[0]['bank_name']}, we estimated the value of property as below.",
                        overflow: pw.TextOverflow.clip),
                    height: 30,
                    //color: Colors.blue,
                  ),
                  pw.SizedBox(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Property Information: ",
                                style: pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 6,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("${list[0]['property_type_name']}",
                                style: pw.TextStyle(fontSize: 12)),
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
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Address : ",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 6,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("${list[0]['verbal_address']}",
                                style: const pw.TextStyle(fontSize: 12)),
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
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Owner Name ",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child:
                                // name rest with api
                                pw.Text("${list[0]['verbal_owner']}",
                                    style: const pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            // name rest with api
                            child: pw.Text(
                                "Contact No : ${list[0]['verbal_contact'].toString()} ",
                                style: const pw.TextStyle(fontSize: 12)),
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
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Bank Officer ",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 30,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("${list[0]['bank_name']}",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 30,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                "Contact No : ${list[0]['bankcontact'].toString()}",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 30,
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
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Latitude ",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("${list[0]['latlong_log']}",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Longtitude ",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 25,
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
                                "${list[0]['latlong_la'].toString()} ",
                                style: const pw.TextStyle(fontSize: 12)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: 12)),
                  pw.Container(
                    height: 120,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: 228,
                          child: pw.Image(
                              pw.MemoryImage(
                                bytes1,
                              ),
                              fit: pw.BoxFit.fitWidth),
                        ),
                        // pw.SizedBox(width: 0.1),
                        pw.Container(
                          width: 228,
                          child: pw.Image(
                              pw.MemoryImage(
                                bytes2,
                              ),
                              fit: pw.BoxFit.fitWidth),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Container(
                    child: pw.Column(children: [
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("DESCRIPTION: ",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
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
                              child: pw.Text("AREA/sqm: ",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
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
                              child: pw.Text("MIN/sqm: ",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
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
                              child: pw.Text("MAX/sqm: ",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
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
                              child: pw.Text("MIN-VALUE: ",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
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
                              child: pw.Text("MAX-VALUE: ",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      if (land.length >= 1)
                        pw.ListView.builder(
                          itemCount: land.length,
                          itemBuilder: (Context, index) {
                            return pw.Container(
                              child: pw.Row(children: [
                                pw.Expanded(
                                  flex: 3,
                                  child: pw.Container(
                                    padding: pw.EdgeInsets.all(2),
                                    alignment: pw.Alignment.centerLeft,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Text(
                                        land[index]["verbal_land_type"] ??
                                            "N/A",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold)),
                                    height: 25,
                                    //color: Colors.blue,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    padding: pw.EdgeInsets.all(2),
                                    alignment: pw.Alignment.centerLeft,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Text(
                                        land[index]["verbal_land_area"] ??
                                            "N/A",
                                        style: pw.TextStyle(
                                            fontSize: 11,
                                            fontWeight: pw.FontWeight.bold)),
                                    height: 25,
                                    //color: Colors.blue,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    padding: pw.EdgeInsets.all(2),
                                    alignment: pw.Alignment.centerLeft,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Text(
                                        land[index]["verbal_land_minsqm"] ??
                                            "N/A",
                                        style: pw.TextStyle(
                                            fontSize: 11,
                                            fontWeight: pw.FontWeight.bold)),
                                    height: 25,
                                    //color: Colors.blue,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    padding: pw.EdgeInsets.all(2),
                                    alignment: pw.Alignment.centerLeft,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Text(
                                        land[index]["verbal_land_maxsqm"] ??
                                            "N/A",
                                        style: pw.TextStyle(
                                            fontSize: 11,
                                            fontWeight: pw.FontWeight.bold)),
                                    height: 25,
                                    //color: Colors.blue,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    padding: pw.EdgeInsets.all(2),
                                    alignment: pw.Alignment.centerLeft,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Text(
                                        land[index]["verbal_land_minvalue"] ??
                                            "N/A",
                                        style: pw.TextStyle(
                                            fontSize: 11,
                                            fontWeight: pw.FontWeight.bold)),
                                    height: 25,
                                    //color: Colors.blue,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    padding: pw.EdgeInsets.all(2),
                                    alignment: pw.Alignment.centerLeft,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Text(
                                        land[index]["verbal_land_maxvalue"] ??
                                            "N/A",
                                        style: pw.TextStyle(
                                            fontSize: 11,
                                            fontWeight: pw.FontWeight.bold)),
                                    height: 25,
                                    //color: Colors.blue,
                                  ),
                                ),
                              ]),
                            );
                          },
                        ),
                      //////////////
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 9,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Property Value(Estimate) ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(total_MIN.toString(),
                                  style: pw.TextStyle(fontSize: 11)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(total_MAX.toString(),
                                  style: pw.TextStyle(fontSize: 11)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 9,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              // ទាយយក forceSale from  ForceSaleAndValuation
                              child: pw.Text("Force Sale Value ${fsv}% ",
                                  style: const pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(fsvN.toString(),
                                  style: pw.TextStyle(fontSize: 11)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(fsvM.toString(),
                                  style: const pw.TextStyle(fontSize: 11)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 5,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Force Sale Value: ",
                                  style: const pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 25,
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
                              child: pw.Text("$fn",
                                  style: const pw.TextStyle(fontSize: 11)),
                              height: 25,
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
                              child: pw.Text("${fx}",
                                  style: const pw.TextStyle(fontSize: 11)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 4,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 11,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  "COMMENT: ${list[0]['verbal_comment']}",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Valuation:  ",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 9,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("",
                                  style: pw.TextStyle(fontSize: 11)),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
                '*Note : The land building size based on the bank officer provided, in case the land and building size are wrong provided when we have the actual size inspect, we are not response on this case.'),
            pw.Text('Verbal Check Replied By:${name_user}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.right),
            pw.Text('${tel}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.right),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
                  style: pw.TextStyle(
                      color: PdfColors.blue,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12)),
            ]),
            pw.Row(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Hotline: 077 997 888',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Row(children: [
                      pw.Text('H/P : (+855)23 988 855/(+855)23 999 761',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]),
                    pw.Row(children: [
                      pw.Text('Email : info@kfa.com.kh',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]),
                    pw.Row(children: [
                      pw.Text('Website: www.kfa.com.kh',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]),
                  ],
                ),
                pw.SizedBox(width: 10),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Villa #36A, Street No4, (Borey Peng Hout The Star',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Natural 371) Sangkat Chak Angrae Leu,',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Khan Mean Chey, Phnom Penh City, Cambodia,',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        )
      ];
    }));

    return pdf.save();
  }

  void generatePdf(int i, String fsv) {
    setState(() {
      if (widget.property_check == '1') {
        Land1(
            list[0]['verbal_id'].toString(), list[0]['verbal_con'].toString());
      } else {
        Land2(
            list[0]['verbal_id'].toString(), list[0]['verbal_con'].toString());
      }
      Future.delayed(const Duration(seconds: 2), () {
        Printing.layoutPdf(onLayout: (format) => _generatePdf(format, fsv));
      });
    });
  }

  void Land1(String i, String fsv) async {
    double x = 0, n = 0;
    var jsonData;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=$i'));
    if (rs.statusCode == 200) {
      jsonData = jsonDecode(rs.body);
      land = jsonData;
      setState(() {
        // print("Land === ${land.length}");

        for (int i = 0; i < land.length; i++) {
          total_MIN = total_MIN! + int.parse(land[i]["verbal_land_minvalue"]);
          total_MAX = total_MAX! + int.parse(land[i]["verbal_land_maxvalue"]);
          // address = land[i]["address"];
          x = x + int.parse(land[i]["verbal_land_maxsqm"]);
          n = n + int.parse(land[i]["verbal_land_minsqm"]);
        }
        fsvM = (total_MAX! * double.parse(fsv)) / 100;
        fsvN = (total_MIN! * double.parse(fsv)) / 100;

        if (land.length < 1) {
          total_MIN = 0;
          total_MAX = 0;
        } else {
          fx = x * (double.parse(fsv) / 100);
          fn = n * (double.parse(fsv) / 100);
        }

        print("Total mix ${total_MAX}");
      });
    }
  }

  void Land2(String i, String fsv) async {
    double x = 0, n = 0;
    var jsonData;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbals/list_land?verbal_landid=$i'));
    if (rs.statusCode == 200) {
      jsonData = jsonDecode(rs.body);
      land = jsonData;
      setState(() {
        for (int i = 0; i < land.length; i++) {
          total_MIN = total_MIN! + int.parse(land[i]["verbal_land_minvalue"]);
          total_MAX = total_MAX! + int.parse(land[i]["verbal_land_maxvalue"]);
          // address = land[i]["address"];
          x = x + int.parse(land[i]["verbal_land_maxsqm"]);
          n = n + int.parse(land[i]["verbal_land_minsqm"]);
        }
        fsvM = (total_MAX! * double.parse(fsv)) / 100;
        fsvN = (total_MIN! * double.parse(fsv)) / 100;

        if (land.length < 1) {
          total_MIN = 0;
          total_MAX = 0;
        } else {
          fx = x * (double.parse(fsv) / 100);
          fn = n * (double.parse(fsv) / 100);
        }

        print("Total mix ${total_MAX}");
      });
    }
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 14, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 15, fontWeight: FontWeight.bold);
  }
}

class Box extends StatelessWidget {
  final String label;
  final String value;
  final Widget iconname;

  const Box({
    Key? key,
    required this.label,
    required this.iconname,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: TextFormField(
        // controller: controller,
        initialValue: value,
        readOnly: true,

        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: label,
          prefixIcon: iconname,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
