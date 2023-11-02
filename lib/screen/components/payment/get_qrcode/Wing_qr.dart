import 'dart:convert';
import 'dart:math';
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

class Qr_Wing extends StatefulWidget {
  const Qr_Wing(
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
  State<Qr_Wing> createState() => _Qr_WingState();
}

class _Qr_WingState extends State<Qr_Wing> {
  String generateCRC(var data) {
    var bytes = utf8.encode(data);
    var crc = base64.encode(sha256.convert(bytes).bytes);
    return crc;
  }

  String? _Url_call_back;

  Random random = Random();
  String crc = '';
  var order_reference_no;
  var url_qr;
  void createInvoice() async {
    final url = Uri.parse(
        'https://demo-eco-gateway.wingmarket.com/invoicing/api/invoice/ext/create');

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
      "customer": {
        "first_name": widget.accont,
        "last_name": "virak",
        "phone": widget.phone,
        "company_name": "My Company",
        "tin_number": "BI02‐220008523"
      },
      "invoice_items": [
        {
          "product_id": "kfa",
          "product": "V-point",
          "product_qty": 1,
          "product_unit_price": widget.price,
          "currency": "USD",
          "amount": widget.price
        }
      ],
      "crc": crc,
      "gateway_setting": {"callback_url": _Url_call_back}
    };
    await Getaccess_token();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      // print('Invoice created successfully. ${response}');
      final responseBody = json.decode(response.body);
      setState(() {
        url_qr = responseBody['body']['qr_code_url'];
      });
    } else {
      // Failed to create invoice
      // print('Failed to create invoice. Status code: ${response.statusCode}');
    }
  }

  var token;
  Future<void> Getaccess_token() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://demo-eco-gateway.wingmarket.com/identity/login?username=077771125&password=XjKOQ596gvx%2F9SwedIBZIMsbhQSBb8HGHhE09wHjAva056f9z4RIqGRrO3sv4haMB0uztiSfSyU%2F261by2iwV8GeIB7ekCRD4Et9SQYia8SxeDerELWlOhIQOwwJBcSfpNA4kECW7ubzOPv%2Bg5RBJ8ba4YLGsoMxnVKGEaKs14fatHn%2BqlnpauIhhN2rxiuxPmZhWYjGfe2J%2BEp%2BIO52zcFFy2Bl1x6ujIxtkrU3Ia48f%2BNRAUBdz15jZr3QB7okGkfeft2qHRianhNOzcLAfnw2jYdSRRcrnejl8MzVJFWRXYuDTnBfQ76Pk1Z%2B7JcXHOT2Asa18T2Px3RuwrNKmQ%3D%3D&grant_type=password&client_id=invoicing&client_secret=QhSNJNIjvVKHmEoSCX5qpz0AG1pzkyGP3jgzIC9r99UU5Xtadq2oaO1zhRrSsAb0pMPWX%2BtLK1MAgmp5JEIcceXLu2qsPgW5dyxOUOXxrxdGyYsuOegF0o7dzlkEUbRr3B3xTO5LsKVHi9R1TOkV%2BjlXVPxCLMAaUJ8%2FzmChq9Hsd1kBFCjLcL3oXE7gu2KlsVnGlQLEiJRZWQaBkhMiC8EbA59MT9%2Fowuybu6q%2Fc6LTTgQgyDdC3PA2gmblo7JrZtEgrj5IlM%2BrIUhPMV%2Bi8k9L2SBTfMW69AQAcpbkwmaorjA0%2BbPTNLdJVevV%2Fw%2FZZv6Hs45Ooddikx4GGQ4OIg%3D%3D'));

    request.body = json.encode({
      "username": "077771125",
      "password":
          "XjKOQ596gvx/9SwedIBZIMsbhQSBb8HGHhE09wHjAva056f9z4RIqGRrO3sv4haMB0uztiSfSyU/261by2iwV8GeIB7ekCRD4Et9SQYia8SxeDerELWlOhIQOwwJBcSfpNA4kECW7ubzOPv+g5RBJ8ba4YLGsoMxnVKGEaKs14fatHn+qlnpauIhhN2rxiuxPmZhWYjGfe2J+Ep+IO52zcFFy2Bl1x6ujIxtkrU3Ia48f+NRAUBdz15jZr3QB7okGkfeft2qHRianhNOzcLAfnw2jYdSRRcrnejl8MzVJFWRXYuDTnBfQ76Pk1Z+7JcXHOT2Asa18T2Px3RuwrNKmQ==",
      "grant_type": "password",
      "client_id": "invoicing",
      "client_secret":
          "QhSNJNIjvVKHmEoSCX5qpz0AG1pzkyGP3jgzIC9r99UU5Xtadq2oaO1zhRrSsAb0pMPWX+tLK1MAgmp5JEIcceXLu2qsPgW5dyxOUOXxrxdGyYsuOegF0o7dzlkEUbRr3B3xTO5LsKVHi9R1TOkV+jlXVPxCLMAaUJ8/zmChq9Hsd1kBFCjLcL3oXE7gu2KlsVnGlQLEiJRZWQaBkhMiC8EbA59MT9/owuybu6q/c6LTTgQgyDdC3PA2gmblo7JrZtEgrj5IlM+rIUhPMV+i8k9L2SBTfMW69AQAcpbkwmaorjA0+bPTNLdJVevV/w/ZZv6Hs45Ooddikx4GGQ4OIg=="
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        token = jsonResponse["body"]["access_token"];
      });
    } else {
      print(response.reasonPhrase);
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
      var thier_plan;
      var count_number = widget.option.split(' ');
      if (count_number[4] == "Day") {
        thier_plan = 1;
      } else if (count_number[4] == "Week") {
        thier_plan = 7;
      } else if (count_number[4] == "Mount") {
        thier_plan = 30;
      }
      final Data = {
        "id_user_control": widget.control_user.toString(),
        "count_autoverbal": int.parse(count_number[0].toString()),
      };
      final response = await http.post(
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/${thier_plan}'),
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
    order_reference_no =
        '${random.nextInt(999).toString()}k${random.nextInt(9999).toString()}f${random.nextInt(9999).toString()}';
    String state =
        r"$2a$05$m3RX2lLwe9IoFqvwTh53e.p.UcdyLYstudb.9Hqa4uz0iqRH8h6xi" +
            order_reference_no.toString() +
            "|USD|" +
            widget.price.toString();
    setState(() {
      crc = generateCRC(state);
      roll_id =
          TextEditingController(text: 'ID Paymemt : ' + order_reference_no);
      _Url_call_back =
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back/${widget.control_user}/6560';
      // print("\n" + crc + "\n" + order_reference_no + "\n" + widget.price);
    });
    Future.delayed(const Duration(seconds: 2), () {
      createInvoice();
    });
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy kk:mm');
    var dateTime = DateFormat('yyyy-MM-ddThh:mm:ss');

    String actualDate = formatterDate.format(now);
    String actualDate1 = dateTime.format(now);
    Future.delayed(const Duration(seconds: 10), () async {
      await Load(context);
      setState(() {
        count++;
      });
    });
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
              TextField(
                controller: roll_id,
                textAlign: TextAlign.center,
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
              const SizedBox(height: 90),
            ],
          ),
        ));
  }
}






//  Padding(
//         padding: const EdgeInsets.only(top: 90),
//         child: Column(
//           children: [
//             Text(
//               "payment",
//               style: TextStyle(
//                   fontSize: MediaQuery.of(context).textScaleFactor * 25),
//             ),
//             Stack(
//               alignment: Alignment.topRight,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 20),
//                   alignment: Alignment.center,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         decoration: BoxDecoration(
//                             color: Colors.blue[50],
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                                 color: Colors.black,
//                                 strokeAlign: BorderSide.strokeAlignOutside)),
//                         child: Stack(
//                           alignment: Alignment.centerLeft,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Price : ' + widget.price + ' \$',
//                                     style: TextStyle(
//                                         fontSize: MediaQuery.of(context)
//                                                 .textScaleFactor *
//                                             16,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const Divider(
//                                     height: 3,
//                                     thickness: 2,
//                                     color: Colors.black,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         '\nCode\'s payment:',
//                                         style: TextStyle(
//                                           fontSize: MediaQuery.of(context)
//                                                   .textScaleFactor *
//                                               11,
//                                         ),
//                                       ),
//                                       Text(
//                                         '\n KFA_2023${random.nextInt(9999999).toString()}',
//                                         style: TextStyle(
//                                           decoration: TextDecoration.underline,
//                                           fontSize: MediaQuery.of(context)
//                                                   .textScaleFactor *
//                                               11,
//                                           decorationStyle:
//                                               TextDecorationStyle.dashed,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.25,
//                                     width: double.infinity,
//                                     margin: const EdgeInsets.only(top: 10),
//                                     padding: const EdgeInsets.all(8.0),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                             blurRadius: 10,
//                                             blurStyle: BlurStyle.outer,
//                                             color: Colors.black12),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Account : ${widget.accont}',
//                                           style: TextStyle(
//                                             fontSize: MediaQuery.of(context)
//                                                     .textScaleFactor *
//                                                 11,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Phone : ${widget.phone}',
//                                           style: TextStyle(
//                                             fontSize: MediaQuery.of(context)
//                                                     .textScaleFactor *
//                                                 11,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Option \t\t: ${widget.option}',
//                                           style: TextStyle(
//                                             fontSize: MediaQuery.of(context)
//                                                     .textScaleFactor *
//                                                 11,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Date \t\t\t\t\t:\t $actualDate',
//                                           style: TextStyle(
//                                             fontSize: MediaQuery.of(context)
//                                                     .textScaleFactor *
//                                                 11,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       GFCard(
//                         content: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             GFCheckbox(
//                               size: 10,
//                               activeBgColor: GFColors.DANGER,
//                               onChanged: (value) {
//                                 setState(() {
//                                   isChecked = value;
//                                 });
//                               },
//                               value: isChecked,
//                               inactiveIcon: null,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 GFAvatar(
//                   child: IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),