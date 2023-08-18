// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class ApprovebyAndVerifyby extends StatefulWidget {
  const ApprovebyAndVerifyby(
      {Key? key,
      required this.approve,
      required this.verify,
      this.vfy,
      this.appro})
      : super(key: key);
  final OnChangeCallback approve;
  final OnChangeCallback verify;
  final String? vfy;
  final String? appro;
  @override
  State<ApprovebyAndVerifyby> createState() => _ApprovebyAndVerifybyState();
}

class _ApprovebyAndVerifybyState extends State<ApprovebyAndVerifyby> {
  String valueapp = '';
  String valueagent = '';
  late List<dynamic> listApprove;
  late List<dynamic> listApprove2;
  late List<dynamic> listVerify;
  late List<dynamic> listVerify2;
  @override
  void initState() {
    super.initState();
    listApprove = [];
    listVerify = [];
    listVerify2 = [];
    listApprove2 = [];
    // ignore: unnecessary_new
    LoadApprove();
    LoadVerify();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 58,
            padding: const EdgeInsets.only(left: 30),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  valueagent = newValue!;

                  widget.verify(valueagent);
                });
              },
              items: listVerify
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["agenttype_id"].toString(),
                      child: Text(value["agenttype_name"]),
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: const Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),

              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelStyle: TextStyle(color: kPrimaryColor),
                labelText: (widget.vfy != null) ? widget.vfy : 'Verify by',
                hintText: 'Select one',
                prefixIcon: const Icon(
                  Icons.person_sharp,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            height: 58,
            padding: const EdgeInsets.only(right: 30),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  valueapp = newValue!;

                  widget.approve(valueapp);
                });
              },
              items: listApprove
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["approve_id"].toString(),
                      child: Text(value["approve_name"]),
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: const Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),

              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelStyle: TextStyle(color: kPrimaryColor),
                labelText: (widget.appro != null) ? widget.appro : 'Approve by',
                hintText: 'Select one',
                prefixIcon: const Icon(
                  Icons.person_outlined,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void LoadApprove() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/approve?approve_published=0'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        listApprove = jsonData;
        // print(_list);
      });
    }
  }

  // void LoadApprove2(id) async {
  //   setState(() {});
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/approve?approve_id=${id}'));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body);

  //     setState(() {
  //       listApprove2 = jsonData;
  //       // print(_list);
  //     });
  //   }
  // }

  void LoadVerify() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verify_by?agenttype_published=0'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        listVerify = jsonData;
        //print(_list);
      });
    }
  }

  // void LoadVerify2(id) async {
  //   setState(() {});
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verify_by?agenttype_id=${id}'));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body);

  //     setState(() {
  //       listVerify2 = jsonData;
  //       //print(_list);
  //     });
  //   }
  // }
}
