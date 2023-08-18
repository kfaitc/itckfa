// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchFromController = TextEditingController();
  List<dynamic> _searchResults = [];
  Future<void> _performSearch() async {
    String searchFromVerbalDate = _searchFromController.text;
    var url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/link_all_search?search=$searchFromVerbalDate');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = json.decode(response.body);
        print(_searchResults.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchFromController,
            decoration: InputDecoration(
              hintText: 'Search from date',
            ),
          ),
          ElevatedButton(
            onPressed: _performSearch,
            child: Text('Search'),
          ),
          (_searchResults.length != 0)
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text(_searchResults[index]['id_ptys'].toString()),
                      );
                    },
                  ),
                )
              : Text('No data')
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchScreen(),
  ));
}
