// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:itckfa/screen/Customs/formShN.dart';

import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class ForceSaleAndValuation extends StatefulWidget {
  final String? fsl;
  ForceSaleAndValuation({Key? key, required this.value, this.fsl})
      : super(key: key);
  final OnChangeCallback value;
  @override
  State<ForceSaleAndValuation> createState() => _ForceSaleAndValuationState();
}

class _ForceSaleAndValuationState extends State<ForceSaleAndValuation> {
  String Value = '30';
  var forceSale = ['10', '20', '30', '40', '50', '0'];
  @override
  void initState() {
    widget.value(Value);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            padding: EdgeInsets.only(left: 30),
            child: FormShN(
              label: 'Valuation Fee',
              onSaved: (input) {},
              iconname: Icon(
                Icons.monetization_on,
                color: Color.fromRGBO(168, 203, 55, 1),
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
            padding: EdgeInsets.only(right: 30),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              value: Value,
              isExpanded: true,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
              onChanged: (String? newValue) {
                setState(() {
                  Value = newValue!;
                  widget.value(Value);
                  // ignore: avoid_print
                  // print(newValue);
                });
              },
              items: forceSale
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),

              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelStyle: TextStyle(color: kPrimaryColor),
                labelText: 'Force Sale',
                hintText: 'Select one',
                prefixIcon: Icon(
                  Icons.attach_money_rounded,
                  color: kImageColor,
                ),
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
