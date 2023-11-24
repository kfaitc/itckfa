import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itckfa/screen/components/payment/class/Aba.dart';
import 'package:itckfa/screen/components/payment/componnet/GetVpoint.dart';

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
  @override
  void dispose() {
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
                        "${widget.set_id_user}24K${Random().nextInt(100)}F${Random().nextInt(1000) + 10}A";
                    print("\n" + widget.set_id_user + "\n");
                    if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ABA(
                              id_set_use: widget.set_id_user,
                              option: widget.option,
                              price: widget.price,
                              tran_id: order_reference_no,
                            ),
                          ));
                    } else if (index == 1) {
                      alertDialog(context, widget.price, widget.set_email ?? "",
                          widget.option, index);
                    } else {
                      alertDialog(context, widget.price, widget.set_email ?? "",
                          widget.option, index);

                      _showCustomSnackbar(
                          context, 'Payment not successful please try again');
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
                    order_reference_no =
                        "${widget.set_id_user}24K${Random().nextInt(100)}F${Random().nextInt(1000) + 10}A";
                    if (index == 0) {}
                    if (index == 1) {
                      await upay.createOrder(
                          price, widget.option, widget.set_id_user, context);
                    } else {
                      // await createOrder_Wing(price, option, context);
                      wing.createOrder_Wing(price, option, context);
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
                    if (index == 0) {
                    } else if (index == 1) {
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
                    } else {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Qr_UPay(
                                  price: price,
                                  accont: account,
                                  phone: widget.set_phone!,
                                  option: option,
                                  id: widget.id_user ?? 'set',
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
              },
            ),
          ],
        );
      },
    );
  }
}
