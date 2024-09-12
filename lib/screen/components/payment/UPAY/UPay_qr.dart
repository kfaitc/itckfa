// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:itckfa/Option/components/colors.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../Getx/Auto_Verbal/autu_verbal.dart';
import '../../../../Getx/Bank/UPay/upay_bank.dart';
import '../../../Home/Home.dart';

class Qr_UPay extends StatefulWidget {
  const Qr_UPay({
    super.key,
    this.price,
    this.accont,
    this.phone,
    this.option,
    this.id,
    this.control_user,
    required this.playerID,
  });
  final String? price;
  final String? accont;
  final String? phone;
  final String? option;
  final String? id;
  final String? control_user;
  final String playerID;
  @override
  State<Qr_UPay> createState() => Qr_UPayState();
}

class Qr_UPayState extends State<Qr_UPay> {
  var loading = false;

  bool isChecked = false;
  Future _saved(image, BuildContext context) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
  }

  int? thierPlan;
  @override
  void initState() {
    super.initState();
    // main();
    setState(() {
      var countNumber = widget.option!.split(' ');

      if (countNumber[4] == "Day") {
        thierPlan = 1;
      } else if (countNumber[4] == "Week") {
        thierPlan = 7;
      } else if (countNumber[4] == "Mount") {
        thierPlan = 30;
      }
    });
    main();
  }

  late Timer _timer;
  AuthVerbal authVerbal = AuthVerbal(Iduser: "");
  void main() async {
    upayBank.createOrderQR(
      widget.price!,
      // "${widget.control_user}/${widget.price}/$thierPlan",
      "${widget.control_user}/1.00/$thierPlan",
    );
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      upayBank.transetionID(upayBank.mcOrderId);
      if (upayBank.listQR.isNotEmpty) {
        _timer.cancel();
        Future.delayed(const Duration(seconds: 5), () async {
          await authVerbal.checkVpoint(widget.control_user);
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
        //   MaterialPageRoute(builder: (context) => const HomePage1()),
        // );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  ScreenshotController screenshotController = ScreenshotController();
  UpayBank upayBank = UpayBank();

  @override
  Widget build(BuildContext context) {
    authVerbal = Get.put(AuthVerbal(Iduser: widget.control_user.toString()));
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
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
            if (upayBank.isQR.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (upayBank.qrCode.value == "") {
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.13,
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/New_KFA_Logo_pdf.png',
                  fit: BoxFit.fitWidth,
                ),
              );
            } else {
              return Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 455,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.only(top: 65),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/logoqr.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "\t\t\t\t\t\t\t\tKFA",
                            style: TextStyle(
                              color: Color.fromRGBO(121, 121, 121, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "\t\t\t\t\t\t\t\t${widget.price ?? ""} \$",
                            style: const TextStyle(
                              color: Color.fromRGBO(63, 63, 63, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 45),
                            child: Center(
                              child: Card(
                                elevation: 10,
                                child: BarcodeWidget(
                                  width: 226,
                                  height: 226,
                                  barcode: Barcode.qrCode(),
                                  data: upayBank.qrCode.value,
                                  color: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          fontSize: MediaQuery.textScaleFactorOf(context) * 10,
                        ),
                      ),
                    ),
                    // if (success_payment)
                    //   GFCheckboxListTile(
                    //     titleText: 'Payment Success',
                    //     size: 20,
                    //     activeBgColor: Colors.green,
                    //     color: Colors.white,
                    //     margin: const EdgeInsets.symmetric(
                    //         vertical: 25, horizontal: 16),
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
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 11,
                            ),
                          ),
                          // Text(' ${count.toString()}'),
                          Text(
                            " ${widget.price} USD",
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
                          const Text(
                            'Total:',
                            style: TextStyle(
                              overflow: TextOverflow.visible,
                              color: Color.fromRGBO(158, 158, 158, 1),
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            " ${widget.price} USD",
                            style: const TextStyle(
                              overflow: TextOverflow.visible,
                              color: Color.fromRGBO(158, 158, 158, 1),
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }
          },

          // ],
          // ),
        ),
      ),
    );
  }
}
