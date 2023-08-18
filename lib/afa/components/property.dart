// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class PropertyDropdown extends StatefulWidget {
  final OnChangeCallback name;
  final OnChangeCallback id;
  const PropertyDropdown({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  State<PropertyDropdown> createState() => _PropertyDropdownState();
}

class _PropertyDropdownState extends State<PropertyDropdown> {
  late String propertyValue;
  late String getname;
  late List name;
  late List<dynamic> _list;

  String dropdownvalue = 'Building';
  @override
  void initState() {
    super.initState();
    propertyValue = "";
    getname = "";
    name = [];
    _list = [];
    // ignore: unnecessary_new
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        //value: genderValue,
        onChanged: (newValue) {
          setState(() {
            propertyValue = newValue as String;
            widget.name(newValue.split(" ")[1]);
            widget.id(newValue.split(" ")[0]);
            // ignore: avoid_print
            // print(newValue.split(" ")[0]);
            // print(newValue.split(" ")[1]);
          });
        },
        items: _list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["property_type_id"].toString() +
                    " " +
                    value["property_type_name"],
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
          labelText: 'Property',
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
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list = jsonData['property'];

        //print(_list);
      });
    }
  }
}
