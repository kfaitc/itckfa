import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/screen/Home/Home.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ABA extends StatefulWidget {
  const ABA(
      {super.key,
      required this.price,
      required this.option,
      required this.id_set_use,
      required this.tran_id,
      required this.set_email,
      required this.set_phone});
  final String price;
  final String option;
  final String id_set_use;
  final String tran_id;
  final String set_email;
  final String set_phone;
  @override
  State<ABA> createState() => _ABAState();
}

class _ABAState extends State<ABA> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isChecked = false;
  int _secondsRemaining = 600;
  late Timer _timer;
  var url_qr;
  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (_secondsRemaining == 0) {
          timer.cancel();
          // Do something when the countdown is complete
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      },
    );
  }

  // ignore: unused_element
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    // if (minutes % 2 == 0) {
    //   const snackBar = SnackBar(
    //     content: Text('Please process your payment'),
    //     duration: Duration(seconds: 4),
    //   );
    //   // ignore: use_build_context_synchronously
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void fetchData() async {
    // Simulating an asynchronous operation, like a network request
    await Future.delayed(Duration(seconds: 2), () {
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          print("\nData loaded successfully!\n");
        });
      }
    });
  }

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
      // "firstname": "${widget.id_set_use.toString()}",
      // "lastname": "$thier_plan",
      "email": "${widget.set_email}",
      "phone": "${widget.set_phone}",
      "amount": widget.price,
      "payment_option": "abapay_khqr_deeplink",
      "return_url":
          "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_pay/6467/${widget.id_set_use}/${widget.price}/${thier_plan}?amount=${widget.price}&orderId=${widget.tran_id}"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        url_qr = jsonResponse['checkout_qr_url'];
        print("\n\tran_id = ${widget.tran_id}\n\n\n${jsonResponse}\n");
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
    var data =
        json.encode({"req_time": "$reqTime", "tran_id": "${widget.tran_id}"});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_transaction/aba',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      var data = response.data['status'];
      if (data.toString() == "0") {
        _showCustomSnackbar("Payment Success");
        // ignore: use_build_context_synchronously
        Get.to(() => HomePage1(pf: true));
        dispose();
      } else {
        print("\n\n\n\nDelayed code executed!\n\n\n\n");
      }
    } else {
      print(response.statusMessage);
    }
  }

  Future check_traslation_aba_is_not() async {
    var headers = {'Content-Type': 'application/json'};
    var data =
        json.encode({"req_time": "$reqTime", "tran_id": "${widget.tran_id}"});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_transaction/aba',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      var data = response.data['status'];
      if (data.toString() != "0") {
        final snackbar = SnackBar(
          content: Container(
            alignment: Alignment.center,
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "Payment not Success,please try again!",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
        // ignore: use_build_context_synchronously, await_only_futures
        await ScaffoldMessenger.of(context).showSnackBar(snackbar);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        await _showCustomSnackbar("Payment Success");
        // ignore: use_build_context_synchronously
        Get.to(() => HomePage1(pf: true));
        dispose();
      }
    } else {
      print(response.statusMessage);
    }
  }

  Future openDeepLink(var qrString) async {
    try {
      // ignore: deprecated_member_use
      bool check_link = await launch(qrString);
      print("check_link ${check_link}");
    } catch (e) {
      if (Platform.isAndroid) {
        final playStoreUrl =
            'https://play.google.com/store/apps/details?id=com.paygo24.ibank';
        // ignore: deprecated_member_use
        if (await canLaunch(playStoreUrl)) {
          // ignore: deprecated_member_use
          await launch(playStoreUrl);
        } else {
          throw 'Could not launch $playStoreUrl';
        }
      }
      if (Platform.isIOS) {
        final playStoreUrl =
            'https://itunes.apple.com/al/app/aba-mobile-bank/id968860649?mt=8';
        // ignore: deprecated_member_use
        if (await canLaunch(playStoreUrl)) {
          // ignore: deprecated_member_use
          await launch(playStoreUrl);
        } else {
          throw 'Could not launch $playStoreUrl';
        }
      }
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
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      check_traslation_aba();
    });
    // Future.delayed(const Duration(seconds: 2), () {
    //   check_traslation_aba();
    //   print("\n\n\n\nDelayed code executed!\n\n\n\n");
    // });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
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
                // Navigator.of(context).pop();
                check_traslation_aba_is_not();
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
              if (url_qr != null)
                Screenshot(
                  controller: screenshotController,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: double.infinity,
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: Uri.parse("$url_qr")),
                    ),
                  ),
                ),
              if (url_qr != null)
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
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 11),
                      ),
                      Text(
                        " ${widget.option}",
                        style: TextStyle(
                            overflow: TextOverflow.visible,
                            color: const Color.fromRGBO(158, 158, 158, 1),
                            fontWeight: FontWeight.w800,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 11),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ));
  }
}
