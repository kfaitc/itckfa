// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itckfa/afa/customs/readonly.dart';
import 'package:itckfa/contants.dart';
import 'package:itckfa/models/autoVerbal.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class detail_verbal extends StatefulWidget {
  const detail_verbal({super.key, required this.set_data_verbal});
  final String set_data_verbal;
  @override
  State<detail_verbal> createState() => _detail_searchingState();
}

class _detail_searchingState extends State<detail_verbal> {
  List list = [];

  void get_all_autoverbal_by_id() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=${widget.set_data_verbal.toString()}'));

    if (rs.statusCode == 200) {
      setState(() {
        list = jsonDecode(rs.body);
        Land_building();
        image_m =
            'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
        getimage();
      });
    }
  }

  var image_i, get_image = [];
  Future<void> getimage() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_image/${widget.set_data_verbal.toString()}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        get_image = jsonData;
        image_i = get_image[0]['url'];
      });
    }
  }

  var image_m;

  double? total_MIN = 0;
  double? total_MAX = 0;
  List<AutoVerbal_List> data_pdf = [];
  List land = [];
  double? fsvM, fsvN, fx, fn;
  Future<void> Land_building() async {
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=${widget.set_data_verbal.toString()}'));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      for (int i = 0; i < land.length; i++) {
        total_MIN = total_MIN! +
            double.parse(land[i]["verbal_land_minvalue"].toString());
        total_MAX = total_MAX! +
            double.parse(land[i]["verbal_land_maxvalue"].toString());
        // address = land[i]["address"];
        x = x + double.parse(land[i]["verbal_land_maxsqm"].toString());
        n = n + double.parse(land[i]["verbal_land_minsqm"].toString());
      }
      setState(() {
        double c1 =
            (total_MAX! * double.parse(list[0]["verbal_con"].toString())) / 100;
        fsvM = (total_MAX! - c1);
        double c2 =
            (total_MIN! * double.parse(list[0]["verbal_con"].toString())) / 100;
        fsvN = (total_MIN! - c2);

        if (land.length < 1) {
          total_MIN = 0;
          total_MAX = 0;
        } else {
          fx = x * (double.parse(list[0]["verbal_con"].toString()) / 100);
          fn = n * (double.parse(list[0]["verbal_con"].toString()) / 100);
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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void generatePdf() async {
    setState(() {
      Future.delayed(const Duration(seconds: 2), () {
        Printing.layoutPdf(onLayout: (format) => _generatePdf(format));
      });
    });
  }

  @override
  void initState() {
    get_all_autoverbal_by_id();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width * 9;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: (list.length > 0)
          ? SafeArea(
              child: ListView(
                children: [
                  Container(
                    height: 70,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(11),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.chevron_left_outlined,
                              size: 35,
                              color: Colors.white,
                              shadows: [
                                Shadow(blurRadius: 5, color: Colors.purple)
                              ],
                            )),
                        Text(
                          "\t\t\tDetail",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1480,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Column(
                      children: [
                        if (image_i != null)
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          NetworkImage('${image_i.toString()}'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        Box(
                          label: "ID Auto Verbal",
                          iconname: const Icon(
                            Icons.code,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_id"] ?? "",
                        ),
                        Box(
                          label: "Property",
                          iconname: const Icon(
                            Icons.business_outlined,
                            color: kImageColor,
                          ),
                          value: list[0]["property_type_name"] ?? "",
                        ),
                        Box(
                          label: "Bank",
                          iconname: const Icon(
                            Icons.home_work,
                            color: kImageColor,
                          ),
                          value: list[0]["bank_name"] ?? "",
                        ),
                        Box(
                          label: "Branch",
                          iconname: const Icon(
                            Icons.account_tree_rounded,
                            color: kImageColor,
                          ),
                          value: list[0]["bank_branch_name"] ?? "",
                        ),
                        Box(
                          label: "Owner",
                          iconname: const Icon(
                            Icons.person,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_owner"] ?? "",
                        ),
                        Box(
                          label: "Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_contact"] ?? "",
                        ),
                        Box(
                          label: "Date",
                          iconname: const Icon(
                            Icons.calendar_today,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_created_date"].split(" ")[0] ??
                              "N/A",
                        ),
                        Box(
                          label: "Bank Officer",
                          iconname: const Icon(
                            Icons.work,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_bank_officer"] ?? "",
                        ),
                        Box(
                          label: "Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_bank_contact"] ?? "",
                        ),
                        Box(
                          label: "Comment",
                          iconname: const Icon(
                            Icons.comment_sharp,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_comment"] ?? "",
                        ),
                        Box(
                          label: "Verify by",
                          iconname: const Icon(
                            Icons.person_sharp,
                            color: kImageColor,
                          ),
                          value: list[0]["agenttype_name"] ?? "",
                        ),
                        Box(
                          label: "Approve by",
                          iconname: const Icon(
                            Icons.person_outlined,
                            color: kImageColor,
                          ),
                          value: list[0]["approve_name"] ?? "",
                        ),
                        Box(
                          label: "Address",
                          iconname: const Icon(
                            Icons.location_on_rounded,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_address"] ?? "",
                        ),
                        SizedBox(
                          width: 450,
                          height: 270,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < land.length; i++)
                                  Container(
                                    width: 270,
                                    height: 200,
                                    padding: const EdgeInsets.all(7),
                                    margin: const EdgeInsets.all(11),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.black45)
                                      ],
                                      border: Border.all(
                                          width: 1, color: kPrimaryColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 10),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <InlineSpan>[
                                                WidgetSpan(
                                                    child: Icon(
                                                  Icons.location_on_sharp,
                                                  color: kPrimaryColor,
                                                  size: 14,
                                                )),
                                                TextSpan(
                                                    text:
                                                        "${land[i]['address']} "),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        const Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: kPrimaryColor,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            land[i]['verbal_land_type'],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Depreciation",
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  "Area",
                                                  style: Label(),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  'Min Value/Sqm',
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Max Value/Sqm',
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Min Value',
                                                  style: Label(),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  'Min Value',
                                                  style: Label(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 15),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 4),
                                                Text(
                                                  ':   ' +
                                                      land[i]['verbal_land_dp'],
                                                  style: Name(),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  ':   ${formatter.format(double.parse(land[i]['verbal_land_area'].toString()))} m\u00B2',
                                                  style: Name(),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  ':   ${formatter.format(double.parse(land[i]['verbal_land_minsqm'].toString()))} \$',
                                                  style: Name(),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  ':   ${formatter.format(double.parse(land[i]['verbal_land_maxsqm'].toString()))} \$',
                                                  style: Name(),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  ':   ${formatter.format(double.parse(land[i]['verbal_land_minvalue'].toString()))} \$',
                                                  style: Name(),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  ':   ${formatter.format(double.parse(land[i]['verbal_land_maxvalue'].toString()))} \$',
                                                  style: Name(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextLiquidFill(
                    boxHeight: 50,
                    boxBackgroundColor: Color.fromARGB(0, 0, 0, 0),
                    text: widget.set_data_verbal.toString(),
                    waveColor: Colors.blueAccent,
                    loadDuration: const Duration(seconds: 20),
                    loadUntil: 1,
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.deepOrange,
        elevation: 12,
        onPressed: () async {
          await Printing.layoutPdf(
            onLayout: (format) => _generatePdf(format),
            format: PdfPageFormat.a4,
          );
        },
        child: const Icon(Icons.print_outlined),
      ),
    );
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 12);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }

  var formatter = NumberFormat("##,###,###,###", "en_US");
  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    // Create a new PDF document
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.robotoSlabBlack();
    final font1 = await PdfGoogleFonts.tinosRegular();
    final font2 = await PdfGoogleFonts.tinosBold();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo_pdf.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    Uint8List bytes1 =
        (await NetworkAssetBundle(Uri.parse('$image_m')).load('$image_m'))
            .buffer
            .asUint8List();
    Uint8List? bytes2;
    if (image_i != null) {
      bytes2 =
          (await NetworkAssetBundle(Uri.parse('$image_i')).load('$image_i'))
              .buffer
              .asUint8List();
    }

    final pageTheme = await _myPageTheme(format);
    // Add a page to the PDF document
    pdf.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      build: (context) {
        return [
          pw.Column(
            children: [
              pw.Column(
                children: [
                  pw.Container(
                    height: 70,
                    margin: pw.EdgeInsets.only(bottom: 5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: 75,
                          height: 50,
                          child: pw.Image(
                              pw.MemoryImage(
                                byteList,
                                // bytes1,
                              ),
                              fit: pw.BoxFit.fill),
                        ),
                        pw.Text("VERBAL CHECK",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                                font: font)),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Column(
                              children: [
                                pw.Container(
                                  height: 50,
                                  width: 79,
                                  child: pw.BarcodeWidget(
                                      barcode: pw.Barcode.qrCode(),
                                      data:
                                          "https://www.oneclickonedollar.com/#/${list[0]["verbal_id"]}"),
                                ),
                                pw.Text(
                                  'verifications PDF',
                                  style: pw.TextStyle(fontSize: 7, font: font1),
                                )
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Container(
                                  height: 50,
                                  width: 79,
                                  child: pw.BarcodeWidget(
                                      barcode: pw.Barcode.qrCode(),
                                      data:
                                          "https://www.latlong.net/c/?lat=${list[0]['latlong_log']}&long=${list[0]['latlong_la']}"),
                                ),
                                pw.Text(
                                  'location map',
                                  style: pw.TextStyle(fontSize: 7, font: font1),
                                )
                              ],
                            ),
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
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              //color: Colors.red,
                              child: pw.Text(
                                  "DATE: ${list[0]['verbal_created_date'].toString()}",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      font: font1,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 20,
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
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold,
                                      font: font1)),
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
                          flex: 11,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                "Requested Date :${list[0]['verbal_created_date'].toString()} ",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
                            height: 20,
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
                        "Referring to your request letter for verbal check by ${list[0]['bank_name'].toString()} ${list[0]['bank_branch_name'] ?? ""}, we estimated the value of property as below.",
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(font: font1, fontSize: 11)),
                    height: 34,
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
                                style: pw.TextStyle(
                                  fontSize: 11,
                                  font: font1,
                                )),
                            height: 20,
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
                            child: pw.Text(
                                " ${list[0]['property_type_name'] ?? ''}",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
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
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Address : ",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
                            height: 20,
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
                            child: pw.Text(
                                " ${list[0]['verbal_address'] ?? ""}.${list[0]['verbal_khan'] ?? ""}",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
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
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Owner Name ",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
                            height: 20,
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
                                pw.Text("${list[0]['verbal_owner'] ?? ""}",
                                    style: pw.TextStyle(
                                        fontSize: 11, font: font1)),
                            height: 20,
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
                                "Contact No : ${list[0]['verbal_contact'] ?? ""}",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
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
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Bank Officer ",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
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
                            child: pw.Text(" ${list[0]['bank_name'] ?? ""}",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
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
                                "Contact No : ${list[0]['bankcontact'] ?? ""}",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
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
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                "Latitude: ${list[0]['latlong_log'].toString()}",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                "Longtitude: ${list[0]['latlong_la'].toString()}",
                                style: pw.TextStyle(fontSize: 11, font: font1)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 11, font: font1)),
                  pw.SizedBox(height: 5),
                  if (image_i != null)
                    pw.Container(
                      height: 110,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            width: 240,
                            child: pw.Image(
                                pw.MemoryImage(
                                  bytes1,
                                ),
                                fit: pw.BoxFit.fitWidth),
                          ),
                          pw.SizedBox(width: 0.1),
                          pw.Container(
                            width: 240,
                            child: pw.Image(
                                pw.MemoryImage(
                                  bytes2!,
                                ),
                                fit: pw.BoxFit.fitWidth),
                          ),
                        ],
                      ),
                    ),
                  if (image_i == null)
                    pw.Container(
                      width: 240,
                      height: 110,
                      alignment: pw.Alignment.center,
                      child: pw.Image(
                          pw.MemoryImage(
                            bytes1,
                          ),
                          fit: pw.BoxFit.fitWidth),
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
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("DESCRIPTION ",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold,
                                    font: font1)),
                            height: 20,
                          )),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("AREA/sqm ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold,
                                  font: font1)),
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
                          child: pw.Text("MIN/sqm ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold,
                                  font: font1)),
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
                          child: pw.Text("MAX/sqm ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold,
                                  font: font1)),
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
                          child: pw.Text("MIN-VALUE ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold,
                                  font: font1)),
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
                          child: pw.Text("MAX-VALUE ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold,
                                  font: font1)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ])),
                    if (land.length >= 1)
                      for (int index = land.length - 1; index >= 0; index--)
                        pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  land[index]["verbal_land_type"] ?? "",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      font: font1)),
                              height: 20,
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
                              child: pw.Text(
                                  '${formatter.format(double.parse(land[index]["verbal_land_area"].toString()))}/sqm',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      font: font1)),
                              height: 20,
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
                              child: pw.Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      font: font1)),
                              height: 20,
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
                              child: pw.Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_maxsqm"].toString()))}',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      font: font1,
                                      fontWeight: pw.FontWeight.bold)),
                              height: 20,
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
                              child: pw.Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      font: font1)),
                              height: 20,
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
                              child: pw.Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_maxvalue"].toString()))}',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      font: font1)),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                    pw.Container(
                      child: pw.Row(children: [
                        pw.Expanded(
                          flex: 9,
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerRight,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text("Property Value(Estimate) ",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  font: font1,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            height: 20,
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
                            child: pw.Text(
                                'USD ${formatter.format(double.parse(total_MIN.toString()))}',
                                style: pw.TextStyle(fontSize: 10, font: font1)),
                            height: 20,
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
                            child: pw.Text(
                                'USD ${formatter.format(double.parse(total_MAX.toString()))}',
                                style: pw.TextStyle(fontSize: 10, font: font1)),
                            height: 20,
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
                            child: pw.Text(
                                "Force Sale Value ${list[0]['verbal_con'].toString()}% ",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  font: font1,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            height: 20,
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
                            child: pw.Text(
                                "USD ${formatter.format(fsvN ?? double.parse('0.00'))}",
                                style: pw.TextStyle(fontSize: 10, font: font1)),
                            height: 20,
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
                            child: pw.Text(
                                'USD ${formatter.format(fsvM ?? double.parse('0.00'))}',
                                style: pw.TextStyle(fontSize: 10, font: font1)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                      ]),
                    ),
                    //  ដកចេញសិន
                    // pw.Container(
                    //   child: pw.Row(children: [
                    //     pw.Expanded(
                    //       flex: 5,
                    //       child: pw.Container(
                    //         padding: const pw.EdgeInsets.all(2),
                    //         alignment: pw.Alignment.centerLeft,
                    //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                    //         child: pw.Text("Force Sale Value: ",
                    //             style: pw.TextStyle(
                    //               fontSize: 11,
                    //               font: font1,
                    //               fontWeight: pw.FontWeight.bold,
                    //             )),
                    //         height: 20,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //     pw.Expanded(
                    //       flex: 2,
                    //       child: pw.Container(
                    //         padding: const pw.EdgeInsets.all(2),
                    //         alignment: pw.Alignment.centerLeft,
                    //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                    //         child: pw.Text("${fn ?? '0.00'}",
                    //             style: pw.TextStyle(fontSize: 11, font: font1)),
                    //         height: 20,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //     pw.Expanded(
                    //       flex: 2,
                    //       child: pw.Container(
                    //         padding: const pw.EdgeInsets.all(2),
                    //         alignment: pw.Alignment.centerLeft,
                    //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                    //         child: pw.Text("${fx ?? '0.00'}",
                    //             style: pw.TextStyle(fontSize: 11, font: font1)),
                    //         height: 20,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //     pw.Expanded(
                    //       flex: 4,
                    //       child: pw.Container(
                    //         padding: pw.EdgeInsets.all(2),
                    //         alignment: pw.Alignment.centerLeft,
                    //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                    //         height: 20,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //   ]),
                    // ),
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
                                "COMMENT: ${list[0]['verbal_comment'] ?? ''}",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: font1)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                      ]),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Text("Valuation fee : ",
                          style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              font: font1)),
                      height: 20,
                      //color: Colors.blue,
                    ),
                  ])),
                  pw.SizedBox(height: 5),
                  pw.Text(
                      '*Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.',
                      style: pw.TextStyle(fontSize: 6, font: font1)),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                              'Verbal Check Replied By:${list[0]['username'].toString()} ',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 7,
                                  font: font1),
                              textAlign: pw.TextAlign.right),
                          pw.SizedBox(height: 4),
                          pw.Text(' ${list[0]['tel_num'].toString()}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: font1,
                                fontSize: 11,
                              ),
                              textAlign: pw.TextAlign.center),
                        ],
                      ),
                    ],
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
                            style: pw.TextStyle(
                                color: PdfColors.blue,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 11,
                                font: font1)),
                      ]),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Hotline: 099 283 388',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                    font: font1)),
                            pw.Row(children: [
                              pw.Text('H/P : (+855)23 988 855/(+855)23 999 761',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 7,
                                      font: font1)),
                            ]),
                            pw.Row(children: [
                              pw.Text('Email : info@kfa.com.kh',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 7,
                                      font: font1)),
                            ]),
                            pw.Row(children: [
                              pw.Text('Website: www.kfa.com.kh',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 7,
                                      font: font1)),
                            ]),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                                'Villa #36A, Street No4, (Borey Peng Hout The Star',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                    font: font1)),
                            pw.Text('Natural 371) Sangkat Chak Angrae Leu,',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                    font: font1)),
                            pw.Text(
                                'Khan Mean Chey, Phnom Penh City, Cambodia,',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                    font: font1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ];
      },
    ));

    // Get the bytes of the PDF document
    final pdfBytes = pdf.save();

    // Print the PDF document to the default printer
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    return pdf.save();
  }
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/Letter En-Kh.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 1.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 1.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    // theme: pw.ThemeData.withFont(
    //   base: await PdfGoogleFonts.openSansRegular(),
    //   bold: await PdfGoogleFonts.openSansBold(),
    //   icons: await PdfGoogleFonts.materialIcons(),
    // ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: bgShape),
      );
    },
  );
}
