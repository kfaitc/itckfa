// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../afa/customs/formSh.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class CommentAndOption extends StatefulWidget {
  final OnChangeCallback value;
  final FormFieldSetter<String> comment;
  final OnChangeCallback id;
  final OnChangeCallback opt_type_id;
  final String? option;
  final String? comment1;
  const CommentAndOption(
      {Key? key,
      required this.value,
      required this.comment,
      required this.id,
      required this.opt_type_id,
      this.option,
      this.comment1})
      : super(key: key);

  @override
  State<CommentAndOption> createState() => _CommentAndOptionState();
}

class _CommentAndOptionState extends State<CommentAndOption> {
  late String Value = '';
  late List<dynamic> _list;
  late List<dynamic> _list2;
  var genderValue;
  @override
  void initState() {
    super.initState();
    _list = [];
    _list2 = [];
    // ignore: unnecessary_new
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 30),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  Value = newValue!;

                  widget.value(newValue.split(" ")[0].toString());
                  widget.id(newValue.split(" ")[1].toString());
                  print(newValue);
                });
              },
              items: _list
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value:
                          "${value["opt_value"].toString()} ${value["opt_id"].toString()}",
                      child: Text(value["opt_des"]),
                      onTap: () {
                        widget.opt_type_id(value["opt_value"].toString());
                      },
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
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                labelText:
                    (widget.option != null) ? widget.option : 'OptionType',
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
        SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: Container(
            height: 60,
            padding: EdgeInsets.only(right: 30),
            child: FormSh(
              label: (widget.comment1 != null)
                  ? "+ ${widget.comment1.toString()}%"
                  : 'Comment',
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

  void Load2(id) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options?opt_id=${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list2 = jsonData;

        // print(_list);
      });
    }
  }
}
