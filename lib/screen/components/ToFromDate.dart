// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class ToFromDate extends StatefulWidget {
  final OnChangeCallback fromDate;
  final OnChangeCallback toDate;
  const ToFromDate({Key? key, required this.fromDate, required this.toDate})
      : super(key: key);

  @override
  State<ToFromDate> createState() => _ToFromDateState();
}

class _ToFromDateState extends State<ToFromDate> {
  TextEditingController todate = TextEditingController();
  TextEditingController fromdate = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    todate.text = ""; //set the initial value of text field
    fromdate.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Center(
              child: TextField(
                controller: fromdate, //editing controller of this TextField
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: kImageColor,
                  ), //icon of text field
                  labelText: "From Date",
                  fillColor: kwhite,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
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
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  //  var date = DateTime.now();
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2020, 01, 01),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    // print(
                    //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    // print(
                    //     formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      fromdate.text = formattedDate;
                      widget.fromDate(
                          formattedDate); //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            height: 55,
            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: Center(
              child: TextField(
                controller: todate, //editing controller of this TextField
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: kImageColor,
                  ), //icon of text field
                  labelText: "To Date",
                  fillColor: kwhite,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
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
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    //   print(
                    //      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    // print(
                    //     formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      todate.text = formattedDate;
                      widget.toDate(
                          formattedDate); //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
