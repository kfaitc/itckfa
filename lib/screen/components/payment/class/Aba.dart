import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;

class ABA extends StatefulWidget {
  const ABA(
      {super.key,
      required this.price,
      required this.option,
      required this.id_set_use,
      required this.tran_id});
  final String price;
  final String option;
  final String id_set_use;
  final String tran_id;
  @override
  State<ABA> createState() => _ABAState();
}

class _ABAState extends State<ABA> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isChecked = false;

  var url_qr;

  var success_payment;
  Future _saved(image, BuildContext context) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
  }

  Future traslation_aba() async {
    var count_number = widget.option.split(' ');
    var thier_plan;
    if (count_number[4] == "Day") {
      thier_plan = 1;
    } else if (count_number[4] == "Week") {
      thier_plan = 7;
    } else if (count_number[4] == "Mount") {
      thier_plan = 30;
    }
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/transaction/aba'));
    request.body = json.encode({
      "tran_id": widget.tran_id,
      "firstname": "virak",
      "lastname": "oum",
      "phone": "+855966519115",
      "amount": widget.price,
      "payment_option": "abapay_khqr_deeplink",
      "return_url":
          "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_upay/6467/${widget.id_set_use}/${widget.price}/${thier_plan}"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        print("\nkokok" +
            widget.option +
            "\nkokok" +
            jsonResponse['qr_string'].toString());
        url_qr = jsonResponse['qr_string'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    traslation_aba();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(49, 27, 146, 1),
              )),
          title: Text(
            "Scan for payments",
            style: TextStyle(
                color: const Color.fromRGBO(49, 27, 146, 1),
                fontSize: MediaQuery.textScaleFactorOf(context) * 18,
                fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await screenshotController
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    await _saved(capturedImage, context);
                    const snackBar = SnackBar(
                      content: Text('Photo saved'),
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }).catchError((onError) {
                    // print(onError);
                  });
                },
                icon: const Icon(
                  Icons.photo_camera_back_outlined,
                  color: Color.fromRGBO(49, 27, 146, 1),
                  size: 35,
                  shadows: [
                    Shadow(
                        offset: Offset(3, -3),
                        blurRadius: 5,
                        color: Colors.black54)
                  ],
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.13,
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/New_KFA_Logo_pdf.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              if (url_qr != null)
                Screenshot(
                  controller: screenshotController,
                  child: Container(
                    height: 465,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(top: 65),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/logoqr.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\t\t\t\t\t\t\t\tKFA",
                          style: TextStyle(
                              color: const Color.fromRGBO(121, 121, 121, 1),
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 20),
                        ),
                        Text(
                          "\t\t\t\t\t\t\t\t${widget.price ?? ""} \$",
                          style: TextStyle(
                              color: const Color.fromRGBO(63, 63, 63, 1),
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 20),
                        ),
                        //  Text(
                        //   '------------------------------------------------',
                        //   style: TextStyle(
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),

                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 45),
                          child: Center(
                            child: BarcodeWidget(
                                width: 226,
                                height: 226,
                                barcode: Barcode.qrCode(),
                                data: url_qr,
                                color: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  height: 400,
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 50,
                child: Text(
                  'Scan with Bakong App Or Mobile Banking app that support KHQR',
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      color: const Color.fromRGBO(158, 158, 158, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 10),
                ),
              ),
              // if (success_payment)
              //   GFCheckboxListTile(
              //     titleText: 'Payment Success',
              //     size: 20,
              //     activeBgColor: Colors.green,
              //     color: Colors.white,
              //     margin:
              //         const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
              //     listItemTextColor: const Color.fromARGB(255, 0, 0, 0),
              //     type: GFCheckboxType.square,
              //     activeIcon: const Icon(
              //       Icons.check,
              //       size: 15,
              //       color: Colors.white,
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         success_payment = value;
              //       });
              //     },
              //     value: success_payment,
              //     inactiveIcon: null,
              //   ),
              //============================================================================================================
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                    ),
                    // Text(' ${count.toString()}'),
                    Text(
                      " ${widget.price} USD",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 50,
                endIndent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'V-Point',
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                    ),
                    Text(
                      " ${widget.option}",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  '................................................................................................................................',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                    ),
                    Text(
                      " ${widget.price} USD",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ));
  }
}
