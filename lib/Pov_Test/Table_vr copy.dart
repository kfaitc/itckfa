// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ScrollController _scrollController = ScrollController();
  int _startIndex = 0;
  int _endIndex = 10;
  List<dynamic> _data = [];
  int? _indexLength;

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_homeytpe'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      setState(() {
        _data = jsonData;
        _indexLength = _data.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _startIndex += 10;
        _endIndex += 10;
        if (_endIndex > _data.length) {
          _endIndex = _data.length;
        }
      });
    }
  }

  void _scrollListenerdok() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _startIndex -= 10;
        _endIndex -= 10;
        if (_endIndex > _data.length) {
          _endIndex = _data.length;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Widget'),
        actions: [
          IconButton(
            onPressed: () {
              _scrollListener();
            },
            icon: Icon(Icons.arrow_downward),
          ),
          IconButton(
            onPressed: () {
              _scrollListenerdok();
            },
            icon: Icon(Icons.safety_check),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _endIndex,
        itemBuilder: (BuildContext context, int index) {
          if (index < _startIndex || index >= _endIndex) {
            return SizedBox.shrink();
          } else {
            final item = _data[index];
            return ListTile(
              title: Text('$index : ${item['hometype'].toString()}'),
            );
          }
        },
      ),
    );
  }
}
