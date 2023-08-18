// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'contants.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late String propertyValue;
  var property = ['Building', 'Borey'];
  var _list = [];
  // ignore: prefer_final_fields
  late String _mySelection = 'bor';
  bool _loading = false;

  String dropdownvalue = 'Building';
  @override
  void initState() {
    super.initState();
    propertyValue = "";
    // ignore: unnecessary_new
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: DropdownButtonFormField<String>(
            //value: genderValue,
            onChanged: (newValue) {
              setState(() {
                propertyValue = newValue as String;
                // ignore: avoid_print
                print(newValue);
              });
            },
            // items: property
            //     .map<DropdownMenuItem<String>>(
            //       (String value) => DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       ),
            //     )
            //     .toList(),
            items: _list
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value["property_type_name"],
                    child: Text(value["property_type_name"]),
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
              labelText: 'Result',
              prefixIcon: Icon(
                Icons.business_outlined,
                color: kImageColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  void Load() async {
    setState(() {
      _loading = true;
    });
    var rs = await http.get(Uri.parse('https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        _list = jsonData['property'];
        _loading = false;
      });
    }
  }
}
