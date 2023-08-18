// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/contants.dart';

class FormTwinN extends StatefulWidget {
  final String Label1;
  final String Label2;
  final Widget icon1;
  final Widget icon2;
  final FormFieldSetter<String> onSaved1;
  final FormFieldSetter<String> onSaved2;
  const FormTwinN({
    Key? key,
    required this.Label1,
    required this.Label2,
    required this.icon1,
    required this.icon2,
    required this.onSaved1,
    required this.onSaved2,
  }) : super(key: key);

  @override
  State<FormTwinN> createState() => _FormTwinNState();
}

class _FormTwinNState extends State<FormTwinN> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 55,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: TextFormField(
                //controller: email,
                onSaved: widget.onSaved1,
                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  labelText: widget.Label1,
                  prefixIcon: widget.icon1,
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
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: SizedBox(
            height: 55,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  // for version 2 and greater youcan also use this
                  FilteringTextInputFormatter.digitsOnly
                ],
                onSaved: widget.onSaved2,
                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  labelText: widget.Label2,
                  prefixIcon: widget.icon2,
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
        ),
      ],
    );
  }
}
