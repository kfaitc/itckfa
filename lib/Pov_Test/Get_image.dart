import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDataList extends StatefulWidget {
  @override
  _MyDataListState createState() => _MyDataListState();
}

class _MyDataListState extends State<MyDataList> {
  List<Map<String, dynamic>> _listData = [
    {'id': 1, 'name': 'oukpov'},
    {'id': 2, 'name': 'ouk'},
  ];

  void deleteItem(int id) {
    setState(() {
      _listData.removeWhere((item) => item['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Data List'),
      ),
      body: ListView.builder(
        itemCount: _listData.length,
        itemBuilder: (context, index) {
          final item = _listData[index];
          return ListTile(
            title: Text(item['name']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteItem(item['id']),
            ),
          );
        },
      ),
    );
  }
}
