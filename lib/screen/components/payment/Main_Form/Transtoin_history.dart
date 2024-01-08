// ignore_for_file: file_names, camel_case_types, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_element, unused_field, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:shimmer/shimmer.dart';

class Transtoin_History extends StatefulWidget {
  Transtoin_History({super.key, required this.id});
  String? id;
  @override
  State<Transtoin_History> createState() => _Transtoin_HistoryState();
}

class _Transtoin_HistoryState extends State<Transtoin_History> {
  bool _await = false;
  @override
  void initState() {
    super.initState();
    _get(widget.id.toString());
  }

  Future<void> _get(id) async {
    _await = true;
    await Future.wait([
      Check_Transtoin(id),
    ]);
    setState(() {
      _await = false;
    });
  }

  bool btn_aba = true, btn_wing = false, btn_upay = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 242, 242),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Transaction history",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: kwhite_new,
            floating: true,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      autofocus: true,
                      onTap: () {
                        setState(() {
                          (!btn_aba) ? btn_aba = true : btn_aba = false;
                          if (btn_aba) {
                            btn_upay = false;
                            btn_wing = false;
                          }
                        });
                      },
                      child: Text(
                        "By ABA",
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.solid,
                            decoration:
                                (btn_aba) ? TextDecoration.underline : null,
                            decorationThickness: 3,
                            decorationColor: Color.fromARGB(153, 23, 255, 73),
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 14,
                            shadows: [
                              Shadow(
                                  blurRadius: 2,
                                  color: Colors.grey,
                                  offset: Offset(-2, 1))
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          (!btn_upay) ? btn_upay = true : btn_upay = false;
                          if (btn_upay) {
                            btn_aba = false;
                            btn_wing = false;
                          }
                        });
                      },
                      child: Text(
                        "By UPAY",
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.solid,
                            decoration:
                                (btn_upay) ? TextDecoration.underline : null,
                            decorationThickness: 3,
                            decorationColor: Color.fromARGB(153, 23, 255, 73),
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 14,
                            shadows: [
                              Shadow(
                                  blurRadius: 2,
                                  color: Colors.grey,
                                  offset: Offset(-2, 1))
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          (!btn_wing) ? btn_wing = true : btn_wing = false;
                          print(btn_wing);
                          if (btn_wing) {
                            btn_aba = false;
                            btn_upay = false;
                          }
                        });
                      },
                      child: Text(
                        "By WING",
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.solid,
                            decoration:
                                (btn_wing) ? TextDecoration.underline : null,
                            decorationThickness: 3,
                            decorationColor: Color.fromARGB(153, 23, 255, 73),
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 14,
                            shadows: [
                              Shadow(
                                  blurRadius: 2,
                                  color: Colors.grey,
                                  offset: Offset(-2, 1))
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: 150,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return (btn_aba)
                    ? Card(
                        child: ListTile(
                        title: Text('orderId: ${aba[index]['orderId']}'),
                        subtitle:
                            Text("Date Order: ${aba[index]['createTime']}"),
                        trailing: Text("${aba[index]['money']}\$"),
                      ))
                    : (btn_upay)
                        ? Card(
                            child: ListTile(
                            title: Text('orderId: ${upay[index]['orderId']}'),
                            subtitle: Text(
                                "Date Order: ${upay[index]['createTime']}"),
                            trailing: Text("${upay[index]['money']}\$"),
                          ))
                        : Card(
                            child: ListTile(
                            title: Text(
                                'orderId: ${wing[index]['order_reference_no']}'),
                            subtitle: Text(
                                "Date Order: ${wing[index]['transaction_date']}"),
                            trailing: Text("${wing[index]['amount']}\$"),
                          ));
              },
              childCount: (btn_aba)
                  ? aba.length
                  : (btn_upay)
                      ? upay.length
                      : wing.length,
            ),
          ),
        ],
      ),
    );
  }

  var url;

  List wing = [];
  List upay = [];
  List aba = [];
  Future<void> Check_Transtoin(id) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/history/per/user?id_user_control=$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      setState(() {
        wing = data['wing'];
        upay = data['upay'];
        aba = data["aba"];
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}
