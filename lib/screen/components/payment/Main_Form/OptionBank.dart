import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itckfa/screen/components/payment/ABA/Aba.dart';
import '../../../../Getx/Auto_Verbal/autu_verbal.dart';
import '../../../../Getx/Bank/UPay/upay_bank.dart';
import '../../../../Getx/Bank/Wing/wing_bank.dart';
import '../../../../Option/components/colors.dart';
import '../../../../Option/components/contants.dart';
import '../UPAY/UPay_qr.dart';
import '../WING/Wing_qr.dart';

class OptionPayment extends StatefulWidget {
  OptionPayment({
    super.key,
    this.set_phone,
    required this.playerID,
    this.up_point,
    this.id_user,
    this.price,
    this.set_email,
    this.option,
    this.set_id_user,
    this.id_verbal,
  });
  final String? set_phone;
  final String? up_point;
  final String? id_user;
  var price;
  var set_email;
  var option;
  var set_id_user;
  final String? id_verbal;
  final String playerID;
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
  UpayBank upayBank = UpayBank();
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
  var order_reference_no;
  bool check_wing = false;

  WingBank wingBank = WingBank();
  int count = 0;

  @override
  void initState() {
    super.initState();
    // main();
  }

  Future<void> createorder(String price) async {
    setState(() {
      Get.back();
      wingBank.checkStatus.value = '';
      checkApp = true;
    });
    await Future.wait([
      wingBank.createOrderWing(
        price,
        thierPlan,
        context,
        widget.set_id_user,
      )
    ]);
    setState(() {
      checkApp = false;
    });
  }

  bool checkApp = false;
  AuthVerbal authVerbal = AuthVerbal(Iduser: "");
  @override
  Widget build(BuildContext context) {
    authVerbal = Get.put(AuthVerbal(Iduser: widget.set_id_user.toString()));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 246, 246),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kwhite_new,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context);
            dispose();
          },
        ),
        title: const Text('Option Payment'),
      ),
      body: checkApp
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                            var tranIdRef = RandomString(10);
                            if (widget.id_verbal == null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ABA(
                                    id_set_use: widget.set_id_user,
                                    option: widget.option,
                                    price: widget.price,
                                    tran_id: tranIdRef,
                                    set_email: widget.set_email,
                                    set_phone: widget.set_phone.toString(),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ABA(
                                    id_set_use: widget.set_id_user,
                                    option: widget.option,
                                    price: widget.price,
                                    tran_id: tranIdRef,
                                    set_email: widget.set_email,
                                    set_phone: widget.set_phone.toString(),
                                    id_verbal: widget.id_verbal ?? '',
                                  ),
                                ),
                              );
                            }
                          } else {
                            alertDialog(
                              context,
                              widget.price,
                              widget.set_email ?? "",
                              widget.option,
                              index,
                            );
                          }
                        });
                      },
                      child: Card(
                        elevation: 7,
                        child: SizedBox(
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
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${text_bank[index]['bank']}",
                                          style: TextStyle(
                                            overflow: TextOverflow.visible,
                                            color: const Color.fromARGB(
                                              255,
                                              21,
                                              21,
                                              21,
                                            ),
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                MediaQuery.textScaleFactorOf(
                                                      context,
                                                    ) *
                                                    14,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${text_bank[index]['subscrip']}",
                                          style: TextStyle(
                                            overflow: TextOverflow.visible,
                                            color: const Color.fromRGBO(
                                              158,
                                              158,
                                              158,
                                              1,
                                            ),
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                MediaQuery.textScaleFactorOf(
                                                      context,
                                                    ) *
                                                    12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromARGB(
                                            255, 242, 240, 240),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color:
                                            Color.fromARGB(255, 171, 169, 169),
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

  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  int? thierPlan;
  String RandomString(int strlen) {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  late Timer _timer;

  Future<void> main() async {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      wingBank.checkTransection(wingBank.orderReferenceNo);
      // print(
      //     "*********(${wingBank.checkStatus.value} || ${wingBank.orderReferenceNo})");
      if (wingBank.checkStatus.value == "OK") {
        _timer.cancel();
        await authVerbal.checkVpoint(widget.set_id_user!);
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
          padding: const EdgeInsets.only(
            right: 50,
            left: 50,
            top: 20,
            bottom: 20,
          ),
          borderColor: const Color.fromARGB(255, 48, 47, 47),
          borderWidth: 1.0,
          borderRadius: 5,
          backgroundColor: const Color.fromARGB(255, 235, 242, 246),
          icon: const Icon(Icons.add_alert),
        );
        Get.back();
      }
    });
  }

  bool checkdeeplink = false;
  List<Image> setImages = [
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
  List<Text> setTitle = [
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
  List<String> setSubtitle = [
    'ABA KHQR',
    'U-Pay',
    'Wing',
  ];
  List qrImage = [
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
  List textBank = [
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
  Future<void> alertDialog(
    BuildContext context,
    var price,
    String account,
    String option,
    int index,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please choose option'),
          titleTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      widget.id_verbal;
                      var countNumber = widget.option!.split(' ');
                      if (countNumber[4] == "Day") {
                        thierPlan = 1;
                      } else if (countNumber[4] == "Week") {
                        thierPlan = 7;
                      } else if (countNumber[4] == "Mount") {
                        thierPlan = 30;
                      }
                    });
                    if (index == 1) {
                      await upayBank.createOrder(
                        price,
                        // "${widget.control_user}/${widget.price}/$thierPlan",
                        "${widget.set_id_user}/1.00/$thierPlan",
                        context,
                      );
                    } else if (index == 2) {
                      // await createOrder_Wing(price, option, context);
                      createorder(price);

                      main();
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
                                child: setImages.elementAt(index),
                              ),
                              setTitle.elementAt(index),
                            ],
                          ),
                        ),
                        Text(
                          "Tap to pay with ${setSubtitle.elementAt(index)} Bank",
                          style: TextStyle(
                            overflow: TextOverflow.visible,
                            color: const Color.fromRGBO(158, 158, 158, 1),
                            fontWeight: FontWeight.w500,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (index == 2) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Qr_Wing(
                            playerID: widget.playerID,
                            price: price,
                            accont: account,
                            phone: widget.set_phone!,
                            option: option,
                            id: widget.id_user ?? 'set',
                            control_user: widget.set_id_user,
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Qr_UPay(
                            playerID: widget.playerID,
                            price: price,
                            accont: account,
                            phone: widget.set_phone!,
                            option: option,
                            id: widget.set_id_user ?? 'set',
                            control_user: widget.set_id_user,
                          ),
                        ),
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
                                      '${qrImage[index]['image']}',
                                    ),
                                  ),
                                ),
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
                              "${textBank[index]['bank']}",
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                                color: const Color.fromARGB(255, 21, 21, 21),
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${textBank[index]['subscrip']}",
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                                color: const Color.fromRGBO(158, 158, 158, 1),
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 9,
                              ),
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
                _timer.cancel();

                // dispose();
              },
            ),
          ],
        );
      },
    );
  }
}
