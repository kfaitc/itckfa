// ignore_for_file: must_be_immutable, unused_element

import 'package:flutter/material.dart';

class Detai_VPoint extends StatefulWidget {
  Detai_VPoint({
    super.key,
    this.await_image,
    this.url,
    required this.list,
    required this.index_get,
    required this.TypePayment_bank,
    this.typebank,
    this.b,
  });
  bool? await_image;
  String? url;
  bool? b;
  String? typebank;
  List list;
  String? TypePayment_bank;

  String? index_get;
  @override
  State<Detai_VPoint> createState() => _Detai_VPointState();
}

class _Detai_VPointState extends State<Detai_VPoint> {
  int index = 0;
  List list = [];
  @override
  void initState() {
    index = int.parse(widget.index_get.toString());
    // list = widget.list[int.parse(widget.index_get.toString())];
    if (widget.b == true) {
      if (widget.typebank == '6591') {
        widget.TypePayment_bank = 'payAmount';
      } else {
        widget.TypePayment_bank = 'amount';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 224, 224),
      appBar: AppBar(
        // title: Text('${widget.typebank}'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 30, 11, 129),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _Box(false),
        ],
      ),
    );
  }

  Widget _Box(bool b) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.85,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            color: Color.fromARGB(255, 30, 11, 129),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                child: Image.network(
                                    'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/v.png'),
                              ),
                              SizedBox(width: 10),
                              _text('V Point', 15, false, false),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: Row(
                              children: [
                                _text(
                                    '${widget.list[index]['count_autoverbal']}',
                                    20,
                                    true,
                                    false),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(30)),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor:
                                  Colors.white, // Set the border color to white
                              backgroundImage: NetworkImage(
                                  '${(widget.list[index]['url'] != null) ? widget.list[index]['url'] : (widget.await_image.toString() == 'true') ? "${widget.url}" : 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/images.png'}'),
                              radius: 30,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Divider(height: 1, color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text(
                          'Day : ( ${(widget.list[index]['their_plans'] != null) ? widget.list[index]['their_plans'] : ""} )',
                          10,
                          false,
                          false),
                      _text(
                          'Expiry : ( ${(widget.list[index]['expiry'] != null) ? widget.list[index]['expiry'] : ""} )',
                          10,
                          false,
                          false),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 15,
              left: 15,
              top: 140,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _text(
                          "V POINT'S USER : ( ${widget.list[index]['control_user']} )",
                          13,
                          true,
                          true,
                        ),
                        _size(),
                        _text("Name : ${widget.list[index]['username']}", 12,
                            false, true),
                        _size(),
                        _text("Gender : ${widget.list[index]['gender']}", 12,
                            false, true),
                        _size(),
                        _text("Phone : ${widget.list[index]['tel_num']}", 12,
                            false, true),
                        _size(),
                        _text("Know From : ${widget.list[index]['known_from']}",
                            12, false, true),
                        _size(),
                        _text(
                            "Payment : ${widget.list[index]['${widget.TypePayment_bank}']} \$",
                            12,
                            false,
                            true),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _size() {
    return SizedBox(height: 10);
  }

  Widget _text(text, double f, bool b, bool c) {
    return Text(
      text,
      style: TextStyle(
          color: (c == false) ? Colors.white : Color.fromARGB(255, 78, 77, 77),
          fontSize: MediaQuery.textScaleFactorOf(context) * f,
          fontWeight: (b == true) ? FontWeight.bold : null),
    );
  }
}
