// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelection extends StatefulWidget {
  
  const DateSelection({Key? key}) : super(key: key);

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  final TextEditingController _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 140,
      //alignment: Alignment.topRight,
      color: Color.fromARGB(255, 255, 255, 255),
      child: TextField(
        controller: _date,
        decoration: const InputDecoration(
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          //icon: Icon(Icons.calendar_month_rounded),
          labelText: 'Birth Date',
        ),
        onTap: () async {
          DateTime? pickeddate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1000),
            lastDate: DateTime(2200),
          );
          if (pickeddate != null) {
            setState(() {
              _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
            });
          }
        },
      ),
    );
  }
}
