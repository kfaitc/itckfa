import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:barcode_widget/barcode_widget.dart';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:screenshot/screenshot.dart';
import 'package:dio/dio.dart';

class Qr_UPay extends StatefulWidget {
  const Qr_UPay(
      {super.key,
      this.price,
      this.accont,
      this.phone,
      this.option,
      this.id,
      this.control_user,});
  final String? price;
  final String? accont;
  final String? phone;
  final String? option;
  final String? id;
  final String? control_user;
  @override
  State<Qr_UPay> createState() => Qr_UPayState();
}

class Qr_UPayState extends State<Qr_UPay> {
  final TextEditingController idText = TextEditingController();
  final TextEditingController keyText = TextEditingController();
  final TextEditingController nameText = TextEditingController();
  final TextEditingController amountText = TextEditingController();
  final TextEditingController orderIdText = TextEditingController();
  final TextEditingController usdText = TextEditingController();
  final TextEditingController versionText = TextEditingController();
  final TextEditingController notifyText = TextEditingController();
  final TextEditingController returnText = TextEditingController();
  final TextEditingController signText = TextEditingController();
  final TextEditingController langText = TextEditingController();
  var loading = false;
  static String baseUrl2 = 'https://upayapi.u-pay.com/upayApi/mc/mcOrder';
  var appUrl = '$baseUrl2/appCreate';
  var qrUrl = '$baseUrl2/create/qrcode';
  var url_qr;
  var orderId;
  void createOrderQR() async {
    setState(() {});
    var merchantId = idText.text;
    var merchantKey = keyText.text;
    var goods = nameText.text;
    var amount = amountText.text;
    var ccy = usdText.text;
    var v = versionText.text;
    var notifyUrl = notifyText.text;
    var returnUrl = returnText.text;
    var language = langText.text;
    orderId = SignUtil().RandomString(10);
    orderIdText.text = orderId;
    Map<String, String> map = {
      'currency': ccy,
      'goodsDetail': goods,
      'lang': language,
      'mcAbridge': 'Khmer Foundation Apprais',
      'mcId': merchantId,
      'mcOrderId': orderId,
      'money': amount,
      'notifyUrl': notifyUrl,
      'version': v,
    };
    var sign = SignUtil.getSign(map, merchantKey);
    map['sign'] = sign;
    // print(jsonEncode(map));
    signText.text = sign;

    try {
      var response = await Dio().post(qrUrl, data: map);
      if (response.statusCode == 200) {
        var data = response.data;
        var d1 = jsonEncode(data['data']);
        var d2 = json.decode(d1);
        setState(() {
          url_qr = d2['qrcode'].toString();
          print(url_qr);
        });
      } else {}
    } catch (e) {}
    loading = false;
    setState(() {});
  }

  bool success_payment = false;
  Future<void> Load() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_done_upay?mcOrderId=$orderId',),);
    var jsonData = jsonDecode(rs.body);
    setState(() {
      if (jsonData.toString() == orderId.toString()) {
        success_payment = true;
      }
    });
  }

  bool isChecked = false;
  Future _saved(image, BuildContext context) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
  }

  TextEditingController roll_id = TextEditingController();
  int count = 0;
  var thier_plan;
  @override
  void initState() {
    super.initState();
    setState(() {
      var countNumber = widget.option!.split(' ');

      if (countNumber[4] == "Day") {
        thier_plan = 1;
      } else if (countNumber[4] == "Week") {
        thier_plan = 7;
      } else if (countNumber[4] == "Mount") {
        thier_plan = 30;
      }
    });
    if (thier_plan != null) {
      idText.text = '1726454244928921602';
      keyText.text = '83ef634e4c80809edd6e2d53a8d49454';
      nameText.text = widget.option ?? "";
      amountText.text = widget.price ?? "";
      usdText.text = 'USD';
      versionText.text = 'V1';
      notifyText.text =
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_pay/6591/${widget.control_user}/${widget.price}/$thier_plan';
      returnText.text = 'kfa://callback';
      langText.text = 'EN';
      createOrderQR();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    // var now = DateTime.now();
    // var formatterDate = DateFormat('dd/MM/yy kk:mm');
    // var dateTime = DateFormat('yyyy-MM-ddThh:mm:ss');

    // String actualDate = formatterDate.format(now);
    // String actualDate1 = dateTime.format(now);

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
              ),),
          title: Text(
            "Scan for payments",
            style: TextStyle(
                color: const Color.fromRGBO(49, 27, 146, 1),
                fontSize: MediaQuery.textScaleFactorOf(context) * 18,
                fontWeight: FontWeight.w900,),
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
                        color: Colors.black54,)
                  ],
                ),)
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
                            fit: BoxFit.fill,),),
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
                                  MediaQuery.textScaleFactorOf(context) * 20,),
                        ),
                        Text(
                          "\t\t\t\t\t\t\t\t${widget.price ?? ""} \$",
                          style: TextStyle(
                              color: const Color.fromRGBO(63, 63, 63, 1),
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 20,),
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
                                backgroundColor: Colors.white,),
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
                      fontSize: MediaQuery.textScaleFactorOf(context) * 10,),
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
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11,),
                    ),
                    // Text(' ${count.toString()}'),
                    Text(
                      " ${widget.price} USD",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11,),
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
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11,),
                    ),
                    Text(
                      " ${widget.option}",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11,),
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
                          fontSize: MediaQuery.textScaleFactorOf(context) * 12,),
                    ),
                    Text(
                      " ${widget.price} USD",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 12,),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),);
  }
}

class SignUtil {
  static StringBuffer getKeys(Map<String, String> inMap, List<String> keys) {
    StringBuffer sbf = StringBuffer();
    for (var i = 0; i < keys.length; i++) {
      var key = keys[i];
      if (key != 'sign' && key.isNotEmpty) {
        var value = inMap[key];
        if (value == '' || value == null) {
          continue;
        }
        sbf
          ..write(key)
          ..write('=')
          ..write(value);
        if (i != (keys.length - 1)) {
          sbf.write('&');
        }
      }
    }
    return sbf;
  }

  static String generateMD5(String data) {
    // print(data);
    Uint8List content = const Utf8Encoder().convert(data);
    Digest digest = md5.convert(content);
    return digest.toString();
  }

  static String getSign(Map<String, String> inMap, String secretKey) {
    var keys = <String>[];
    keys.addAll(inMap.keys);
    keys.sort();
    var sbf = getKeys(inMap, keys);
    sbf.write(secretKey);
    // print(sbf.toString());
    return generateMD5(sbf.toString()).toUpperCase();
  }

  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  String RandomString(int strlen) {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }
}
