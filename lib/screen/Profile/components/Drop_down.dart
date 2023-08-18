// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../afa/components/contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Dropdown extends StatefulWidget {
  final String gender;
  final OnChangeCallback get_gender;
  const Dropdown({Key? key, required this.gender, required this.get_gender})
      : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String bankvalue = 'Male';
  var gender = [
    'Male',
    'Female',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      width: 140,
      child: DropdownButtonFormField<String>(
        onChanged: (String? newValue) {
          setState(() {
            bankvalue = newValue!;
            widget.get_gender(newValue);
          });
        },
        // validator: (String? value) {
        //   if (value?.isEmpty ?? true) {
        //     return 'Please select bank';
        //   }
        //   return null;
        // },
        value: widget.gender,
        items: gender
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: kwhite_new,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Gender',
          hintText: 'select one',
        ),
      ),
    );
  }
}
