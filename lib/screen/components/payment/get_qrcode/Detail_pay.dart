// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class QRCodeDialog extends StatefulWidget {
  String? qrCode;
  // String? qrCode;
  QRCodeDialog({super.key, required this.qrCode});

  @override
  State<QRCodeDialog> createState() => _QRCodeDialogState();
}

class _QRCodeDialogState extends State<QRCodeDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListTile(
                leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                    )),
                title: Text(
                  'U-Pay',
                  style: TextStyle(
                      fontSize: MediaQuery.textScaleFactorOf(context) * 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
