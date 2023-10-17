// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/screen/Home/Home.dart';
import 'package:itckfa/screen/components/payment/app_link_payment/app_link_upay.dart';
import 'package:itckfa/screen/components/payment/get_qrcode/UPay_qr.dart';
import 'package:itckfa/screen/components/payment/get_qrcode/Wing_qr.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Transtoin_history.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key, this.set_phone, this.up_point, this.id_user});
  final String? set_phone;
  final String? up_point;
  final String? id_user;
  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  int count_time = 0;
  List list_User_by_id = [];
  var set_id_user;
  var set_email;
  Future get_control_user(String id) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
    if (rs.statusCode == 200) {
      setState(() {
        var jsonData = jsonDecode(rs.body);
        list_User_by_id = jsonData;
        set_id_user = list_User_by_id[0]['control_user'].toString();
        set_email = list_User_by_id[0]['email'].toString();
      });
    }
  }

  int v_point = 0;
  Future<void> get_count() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_count?id_user_control=${set_id_user}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        v_point = jsonData;
        print(v_point);
      });
    }
  }

  Future<void> check() async {
    await get_control_user(widget.id_user.toString());
    get_count();
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    // check();
    setState(() {
      v_point;
    });
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
            Navigator.pop(context, HomePage1(id: widget.id_user));
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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.178,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.mirror,
                    colors: [kwhite_new, kwhite_new, Colors.blue],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
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
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          ' $v_point',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.amber[800],
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
                              set_email ?? "",
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Transtoin_History(
                                    id: widget.id_user,
                                  );
                                },
                              ));
                            },
                            text: "Transaction history",
                            textColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 10, color: Colors.white),
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
              width: MediaQuery.of(context).size.width * 1,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.35,
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
                                    fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "ONE DAY",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    decorationStyle: TextDecorationStyle.dashed,
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  BottomSheet(context, '1.00', set_email ?? "",
                                      '1  V / Day');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(1.0, 7.0))
                                    ],
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: Image.asset(
                                                  "assets/images/v.png")),
                                          Text(
                                            "1",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.amber[800],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "\$1.0",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                255, 242, 11, 134),
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BottomSheet(context, '2.50', set_email ?? "",
                                      '3  V / Day');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(1.0, 7.0))
                                    ],
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: Image.asset(
                                                  "assets/images/v.png")),
                                          Text(
                                            "3",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.amber[800],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "\$2.5",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                255, 242, 11, 134),
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BottomSheet(context, '3.00', set_email ?? "",
                                      '5  V / Day');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(1.0, 7.0))
                                    ],
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: Image.asset(
                                                  "assets/images/v.png")),
                                          Text(
                                            "5",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.amber[800],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "\$3.0",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                255, 242, 11, 134),
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  BottomSheet(context, '5.00', set_email ?? "",
                                      '6  V / Day');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(1.0, 7.0))
                                    ],
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: Image.asset(
                                                  "assets/images/v.png")),
                                          Text(
                                            "6",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.amber[800],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "\$5.0",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                255, 242, 11, 134),
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BottomSheet(context, '6.50', set_email ?? "",
                                      '8  V / Day');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(1.0, 7.0))
                                    ],
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: Image.asset(
                                                  "assets/images/v.png")),
                                          Text(
                                            "8",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.amber[800],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "\$6.5",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                255, 242, 11, 134),
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BottomSheet(context, '8.00', set_email ?? "",
                                      '10  V / Day');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(1.0, 7.0))
                                    ],
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: Image.asset(
                                                  "assets/images/v.png")),
                                          Text(
                                            "10",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.amber[800],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "\$8.0",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                255, 242, 11, 134),
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //     right: 15,
                  //     bottom: -1,
                  //     child: Image.asset(
                  //       "assets/images/pay.png",
                  //       width: 125,
                  //     ))
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 1,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "Tariff Plans for",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(
                                  height: 25,
                                  child: Row(
                                    children: [
                                      Text("Week&Month",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              decorationStyle:
                                                  TextDecorationStyle.dashed,
                                              decoration:
                                                  TextDecoration.underline)),
                                    ],
                                  )),
                              SizedBox(width: 0),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              BottomSheet(context, '10.00', set_email ?? "",
                                  '5  V / Week');
                            },
                            child: const Card(
                              color: Colors.white,
                              elevation: 5,
                              child: ListTile(
                                minVerticalPadding: 5,
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Use ",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    Text(
                                      "5 VERBAL CKECK",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 13,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          decoration: TextDecoration.underline),
                                    ),
                                    Text(
                                      " for ",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    Text(
                                      "1 week",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 13,
                                          decorationStyle:
                                              TextDecorationStyle.dashed,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                                subtitle: Text("10 \$"),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              BottomSheet(context, '30.00', set_email ?? "",
                                  '40  V / Mount');
                            },
                            child: const Card(
                              color: Colors.white,
                              elevation: 5,
                              child: ListTile(
                                minVerticalPadding: 5,
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Use ",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    Text(
                                      "40 VERBAL CKECK",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 13,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          decoration: TextDecoration.underline),
                                    ),
                                    Text(
                                      " for ",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    Text(
                                      "1 month",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 13,
                                          decorationStyle:
                                              TextDecorationStyle.dashed,
                                          decoration: TextDecoration.underline),
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
        ),
      ),
    );
  }

  Future BottomSheet(
      BuildContext context, String price, String account, String option) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Color.fromARGB(0, 33, 149, 243),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose bank for payment',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              const Divider(
                height: 5,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(3, -3),
                              color: kwhite_new)
                        ]),
                    child: InkWell(
                      onTap: () {
                        _dialogBuilder(
                            context, price, set_email ?? "", option, 0);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 65,
                            width: 65,
                            child: Image.asset(
                              'assets/images/UPAY-logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Text(
                            'U-PAY',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(3, -3),
                              color: kwhite_new)
                        ]),
                    child: InkWell(
                      onTap: () {
                        _dialogBuilder(
                            context, price, set_email ?? "", option, 1);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 65,
                            width: 65,
                            child: Image.asset(
                              'assets/images/wing.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Text(
                            'Wing',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(3, -3),
                              color: kwhite_new)
                        ]),
                    child: InkWell(
                      onTap: () {
                        _dialogBuilder(
                            context, price, set_email ?? "", option, 2);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 65,
                            width: 65,
                            child: Image.asset(
                              'assets/images/Partners/ABA_Logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Text(
                            'ABA',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(3, -3),
                              color: kwhite_new)
                        ]),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Qr_Wing(
                                    price: price,
                                    accont: account,
                                    phone: widget.set_phone!,
                                    option: option,
                                    id: widget.id_user ?? 'set',
                                    control_user: set_id_user,
                                  )),
                        );
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 65,
                            width: 65,
                            child: Image.asset(
                              'assets/images/bakong.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Text(
                            'Bakong',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context, var price, String account,
      String option, int index) {
    List<Image> set_images = [
      Image.asset(
        'assets/images/UPAY-logo.png',
        fit: BoxFit.scaleDown,
      ),
      Image.asset(
        'assets/images/wing.png',
        fit: BoxFit.scaleDown,
      ),
      Image.asset(
        'assets/images/Partners/ABA_Logo.png',
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
    List<String> set_Subtitle = [
      'U-Pay',
      'Wing',
      'ABA',
    ];

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('PLease choose option'),
          titleTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    if (index == 0) {
                      await createOrder_Upay(price, option, context);
                    } else if (index == 1) {
                      setState(() {
                        order_reference_no =
                            "K${Random().nextInt(100)}F${Random().nextInt(1000)}";
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
                              color: Color.fromRGBO(158, 158, 158, 1),
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
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Qr_UPay(
                                  price: price,
                                  accont: account,
                                  phone: widget.set_phone!,
                                  option: option,
                                  id: widget.id_user ?? 'set',
                                  control_user: set_id_user,
                                )),
                      );
                    } else if (index == 0) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Qr_Wing(
                                  price: price,
                                  accont: account,
                                  phone: widget.set_phone!,
                                  option: option,
                                  id: widget.id_user ?? 'set',
                                  control_user: set_id_user,
                                )),
                      );
                    } else {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Qr_Wing(
                                  price: price,
                                  accont: account,
                                  phone: widget.set_phone!,
                                  option: option,
                                  id: widget.id_user ?? 'set',
                                  control_user: set_id_user,
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
                        Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 60,
                                child: Image.asset(
                                  'assets/images/KHQR.jpg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              const Text(
                                'KHQR',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Tap to pay with KHQR",
                          style: TextStyle(
                              overflow: TextOverflow.visible,
                              color: Color.fromRGBO(158, 158, 158, 1),
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 10),
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

  // var intValue = Random().nextInt(99);

  var deeplink_hask;
  var token;
  var order_reference_no;
//Wing Token
  Future<void> createOrder_Wing(price, option, context) async {
    var accessToken;
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var url =
        await Uri.parse('https://ir.wingmoney.com:9443/RestEngine/oauth/token');
    var body = {
      'username': 'online.mangogame',
      'password': '914bade01fd32493a0f2efc583e1a5f6',
      'grant_type': 'password',
      'client_id': 'third_party',
      'client_secret': '16681c9ff419d8ecc7cfe479eb02a7a',
    };

    // Encode the body as a form-urlencoded string
    var requestBody = Uri(queryParameters: body).query;

    var response = await http.post(url, headers: headers, body: requestBody);

    if (response.statusCode == 200) {
      // Parse the JSON response
      setState(() {
        var jsonResponse = jsonDecode(response.body);
        accessToken = jsonResponse['access_token'];
        var parts = accessToken.split('-');
        token = '${parts[0]}${parts[1]}${parts[2]}${parts[3]}${parts[4]}';
      });
      if (token != null) {
        await deeplinkHask(accessToken, token, price, option, context);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

//Deeplink hask
  Future deeplinkHask(accessToken, token, price, option, context) async {
    print('or = $order_reference_no');
    // print('deeplinkHask = $token');
    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/DeepLink_Hask');
    // Create a POST request
    final request = http.MultipartRequest('POST', url);
    // Add form fields to the request
    request.fields.addAll({
      'str': '1.00#USD#00402#$order_reference_no#kfa://callback',
      'key': '$token',
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        deeplink_hask = jsonResponse['Deeplink_Hask'];
      });
      if (deeplink_hask != null) {
        var data = await Wing_app(deeplink_hask, accessToken, price);
      }
    } else {
      // If the response status code is not 200, print the reason phrase
      print('Request failed with status: ${response.reasonPhrase}');
    }
  }

  Future Wing_app(deeplink_hask, accessToken, price) async {
    print('Wing_app $deeplink_hask || $order_reference_no || $accessToken');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://ir.wingmoney.com:9443/RestEngine/api/v4/generatedeeplink'));
    request.body = json.encode({
      "order_reference_no": "$order_reference_no",
      "amount": "$price",
      "currency": "USD",
      "merchant_name": "Khmer Foundation Appraisal Co., Ltd",
      "merchant_id": "00402",
      "item_name": "Payin",
      "success_callback_url":
          "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Client/Wing/Callback",
      "schema_url": "kfa://callback",
      "integration_type": "MOBAPP",
      "txn_hash": "$deeplink_hask",
      "product_detail": [
        {
          "product_id": "6205",
          "product_type": "Property",
          "product_qty": 1,
          "product_unit_price": "$price",
          "currency": "USD"
        }
      ]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      var redirect_url = jsonResponse['redirect_url'];
      // ignore: deprecated_member_use
      launch(
        '$redirect_url',
        forceSafariVC: false,
        forceWebView: false,
      );
      await showSuccessDialog(context, price.toString());
      Navigator.pop(context);
      return redirect_url;
    } else {
      print(response.reasonPhrase);
    }
  }

// Upay deeplink
  static String baseUrl2 = 'https://dev-upayapi.u-pay.com/upayApi/mc/mcOrder';
  var appUrl = '$baseUrl2/appCreate';
  var qrUrl = '$baseUrl2/create/qrcode';
  var loading = false;
  var thier_plan;
  Future<void> createOrder_Upay(
      var price, var number_order, BuildContext context) async {
    if (loading) {
      return;
    }
    loading = true;
    setState(() {
      var count_number = number_order!.split(' ');

      if (count_number[4] == "Day") {
        thier_plan = 1;
      } else if (count_number[4] == "Week") {
        thier_plan = 7;
      } else if (count_number[4] == "Mount") {
        thier_plan = 30;
      }
      print("kokokok\n\n\n$thier_plan");
    });
    if (thier_plan != null) {
      var merchantKey = '3142e7560039d1661121992cfaafe17e';
      var order = SignUtil().RandomString(10).toString();
      Map<String, String> map = {
        'currency': "USD",
        'goodsDetail': "0001",
        'lang': "EN",
        'mcAbridge': 'test',
        'mcId': '1674724041055870978',
        'mcOrderId': order,
        'money': price.toString(),
        'returnUrl': "kfa://callback",
        'notifyUrl':
            "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_upay/${widget.id_user}/8899/${set_id_user}/${price}/${thier_plan}",
        'version': 'V1',
      };
      var sign = SignUtil.getSign(map, merchantKey);
      map['sign'] = sign;
      //upayDeeplink
      try {
        var response = await Dio().post(appUrl, data: map);
        if (response.statusCode == 200) {
          var data = response.data;
          var upayDeeplink = data['data']['upayDeeplink'].toString();
          // ignore: deprecated_member_use
          await launch(
            '$upayDeeplink',
            forceSafariVC: false,
            forceWebView: false,
          );

          await showSuccessDialog(context, price.toString());
          Navigator.pop(context);
        } else {
          showErrorDialog(response.statusMessage ?? '');
        }
      } catch (e) {
        showErrorDialog(e.toString());
      }
      loading = false;
      setState(() {});
    }
  }

  void showErrorDialog(String error) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('title'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future showSuccessDialog(BuildContext context, String success) async {
    await get_count();

    return AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.info,
        showCloseIcon: false,
        title: "You paid successfuly",
        autoHide: const Duration(seconds: 5),
        btnOkOnPress: () {
          Navigator.pop(context);
        },
        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        onDismissCallback: (type) {
          Navigator.pop(context);
        }).show();
  }
  //check payment method upay
}

Future showCircularProgressIndicatorDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
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

  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  String RandomString(int strlen) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }
}
