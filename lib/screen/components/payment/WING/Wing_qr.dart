import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class Qr_Wing extends StatefulWidget {
  const Qr_Wing({
    super.key,
    required this.price,
    required this.accont,
    required this.phone,
    required this.option,
    required this.id,
    required this.control_user,
  });
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
      'https://eco-gateway.wingmarket.com/invoicing/api/invoice/ext/create',
    );

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
        "tin_number": "BI02‐220008523",
      },
      "invoice_items": [
        {
          "product_id": "kfa",
          "product": "V-point",
          "product_qty": 1,
          "product_unit_price": widget.price,
          "currency": "USD",
          "amount": widget.price,
        }
      ],
      "crc": crc,
      "gateway_setting": {"callback_url": _Url_call_back},
    };
    await Getaccess_token();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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
      print(
        'Failed to create invoice. Status code: ${response.statusCode} \n ${response.body}',
      );
    }
  }

  var token;
  Future<void> Getaccess_token() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
        'https://eco-gateway.wingmarket.com/v2/identity/login?username=100224779&password=L3pvo4EiVkZ9vKVMeO2yu43nsGBV0LBs8zpYqKnydLMkCwS16wdEH1+wH2/ay3oTDCjWvEwYeplrKTRzWfCUFl/savqtmGZVUSNSY2nxAlnsKQNr8mzg1iBxwzEY1CAlnFD/Hp3DGscz3YLGcV9mO22DQG6ibxmCX0E4aHmUmPafRRwsG9RQ5n1gY+0q6vPKQNZAHvYWH9tnkXrj8Hsm1QQdjzgPH8L2k+ROaJXcn/w5Asro7G9wJsAJcPasD3jsGml77MXm4XCkpaYzvPV5Zxgo1BFdek4Sl+jCJ4uYqjzDoc9q0jR4ZJGrzKeupMo6yL/EvAmLFYs0H0vM+jP5ow==&grant_type=password&client_id=kfa&client_secret=YetKZu7yEHhnMxNatpjSaeQS8c+xXkgSJ8jqS/LCn/F5dp3oI+uiNZ5niwiDQWsyTfD+7LLk2yqT1HMWVL+AcdAF62OyPVgqsg3m0g/H7YbaZo1n5dj3W7I1F25hNo/KykTmB5V4p/6lBlIsmfG9sz+7h8rPxRRYoY+2mkUlP++rK7PVfYkFBeJR1c9+AseHzU+2Edvw62lQdoibFhie0foerppUBg//510U0s1jFxoJEW6U7UoqujLIE08xuVqU9ro8eELUIQJsm47Wh6Jnp8KSy28q9H27D2CYauM0dgw/Xa0QB2YBY34oji6cgOQnASYsZtXufOkvVIHQvVAlqw==',
      ),
    );
    request.body = json.encode({
      "username": "100224779",
      "password":
          "L3pvo4EiVkZ9vKVMeO2yu43nsGBV0LBs8zpYqKnydLMkCwS16wdEH1+wH2/ay3oTDCjWvEwYeplrKTRzWfCUFl/savqtmGZVUSNSY2nxAlnsKQNr8mzg1iBxwzEY1CAlnFD/Hp3DGscz3YLGcV9mO22DQG6ibxmCX0E4aHmUmPafRRwsG9RQ5n1gY+0q6vPKQNZAHvYWH9tnkXrj8Hsm1QQdjzgPH8L2k+ROaJXcn/w5Asro7G9wJsAJcPasD3jsGml77MXm4XCkpaYzvPV5Zxgo1BFdek4Sl+jCJ4uYqjzDoc9q0jR4ZJGrzKeupMo6yL/EvAmLFYs0H0vM+jP5ow==",
      "grant_type": "password",
      "client_id": "kfa",
      "client_secret":
          "YetKZu7yEHhnMxNatpjSaeQS8c+xXkgSJ8jqS/LCn/F5dp3oI+uiNZ5niwiDQWsyTfD+7LLk2yqT1HMWVL+AcdAF62OyPVgqsg3m0g/H7YbaZo1n5dj3W7I1F25hNo/KykTmB5V4p/6lBlIsmfG9sz+7h8rPxRRYoY+2mkUlP++rK7PVfYkFBeJR1c9+AseHzU+2Edvw62lQdoibFhie0foerppUBg//510U0s1jFxoJEW6U7UoqujLIE08xuVqU9ro8eELUIQJsm47Wh6Jnp8KSy28q9H27D2CYauM0dgw/Xa0QB2YBY34oji6cgOQnASYsZtXufOkvVIHQvVAlqw==",
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

  // bool success_payment = false;
  // Future<void> Load(BuildContext context) async {
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_done?order_reference_no=${order_reference_no}'));
  //   var jsonData = jsonDecode(rs.body);
  //   setState(() {
  //     if (jsonData.toString() == order_reference_no.toString()) {
  //       success_payment = true;
  //     }
  //   });

  //   if (success_payment) {
  //     var thier_plan;
  //     var count_number = widget.option.split(' ');
  //     if (count_number[4] == "Day") {
  //       thier_plan = 1;
  //     } else if (count_number[4] == "Week") {
  //       thier_plan = 7;
  //     } else if (count_number[4] == "Mount") {
  //       thier_plan = 30;
  //     }
  //     final Data = {
  //       "id_user_control": widget.control_user.toString(),
  //       "count_autoverbal": int.parse(count_number[0].toString()),
  //     };
  //     final response = await http.post(
  //       Uri.parse(
  //           'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/${thier_plan}'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode(Data),
  //     );
  //     Future.delayed(const Duration(seconds: 10), () async {
  //       Navigator.pop(context);
  //     });
  //   }
  // }

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
        r"$2a$10$fVrLAzVSkx7s0/N7WOWFsOM2W7L0gh.UgbAxoqDc5B9a.aqyR4MqK" +
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
    // var now = DateTime.now();
    // var formatterDate = DateFormat('dd/MM/yy kk:mm');
    // var dateTime = DateFormat('yyyy-MM-ddThh:mm:ss');

    // String actualDate = formatterDate.format(now);
    // String actualDate1 = dateTime.format(now);

    return Scaffold(
      // backgroundColor: Colors.grey[100],
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
                  color: Colors.black54,
                ),
              ],
            ),
          ),
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
            // TextField(
            //   controller: roll_id,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: Colors.black),
            // ),
            if (url_qr != null)
              Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    // alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 400,
                        // color: Colors.white,
                        padding: const EdgeInsets.all(0),
                        // color: Colors.red[600],
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
                          image: url_qr.toString(),
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
                      fontSize: MediaQuery.textScaleFactorOf(context) * 11,
                    ),
                  ),
                  // Text(' ${count.toString()}'),
                  Text(
                    " ${widget.price} USD",
                    style: TextStyle(
                      overflow: TextOverflow.visible,
                      color: const Color.fromRGBO(158, 158, 158, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 11,
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
                      fontSize: MediaQuery.textScaleFactorOf(context) * 11,
                    ),
                  ),
                  Text(
                    " ${widget.option}",
                    style: TextStyle(
                      overflow: TextOverflow.visible,
                      color: const Color.fromRGBO(158, 158, 158, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 11,
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
                      fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                    ),
                  ),
                  Text(
                    " ${widget.price} USD",
                    style: TextStyle(
                      overflow: TextOverflow.visible,
                      color: const Color.fromRGBO(158, 158, 158, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
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