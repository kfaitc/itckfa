// ignore_for_file: unused_local_variable, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables, unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';

import '../../contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Building extends StatefulWidget {
  Building(
      {super.key,
      this.verble_Edit,
      required this.l,
      required this.w,
      required this.total,
      this.l_value,
      this.type,
      this.w_value,
      this.total_value});
  final OnChangeCallback l;
  final OnChangeCallback w;
  final OnChangeCallback total;
  bool? verble_Edit;
  String? w_value;
  String? l_value;
  String? total_value;
  String? type;

  @override
  _MultiplyFormState createState() => _MultiplyFormState();
}

class _MultiplyFormState extends State<Building> {
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  TextEditingController total = TextEditingController();
  // double _total = 0;

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }

  void _updateTotal() {
    double a = double.tryParse(_controllerA.text) ?? 0;
    double b = double.tryParse(_controllerB.text) ?? 0;
    double _total = double.tryParse(total.text) ?? 0;
    // int a =
    //     int.tryParse(_controllerA.text) ?? int.parse(widget.l_value.toString());
    // int b =
    //     int.tryParse(_controllerB.text) ?? int.parse(widget.w_value.toString());
    setState(() {
      // _total = a * b;

      // _total = a * b;

      widget.l(a.toString());
      widget.w(b.toString());
      widget.total(_total.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.2;
    double w2 = MediaQuery.of(context).size.width * 0.2;
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: Colors.grey)
            // color: Color.fromARGB(255, 196, 197, 195),
            ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: w2,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _controllerA,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText:
                          '${(widget.type == "Edit") ? widget.l_value.toString() : "l"}',
                      labelStyle: TextStyle(
                          color: (widget.type == "Edit")
                              ? Color.fromARGB(255, 33, 32, 32)
                              : Colors.grey,
                          fontSize:
                              MediaQuery.of(context).size.height * 0.015)),
                  onChanged: (value) => _updateTotal(),
                ),
              ),
              Container(
                width: w2,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _controllerB,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      // prefixIcon: Icon(
                      //   Icons.width_full_outlined,
                      //   color: kImageColor,
                      // ),
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText:
                          '${(widget.type == "Edit") ? widget.w_value.toString() : "w"}',
                      labelStyle: TextStyle(
                          color: (widget.type == "Edit")
                              ? Color.fromARGB(255, 33, 32, 32)
                              : Colors.grey,
                          fontSize:
                              MediaQuery.of(context).size.height * 0.015)),
                  onChanged: (value) => _updateTotal(),
                ),
              ),
              Text(
                '=',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    color: Colors.grey),
              ),
              Container(
                width: w2,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: total,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      // prefixIcon: Icon(
                      //   Icons.width_full_outlined,
                      //   color: kImageColor,
                      // ),
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText:
                          '${(widget.type == "Edit") ? widget.total_value.toString() : "Total"}',
                      labelStyle: TextStyle(
                          color: (widget.type == "Edit")
                              ? Color.fromARGB(255, 33, 32, 32)
                              : Colors.grey,
                          fontSize:
                              MediaQuery.of(context).size.height * 0.015)),
                  onChanged: (value) => _updateTotal(),
                ),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       border: Border.all(width: 0.5, color: Colors.grey),
              //       borderRadius: BorderRadius.circular(10)),
              //   width: w,
              //   height: MediaQuery.of(context).size.height * 0.065,
              //   child: (widget.type != 'Edit')
              //       ? Text(
              //           '$_total',
              //           style:
              //               TextStyle(color: Color.fromARGB(255, 100, 99, 99)),
              //         )
              //       // ? Text(
              //       //     '$_total',
              //       //     style: TextStyle(
              //       //         color: Color.fromARGB(255, 112, 112, 112)),
              //       //   )
              //       : Text(
              //           '${_total = double.parse(widget.total_value.toString())}',
              //           style:
              //               TextStyle(color: Color.fromARGB(255, 100, 99, 99)),
              //         ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
