// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_const_constructors, unused_import, unnecessary_import, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../afa/components/contants.dart';

class MyDropdown111 extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown111> {
  String? last_cid;
  String? provice = '1000001';
  String? price = '22222';
  String? sqm = '22222';
  var bed = '22222';
  var bath = '22222';
  String? type = 'For Sale';
  var address = '22222';
  String land = '22222';
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  last_cid = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.price_change_outlined,
                                    color: kImageColor,
                                  ),
                                  hintText: 'ID',
                                  fillColor: kwhite,
                                  filled: true,
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
                                validator: (value) {
                                  if (last_cid == null || last_cid!.isEmpty) {
                                    return 'require *';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          TextButton(
              onPressed: () async {
                setState(() {
                  Post_Sale();
                });
              },
              child: Text('Post')),
        ]),
      ),
    );
  }

  void Post_Sale() async {
    print('Post_Sale');

    Map<String, dynamic> payload = {
      'id_ptys': last_cid,
      'property_type_id': 100,
      'price': 20.2323,
      'sqm': 20.2323,
      'bed': 4,
      'bath': 5,
      'type': type.toString(),
      'land': 34,
      'address': address,
    };

    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_Post');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success For Sale');
    } else {
      print('Error Sale: ${response.reasonPhrase}');
    }
  }
}
