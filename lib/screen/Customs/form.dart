// ignore_for_file: prefer_const_constructors

import '../components/contants.dart';
import 'package:flutter/material.dart';

class FormS extends StatelessWidget {
  final String label;
  final Widget iconname;
  final FormFieldSetter<String> onSaved;
  const FormS({
    Key? key,
    required this.label,
    required this.iconname,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: TextFormField(
          onChanged: onSaved,
          decoration: InputDecoration(
            fillColor: kwhite,
            filled: true,
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            labelStyle: TextStyle(color: Colors.grey),
            prefixIcon: iconname,
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
    );
  }
}
