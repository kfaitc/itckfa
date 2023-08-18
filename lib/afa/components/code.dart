// ignore_for_file: prefer_const_constructors

import '../components/contants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

typedef OnChangeCallback = void Function(dynamic value);

class Code extends StatefulWidget {
  final OnChangeCallback code;
  const Code({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  late List code;
  bool loading = false;
  late int codedisplay;
  @override
  void initState() {
    Load();
    code = [];
    codedisplay = 0;
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void Load() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal?verbal_published=0'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        loading = false;
        code = jsonData;
        codedisplay = int.parse(code[0]['verbal_id']) + 1;
        // ignore: avoid_print
        print(code[0]['verbal_id']);
        widget.code(codedisplay);
        // ignore: avoid_print
        print(codedisplay);

        // print(_list);
      });
      // print(list.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: loading
          ? Center(child: CircularProgressIndicator())
          : //if loading == true, show progress indicator
          Row(
              children: [
                SizedBox(width: 30),
                Icon(
                  Icons.qr_code,
                  color: Color.fromARGB(255, 112, 223, 52),
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  codedisplay.toString(),
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
              ],
            ),
    );
  }
}
