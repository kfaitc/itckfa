// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SingleBox extends StatelessWidget {
  final String phone;
  const SingleBox({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 280,
          color: Color.fromARGB(255, 255, 255, 255),
          child: TextFormField(
            initialValue: phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: 'Phone Number',
            ),
          ),
        ),
      ],
    );
  }
}
