// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class AutoVerbalTypeDropdown extends StatefulWidget {
  final OnChangeCallback name;
  final OnChangeCallback id;
  const AutoVerbalTypeDropdown({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  State<AutoVerbalTypeDropdown> createState() => _AutoVerbalTypeDropdownState();
}

class _AutoVerbalTypeDropdownState extends State<AutoVerbalTypeDropdown> {
  late String autoTypeValue;
  late String getname;
  late List name;
  late List<dynamic> _list;

  String dropdownvalue = 'Building';
  @override
  void initState() {
    Load();
    super.initState();
    autoTypeValue = "";
    getname = "";
    name = [];
    _list = [];
    // ignore: unnecessary_new
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        //value: genderValue,
        onChanged: (newValue) {
          setState(() {
            autoTypeValue = newValue as String;
            widget.name(newValue.split(",")[1]);
            widget.id(newValue.split(",")[0]);
            // ignore: avoid_print
            print(newValue.split(" ")[0]);
            print(newValue.split(" ")[1]);
          });
        },
        items: _list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["autoverbal_id"].toString() + "," + value["type"],
                child: Text(
                  value["type"],
                  style: TextStyle(
                      fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                      height: 0.1),
                ),
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
          labelText: 'Type',
          hintText: 'Select one',
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
    );
  }

  void Load() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/type'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list = jsonData;

        //print(_list);
      });
    }
  }
}
