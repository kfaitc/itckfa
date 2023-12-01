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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 242, 242),
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        backgroundColor: kwhite_new,
        title: Text(
          'History payment',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _await
          ? Center(
              child: _await_value(),
            )
          : _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ListView(
      children: [
        if (aba_upay[0].isNotEmpty)
          for (int i = 0; i < aba_upay[0].length; i++)
            Container(
              margin: EdgeInsets.all(20),
              height: 80,
              color: Colors.amber,
            ),
      ],
    );
  }

  var url;

  List wing_khqr = [];
  List wing_deeplink = [];
  List aba_upay = [];
  Future<void> Check_Transtoin(id) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/history/per/user?id_user_control=$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      wing_khqr.add(data['wing_khqr']);
      wing_deeplink.add(data['wing_deeplink']);
      aba_upay.add(data['aba_upay']);
      print(aba_upay[0]);
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget _await_value() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 151, 150, 150),
            highlightColor: Color.fromARGB(255, 221, 221, 219),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey),
                                    SizedBox(width: 5),
                                    _container(0.02, 0.18),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _container(0.02, 0.3),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            )),
      ),
    );
  }

  Widget _container(double h, double w) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: MediaQuery.of(context).size.height * h,
        width: MediaQuery.of(context).size.width * w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 190, 14, 14),
        ),
      ),
    );
  }
}
