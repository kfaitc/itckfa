// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_string_interpolations, unused_element, unnecessary_null_comparison, prefer_is_empty

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PropertyModel {
  final int id_ptys;
  final String type;
  final String commune;
  final int price;
  final String description;
  final int bed;
  final String urgent;
  final String homeType;
  final String address;
  final int bath;
  final int land;

  PropertyModel({
    required this.id_ptys,
    required this.type,
    required this.commune,
    required this.price,
    required this.description,
    required this.bed,
    required this.urgent,
    required this.homeType,
    required this.bath,
    required this.land,
    required this.address,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id_ptys: json['id_ptys'] ?? 0,
      type: json['type'] ?? '',
      commune: json['Name_cummune'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      bed: json['bed'] ?? 0,
      urgent: json['urgent'] ?? '',
      homeType: json['hometype'] ?? '',
      bath: json['bath'] ?? 0,
      land: json['land'] ?? 0,
    );
  }
}

class ListSearchExamplessss extends StatefulWidget {
  @override
  _ListSearchExampleState createState() => _ListSearchExampleState();
}

class _ListSearchExampleState extends State<ListSearchExamplessss> {
  List<PropertyModel> propertyList = [];
  List<PropertyModel> filteredList = [];
  bool _isLoading_re = false;
  String? query;
  Future<void> _refresh(query) async {
    _isLoading_re = true;
    await Future.wait([filterItems(query)]);

    setState(() {
      _isLoading_re = false;
    });
    // All three functions have completed at this point
    // Do any additional initialization here
  }

  Future<void> filterItems(query) async {
    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/link_all_search_down?search=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<PropertyModel> searchResults = responseData
          .map((propertyData) => PropertyModel.fromJson(propertyData))
          .toList();

      setState(() {
        filteredList = searchResults;
      });
    } else {
      throw Exception('Failed to fetch search results');
    }
  }

  Future<void> Dropdown(String query) async {
    filteredList = propertyList
        .where((property) =>
            property.address.contains(query.toLowerCase()) ||
            property.id_ptys.toString().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Search Exasmple'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                        _refresh(query);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _refresh(query);
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          (_isLoading_re)
              ? Center(child: CircularProgressIndicator())
              : (filteredList.length != 0)
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final property = filteredList[index];
                          return Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, top: 10),
                              child: Text(
                                  '${property.address} / ${property.homeType} / ${property.urgent} / ${property.type} / ${property.id_ptys}'));
                        },
                      ),
                    )
                  : SizedBox()
        ],
      ),
    );
  }
}
