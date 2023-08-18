// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTwinForm extends StatelessWidget {
  final String Label1;
  final String Label2;
  final Widget icon1;
  final Widget icon2;
  final FormFieldSetter<String> onSaved1;
  final FormFieldSetter<String> onSaved2;
  const CustomTwinForm({
    Key? key,
    required this.Label1,
    required this.Label2,
    required this.icon1,
    required this.icon2,
    required this.onSaved1,
    required this.onSaved2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
              child: TextFormField(
                //controller: email,
                onSaved: onSaved1,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  labelText: Label1,
                  prefixIcon: icon1,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(0, 126, 250, 1),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
              child: TextFormField(
                //controller: email,
                onSaved: onSaved2,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  labelText: Label2,
                  prefixIcon: icon2,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(0, 126, 250, 1),
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
