import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:itckfa/screen/components/payment/ABA/Aba.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../afa/components/contants.dart';
import '../UPAY/UPay_qr.dart';
import '../WING/Wing_qr.dart';
import '../UPAY/UPAY.dart';
import '../WING/WING.dart';

class OptionPayment extends StatefulWidget {
  OptionPayment({
    super.key,
    this.set_phone,
    this.up_point,
    this.id_user,
    this.price,
    this.set_email,
    this.option,
    this.set_id_user,
  });
  final String? set_phone;
  final String? up_point;
  final String? id_user;
  var price;
  var set_email;
  var option;
  var set_id_user;

  @override
  State<OptionPayment> createState() => _OptionPaymentState();
}

class _OptionPaymentState extends State<OptionPayment> {
  List<Image> set_images = [
    Image.asset(
      'assets/images/UPAY-logo.png',
      fit: BoxFit.scaleDown,
    ),
    Image.asset(
      'assets/images/WingBank-Logo_Square.png',
      fit: BoxFit.scaleDown,
    ),
    Image.asset(
      'assets/images/Partners/KHQR.png',
      fit: BoxFit.scaleDown,
    ),
  ];
  List<Text> set_title = [
    const Text(
      'U-Pay Pay',
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Wing Pay',
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ),
    const Text(
      'PayWay',
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ),
  ];
  // List<String> set_Subtitle = [
  //   'U-Pay',
  //   'Wing',
  //   'ABA',
  // ];
  List Qr_Image = [
    {
      'image': 'assets/images/Partners/KHQR.png',
    },
    {
      'image': 'assets/images/UPAY-logo.png',
    },
    {
      'image': 'assets/images/WingBank-Logo_Square.png',
    },
  ];
  List text_bank = [
    {
      'bank': 'ABA KHQR',
      'subscrip': 'Scan to pay with any banking app',
    },
    {
      'bank': 'U-Pay KHQR',
      'subscrip': 'Tap to pay with KHQR',
    },
    {
      'bank': 'Wing KHQR',
      'subscrip': 'Tap to pay with KHQR',
    },
  ];

  UPAY upay = UPAY();
  WING wing = WING();

  var order_reference_no;
  late Timer _timer;
  bool check_wing = false;
  Future check_traslation_wing(order_reference_no) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/checkdone/wing?order_reference_no=$order_reference_no'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        print("kokok\n\n\n");
      });
      if (jsonResponse["status"].toString() == "OK") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Payment',
          desc: jsonResponse["message"],
          autoHide: Duration(seconds: 3),
          onDismissCallback: (type) {
            dispose();
            setState(() {
              check_wing = true;
            });
            Navigator.pop(context);
          },
        ).show();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _await(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  var token;
  var accessToken;
  Future<bool> createOrder_Wing(price, option, context) async {
    // Navigator.pop(context);
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Test_token');
    var body = {
      // 'username': 'online.mangogame',
      // 'username': 'online.kfausd',
      // 'password': '914bade01fd32493a0f2efc583e1a5f6',
      // 'grant_type': 'password',
      // 'client_id': 'third_party',
      // 'client_secret': '16681c9ff419d8ecc7cfe479eb02a7a',
    };

    // Encode the body as a form-urlencoded string
    // var requestBody = Uri(queryParameters: body).query;

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonResponse = jsonDecode(response.body);
      accessToken = jsonResponse['access_token'];

      var parts = accessToken.split('-');
      token = '${parts[0]}${parts[1]}${parts[2]}${parts[3]}${parts[4]}';

      print('accessToken: ${accessToken}');
      print('token: ${token}');
      print('Price : $price');

      // await deeplink_hask(token);
      if (token != null) {
        await deeplinkHask(accessToken, token, price, option, context);

        return true;
      }
    } else {
      print('T: Request failed with status: ${response.statusCode}');
      print('T: Response: ${response.body}');
      return false;
    }
    return false;
  }

  var deeplink_hask;
  Future<void> deeplinkHask(accessToken, token, price, option, context) async {
    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/DeepLink_Hask');
    final request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'str':
          '$price#USD#00432#$order_reference_no#https://oneclickonedollar.com/app',
      'key': '$token',
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      deeplink_hask = jsonResponse['Deeplink_Hask'];
      if (deeplink_hask != null) {
        await call_back_wing(context, price);
      }
    } else {
      print('D: Request failed with status: ${response.reasonPhrase}');
    }
  }

  var redirect_url;

  Future call_back_wing(BuildContext context, price) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/LinkWing'));
    request.body = json.encode({
      "order_reference_no": "$order_reference_no",
      "amount": "$price",
      "txn_hash": "$deeplink_hask",
      "accessToken": "$accessToken"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      redirect_url = jsonResponse['redirect_url'];
      print("\n$redirect_url\n");
      // await launchUrl(Uri.parse(redirect_url));
      await openDeepLink("$redirect_url");
    } else {
      print(response.reasonPhrase);
    }
  }

  Future openDeepLink(var qrString) async {
    if (Platform.isIOS) {
      try {
        // ignore: deprecated_member_use
        bool check_link = await launchUrl(Uri.parse(qrString));
        if (check_link == false) {
          final playStoreUrl = 'https://onelink.to/dagdt6';
          // ignore: deprecated_member_use
          if (await canLaunch(playStoreUrl)) {
            // ignore: deprecated_member_use
            await launch(playStoreUrl);
          } else {
            throw 'Could not launch $playStoreUrl';
          }
        }
      } catch (e) {}
    } else if (Platform.isAndroid) {
      try {
        // ignore: deprecated_member_use
        bool check_link = await launch(qrString);

        if (check_link == false) {
          final playStoreUrl = 'https://onelink.to/dagdt6';
          // ignore: deprecated_member_use
          if (await canLaunch(playStoreUrl)) {
            // ignore: deprecated_member_use
            await launch(playStoreUrl);
          } else {
            throw 'Could not launch $playStoreUrl';
          }
        }
      } catch (e) {
        if (Platform.isAndroid) {
          final playStoreUrl = 'https://onelink.to/dagdt6';
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
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 246, 246),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kwhite_new,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context);
            dispose();
          },
        ),
        title: const Text('Option Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: text_bank.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: InkWell(
                onTap: () {
                  setState(() {
                    order_reference_no =
                        "${widget.set_id_user}24K${RandomString(2)}F${RandomString(3)}A";

                    if (index == 0) {
                      var tran_id_ref = RandomString(10);
                      if (tran_id_ref != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ABA(
                                id_set_use: widget.set_id_user,
                                option: widget.option,
                                price: widget.price,
                                tran_id: tran_id_ref,
                                set_email: widget.set_email,
                                set_phone: widget.set_phone.toString(),
                              ),
                            ));
                      }
                    } else {
                      alertDialog(context, widget.price, widget.set_email ?? "",
                          widget.option, index);
                    }
                  });
                },
                child: Card(
                  elevation: 7,
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        '${Qr_Image[index]['image']}',
                                      ),
                                    )),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${text_bank[index]['bank']}",
                                    style: TextStyle(
                                        overflow: TextOverflow.visible,
                                        color: const Color.fromARGB(
                                            255, 21, 21, 21),
                                        fontWeight: FontWeight.w500,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${text_bank[index]['subscrip']}",
                                    style: TextStyle(
                                        overflow: TextOverflow.visible,
                                        color: const Color.fromRGBO(
                                            158, 158, 158, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            12),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 242, 240, 240)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Color.fromARGB(255, 171, 169, 169),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future _showCustomSnackbar(BuildContext context, String message) async {
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

  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  String RandomString(int strlen) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  Future<void> alertDialog(BuildContext context, var price, String account,
      String option, int index) {
    List<Image> set_images = [
      Image.asset(
        'assets/images/Partners/KHQR.png',
        fit: BoxFit.scaleDown,
      ),
      Image.asset(
        'assets/images/UPAY-logo.png',
        fit: BoxFit.scaleDown,
      ),
      Image.asset(
        'assets/images/WingBank-Logo_Square.png',
        fit: BoxFit.scaleDown,
      ),
    ];
    List<Text> set_title = [
      const Text(
        'PayWay',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const Text(
        'U-Pay Pay',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const Text(
        'Wing Pay',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ];
    List<String> set_Subtitle = [
      'ABA KHQR',
      'U-Pay',
      'Wing',
    ];
    List Qr_Image = [
      {
        'image': 'assets/images/Partners/KHQR.png',
      },
      {
        'image': 'assets/images/KHQR.jpg',
      },
      {
        'image': 'assets/images/KHQR.jpg',
      },
    ];
    List text_bank = [
      {
        'bank': 'ABA',
        'subscrip': 'Scan to pay with any banking app',
      },
      {
        'bank': 'U-Pay KHQR',
        'subscrip': 'Tap to pay with KHQR',
      },
      {
        'bank': 'Wing KHQR',
        'subscrip': 'Tap to pay with KHQR',
      },
    ];
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please choose option'),
          titleTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    // order_reference_no = SignUtil().RandomString(10).toString();
                    // order_reference_no =
                    //     "${widget.set_id_user}24K${RandomString(2)}F${Random().nextInt(10) + 10}A";

                    if (index == 1) {
                      await upay.createOrder(
                          price, widget.option, widget.set_id_user, context);
                    } else if (index == 2) {
                      setState(() {
                        if (check_wing == false) {
                          _await(context);
                          _timer =
                              Timer.periodic(Duration(seconds: 5), (timer) {
                            check_traslation_wing(order_reference_no);
                          });
                        }
                      });
                      await createOrder_Wing(price, option, context);
                    }
                  },
                  child: Card(
                    elevation: 10,
                    child: Row(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 60,
                                child: set_images.elementAt(index),
                              ),
                              set_title.elementAt(index),
                            ],
                          ),
                        ),
                        Text(
                          "Tap to pay with ${set_Subtitle.elementAt(index)} App",
                          style: TextStyle(
                              overflow: TextOverflow.visible,
                              color: const Color.fromRGBO(158, 158, 158, 1),
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 10),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (index == 2) {
                      // print(
                      //     'price = $price || account = $account || set_phone = ${widget.set_phone} || option = $option || id_user = ${widget.id_user} || set_id_user = ${getVpoint.set_id_user} ');
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Qr_Wing(
                                  price: price,
                                  accont: account,
                                  phone: widget.set_phone!,
                                  option: option,
                                  id: widget.id_user ?? 'set',
                                  control_user: widget.set_id_user,
                                )),
                      );
                    } else if (index == 1) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Qr_UPay(
                                  price: price,
                                  accont: account,
                                  phone: widget.set_phone!,
                                  option: option,
                                  id: widget.set_id_user ?? 'set',
                                  control_user: widget.set_id_user,
                                )),
                      );
                    }

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Card(
                    elevation: 10,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Card(
                              child: Container(
                                height: 50,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          '${Qr_Image[index]['image']}'),
                                    )),
                              ),
                            ),
                            const Text(
                              'KHQR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(width: 3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${text_bank[index]['bank']}",
                              style: TextStyle(
                                  overflow: TextOverflow.visible,
                                  color: const Color.fromARGB(255, 21, 21, 21),
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${text_bank[index]['subscrip']}",
                              style: TextStyle(
                                  overflow: TextOverflow.visible,
                                  color: const Color.fromRGBO(158, 158, 158, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          9),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                // dispose();
              },
            ),
          ],
        );
      },
    );
  }
}
