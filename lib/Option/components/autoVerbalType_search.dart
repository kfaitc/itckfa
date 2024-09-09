import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../contants.dart';
import '../../screen/Profile/components/Drop.dart';
import 'colors.dart';

class ApprovebyAndVerifybySearch extends StatefulWidget {
  final OnChangeCallback name;
  final OnChangeCallback id;
  Map<String, dynamic>? defaultValue;

  final String? pro;
  ApprovebyAndVerifybySearch({
    Key? key,
    required this.name,
    required this.id,
    this.defaultValue,
    this.pro,
  }) : super(key: key);

  @override
  State<ApprovebyAndVerifybySearch> createState() => _PropertySearchState();
}

class _PropertySearchState extends State<ApprovebyAndVerifybySearch> {
  List<Map<dynamic, dynamic>> listProperty = [];
  late String bankvalue;
  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
          // decoration: BoxDecoration(
          //     border: Border.all(width: 1, color: kPrimaryColor),
          //     borderRadius: BorderRadius.circular(10)),
          child: DropdownSearch<Map<dynamic, dynamic>>(
            items: listProperty,
            compareFn: (item1, item2) {
              return item1['type'] == item2['type'];
            },
            popupProps: PopupProps.menu(
              isFilterOnline: true,
              showSearchBox: true,
              showSelectedItems: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(item['type'] ?? ''),
                  selected: isSelected,
                );
              },
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search a Type',
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                widget.id(value?['autoverbal_id'].toString());
                widget.name(value?['type'].toString());
              });
            },
            selectedItem: widget.defaultValue ?? const {"type": "LS"},
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: 'Select one',
                labelText: 'Type',
                labelStyle: TextStyle(
                  color: greyColorNolots,
                  fontSize: 17,
                ),
                prefixIcon:
                    const Icon(Icons.business_outlined, color: kImageColor),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: kerror),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 5,
                    color: kerror,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                border: InputBorder.none,
              ),
            ),
            filterFn: (item, filter) {
              return item['type']
                      ?.toLowerCase()
                      .contains(filter.toLowerCase()) ??
                  false;
            },
            itemAsString: (item) => item['type'] ?? '',
          ),
        ),
      ],
    );
  }

  List list = [];
  Future<void> load() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/type',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        list = jsonDecode(json.encode(response.data));
        for (int i = 0; i < list.length; i++) {
          listProperty.add(list[i]);
        }
        // Set default values after loading
        if (widget.defaultValue != null) {
          widget.id(widget.defaultValue?['autoverbal_id'].toString());
          widget.name(widget.defaultValue?['type'].toString());
        }
      });
    } else {
      print(response.statusMessage);
    }
  }
}
