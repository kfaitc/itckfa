import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
// ignore: unused_import
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:itckfa/screen/Home/Home.dart';
import 'package:screenshot/screenshot.dart';
import 'package:barcode_widget/barcode_widget.dart';

class save_image_after_add_verbal extends StatefulWidget {
  const save_image_after_add_verbal({super.key, required this.set_data_verbal});
  final String set_data_verbal;
  @override
  State<save_image_after_add_verbal> createState() =>
      _save_image_after_add_verbalState();
}

// ignore: camel_case_types
class _save_image_after_add_verbalState
    extends State<save_image_after_add_verbal> {
  List list = [];
  ScreenshotController screenshotController = ScreenshotController();
  void get_all_autoverbal_by_id() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=${widget.set_data_verbal.toString()}'));

    if (rs.statusCode == 200) {
      setState(() {
        list = jsonDecode(rs.body);
        Land_building();
        image_m =
            'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=18&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
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

  var formatter = NumberFormat("##,###,###,###", "en_US");
  var formatter1 = NumberFormat("###.#####", "en_US");
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

  Future _saved(image, BuildContext context) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
  }

  @override
  void initState() {
    get_all_autoverbal_by_id();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage1(id: list[0]['id'].toString())));
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        title: const Text("Get Photo like this"),
      ),
      body: (list.isNotEmpty && land.length >= 1)
          ? Screenshot(
              controller: screenshotController,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/Letter En-Kh.png'))),
                child: ListView(
                  children: [
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 75,
                              height: 50,
                              child: Image.asset(
                                  'assets/images/New_KFA_Logo_pdf.png')),
                          const Text("VERBAL CHECK",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      BarcodeWidget(
                                        barcode: Barcode.qrCode(
                                          errorCorrectLevel:
                                              BarcodeQRCorrectionLevel.high,
                                        ),
                                        data:
                                            "https://www.oneclickonedollar.com/#/${list[0]["verbal_id"]}",
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: 10,
                                        height: 10,
                                        child: Image.asset(
                                          'assets/images/New_KFA_Logo.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'verifications PNG',
                                    style: TextStyle(
                                      fontSize: 6,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      BarcodeWidget(
                                        barcode: Barcode.qrCode(
                                          errorCorrectLevel:
                                              BarcodeQRCorrectionLevel.high,
                                        ),
                                        data:
                                            'https://www.latlong.net/c/?lat=${list[0]['latlong_log']}&long=${list[0]['latlong_la']}',
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: 10,
                                        height: 10,
                                        child: Image.asset(
                                          'assets/images/New_KFA_Logo.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'location map',
                                    style: TextStyle(
                                      fontSize: 6,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(children: [
                      Row(children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            alignment: Alignment.centerLeft,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.4)),
                            height: 18,
                            //color: Colors.red,
                            child: Text(
                                "DATE: ${list[0]['verbal_created_date'].toString()}",
                                style: const TextStyle(
                                    fontSize: 7, fontWeight: FontWeight.bold)),
                            //color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            alignment: Alignment.centerLeft,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.4)),
                            height: 18,
                            child:
                                Text("CODE: ${list[0]['verbal_id'].toString()}",
                                    style: const TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                    )),
                            //color: Colors.yellow,
                          ),
                        ),
                      ])
                    ]),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  "Requested Date :${list[0]['verbal_created_date'].toString()} ",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(border: Border.all(width: 0.4)),
                      height: 17,
                      child: Text(
                          "Referring to your request letter for verbal check by ${list[0]['bank_name'].toString()}, we estimated the value of property as below.",
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 6)),
                      //color: Colors.blue,
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: const Text("Property Information: ",
                                  style: TextStyle(
                                    fontSize: 7,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  " ${list[0]['property_type_name'] ?? ''}",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              height: 18,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              child: const Text("Address : ",
                                  style: TextStyle(
                                    fontSize: 7,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              height: 18,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              child: Text(
                                  " ${list[0]['verbal_address'] ?? ""}.${list[0]['verbal_khan'] ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              height: 18,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              child: const Text("Owner Name ",
                                  style: TextStyle(
                                    fontSize: 7,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(" ${list[0]['verbal_owner'] ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),

                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              // name rest with api
                              child: Text(
                                  "Contact No : ${list[0]['verbal_contact'] ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 30,
                              child: const Text("Bank Officer ",
                                  style: TextStyle(
                                    fontSize: 7,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 30,
                              child: Text(" ${list[0]['bank_name'] ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 30,
                              child: Text(
                                  "Contact No : ${list[0]['bankcontact'] ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              height: 18,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              child: Text(
                                  "Latitude: ${formatter1.format(list[0]['latlong_log'])}",
                                  style: const TextStyle(
                                    fontSize: 7,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              height: 18,
                              decoration: 
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              child: Text(
                                  "Longtitude: ${formatter1.format(list[0]['latlong_la'])}",
                                  style: const TextStyle(fontSize: 7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 7,
                        )),
                    const SizedBox(height: 6),
                    if (image_i != null)
                      SizedBox(
                        height: 90,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholderFit: BoxFit.fill,
                                placeholder: 'assets/earth.gif',
                                image: image_i.toString(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              flex: 2,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholderFit: BoxFit.fill,
                                placeholder: 'assets/earth.gif',
                                image: image_m.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (image_i == null)
                      SizedBox(
                        height: 90,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.fill,
                          placeholder: 'assets/earth.gif',
                          image: image_m.toString(),
                        ),
                      ),
                    const SizedBox(height: 5),
                    Row(children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.4)),
                            height: 18,
                            child: const Text("DESCRIPTION ",
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: const Text("AREA/sqm ",
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              )),
                          //color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: const Text("MIN/sqm ",
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              )),
                          //color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: const Text("MAX/sqm ",
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              )),
                          //color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: const Text("MIN-VALUE ",
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              )),
                          //color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center, height: 18,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          child: const Text("MAX-VALUE ",
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              )),

                          //color: Colors.blue,
                        ),
                      ),
                    ]),

                    for (int index = land.length - 1; index >= 0; index--)
                      SizedBox(
                        height: 18,
                        child: Row(children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(land[index]["verbal_land_type"] ?? "",
                                  style: const TextStyle(
                                    fontSize: 5,
                                    fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  '${formatter.format(double.parse(land[index]["verbal_land_area"].toString()))}/sqm',
                                  style: const TextStyle(
                                    fontSize: 5,
                                    fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
                                  style: const TextStyle(
                                    fontSize: 5,
                                    fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_maxsqm"].toString()))}',
                                  style: const TextStyle(
                                      fontSize: 5,
                                      fontWeight: FontWeight.bold)),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
                                  style: const TextStyle(
                                    fontSize: 5,
                                    fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  'USD ${formatter.format(double.parse(land[index]["verbal_land_maxvalue"].toString()))}',
                                  style: const TextStyle(
                                    fontSize: 5,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ]),
                      ),
                    Row(children: [
                      Expanded(
                        flex: 9,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: const Text("Property Value(Estimate) ",
                              style: TextStyle(
                                fontSize: 6,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerLeft,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: Text(
                              'USD ${formatter.format(double.parse(total_MIN.toString()))}',
                              style: const TextStyle(
                                fontSize: 6,
                              )),
                          //color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerLeft,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: Text(
                              'USD ${formatter.format(double.parse(total_MAX.toString()))}',
                              style: const TextStyle(
                                fontSize: 6,
                              )),
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                    Container(
                      child: Row(children: [
                        Expanded(
                          flex: 9,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            alignment: Alignment.centerLeft,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.4)),
                            // ទាយយក forceSale from  ForceSaleAndValuation
                            child: Text(
                                "Force Sale Value ${list[0]['verbal_con'].toString()}% ",
                                style: TextStyle(
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                )),
                            height: 18,
                            //color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment.centerLeft,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.4)),
                            height: 18,
                            child: Text(
                                "USD ${formatter.format(fsvN ?? double.parse('0.00'))}",
                                style: const TextStyle(
                                  fontSize: 6,
                                )),
                            //color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment.centerLeft,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.4)),
                            child: Text(
                                'USD ${formatter.format(fsvM ?? double.parse('0.00'))}',
                                style: TextStyle(
                                  fontSize: 6,
                                )),
                            height: 18,
                            //color: Colors.blue,
                          ),
                        ),
                      ]),
                    ),
                    //  ដកចេញសិន
                    // Container(
                    //   child: Row(children: [
                    //     Expanded(
                    //       flex: 6,
                    //       child: Container(
                    //         padding: const EdgeInsets.all(2),
                    //         alignment: Alignment.centerLeft,
                    //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                    //         child: Text("Force Sale Value: ",
                    //             style: TextStyle(
                    //               fontSize: 6,
                    //               ,
                    //               fontWeight: FontWeight.bold,
                    //             )),
                    //         height: 18,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 2,
                    //       child: Container(
                    //         padding: const EdgeInsets.all(2),
                    //         alignment: Alignment.centerLeft,
                    //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                    //         child: Text("${fn ?? '0.00'}",
                    //             style: TextStyle(fontSize: 6, )),
                    //         height: 18,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 2,
                    //       child: Container(
                    //         padding: const EdgeInsets.all(2),
                    //         alignment: Alignment.centerLeft,
                    //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                    //         child: Text("${fx ?? '0.00'}",
                    //             style: TextStyle(fontSize: 6, )),
                    //         height: 18,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 4,
                    //       child: Container(
                    //         padding: EdgeInsets.all(2),
                    //         alignment: Alignment.centerLeft,
                    //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                    //         height: 18,
                    //         //color: Colors.blue,
                    //       ),
                    //     ),
                    //   ]),
                    // ),
                    Container(
                      child: Row(children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment.centerLeft,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.4)),
                            child: Text(
                                "COMMENT: ${list[0]['verbal_comment'] ?? ''}",
                                style: TextStyle(
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                )),
                            height: 18,
                            //color: Colors.blue,
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(width: 0.4)),
                      height: 18,
                      child: const Text("Valuation fee : ",
                          style: TextStyle(
                            fontSize: 6,
                            fontWeight: FontWeight.bold,
                          )),
                      //color: Colors.blue,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                        '*Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.',
                        style: TextStyle(
                          fontSize: 5,
                        )),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    'Verbal Check Replied By:${list[0]['username'].toString()} ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 6,
                                    ),
                                    textAlign: TextAlign.right),
                                const SizedBox(height: 4),
                                Text(' ${list[0]['tel_num'].toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 6,
                                    ),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 6,
                                  )),
                            ]),
                        SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Hotline: 099 283 388',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 6,
                                      )),
                                  Row(children: [
                                    Text(
                                        'H/P : (+855)23 988 855/(+855)23 999 761',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 6,
                                        )),
                                  ]),
                                  Row(children: [
                                    Text('Email : info@kfa.com.kh',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 6,
                                        )),
                                  ]),
                                  Row(children: [
                                    Text('Website: www.kfa.com.kh',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 6,
                                        )),
                                  ]),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Villa #36A, Street No4, (Borey Peng Hout The Star',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 6,
                                      )),
                                  Text('Natural 371) Sangkat Chak Angrae Leu,',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 6,
                                      )),
                                  Text(
                                      'Khan Mean Chey, Phnom Penh City, Cambodia,',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 6,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await screenshotController
              .capture(delay: const Duration(milliseconds: 10))
              .then((capturedImage) async {
            await _saved(capturedImage, context);
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage1(id: list[0]['id'].toString())));
          }).catchError((onError) {
            print(onError);
          });
        },
        child: const Icon(Icons.screenshot),
      ),
    );
  }
}
