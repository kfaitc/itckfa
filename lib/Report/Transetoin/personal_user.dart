// ignore_for_file: must_be_immutable, unused_field, camel_case_types, non_constant_identifier_names, unnecessary_new, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Detail.dart';
import '../companent/_await.dart';

class persoin_User extends StatefulWidget {
  persoin_User({super.key, required this.id_controller});
  String? id_controller;
  @override
  State<persoin_User> createState() => _persoin_UserState();
}

class _persoin_UserState extends State<persoin_User> {
  List list = [];
  int indexs = 0;
  @override
  void initState() {
    super.initState();
    _get();
  }

  bool _await = true;
  Future<void> _get() async {
    _await = true;
    await Future.wait([
      Get_User(),
    ]);
    setState(() {
      _await = false;
    });
  }

  var url;
  Future<List> Get_User() async {
    // index = int.parse(widget.index.toString());
    final rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/User_Tran/${widget.id_controller}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list = jsonData;
        // print(list.toString());
      });
    }
    return list;
  }

  String? payment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
                color: Color.fromARGB(255, 47, 46, 46), size: 25)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 150, 148, 148),
        elevation: 1,
        title: Text(
          '${widget.id_controller}',
          style: TextStyle(color: Color.fromARGB(255, 43, 42, 42)),
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: CircleAvatar(
          //     radius: 25,
          //     backgroundImage:
          //         NetworkImage('${widget.list_get[indexs]['url']}'),
          //   ),
          // ),
        ],
      ),
      // body:Column(
      //   children: [
      //     Text('${widget.')
      //   ],
      // )
      body: _await
          ? Center(
              child: Await_Transtion(),
            )
          : _PaginatedDataTable(list),
    );
  }

  int on_row = 10;
  Widget _PaginatedDataTable(List list) {
    // return Text(list.length.toString());
    return PaginatedDataTable(
      horizontalMargin: 5.0,
      arrowHeadColor: Color.fromARGB(255, 176, 177, 179),
      columns: [
        DataColumn(label: _text('Code')),
        // DataColumn(label: _text('Bank')),
        DataColumn(label: _text('Name')),
        DataColumn(label: _text('Gender')),
        DataColumn(label: _text('Payment')),
        DataColumn(label: _text('Phone')),
        DataColumn(label: _text('Email')),
      ],
      dataRowHeight: 50,
      rowsPerPage: on_row,
      onRowsPerPageChanged: (value) {
        setState(() {
          on_row = value!;
        });
      },
      source: new _DataSource(list, list.length, context, ''),
    );
  }

  Widget _text(text) {
    return Text(
      text,
      style: TextStyle(
          color: Color.fromARGB(255, 46, 45, 45),
          fontSize: MediaQuery.textScaleFactorOf(context) * 09,
          fontWeight: FontWeight.bold),
    );
  }
}

Naviga(BuildContext context, List list, index, type_bank, url) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return Detai_VPoint(
        await_image: true,
        url: '$url',
        typebank: type_bank,
        b: true,
        TypePayment_bank: '',
        list: list,
        index_get: index.toString(),
      );
    },
  ));
}

class _DataSource extends DataTableSource {
  final String? url;
  final List data;
  final int count_row;
  final BuildContext context;
  _DataSource(this.data, this.count_row, this.context, this.url);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0 ? Colors.grey[300] : Colors.white;
            }
            return index % 2 == 0
                ? Color.fromARGB(255, 255, 162, 162)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            Text(
              '${(item['bank_id'].toString() == '8899') ? item['orderId'].toString() : item['order_reference_no'].toString()}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, '${item['bank_id']}', url);
            },
          ),
          DataCell(
            placeholder: true,
            Text(
              '${(item['username'] != null) ? item['username'].toString() : ""}',
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              Naviga(context, data, index, '${item['bank_id']}', url);
            },
          ),
          DataCell(
            Text(
              '${(item['gender'] != null) ? item['gender'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, '${item['bank_id']}', url);
            },
          ),
          DataCell(
            Text(
              '${(item['bank_id'].toString() == '8899') ? item['payAmount'].toString() : item['amount'].toString()}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Naviga(context, data, index, '${item['bank_id']}', url);
            },
          ),
          DataCell(
            Text(
              '${(item['tel_num'] != null) ? item['tel_num'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // Naviga(context, data, index, payment);
            },
          ),
          DataCell(
            Text(
              '${(item['email'] != null) ? item['email'].toString() : ""}',
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // Naviga(context, data, index, payment);
            },
          ),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
