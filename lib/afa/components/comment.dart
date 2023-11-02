// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itckfa/afa/customs/formSh.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class CommentAndOption extends StatefulWidget {
  final OnChangeCallback value;
  final FormFieldSetter<String> comment;
  final OnChangeCallback id;
  const CommentAndOption(
      {Key? key, required this.value, required this.comment, required this.id})
      : super(key: key);

  @override
  State<CommentAndOption> createState() => _CommentAndOptionState();
}

class _CommentAndOptionState extends State<CommentAndOption> {
  // ignore: non_constant_identifier_names
  late String Value;
  late List<dynamic> _list;
  @override
  void initState() {
    super.initState();
    _list = [];
    // ignore: unnecessary_new
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            padding: EdgeInsets.only(left: 30),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  Value = newValue!;

                  widget.value(newValue.split(" ")[0]);
                  widget.id(newValue.split(" ")[1]);
                  // ignore: avoid_print
                  // print(_list.toString());
                  // ignore: avoid_print
                  // print(newValue);
                });
              },

              items: _list
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["opt_value"] + " " + value["opt_id"],
                      child: Text(value["opt_des"]),
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
                labelText: 'OptionType',
                hintText: 'Select one',
                prefixIcon: Icon(
                  Icons.my_library_books_rounded,
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
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            height: 55,
            padding: EdgeInsets.only(right: 30),
            child: FormSh(
              label: 'Comment',
              onSaved: widget.comment,
              iconname: Icon(
                Icons.comment_sharp,
                color: kImageColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  void Load() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list = jsonData;

        // print(_list);
      });
    }
  }
}
