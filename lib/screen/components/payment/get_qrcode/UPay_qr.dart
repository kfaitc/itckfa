import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class Qr_UPay extends StatefulWidget {
  const Qr_UPay(
      {super.key,
      required this.price,
      required this.accont,
      required this.phone,
      required this.option,
      required this.id,
      required this.control_user});
  final String price;
  final String accont;
  final String phone;
  final String option;
  final String id;
  final String control_user;
  @override
  State<Qr_UPay> createState() => Qr_UPayState();
}

class Qr_UPayState extends State<Qr_UPay> {
  generateMd5() {
    var content = new Utf8Encoder().convert(
        'currency=USD&goodsDetail=test0001&mcId=1427830347298627585&mcOrderId=test00200007&money=sefs&notifyUrl=http://127.0.0.1:30005/upayApi/test/notify6c509474001d099e8ee25540cb5ad0a8');
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  String? _Url_call_back;

  Random random = Random();
  String crc = '';
  var order_reference_no;
  var url_qr;
  void createInvoice() async {
    final url = Uri.parse('https://dev-upayapi.u-pay.com');

    // JSON data
    final jsonData = {
      "order_reference_no": order_reference_no,
      "type": "TAX",
      "currency": "USD",
      "issue_date": "2023-07-07T08:56:56.626Z",
      "sub_total": widget.price,
      "total": widget.price,
      "billing_from": "#711, PP, Cambodia",
      "billing_to": "#712, PP, Cambodia",
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer f104c7a9-1cf5-4fe8-a161-8d2c32c04345'
      },
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      print('Invoice created successfully. ${response}');
      final responseBody = json.decode(response.body);
      setState(() {
        url_qr = responseBody['body']['qr_code_url'];
        print('\n' +
            'trace_id ' +
            responseBody['trace_id '].toString() +
            '\n' +
            widget.id);
      });
    } else {
      // Failed to create invoice
      print('Failed to create invoice. Status code: ${response.statusCode}');
    }
  }

  bool success_payment = false;
  Future<void> Load(BuildContext context) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_done?order_reference_no=${order_reference_no}'));
    var jsonData = jsonDecode(rs.body);
    setState(() {
      if (jsonData.toString() == order_reference_no.toString()) {
        success_payment = true;
      }
    });

    if (success_payment) {
      var count_number = widget.option.split(' ');
      final Data = {
        "id_user_control": widget.control_user.toString(),
        "count_autoverbal": int.parse(count_number[0].toString()),
      };
      final response = await http.post(
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(Data),
      );
      Future.delayed(const Duration(seconds: 10), () async {
        Navigator.pop(context);
      });
    }
  }

  bool isChecked = false;
  Future _saved(image, BuildContext context) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
  }

  TextEditingController roll_id = TextEditingController();
  int count = 0;
  @override
  void initState() {
    // order_reference_no =
    //     'KFA-${random.nextInt(9999999).toString()}k${random.nextInt(9999999).toString()}f${random.nextInt(9999999).toString()}';
    // String state =
    //     r"$2a$05$m3RX2lLwe9IoFqvwTh53e.p.UcdyLYstudb.9Hqa4uz0iqRH8h6xi" +
    //         "${order_reference_no}|USD|${widget.price}";
    // setState(() {
    //   crc = generateCRC(state);
    String md5 = generateMd5();
    roll_id = TextEditingController(text: md5);
    //   _Url_call_back =
    //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back/${widget.control_user}/6560';
    //   print("\n" + crc + "\n" + order_reference_no + "\n" + widget.price);
    // });
    // Future.delayed(const Duration(seconds: 2), () {
    //   createInvoice();
    // });
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy kk:mm');
    var dateTime = DateFormat('yyyy-MM-ddThh:mm:ss');

    String actualDate = formatterDate.format(now);
    String actualDate1 = dateTime.format(now);
    // Future.delayed(const Duration(seconds: 10), () async {
    //   await Load(context);
    //   setState(() {
    //     count++;
    //   });
    // });
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
                color: Color.fromRGBO(49, 27, 146, 1),
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
                    print(onError);
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
              TextField(
                controller: roll_id,
                style: TextStyle(color: Colors.black),
              ),
              if (url_qr != null)
                Screenshot(
                  controller: screenshotController,
                  child: Container(
                    height: 400,
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                    child: FadeInImage.assetNetwork(
                      placeholderCacheHeight: 50,
                      placeholderCacheWidth: 50,
                      fit: BoxFit.cover,
                      placeholderFit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: 'assets/earth.gif',
                      image: url_qr.toString(),
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
                      color: Color.fromRGBO(158, 158, 158, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 10),
                ),
              ),
              if (success_payment)
                GFCheckboxListTile(
                  titleText: 'Payment Success',
                  size: 25,
                  activeBgColor: Colors.green,
                  listItemTextColor: Color.fromRGBO(158, 158, 158, 1),
                  type: GFCheckboxType.square,
                  activeIcon: Icon(
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
                          color: Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                    ),
                    // Text(' ${count.toString()}'),
                    Text(
                      " ${widget.price} USD",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: Color.fromRGBO(158, 158, 158, 1),
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
                          color: Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 11),
                    ),
                    Text(
                      " ${widget.option}",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: Color.fromRGBO(158, 158, 158, 1),
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
                          color: Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                    ),
                    Text(
                      " ${widget.price} USD",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: Color.fromRGBO(158, 158, 158, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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
    print(data);
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
    print(sbf.toString());
    return generateMD5(sbf.toString()).toUpperCase();
  }
}
