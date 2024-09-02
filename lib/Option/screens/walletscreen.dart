// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unnecessary_new, unused_local_variable, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, await_only_futures, unnecessary_null_comparison, empty_catches, unused_field, unrelated_type_equality_checks, sized_box_for_whitespace, use_build_context_synchronously
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:itckfa/screen/Contacts/ContactsUs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Walletscreen extends StatefulWidget {
  const Walletscreen (
      {super.key,});
  @override
  State<Walletscreen > createState() => _WalletscreenState();
}

class _WalletscreenState extends State<Walletscreen > {
  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {

    }
  }
   Future<void> _makePhoneCall(String url) async {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.yellow,
      Colors.lightGreen,
      Color.fromRGBO(169, 255, 194, 1),
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Horizon',
      color: Colors.black,
      //shadows: [Shadow(blurRadius: 2, color: Colors.deepPurpleAccent)],
    );
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      color: ui.Color.fromARGB(255, 191, 197, 186),)
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(250),
                  bottomRight: Radius.circular(250),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text("For any benefit or promotion please contact:",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                   Hotline(
                        onPress: () => setState(() {
                          _makePhoneCall('tel:023 999 855');
                        }),
                        icon: Icons.phone,
                        phone: '(855) 23 999 855',
                      ),
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              right: 1,
              child: SizedBox(
                  height: 90, child: Image.asset("assets/images/KFA_CRM.png"),),
            ),
            Positioned(
                top: 1,
                left: 1,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left_outlined,
                      size: 35,
                      color: Colors.white,
                    ),),),
          ],
        ),
      ),
    );
  }
}

