import 'dart:convert';
import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

  bool success_payment = false;
  Future _saved(image, BuildContext context) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
  }

  String? reqTime;
  Future traslation_aba() async {
    DateTime currentDateTime = DateTime.now();
    reqTime = DateFormat('yyyyMMddHHmmss').format(currentDateTime);
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
      "req_time": reqTime,
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
      if (url_qr != null) {
        await openDeepLink(jsonResponse['abapay_deeplink']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future check_traslation_aba() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_transaction/aba'));
    request.body =
        json.encode({"req_time": reqTime, "tran_id": widget.tran_id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        if (jsonResponse['status'] == 0) {
          isChecked = true;
          success_payment = true;
          _showCustomSnackbar("Payment is successfully");
        } else {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Your'),
                content: Text("Payment isn't successfully"),
                actions: <Widget>[
                  TextButton(
                    child: Text('Done'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future openDeepLink(var qrString) async {
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(qrString)) {
        if (Platform.isAndroid) {
          final marketUrl =
              'https://play.google.com/store/apps/details?id=com.paygo24.ibank';
          // ignore: deprecated_member_use
          if (await canLaunch(marketUrl)) {
          } else {
            throw 'Could not open the app store';
          }
        } else if (Platform.isIOS) {
          final marketUrl =
              'https://itunes.apple.com/al/app/aba-mobile-bank/id968860649?mt=8';
          // ignore: deprecated_member_use
          if (await canLaunch(marketUrl)) {
          } else {
            throw 'Could not open the app store';
          }
        }
      } else {
        // ignore: deprecated_member_use
        bool lh = await launch(qrString);
        if (lh == true) {
          await check_traslation_aba();
        }

        // ignore: deprecated_member_use
      }
    } catch (ex) {
      print('Error: $ex');
    }
  }

  Future _showCustomSnackbar(String message) async {
    final snackbar = SnackBar(
      content: Container(
        alignment: Alignment.center,
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 60),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/done.png'),
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
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

              if (success_payment)
                GFCheckboxListTile(
                  titleText: 'Payment Success',
                  size: 20,
                  activeBgColor: Colors.green,
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                  listItemTextColor: const Color.fromARGB(255, 0, 0, 0),
                  type: GFCheckboxType.square,
                  activeIcon: const Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      success_payment = value;
                    });
                  },
                  value: success_payment,
                  inactiveIcon: null,
                ),
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
