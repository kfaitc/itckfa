// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDisableForm extends StatelessWidget {
  final String label;
  final Widget iconname;
  const CustomDisableForm(
      {Key? key, required this.label, required this.iconname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          labelText: label,
          enabled: false,
          prefixIcon: iconname,
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
    );
  }
}
