// ignore_for_file: file_names, camel_case_types, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_element, unused_field, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 243, 242, 242),
        title: Text(
          'Transtoin',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _await
          ? Center(
              child: _await_value(),
            )
          : _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: double.infinity,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Card(
                      elevation: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    '${list[index]['bank_id'].toString() == '8899' ? 'assets/images/UPAY-logo.png' : 'assets/images/WingBank-Logo_Square.png'}',
                                  )),
                              SizedBox(width: 20),
                              Text(
                                'Payment By ',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.textScaleFactorOf(context) *
                                            9,
                                    color: const Color.fromARGB(
                                        255, 112, 111, 111)),
                              ),
                              Text(
                                '${list[index]['bank_id'].toString() == '8899' ? 'UPAY BANK' : 'WING BANK'}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) * 8,
                                ),
                              ),

                              //
                              //
                              Spacer(),
                              SizedBox(width: 10),
                              Text(
                                '-${list[index]['${list[index]['bank_id'].toString() == '8899' ? 'payAmount' : 'amount'}']} USD',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.textScaleFactorOf(context) *
                                            15,
                                    color: Color.fromARGB(255, 229, 59, 59)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  var url;

  List list_User_by_id = [];
  var set_id_user;
  // Future<void> Get_ID(String id) async {
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
  //   if (rs.statusCode == 200) {
  //     setState(() {
  //       var jsonData = jsonDecode(rs.body);
  //       list_User_by_id = jsonData;
  //       if (list_User_by_id[0]['control_user'] != null) {
  //         set_id_user = list_User_by_id[0]['control_user'].toString();
  //         print('ID = ${set_id_user}');
  //         // get_image(list_User_by_id[0]['control_user'].toString());
  //         if (set_id_user != null) {
  //           print('sdfasdfasdfsadff');
  //           Check_Transtoin(id);
  //         }
  //       }
  //     });
  //   }
  // }

  List list = [];
  Future<void> Check_Transtoin(String id) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/User_Tran/$id'));
    if (rs.statusCode == 200) {
      setState(() {
        var jsonData = jsonDecode(rs.body);
        list = jsonData;
        // print('List = ${list.toString()}');
      });
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
