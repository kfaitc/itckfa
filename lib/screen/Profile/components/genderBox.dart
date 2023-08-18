// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:itckfa/screen/Profile/components/Drop.dart';
import 'package:itckfa/screen/Profile/components/Drop_down.dart';

class GenderBox extends StatelessWidget {
  final String gender;
  final String from;
  const GenderBox({
    Key? key,
    required this.gender,
    required this.from,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dropdown(
          gender: gender,
          get_gender: (value) {},
        ),
        SizedBox(
          width: 6,
        ),
        // BankDropdown(
        //   from: from,
        // ),
      ],
    );
  }
}
