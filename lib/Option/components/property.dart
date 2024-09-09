import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:itckfa/Option/components/contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class PropertyDropdown extends StatefulWidget {
  final OnChangeCallback name;
  final OnChangeCallback id;
  final OnChangeCallback? check_onclick;
  final String? pro;
  const PropertyDropdown({
    Key? key,
    required this.name,
    required this.id,
    this.pro,
    this.check_onclick,
  }) : super(key: key);

  @override
  State<PropertyDropdown> createState() => _PropertyDropdownState();
}

class _PropertyDropdownState extends State<PropertyDropdown> {
  String propertyValue = "";
  String getname = "";
  List name = [];
  List<dynamic> _list = [];

  String dropdownvalue = 'Building';
  @override
  void initState() {
    super.initState();
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      // margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: DropdownButtonFormField<String>(
          isExpanded: true,

          onChanged: (newValue) {
            setState(() {
              propertyValue = newValue as String;
              widget.name(propertyValue.split(",")[1]);
              widget.id(propertyValue.split(",")[0]);
            });
          },

          items: _list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["property_type_id"].toString() +
                      "," +
                      value["property_type_name"],
                  child: Text(
                    value["property_type_name"].toString(),
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            fillColor: Colors.white,
            labelText: ((widget.pro == null) ? 'Property' : widget.pro),
            hintText: 'Select one',
            labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 12),
            prefixIcon: const Icon(
              Icons.business_outlined,
              color: kImageColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: kerror),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 5, color: kerror),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }

  void Load() async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list = jsonData['property'];
        print("_list => ${_list.length}");
      });
    }
  }
}
