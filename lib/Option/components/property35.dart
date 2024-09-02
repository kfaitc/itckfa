import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../contants.dart';
import '../../screen/Profile/components/Drop.dart';

class PropertyDropdown35 extends StatefulWidget {
  final OnChangeCallback name;
  final OnChangeCallback id;
  final OnChangeCallback? check_onclick;
  final String? pro;
  const PropertyDropdown35(
      {Key? key,
      required this.name,
      required this.id,
      this.pro,
      this.check_onclick})
      : super(key: key);

  @override
  State<PropertyDropdown35> createState() => _PropertyDropdown35State();
}

class _PropertyDropdown35State extends State<PropertyDropdown35> {
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
    return SizedBox(
      height: 35,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        //value: genderValue,
        onTap: () {
          setState(() {
            widget.check_onclick!(true);
          });
        },
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
                child: Text(
                  value["property_type_name"],
                ),
              ),
            )
            .toList(),
        // add extra sugar..
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),

        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          fillColor: Colors.white,
          labelText: ((widget.pro == null) ? 'Property' : widget.pro),
          hintText: 'Select one',
          labelStyle: const TextStyle(color: kPrimaryColor),
          prefixIcon: const Icon(Icons.business_outlined, color: kImageColor),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kPrimaryColor),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kerror),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 5,
              color: kerror,
            ),
            borderRadius: BorderRadius.circular(5),
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
      });
    }
  }
}
