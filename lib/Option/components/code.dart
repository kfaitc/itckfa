// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:itckfa/Option/components/contants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

typedef OnChangeCallback = void Function(dynamic value);

class Code extends StatefulWidget {
  final OnChangeCallback code;
  final int check_property;
  const Code({
    Key? key,
    required this.code,
    this.cd,
    required this.check_property,
  }) : super(key: key);
  final String? cd;
  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  late List code;
  bool loading = false;
  late int codedisplay;
  @override
  void initState() {
    // if (widget.check_property == 1) {
    //   Load1();
    // }
    // if (widget.check_property == 2) {
    //   Load2();
    // }
    code = [];
    codedisplay = 0;
    super.initState();
  }

  void Load1() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal?verbal_published=0',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        loading = false;
        code = jsonData;
        codedisplay = int.parse(code[0]['verbal_id']) + 1;
        widget.code(codedisplay);
      });
    }
  }

  void Load2() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbals?verbal_published=0',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        loading = false;
        code = jsonData;
        codedisplay = int.parse(code[0]['verbal_id']) + 1;
        widget.code(codedisplay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      codedisplay;
    });
    return Container(
      alignment: Alignment.topLeft,
      child: loading
          ? SizedBox()
          : //if loading == true, show progress indicator
          Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Icon(
                    Icons.qr_code,
                    color: kImageColor,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  ((widget.cd == null)
                      // ? SizedBox()
                      ? Text(
                          codedisplay.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        )
                      : Text(
                          widget.cd.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        )),
                ],
              ),
            ),
    );
  }
}
