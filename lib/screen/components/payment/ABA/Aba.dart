// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../Getx/Auto_Verbal/autu_verbal.dart';
import '../../../../Getx/Bank/ABA/aba_bank.dart';
import '../../../../Option/components/colors.dart';

class ABA extends StatefulWidget {
  const ABA({
    super.key,
    required this.price,
    required this.option,
    required this.id_set_use,
    required this.tran_id,
    required this.set_email,
    required this.set_phone,
    this.id_verbal,
  });
  final String price;
  final String option;
  final String id_set_use;
  final String tran_id;
  final String set_email;
  final String set_phone;
  final String? id_verbal;
  @override
  State<ABA> createState() => _ABAState();
}

class _ABAState extends State<ABA> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isChecked = false;
  late Timer _timer;

  // ignore: unused_element
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool success_payment = false;
  Future _saved(image, BuildContext context) async {
    final result = await ImageGallerySaver.saveImage(image);
  }

  String? reqTime;
  int? thierPlan;
  AuthVerbal authVerbal = AuthVerbal(Iduser: "");
  ABABank abaBank = ABABank();

  @override
  void initState() {
    super.initState();
    abaBank.checkQR.value = "2";
    DateTime currentDateTime = DateTime.now();
    reqTime = DateFormat('yyyyMMddHHmmss').format(currentDateTime);
    var countNumber = widget.option.split(' ');

    if (countNumber[4] == "Day") {
      thierPlan = 1;
    } else if (countNumber[4] == "Week") {
      thierPlan = 7;
    } else if (countNumber[4] == "Mount") {
      thierPlan = 30;
    }
    abaBank.traslationABA(
      widget.tran_id,
      widget.set_email,
      widget.set_phone,
      widget.price,
      widget.id_set_use,
      thierPlan!,
      reqTime!,
    );
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      abaBank.checkTraslationABAisNot(reqTime!, widget.tran_id, context);
      if (abaBank.checkQR.value == "0") {
        _timer.cancel();

        Future.delayed(const Duration(seconds: 5), () async {
          await authVerbal.checkVpoint(widget.id_set_use);
          Get.snackbar(
            "",
            "",
            titleText: Text(
              'Done!',
              style: TextStyle(
                color: greyColor,
                fontSize: 14,
              ),
            ),
            messageText: Text(
              'Payment is successfuly!',
              style: TextStyle(
                color: greyColor,
                fontSize: 12,
              ),
            ),
            colorText: Colors.black,
            padding:
                const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
            borderColor: const Color.fromARGB(255, 48, 47, 47),
            borderWidth: 1.0,
            borderRadius: 5,
            backgroundColor: const Color.fromARGB(255, 235, 242, 246),
            icon: const Icon(Icons.add_alert),
          );
        });

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const TopUp()),
        // );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authVerbal = Get.put(AuthVerbal(Iduser: widget.id_set_use.toString()));
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
            print(widget.id_set_use.toString());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(49, 27, 146, 1),
          ),
        ),
        title: Text(
          "Scan for payments",
          style: TextStyle(
            color: const Color.fromRGBO(49, 27, 146, 1),
            fontSize: MediaQuery.textScaleFactorOf(context) * 18,
            fontWeight: FontWeight.w900,
          ),
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

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }).catchError((onError) {});
            },
            icon: const Icon(
              Icons.photo_camera_back_outlined,
              color: Color.fromRGBO(49, 27, 146, 1),
              size: 35,
              shadows: [
                Shadow(
                  offset: Offset(3, -3),
                  blurRadius: 5,
                  color: Colors.black54,
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            if (abaBank.isABA.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (abaBank.qrCode.value == "") {
              return const SizedBox();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: double.infinity,
                      child: InAppWebView(
                        initialUrlRequest:
                            URLRequest(url: Uri.parse(abaBank.qrCode.value)),
                      ),
                    ),
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
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 11,
                          ),
                        ),
                        Text(
                          " ${widget.option}",
                          style: TextStyle(
                            overflow: TextOverflow.visible,
                            color: const Color.fromRGBO(158, 158, 158, 1),
                            fontWeight: FontWeight.w800,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
