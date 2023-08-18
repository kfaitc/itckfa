// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class DateComponents extends StatefulWidget {
  const DateComponents({Key? key, required this.date}) : super(key: key);
  final OnChangeCallback date;
  @override
  State<DateComponents> createState() => _DateComponentsState();
}

class _DateComponentsState extends State<DateComponents> {
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Center(
        child: TextField(
          controller: dateinput, //editing controller of this TextField
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today,
              color: kImageColor,
            ), //icon of text field
            labelText: "Choose Date",
            fillColor: kwhite,
            filled: true,
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
            ), //label text of field
          ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                dateinput.text = formattedDate;
                widget
                    .date(formattedDate); //set output date to TextField value.
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }
}
