import 'package:flutter/material.dart';

import '../../../Option/components/contants.dart';

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
  late String bankvalue;
  final List<String> gender = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    if (widget.gender == " " || widget.gender == "null") {
      bankvalue = "Other";
    } else {
      bankvalue = widget.gender;
    }
    // Initialize bankvalue with the passed gender
  }

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
        value: bankvalue, // Use bankvalue for the value
        items: gender.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kwhite_new,
        ),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Gender',
          hintText: 'select one',
        ),
      ),
    );
  }
}
