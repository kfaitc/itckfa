// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class LandSize extends StatefulWidget {
  final OnChangeCallback land_min;
  final OnChangeCallback land_max;
  const LandSize({Key? key, required this.land_min, required this.land_max})
      : super(key: key);

  @override
  State<LandSize> createState() => _LandSizeState();
}

class _LandSizeState extends State<LandSize> {
  String Value = '10000000';
  String Valueland = '0';
  late List<dynamic> _list;
  late List<dynamic> list;

  @override
  void initState() {
    super.initState();
    _list = [];
    list = [];
    // ignore: unnecessary_new
    Load();
    Load_();
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
              value: Valueland,
              onChanged: (String? newValue) {
                setState(() {
                  Valueland = newValue!;
                  // ignore: avoid_print
                  widget.land_min(newValue);
                  // ignore: avoid_print
                  print(newValue);
                });
              },

              items: list
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["land_min"].toString(),
                      child: Text(value["land_min"].toString()),
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
                labelText: 'Land size',
                hintText: 'Select',
                prefixIcon: Icon(
                  Icons.layers_rounded,
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
              value: Value,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  Value = newValue!;
                  widget.land_max(newValue);
                  // ignore: avoid_print
                  print(newValue);
                });
              },
              items: _list
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["land_max"].toString(),
                      child: Text(value["land_max"].toString()),
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
                prefixIcon: Icon(
                  Icons.crop_landscape,
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

  void Load() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/landsize/min'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;

        // print(_list);
      });
    }
  }

  void Load_() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/landsize/max'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list = jsonData;

        // print(_list);
      });
    }
  }
}
