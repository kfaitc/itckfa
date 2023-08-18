// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Field_box extends StatefulWidget {
  final String name;
  final String email;
  final OnChangeCallback get_email;
  const Field_box({
    Key? key,
    required this.name,
    required this.email,
    required this.get_email,
  }) : super(key: key);

  @override
  State<Field_box> createState() => _Field_boxState();
}

class _Field_boxState extends State<Field_box> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 280,
        color: Colors.white,
        child: TextFormField(
          initialValue: widget.email,
          onChanged: (value) {
            setState(() {
              widget.get_email(value);
            });
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            labelText: widget.name,
          ),
        ));
  }
}
