// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class image_test extends StatefulWidget {
  const image_test({super.key});

  @override
  State<image_test> createState() => _image_testState();
}

class _image_testState extends State<image_test> {
  List _data = [];

  @override
  void initState() {
    super.initState();
  }

  void _loadData() async {
    // Perform a network request or some other async task to load data
    await Property_Sale_image_1();

    // Update the state to reflect the loaded data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _loadData();
              },
              child: Text('Go')),
          Container(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              itemCount: list2_Sale1.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(list2_Sale1[index]['id_image'].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Future<List<String>> fetchDataFromApi() async {
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get_id/20234698'));
  //   if (response.statusCode == 200) {
  //     // If the request is successful, parse the response body and return the data
  //     final jsonData = json.decode(response.body);
  //     return List<String>.from(jsonData['data']);
  //   } else {
  //     // If the request is unsuccessful, throw an exception with the error message
  //     throw Exception(
  //         'Failed to fetch data from API: ${response.reasonPhrase}');
  //   }
  // }
  List list2_Sale1 = [];
  Future<void> Property_Sale_image_1() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_get_id/20234698'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      list2_Sale1 = jsonData;
      setState(() {
        list2_Sale1;
        // print(list2_Sale1);
      });
    }
  }
}
