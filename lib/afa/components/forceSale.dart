// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:itckfa/afa/customs/formShN.dart';

import 'contants.dart';

class ForceSaleAndValuation extends StatefulWidget {
  const ForceSaleAndValuation(
      {Key? key, required Null Function(dynamic value) value})
      : super(key: key);

  @override
  State<ForceSaleAndValuation> createState() => _ForceSaleAndValuationState();
}

class _ForceSaleAndValuationState extends State<ForceSaleAndValuation> {
  String Value = '30';
  var forceSale = ['10', '20', '30', '40', '50', '0'];
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
