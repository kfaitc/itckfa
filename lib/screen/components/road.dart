// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class RoadDropdown extends StatefulWidget {
  final OnChangeCallback onChanged;
  const RoadDropdown({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<RoadDropdown> createState() => _RoadDropdownState();
}

class _RoadDropdownState extends State<RoadDropdown> {
  late String roadValue;

  var _list = [];

  @override
  void initState() {
    super.initState();
    roadValue = "";
    // ignore: unnecessary_new
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: DropdownButtonFormField<String>(
            //value: genderValue,
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                widget.onChanged(newValue);
                roadValue = newValue as String;
                // ignore: avoid_print
                print(newValue);
              });
            },
            items: _list
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value["road_id"].toString(),
                    child: Text(value["road_name"]),
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
              labelText: 'Road',
              hintText: 'Select one',
              prefixIcon: Icon(
                Icons.edit_road_outlined,
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

  void Load() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/road'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        _list = jsonData['roads'];
      });
    }
  }
}
