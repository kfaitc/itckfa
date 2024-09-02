import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../contants.dart';
import '../../screen/Profile/components/Drop.dart';
import 'colors.dart';

class PropertySearch extends StatefulWidget {
  final OnChangeCallback name;
  final OnChangeCallback id;
  final OnChangeCallback checkOnclick;
  final String? pro;
  const PropertySearch(
      {Key? key,
      required this.name,
      required this.id,
      this.pro,
      required this.checkOnclick})
      : super(key: key);

  @override
  State<PropertySearch> createState() => _PropertySearchState();
}

class _PropertySearchState extends State<PropertySearch> {
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
        Container(
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: kPrimaryColor),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownSearch<Map<dynamic, dynamic>>(
            items: listProperty,
            compareFn: (item1, item2) {
              return item1['property_type_name'] == item2['property_type_name'];
            },
            popupProps: PopupProps.menu(
              isFilterOnline: true,
              showSearchBox: true,
              showSelectedItems: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(item['property_type_name'] ?? ''),
                  selected: isSelected,
                );
              },
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search a Property',
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                widget.id(value?['property_type_id'].toString());
                widget.name(value?['property_type_name'].toString());

                // print(value?['property_type_id'].toString());
              });
            },
            selectedItem: const {"title": "A"},
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: 'Select one',
                labelText: 'Property',
                labelStyle: TextStyle(
                  color: blueColor,
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
              return item['property_type_name']
                      ?.toLowerCase()
                      .contains(filter.toLowerCase()) ??
                  false;
            },
            itemAsString: (item) => item['property_type_name'] ?? '',
          ),
        ),
      ],
    );
  }

  List list = [];
  Future<void> load() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        list = jsonDecode(json.encode(response.data))['property'];
        for (int i = 0; i < list.length; i++) {
          listProperty.add(list[i]);
        }
      });
    } else {
      print(response.statusMessage);
    }
  }
}
