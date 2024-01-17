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
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:async';

class detail_verbal_by_id extends StatefulWidget {
  const detail_verbal_by_id({super.key, required this.id_verbal});
  final String id_verbal;
  @override
  State<detail_verbal_by_id> createState() => _detail_searchingState();
}

class _detail_searchingState extends State<detail_verbal_by_id> {
  List list = [];

  int? total_MIN = 0;
  int? total_MAX = 0;
  List<AutoVerbal_List> data_pdf = [];
  List land = [];
  double? fsvM, fsvN, fx, fn;
  void get_verbal_by_id() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbals/list?verbal_id=${widget.id_verbal.toString()}',),);
    double x = 0, n = 0;
    if (rs.statusCode == 200) {
      setState(() {
        list = jsonDecode(rs.body)['verbal'];
        image_m =
            'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
        land = jsonDecode(rs.body)['land_building'];
        for (int i = 0; i < land.length; i++) {
          total_MIN = total_MIN! +
              int.parse(land[i]["verbal_land_minvalue"].toString());
          total_MAX = total_MAX! +
              int.parse(land[i]["verbal_land_maxvalue"].toString());
          // address = land[i]["address"];
          x = x + int.parse(land[i]["verbal_land_maxsqm"].toString());
          n = n + int.parse(land[i]["verbal_land_minsqm"].toString());
        }
        setState(() {
          fsvM = (total_MAX! * double.parse(list[0]["verbal_con"].toString())) /
              100;
          fsvN = (total_MIN! * double.parse(list[0]["verbal_con"].toString())) /
              100;

          if (land.isEmpty) {
            total_MIN = 0;
            total_MAX = 0;
          } else {
            fx = x * (double.parse(list[0]["verbal_con"].toString()) / 100);
            fn = n * (double.parse(list[0]["verbal_con"].toString()) / 100);
          }
        });
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

  var formatter = NumberFormat("##,###,###,###.00", "en_US");

  @override
  void initState() {
    get_verbal_by_id();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: (list.isNotEmpty)
          ? SafeArea(
              child: ListView(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(20),),
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
                            ),),
                        const Text(
                          '\t\tDetail',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.network(
                            'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Box(
                          label: "ID Auto Verbal",
                          iconname: const Icon(
                            Icons.code,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_id"].toString(),
                        ),
                        Box(
                          label: "Property",
                          iconname: const Icon(
                            Icons.business_outlined,
                            color: kImageColor,
                          ),
                          value: list[0]["property_type_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Bank",
                          iconname: const Icon(
                            Icons.home_work,
                            color: kImageColor,
                          ),
                          value: list[0]["bank_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Branch",
                          iconname: const Icon(
                            Icons.account_tree_rounded,
                            color: kImageColor,
                          ),
                          value: list[0]["bank_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Owner",
                          iconname: const Icon(
                            Icons.person,
                            color: kImageColor,
                          ),
                          value: (list[0]["verbal_owner"] == "")
                              ? "N/A"
                              : list[0]["verbal_owner"],
                        ),
                        Box(
                          label: "Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: (list[0]["verbal_contact"] == "")
                              ? "N/A"
                              : list[0]["verbal_contact"],
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
                          value: (list[0]["verbal_bank_officer"] == "")
                              ? "N/A"
                              : list[0]["verbal_bank_officer"],
                        ),
                        Box(
                          label: "Bank Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: (list[0]["verbal_bank_contact"] == "")
                              ? "N/A"
                              : list[0]["verbal_bank_contact"],
                        ),
                        Box(
                          label: "Comment",
                          iconname: const Icon(
                            Icons.comment_sharp,
                            color: kImageColor,
                          ),
                          value: (list[0]["verbal_comment"] == "")
                              ? "N/A"
                              : list[0]["verbal_comment"],
                        ),
                        Box(
                          label: "Verify by",
                          iconname: const Icon(
                            Icons.person_sharp,
                            color: kImageColor,
                          ),
                          value: list[0]["agenttype_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Approve by",
                          iconname: const Icon(
                            Icons.person_outlined,
                            color: kImageColor,
                          ),
                          value: list[0]["approve_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Phum ",
                          iconname: const Icon(
                            Icons.location_on_rounded,
                            color: kImageColor,
                          ),
                          value: (list[0]["verbal_address"] == "")
                              ? "N/A"
                              : list[0]["verbal_address"],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 290,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Row(
                              children: [
                                for (int i = 0; i < land.length; i++)
                                  Container(
                                    width: 270,
                                    height: 280,
                                    padding: const EdgeInsets.all(7),
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.black45,)
                                      ],
                                      border: Border.all(
                                          width: 1, color: kPrimaryColor,),
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 10,),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <InlineSpan>[
                                                const WidgetSpan(
                                                    child: Icon(
                                                  Icons.location_on_sharp,
                                                  color: kPrimaryColor,
                                                  size: 14,
                                                ),),
                                                TextSpan(
                                                    text:
                                                        "${list[0]['district_name']} ",),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                overflow:
                                                    TextOverflow.ellipsis,),
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
                                                  "Description",
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  "Floor / Type",
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  "Area",
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
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
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Min Value',
                                                  style: Label(),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ':   ',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${land[i]['verbal_land_des']}',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_area'])}'
                                                          ' m' '\u00B2',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_minsqm'])}' '\$',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_maxsqm'])}' '\$',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_minvalue'])}' '\$',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_maxvalue'])}\$',
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
                    boxWidth: MediaQuery.of(context).size.width * 1,
                    boxBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
                    text: widget.id_verbal.toString(),
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
    return const TextStyle(color: kPrimaryColor, fontSize: 12);
  }

  TextStyle Name() {
    return const TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold,);
  }

  TextStyle NameProperty() {
    return const TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold,);
  }

  var image_m;
  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    // Create a new PDF document
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final pageTheme = await _myPageTheme(format);
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo_pdf.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    Uint8List bytes1 =
        (await NetworkAssetBundle(Uri.parse('$image_m')).load('$image_m'))
            .buffer
            .asUint8List();

    // Add a page to the PDF document
    pdf.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      build: (context) {
        return [
          pw.Column(
            children: [
              pw.Container(
                height: 70,
                margin: const pw.EdgeInsets.only(bottom: 5),
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
                          fit: pw.BoxFit.fill,),
                    ),
                    pw.Text("VERBAL CHECK",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 20,),),
                    pw.Container(
                      height: 50,
                      width: 79,
                      child: pw.BarcodeWidget(
                          barcode: pw.Barcode.qrCode(),
                          data:
                              "https://www.latlong.net/c/?lat=${list[0]['latlong_log']}&long=${list[0]['latlong_la']}",),
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
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          //color: Colors.red,
                          child: pw.Text(
                              "DATE: ${list[0]['verbal_created_date'].toString()}",
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,),),
                          height: 25,
                          //color: Colors.white,
                        ),
                      ),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              "CODE: ${list[0]['verbal_id'].toString()}",
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,),),
                          height: 25,
                          //color: Colors.yellow,
                        ),
                      ),
                    ],),)
                  ],)
                ],),
              ),
              pw.SizedBox(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 8,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "Requested Date :${list[0]['verbal_created_date'].toString()} ",
                            style: const pw.TextStyle(fontSize: 12),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(2),
                alignment: pw.Alignment.centerLeft,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    "Referring to your request letter for verbal check by ${list[0]['bank_name'].toString()}, we estimated the value of property as below.",
                    overflow: pw.TextOverflow.clip,
                    style: const pw.TextStyle(fontSize: 10),),
                height: 26,
                //color: Colors.blue,
              ),
              pw.SizedBox(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Property Information ",
                            style: const pw.TextStyle(fontSize: 12),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            list[0]['property_type_name'].toString(),
                            style: const pw.TextStyle(fontSize: 12),),
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
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Address  ",
                            style: const pw.TextStyle(fontSize: 12),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "${list[0]['district_name']} ${(list[0]['verbal_address'] == "") ? "" : ' ${list[0]['verbal_address']}'}",
                            style: const pw.TextStyle(fontSize: 12),),
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
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Owner Name ",
                            style: const pw.TextStyle(fontSize: 12),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child:
                            // name rest with api
                            pw.Text(list[0]['verbal_owner'].toString(),
                                style: const pw.TextStyle(fontSize: 12),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        // name rest with api
                        child: pw.Text(
                            "Contact No : ${list[0]['verbal_contact'].toString()}",
                            style: const pw.TextStyle(fontSize: 12),),
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
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Bank Officer ",
                            style: const pw.TextStyle(fontSize: 12),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(list[0]['bank_name'].toString(),
                            style: const pw.TextStyle(fontSize: 9),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "Contact No : ${list[0]['bankcontact'].toString()}",
                            style: const pw.TextStyle(fontSize: 9),),
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
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "Latitude ${list[0]['latlong_log'].toString()}",
                            style: const pw.TextStyle(fontSize: 12),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "Longtitude ${list[0]['latlong_la'].toString()}",
                            style: const pw.TextStyle(fontSize: 12),),
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
                  style: const pw.TextStyle(fontSize: 12),),
              pw.Container(
                height: 130,
                width: 450,
                child: pw.Image(
                    pw.MemoryImage(
                      bytes1,
                    ),
                    fit: pw.BoxFit.fitWidth,),
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
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("DESCRIPTION ",
                            style: pw.TextStyle(
                                fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                        height: 25,
                      ),),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Text("AREA/sqm ",
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                      height: 25,
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
                              fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                      height: 25,
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
                              fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                      height: 25,
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
                              fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                      height: 25,
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
                              fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                      height: 25,
                      //color: Colors.blue,
                    ),
                  ),
                ],),),
                if (land.isNotEmpty)
                  pw.ListView.builder(
                    itemCount: land.length,
                    itemBuilder: (Context, index) {
                      return pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  land[index]["verbal_land_type"] ?? "N/A",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,),),
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
                                  " ${formatter.format(land[index]["verbal_land_area"]).toString()}/sqm",
                                  style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,),),
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
                                  "USD ${formatter.format(land[index]["verbal_land_minsqm"]).toString()}/sqm",
                                  style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,),),
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
                                  "USD ${formatter.format(land[index]["verbal_land_maxsqm"]).toString()}",
                                  style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,),),
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
                                  "USD  ${formatter.format(land[index]["verbal_land_minvalue"]).toString()}",
                                  style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,),),
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
                                  "USD ${formatter.format(land[index]["verbal_land_maxvalue"]).toString()}",
                                  style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,),),
                              height: 25,
                              //color: Colors.blue,
                            ),
                          ),
                        ],),
                      );
                    },
                  ),
                pw.Container(
                  child: pw.Row(children: [
                    pw.Expanded(
                      flex: 9,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Property Value(Estimate) ",
                            style: const pw.TextStyle(
                              fontSize: 11,
                            ),),
                        height: 25,
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
                            "USD ${formatter.format(total_MIN).toString()}",
                            style: const pw.TextStyle(fontSize: 9),),
                        height: 25,
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
                            "USD  ${formatter.format(total_MAX).toString()}",
                            style: const pw.TextStyle(fontSize: 9),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                  ],),
                ),
                pw.Container(
                  child: pw.Row(children: [
                    pw.Expanded(
                      flex: 9,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        // ទាយយក forceSale from  ForceSaleAndValuation
                        child: pw.Text(
                            "Force Sale Value ${list[0]['verbal_con'].toString()}% ",
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(fsvN.toString(),
                            style: const pw.TextStyle(fontSize: 11),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(fsvM.toString(),
                            style: const pw.TextStyle(fontSize: 11),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                  ],),
                ),
                pw.Container(
                  child: pw.Row(children: [
                    pw.Expanded(
                      flex: 5,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Force Sale Value: ",
                            style: const pw.TextStyle(
                              fontSize: 11,
                            ),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("$fn",
                            style: const pw.TextStyle(fontSize: 11),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("$fx",
                            style: const pw.TextStyle(fontSize: 11),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 4,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                  ],),
                ),
                pw.Container(
                  child: pw.Row(children: [
                    pw.Expanded(
                      flex: 11,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "COMMENT: ${list[0]['verbal_comment'].toString()}",
                            style: pw.TextStyle(
                                fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                  ],),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  alignment: pw.Alignment.centerLeft,
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Text("Valuation fee :  ",
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold,),),
                  height: 25,
                  //color: Colors.blue,
                )
              ],),),
              pw.SizedBox(height: 5),
              pw.Text(
                  '*Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 7,),),
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
                              'Verbal Check Replied By:${list[0]['agenttype_name'].toString()} ',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 7,
                              ),
                              textAlign: pw.TextAlign.right,),
                          pw.SizedBox(height: 4),
                          pw.Text(' ${list[0]['agent_type_phone'].toString()}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9,
                              ),
                              textAlign: pw.TextAlign.center,),
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
                              fontSize: 9,
                            ),),
                      ],),
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
                                ),),
                            pw.Row(children: [
                              pw.Text('H/P : (+855)23 988 855/(+855)23 999 761',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                  ),),
                            ],),
                            pw.Row(children: [
                              pw.Text('Email : info@kfa.com.kh',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                  ),),
                            ],),
                            pw.Row(children: [
                              pw.Text('Website: www.kfa.com.kh',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                  ),),
                            ],),
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
                                ),),
                            pw.Text('Natural 371) Sangkat Chak Angrae Leu,',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 7,
                                ),),
                            pw.Text(
                                'Khan Mean Chey, Phnom Penh City, Cambodia,',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 7,
                                ),),
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
    ),);

    // Get the bytes of the PDF document
    final pdfBytes = pdf.save();

    // Print the PDF document to the default printer
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes,);
    return pdf.save();
  }
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/Letter En-Kh.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 1.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 1.0 * PdfPageFormat.cm,);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.tinosRegular(),
      bold: await PdfGoogleFonts.tinosBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: bgShape),
      );
    },
  );
}
