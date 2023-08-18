// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/contants.dart';

class FormTwinN extends StatefulWidget {
  final String Label1;
  final String Label2;
  final String? Label1_e;
  final String? Label2_e;
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
    this.Label1_e,
    this.Label2_e,
  }) : super(key: key);

  @override
  State<FormTwinN> createState() => _FormTwinNState();
}

class _FormTwinNState extends State<FormTwinN> {
  // final TextEditingController _controller = TextEditingController();
  late TextEditingController Owner;
  late TextEditingController Contect;
  @override
  void initState() {
    if (widget.Label1_e != null) {
      Owner = TextEditingController(text: widget.Label1_e);
      Contect = TextEditingController(text: widget.Label2_e);
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (widget.Label1_e != null)
            ? Expanded(
                child: SizedBox(
                  height: 58,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: TextFormField(
                      controller: Owner,
                      onChanged: (value) {
                        setState(() {
                          widget.onSaved1(value);
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        labelStyle: TextStyle(
                            color: kPrimaryColor,
                            overflow: TextOverflow.ellipsis),
                        labelText: widget.Label1,
                        prefixIcon: widget.icon1,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
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
              )
            : Expanded(
                child: SizedBox(
                  height: 55,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: TextFormField(
                      onChanged: widget.onSaved1,
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        labelStyle: TextStyle(color: kPrimaryColor),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        labelText: widget.Label1,
                        prefixIcon: widget.icon1,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
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
        (widget.Label1_e != null)
            ? Expanded(
                child: SizedBox(
                  height: 58,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: TextFormField(
                      controller: Contect,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        // for below version 2 use this
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        // for version 2 and greater youcan also use this
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.onSaved2(value);
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        filled: true,
                        labelStyle: TextStyle(color: kPrimaryColor),
                        labelText: widget.Label2,
                        prefixIcon: widget.icon2,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
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
              )
            : Expanded(
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
                      onChanged: widget.onSaved2,
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        labelText: widget.Label2,
                        labelStyle: TextStyle(color: kPrimaryColor),
                        prefixIcon: widget.icon2,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
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
