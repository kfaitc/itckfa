// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:barcode_widget/barcode_widget.dart';
// import 'package:http/http.dart' as http;
// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:dio/dio.dart';
// import 'package:url_launcher/url_launcher.dart';

// class App_link_Upay extends StatefulWidget {
//   const App_link_Upay(
//       {super.key,
//       this.price,
//       this.accont,
//       this.phone,
//       this.option,
//       this.id,
//       this.control_user});
//   final String? price;
//   final String? accont;
//   final String? phone;
//   final String? option;
//   final String? id;
//   final String? control_user;
//   @override
//   State<App_link_Upay> createState() => Qr_UPayState();
// }

// class Qr_UPayState extends State<App_link_Upay> {
//   final TextEditingController idText = TextEditingController();
//   final TextEditingController keyText = TextEditingController();
//   final TextEditingController nameText = TextEditingController();
//   final TextEditingController amountText = TextEditingController();
//   final TextEditingController orderIdText = TextEditingController();
//   final TextEditingController usdText = TextEditingController();
//   final TextEditingController versionText = TextEditingController();
//   final TextEditingController notifyText = TextEditingController();
//   final TextEditingController returnText = TextEditingController();
//   final TextEditingController signText = TextEditingController();
//   final TextEditingController langText = TextEditingController();
//   var loading = false;
//   Future<void> showConfirmationBottomSheet(BuildContext context) {
//     return showModalBottomSheet<void>(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.7,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//               color: Colors.white,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 if (url_qr != null)
//                   Container(
//                     width: 226,
//                     height: 226,
//                     margin: const EdgeInsets.symmetric(vertical: 45),
//                     child: Center(
//                       child: BarcodeWidget(
//                         barcode: Barcode.qrCode(),
//                         data: url_qr,
//                       ),
//                     ),
//                   )
//                 else
//                   Text('No url_qr'),
//                 SizedBox(height: 20),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       createOrder();
//                       // print('CreateOrder');
//                     });
//                   },
//                   child: Text(
//                     'OPEN UPAY Wallet APP',
//                     style: TextStyle(
//                         fontSize: MediaQuery.textScaleFactorOf(context) * 13,
//                         color: Colors.grey[800]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static String baseUrl2 = 'https://dev-upayapi.u-pay.com/upayApi/mc/mcOrder';
//   var appUrl = '$baseUrl2/appCreate';
//   var qrUrl = '$baseUrl2/create/qrcode';
//   var url_qr;
//   var orderId;
//   void createOrderQR() async {
//     setState(() {});
//     var merchantId = idText.text;
//     var merchantKey = keyText.text;
//     var goods = nameText.text;
//     var amount = amountText.text;
//     var ccy = usdText.text;
//     var v = versionText.text;
//     var notifyUrl = notifyText.text;
//     // var returnUrl = returnText.text;
//     var language = langText.text;
//     orderId = SignUtil().RandomString(10);
//     orderIdText.text = orderId;
//     Map<String, String> map = {
//       // 'currency': ccy,
//       // 'goodsDetail': goods,
//       // 'lang': language,
//       // 'mcAbridge': 'test',
//       // 'mcId': merchantId,
//       // 'mcOrderId': orderId,
//       // 'money': amount,
//       // 'notifyUrl': notifyUrl,
//       // 'version': v,
//       'currency': "USD",
//       'goodsDetail': "0001",
//       'lang': "EN",
//       'mcAbridge': 'test',
//       'mcId': '1674724041055870978',
//       'mcOrderId': "108807",
//       'money': "1.00",
//       'notifyUrl':
//           "https:www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_upay/58/8899",
//       'version': 'V1',
//     };
//     var sign = SignUtil.getSign(map, merchantKey);
//     map['sign'] = sign;
//     // print(jsonEncode(map));
//     signText.text = sign;

//     try {
//       var response = await Dio().post(qrUrl, data: map);
//       if (response.statusCode == 200) {
//         var data = response.data;
//         var d1 = jsonEncode(data['data']);
//         var d2 = json.decode(d1);
//         setState(() {
//           url_qr = d2['qrcode'].toString();
//           showConfirmationBottomSheet(context);
//           // print('Function=====================================');
//         });
//       } else {}
//     } catch (e) {}
//     loading = false;
//     setState(() {});
//   }

//   var deepLink;
//   void createOrder() async {
//     if (loading) {
//       return;
//     }
//     loading = true;
//     setState(() {});
//     var merchantId = idText.text;
//     var merchantKey = keyText.text;
//     var goods = nameText.text;
//     var amount = amountText.text;
//     var ccy = usdText.text;
//     var v = versionText.text;
//     var notifyUrl = notifyText.text;
//     var returnUrl = returnText.text;
//     var language = langText.text;
//     // var orderId = SignUtil.RandomString(10);
//     orderIdText.text = orderId;
//     var map = {
//       'currency': "USD",
//       'goodsDetail': "0001",
//       'lang': "EN",
//       'mcAbridge': 'test',
//       'mcId': '1674724041055870978',
//       'mcOrderId': "1044017",
//       'money': "17",
//       'returnUrl': "https://itckfa.page.link/kfalink",
//       'notifyUrl':
//           "https:www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_upay/58/8899",
//       'version': 'V1',
//     };
//     var sign = SignUtil.getSign(map, merchantKey);
//     map['sign'] = sign;
//     signText.text = sign;
// //upayDeeplink
//     try {
//       var response = await Dio().post(appUrl, data: map);
//       if (response.statusCode == 200) {
//         var data = response.data;
//         var upayDeeplink = data['data']['upayDeeplink'].toString();
//         // print('upayDeeplink_Pov = $upayDeeplink');
//         // ignore: deprecated_member_use
//         launch(
//           '$upayDeeplink',
//           forceSafariVC: false,
//           forceWebView: false,
//         );
//       } else {
//         showErrorDialog(response.statusMessage ?? '');
//       }
//     } catch (e) {
//       showErrorDialog(e.toString());
//     }
//     loading = false;
//     setState(() {});
//   }

//   void showErrorDialog(String error) {
//     showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       // false = user must tap button, true = tap outside dialog
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: Text('title'),
//           content: Text(error),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Done'),
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(); // Dismiss alert dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static String RandomString(int strlen) {
//     var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
//     Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
//     String result = "";
//     for (var i = 0; i < strlen; i++) {
//       result += chars[rnd.nextInt(chars.length)];
//     }
//     return result;
//   }

//   bool success_payment = false;
//   Future<void> Load(BuildContext context) async {
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_done_upay?mcOrderId=${orderId}'));
//     var jsonData = jsonDecode(rs.body);

//     if (success_payment && !call_back) {
//       await payment_done();
//     }
//     setState(() {
//       if (jsonData.toString() == orderId.toString()) {
//         success_payment = true;
//       }
//     });
//   }

//   bool call_back = false;
//   Future<void> payment_done() async {
//     var count_number = widget.option!.split(' ');
//     final Data = {
//       "id_user_control": widget.control_user.toString(),
//       "count_autoverbal": count_number[0].toString(),
//     };
//     final response = await http.post(
//       Uri.parse(
//           'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(Data),
//     );
//     setState(() {
//       success_payment = false;
//       call_back = true;
//     });
//     Navigator.pop(context);
//     Navigator.pop(context);
//   }

//   bool isChecked = false;
//   Future _saved(image, BuildContext context) async {
//     final result = await ImageGallerySaver.saveImage(image);
//   }

//   TextEditingController roll_id = TextEditingController();
//   int count = 0;
//   @override
//   void initState() {
//     super.initState();
//     idText.text = '1674724041055870978';
//     keyText.text = '3142e7560039d1661121992cfaafe17e';
//     nameText.text = widget.option ?? "";
//     amountText.text = widget.price ?? "";
//     usdText.text = 'USD';
//     versionText.text = 'V1';
//     notifyText.text =
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_upay/58/8899';
//     returnText.text = 'https://itckfa.page.link/kfalink';
//     langText.text = 'EN';
//     createOrderQR();
//   }

//   ScreenshotController screenshotController = ScreenshotController();
//   @override
//   Widget build(BuildContext context) {
//     // var now = DateTime.now();
//     // var formatterDate = DateFormat('dd/MM/yy kk:mm');
//     // var dateTime = DateFormat('yyyy-MM-ddThh:mm:ss');

//     // String actualDate = formatterDate.format(now);
//     // String actualDate1 = dateTime.format(now);
//     Future.delayed(const Duration(seconds: 15), () async {
//       await Load(context);
//     });

//     return Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Color.fromRGBO(49, 27, 146, 1),
//               )),
//           title: Text(
//             "Scan for payments",
//             style: TextStyle(
//                 color: const Color.fromRGBO(49, 27, 146, 1),
//                 fontSize: MediaQuery.textScaleFactorOf(context) * 18,
//                 fontWeight: FontWeight.w900),
//           ),
//           centerTitle: true,
//           actions: [
//             IconButton(
//                 onPressed: () async {
//                   await screenshotController
//                       .capture(delay: const Duration(milliseconds: 10))
//                       .then((capturedImage) async {
//                     await _saved(capturedImage, context);
//                     const snackBar = SnackBar(
//                       content: Text('Photo saved'),
//                     );
//                     // ignore: use_build_context_synchronously
//                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   }).catchError((onError) {
//                     // print(onError);
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.photo_camera_back_outlined,
//                   color: Color.fromRGBO(49, 27, 146, 1),
//                   size: 35,
//                   shadows: [
//                     Shadow(
//                         offset: Offset(3, -3),
//                         blurRadius: 5,
//                         color: Colors.black54)
//                   ],
//                 ))
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 color: Colors.white,
//                 height: MediaQuery.of(context).size.height * 0.13,
//                 width: double.infinity,
//                 alignment: Alignment.topCenter,
//                 child: Image.asset(
//                   'assets/images/New_KFA_Logo_pdf.png',
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {
//                     setState(() {
//                       showConfirmationBottomSheet(context);
//                     });
//                   },
//                   child: Text('QR')),
//               if (url_qr != null)
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 45),
//                   child: Center(
//                     child: BarcodeWidget(
//                         width: 226,
//                         height: 226,
//                         barcode: Barcode.qrCode(),
//                         data: url_qr,
//                         color: Colors.black,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         backgroundColor: Colors.white),
//                   ),
//                 )
//               else
//                 Text('No url_qr'),
//               // if (url_qr != null)
//               //   Screenshot(
//               //     controller: screenshotController,
//               //     child: Container(
//               //       height: 465,
//               //       width: MediaQuery.of(context).size.width * 0.9,
//               //       padding: const EdgeInsets.only(top: 65),
//               //       decoration: BoxDecoration(
//               //           borderRadius: BorderRadius.circular(30),
//               //           image: const DecorationImage(
//               //               image: AssetImage("assets/images/logoqr.png"),
//               //               fit: BoxFit.fill)),
//               //       child: Column(
//               //         crossAxisAlignment: CrossAxisAlignment.start,
//               //         children: [
//               //           const SizedBox(
//               //             height: 10,
//               //           ),
//               //           Text(
//               //             "\t\t\t\t\t\t\t\tKFA",
//               //             style: TextStyle(
//               //                 color: const Color.fromRGBO(121, 121, 121, 1),
//               //                 fontWeight: FontWeight.w700,
//               //                 fontSize:
//               //                     MediaQuery.textScaleFactorOf(context) * 20),
//               //           ),
//               //           Text(
//               //             "\t\t\t\t\t\t\t\t${widget.price ?? ""} \$",
//               //             style: TextStyle(
//               //                 color: const Color.fromRGBO(63, 63, 63, 1),
//               //                 fontWeight: FontWeight.w700,
//               //                 fontSize:
//               //                     MediaQuery.textScaleFactorOf(context) * 20),
//               //           ),
//               //           //  Text(
//               //           //   '------------------------------------------------',
//               //           //   style: TextStyle(
//               //           //     overflow: TextOverflow.ellipsis,
//               //           //   ),
//               //           // ),
//               //         ],
//               //       ),
//               //     ),
//               //   )
//               // else
//               //   Container(
//               //     height: 400,
//               //     color: Colors.white,
//               //     margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
//               //   ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 height: 50,
//                 child: Text(
//                   'Scan with Bakong App Or Mobile Banking app that support KHQR',
//                   style: TextStyle(
//                       overflow: TextOverflow.visible,
//                       color: const Color.fromRGBO(158, 158, 158, 1),
//                       fontWeight: FontWeight.w500,
//                       fontSize: MediaQuery.textScaleFactorOf(context) * 10),
//                 ),
//               ),
//               if (success_payment)
//                 GFCheckboxListTile(
//                   titleText: 'Payment Success',
//                   size: 20,
//                   activeBgColor: Colors.green,
//                   color: Colors.white,
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
//                   listItemTextColor: const Color.fromARGB(255, 0, 0, 0),
//                   type: GFCheckboxType.square,
//                   activeIcon: const Icon(
//                     Icons.check,
//                     size: 15,
//                     color: Colors.white,
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       success_payment = value;
//                     });
//                   },
//                   value: success_payment,
//                   inactiveIcon: null,
//                 ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Subtotal',
//                       style: TextStyle(
//                           overflow: TextOverflow.visible,
//                           color: const Color.fromRGBO(158, 158, 158, 1),
//                           fontWeight: FontWeight.w800,
//                           fontSize: MediaQuery.textScaleFactorOf(context) * 11),
//                     ),
//                     // Text(' ${count.toString()}'),
//                     Text(
//                       " ${widget.price} USD",
//                       style: TextStyle(
//                           overflow: TextOverflow.visible,
//                           color: const Color.fromRGBO(158, 158, 158, 1),
//                           fontWeight: FontWeight.w800,
//                           fontSize: MediaQuery.textScaleFactorOf(context) * 11),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 thickness: 1,
//                 color: Colors.black,
//                 indent: 50,
//                 endIndent: 50,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'V-Point',
//                       style: TextStyle(
//                           overflow: TextOverflow.visible,
//                           color: const Color.fromRGBO(158, 158, 158, 1),
//                           fontWeight: FontWeight.w800,
//                           fontSize: MediaQuery.textScaleFactorOf(context) * 11),
//                     ),
//                     Text(
//                       " ${widget.option}",
//                       style: TextStyle(
//                           overflow: TextOverflow.visible,
//                           color: const Color.fromRGBO(158, 158, 158, 1),
//                           fontWeight: FontWeight.w800,
//                           fontSize: MediaQuery.textScaleFactorOf(context) * 11),
//                     ),
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Text(
//                   '................................................................................................................................',
//                   style: TextStyle(
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Total:',
//                       style: TextStyle(
//                           overflow: TextOverflow.visible,
//                           color: const Color.fromRGBO(158, 158, 158, 1),
//                           fontWeight: FontWeight.w800,
//                           fontSize: MediaQuery.textScaleFactorOf(context) * 12),
//                     ),
//                     Text(
//                       " ${widget.price} USD",
//                       style: TextStyle(
//                           overflow: TextOverflow.visible,
//                           color: const Color.fromRGBO(158, 158, 158, 1),
//                           fontWeight: FontWeight.w800,
//                           fontSize: MediaQuery.textScaleFactorOf(context) * 12),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ));
//   }
// }

// class SignUtil {
//   static StringBuffer getKeys(Map<String, String> inMap, List<String> keys) {
//     StringBuffer sbf = StringBuffer();
//     for (var i = 0; i < keys.length; i++) {
//       var key = keys[i];
//       if (key != 'sign' && key.isNotEmpty) {
//         var value = inMap[key];
//         if (value == '' || value == null) {
//           continue;
//         }
//         sbf
//           ..write(key)
//           ..write('=')
//           ..write(value);
//         if (i != (keys.length - 1)) {
//           sbf.write('&');
//         }
//       }
//     }
//     return sbf;
//   }

//   static String generateMD5(String data) {
//     // print(data);
//     Uint8List content = const Utf8Encoder().convert(data);
//     Digest digest = md5.convert(content);
//     return digest.toString();
//   }

//   static String getSign(Map<String, String> inMap, String secretKey) {
//     var keys = <String>[];
//     keys.addAll(inMap.keys);
//     keys.sort();
//     var sbf = getKeys(inMap, keys);
//     sbf.write(secretKey);
//     // print(sbf.toString());
//     return generateMD5(sbf.toString()).toUpperCase();
//   }

//   var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

//   String RandomString(int strlen) {
//     Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
//     String result = "";
//     for (var i = 0; i < strlen; i++) {
//       result += chars[rnd.nextInt(chars.length)];
//     }
//     return result;
//   }
// }
