// ignore_for_file: prefer_const_constructors

import '../components/contants.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String label;
  final String value;
  final Widget iconname;

  const Box({
    Key? key,
    required this.label,
    required this.iconname,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: TextFormField(
        // controller: controller,
        initialValue: value,
        readOnly: true,

        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          labelText: label,
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
    );
  }
}
