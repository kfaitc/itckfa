// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unnecessary_import, implementation_imports

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomDropDown extends StatelessWidget {
  final Widget setState;
  final List gender;
  const CustomDropDown({
    Key? key,
    required this.setState,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: DropdownButtonFormField<String>(
          //value: genderValue,
          onChanged: (String? newValue) {
            setState;
          },
          items: gender
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          // add extra sugar..
          icon: Icon(
            Icons.arrow_drop_down,
            color: Color.fromRGBO(168, 203, 55, 1),
          ),

          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 255, 255, 255),
            filled: true,
            labelText: 'Gender',
            hintText: 'Select one',
            prefixIcon: Icon(
              Icons.accessibility_new_sharp,
              color: Color.fromRGBO(168, 203, 55, 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 126, 250, 1),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
