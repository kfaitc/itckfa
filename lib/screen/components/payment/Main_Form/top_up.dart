// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:itckfa/Option/components/colors.dart';
import 'package:itckfa/Option/components/contants.dart';
import 'package:itckfa/screen/Home/Home.dart';
import 'package:itckfa/screen/components/payment/Main_Form/OptionBank.dart';
import 'package:crypto/crypto.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../../Getx/Auto_Verbal/autu_verbal.dart';
import 'Transtoin_history.dart';

class TopUp extends StatefulWidget {
  const TopUp({
    super.key,
    this.set_phone,
    this.up_point,
    this.id_user,
    this.set_id_user,
    this.set_email,
    this.id_verbal,
  });
  final String? set_phone;
  final String? up_point;
  final String? id_user;
  final String? set_id_user;
  final String? set_email;
  final String? id_verbal;

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  int count_time = 0;
  List list_User_by_id = [];

  AuthVerbal authVerbal = AuthVerbal(Iduser: "");
  @override
  void initState() {
    // mainPlayerID();
    super.initState();
    // check();
  }

  String playerId = '';
  void mainPlayerID() {
    OneSignal.shared.getDeviceState().then((deviceState) {
      if (deviceState != null) {
        setState(() {
          playerId = deviceState.userId!;
        });
        // print("OneSignal Player ID: $playerId");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    authVerbal = Get.put(AuthVerbal(Iduser: widget.set_id_user.toString()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        title: const Text(
          "V-Point",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, const HomePage1());
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        actions: [
          GFIconButton(
            padding: const EdgeInsets.all(1),
            onPressed: () {},
            icon: const Icon(
              Icons.question_mark,
              color: Colors.white,
              size: 20,
            ),
            color: Colors.white,
            type: GFButtonType.outline2x,
            size: 10,
            iconSize: 30.0,
            disabledColor: Colors.white,
            shape: GFIconButtonShape.circle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () {
            if (authVerbal.isAuthGet.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (authVerbal.listCheckVP.isEmpty) {
              return const SizedBox();
            } else {
              return Column(
                children: [
                  Container(
                    height: 135,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                        colors: [kwhite_new, kwhite_new, Colors.blue],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                padding: const EdgeInsets.all(5),
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/v.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                authVerbal.countAccount.value.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.amber[800],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  authVerbal.checkVpoint(widget.set_id_user);
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: whiteColor,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Icon(
                                    Icons.account_circle_outlined,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.set_email ?? "",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: GFButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Transtoin_History(
                                            id: widget.set_id_user,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  text: "Transaction history",
                                  // text: widget.set_id_user,
                                  textColor: Colors.white,
                                  textStyle: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                  type: GFButtonType.outline,
                                  shape: GFButtonShape.pills,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: 220,
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                            color: kImageColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: kImageColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tariff Plans for ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "ONE DAY",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        decorationStyle:
                                            TextDecorationStyle.dashed,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // print(widget.set_id_user.toString());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OptionPayment(
                                              playerID: playerId,
                                              id_user: widget.id_user,
                                              set_email: widget.set_email ?? "",
                                              set_phone: widget.set_phone,
                                              option: '1  V / Day',
                                              price: '0.01',
                                              up_point: widget.up_point,
                                              set_id_user:
                                                  widget.set_id_user.toString(),
                                              id_verbal: widget.id_verbal,
                                            ),
                                          ),
                                        );
                                      },
                                      child: optionV(
                                        "1",
                                        "1.0",
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OptionPayment(
                                              playerID: playerId,
                                              id_user: widget.id_user,
                                              set_email: widget.set_email ?? "",
                                              set_phone: widget.set_phone,
                                              option: '3  V / Day',
                                              price: '2.50',
                                              up_point: widget.up_point,
                                              set_id_user: widget.set_id_user,
                                              id_verbal: widget.id_verbal,
                                            ),
                                          ),
                                        );
                                      },
                                      child: optionV(
                                        "3",
                                        "2.5",
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OptionPayment(
                                              playerID: playerId,
                                              id_user: widget.id_user,
                                              set_email: widget.set_email ?? "",
                                              set_phone: widget.set_phone,
                                              option: '5  V / Day',
                                              price: '3.00',
                                              up_point: widget.up_point,
                                              set_id_user: widget.set_id_user,
                                              id_verbal: widget.id_verbal,
                                            ),
                                          ),
                                        );
                                      },
                                      child: optionV(
                                        "5",
                                        "3.0",
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OptionPayment(
                                              playerID: playerId,
                                              id_user: widget.id_user,
                                              set_email: widget.set_email ?? "",
                                              set_phone: widget.set_phone,
                                              option: '6  V / Day',
                                              price: '5.00',
                                              up_point: widget.up_point,
                                              set_id_user: widget.set_id_user,
                                              id_verbal: widget.id_verbal,
                                            ),
                                          ),
                                        );
                                      },
                                      child: optionV(
                                        "6",
                                        "5.0",
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OptionPayment(
                                                playerID: playerId,
                                                id_user: widget.id_user,
                                                set_email:
                                                    widget.set_email ?? "",
                                                set_phone: widget.set_phone,
                                                option: '8  V / Day',
                                                price: '6.50',
                                                up_point: widget.up_point,
                                                set_id_user: widget.set_id_user,
                                                id_verbal: widget.id_verbal,
                                              ),
                                            ),
                                          );
                                        },
                                        child: optionV(
                                          "8",
                                          "6.5",
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OptionPayment(
                                                playerID: playerId,
                                                id_user: widget.id_user,
                                                set_email:
                                                    widget.set_email ?? "",
                                                set_phone: widget.set_phone,
                                                option: '10  V / Day',
                                                price: '8.00',
                                                up_point: widget.up_point,
                                                set_id_user: widget.set_id_user,
                                                id_verbal: widget.id_verbal,
                                              ),
                                            ),
                                          );
                                        },
                                        child: optionV(
                                          "10",
                                          "8.0",
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: 210,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: kImageColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "Tariff Plans for",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Week&Month",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              decorationStyle:
                                                  TextDecorationStyle.dashed,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 0),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OptionPayment(
                                          playerID: playerId,
                                          id_user: widget.id_user,
                                          set_email: widget.set_email ?? "",
                                          set_phone: widget.set_phone,
                                          option: '5  V / Week',
                                          price: '10.00',
                                          up_point: widget.up_point,
                                          set_id_user: widget.set_id_user,
                                          id_verbal: widget.id_verbal,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    child: ListTile(
                                      minVerticalPadding: 5,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Use ",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "5 VERBAL CKECK",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 13,
                                              decorationStyle:
                                                  TextDecorationStyle.dotted,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          Text(
                                            " for ",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "1 week",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 13,
                                              decorationStyle:
                                                  TextDecorationStyle.dashed,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text("10 \$"),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OptionPayment(
                                          playerID: playerId,
                                          id_user: widget.id_user,
                                          set_email: widget.set_email ?? "",
                                          set_phone: widget.set_phone,
                                          option: '40  V / Mount',
                                          price: '30.00',
                                          up_point: widget.up_point,
                                          set_id_user: widget.set_id_user,
                                          id_verbal: widget.id_verbal,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    child: ListTile(
                                      minVerticalPadding: 5,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Use ",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "40 VERBAL CKECK",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 13,
                                              decorationStyle:
                                                  TextDecorationStyle.dotted,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          Text(
                                            " for ",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "1 month",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 13,
                                              decorationStyle:
                                                  TextDecorationStyle.dashed,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text("30 \$"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Positioned(
                        //     right: 15,
                        //     child: Image.asset(
                        //       "assets/images/pay.png",
                        //       width: 125,
                        //     ))
                      ],
                    ),
                  ),
                  Image.asset("assets/images/mobile_payment.png")
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget optionV(String v, String price) {
    return Container(
      margin: const EdgeInsets.all(6),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(80),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            offset: Offset(1.0, 7.0),
          )
        ],
        border: Border.all(
          width: 1,
        ),
      ),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: Image.asset(
                  "assets/images/v.png",
                ),
              ),
              Text(
                v,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.amber[800],
                ),
              )
            ],
          ),
          Text(
            "\$$price",
            style: const TextStyle(
              fontSize: 17,
              color: Color.fromARGB(
                255,
                242,
                11,
                134,
              ),
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline,
            ),
          )
        ],
      ),
    );
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
