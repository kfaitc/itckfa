// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../Getx/Auto_Verbal/autu_verbal.dart';
import '../../../../Getx/Bank/Wing/wing_bank.dart';
import '../../../../Option/components/colors.dart';
import '../../../Home/Home.dart';

class Qr_Wing extends StatefulWidget {
  const Qr_Wing({
    super.key,
    required this.price,
    required this.accont,
    required this.phone,
    required this.option,
    required this.id,
    required this.control_user,
    required this.playerID,
  });
  final String price;
  final String accont;
  final String phone;
  final String option;
  final String id;
  final String playerID;
  final String control_user;
  @override
  State<Qr_Wing> createState() => _Qr_WingState();
}

class _Qr_WingState extends State<Qr_Wing> {
  String generateCRC(var data) {
    var bytes = utf8.encode(data);
    var crc = base64.encode(sha256.convert(bytes).bytes);
    return crc;
  }

  Random random = Random();
  String crc = '';
  var order_reference_no;

  int vpoint = 0;
  int vpointSecond = 0;
  late Timer _timer;
  int count = 0;
  void main() async {
    Future.delayed(const Duration(seconds: 2), () {
      wingBank.createInvoice(
        widget.control_user,
        widget.price,
        "first",
        "last",
        "01012",
        crc,
        order_reference_no,
      );
    });
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      await wingBank.checkTransetionQR(order_reference_no);
      // print(
      //     "wingBank.orderbycode.value : ${wingBank.orderbycode.value} || $order_reference_no");
      if (wingBank.orderbycode.value == order_reference_no) {
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

  // Future<void> notification() async {
  //   var headers = {
  //     'Content-Type': 'application/json; charset=utf-8',
  //     'Cookie':
  //         '__cf_bm=Tz0b2VzsEGdqRwABVHE9.d1MJ75lrLCUpGpFioEzZ2c-1711944598-1.0.1.1-1JSGW9GW6AxAwmFIBjF6UfpSo84Xb1b.dsB7Z0PiGRbaOMlul3B8F2hgZ9yMnBHuAIvohTpEebcHmDD.F4Noqw; __cf_bm=JyLnwxo0CFbi7c4EUDCxEybwa47B6IM0RMBEt2awf6Q-1719595913-1.0.1.1-QKP1lqbqfEJZGhL51ETlMQ5eZWr9OrPYpgxBQAXZQ4d2OEGfG4QGFZgT2nBL9WXmUmFxFB08EuhT..OBcVBKmA'
  //   };
  //   var data =
  //       '''{\r\n    "app_id": "d3025f03-32f5-444a-8100-7f7637a7f631",\r\n    "name": {"en": "Khmer Fundation appraisal"},    \r\n    "headings": {"en": "KFA"}, \r\n    "contents": {"en": "Your payment succesfuly for up VPoint"},\r\n    "include_player_ids": ["${widget.playerID}"],\r\n    \n    "large_icon": "https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/images/New_KFA_Logo.png"\r\n    \n    \n}\r\n''';
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://onesignal.com/api/v1/notifications',
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );

  //   if (response.statusCode == 200) {
  //     print(json.encode(response.data));
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }

  WingBank wingBank = WingBank();
  bool isChecked = false;
  Future _saved(image, BuildContext context) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
  }

  @override
  void initState() {
    super.initState();
    order_reference_no =
        '${random.nextInt(999).toString()}k${random.nextInt(9999).toString()}f${random.nextInt(9999).toString()}';
    String state =
        r"$2a$10$fVrLAzVSkx7s0/N7WOWFsOM2W7L0gh.UgbAxoqDc5B9a.aqyR4MqK" +
            order_reference_no.toString() +
            "|USD|" +
            widget.price.toString();
    setState(() {
      crc = generateCRC(state);
    });
    main();
  }

  AuthVerbal authVerbal = AuthVerbal(Iduser: "");
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    authVerbal = Get.put(AuthVerbal(Iduser: widget.control_user.toString()));
    // var now = DateTime.now();
    // var formatterDate = DateFormat('dd/MM/yy kk:mm');
    // var dateTime = DateFormat('yyyy-MM-ddThh:mm:ss');

    // String actualDate = formatterDate.format(now);
    // String actualDate1 = dateTime.format(now);

    return Scaffold(
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
          ),
        ),
        title: Text(
          "Scan for payments($count)",
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
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            if (wingBank.isQR.value) {
              return const Center(child: SizedBox());
            } else if (wingBank.listQR.isEmpty) {
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
              return Column(
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
                  // TextField(
                  //   controller: roll_id,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(color: Colors.black),
                  // ),

                  Screenshot(
                    controller: screenshotController,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        // alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 400,
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.only(
                              top: 15,
                              right: 10,
                              left: 10,
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholderCacheHeight: 50,
                              placeholderCacheWidth: 50,
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              placeholder: 'assets/earth.gif',
                              image: wingBank.qrCode.value,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 0.38,
                            child: Image.asset(
                              "assets/images/WingBank.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
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
                  //     size: 25,
                  //     activeBgColor: Colors.green,
                  //     listItemTextColor: Color.fromRGBO(158, 158, 158, 1),
                  //     type: GFCheckboxType.square,
                  //     activeIcon: Icon(
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
                        Text(
                          'Total:',
                          style: TextStyle(
                            overflow: TextOverflow.visible,
                            color: const Color.fromRGBO(158, 158, 158, 1),
                            fontWeight: FontWeight.w800,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 12,
                          ),
                        ),
                        Text(
                          " ${widget.price} USD",
                          style: TextStyle(
                            overflow: TextOverflow.visible,
                            color: const Color.fromRGBO(158, 158, 158, 1),
                            fontWeight: FontWeight.w800,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
