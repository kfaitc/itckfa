// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Minmax extends StatefulWidget {
  final OnChangeCallback min;
  final OnChangeCallback max;
  const Minmax({Key? key, required this.min, required this.max})
      : super(key: key);

  @override
  State<Minmax> createState() => _MinmaxState();
}

class _MinmaxState extends State<Minmax> {
  late List<dynamic> min;
  late List<dynamic> max;
  String minValue = '20';
  String maxValue = '30';
  String dropdownvalue = 'Building';
  @override
  void initState() {
    super.initState();
    min = [];
    max = [];
    minApi();
    maxApi();
    // ignore: unnecessary_new
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: DropdownButtonFormField<String>(
              value: minValue,
              onChanged: (String? newValue) {
                setState(() {
                  minValue = newValue!;
                  widget.min(newValue);
                  // ignore: avoid_print
                  print(newValue);
                });
              },
              items: min
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["num"].toString(),
                      child: Text(value["num"].toString()),
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),

              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                label: Text('Min'),
                prefixIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //   decoration: InputDecoration(
                //       labelText: 'From',
                //       prefixIcon: Icon(Icons.business_outlined)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            height: 55,
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: DropdownButtonFormField<String>(
              value: maxValue,
              onChanged: (String? newValue) {
                setState(() {
                  maxValue = newValue!;
                  widget.max(newValue);
                  // ignore: avoid_print
                  print(newValue);
                });
              },

              items: max
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["num"].toString(),
                      child: Text(value["num"].toString()),
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),

              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelText: 'Max',
                prefixIcon: Icon(
                  Icons.arrow_back_ios,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //   decoration: InputDecoration(
                //       labelText: 'From',
                //       prefixIcon: Icon(Icons.business_outlined)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void minApi() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/min_max/min'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        min = jsonData;
        // print(_list);
      });
    }
  }

  void maxApi() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/min_max/max'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        max = jsonData;
        // print(_list);
      });
    }
  }
}
