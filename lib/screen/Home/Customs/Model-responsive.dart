// ignore_for_file: import_of_legacy_library_into_null_safe, camel_case_types, prefer_const_constructors, unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:itckfa/Option/screens/AutoVerbal/Verbal/Add.dart';
import 'package:itckfa/Option/screens/AutoVerbal/List.dart';
import 'package:itckfa/contants.dart';
import 'package:itckfa/screen/Account/account.dart';
import 'package:itckfa/screen/Customs/responsive.dart';

import 'package:itckfa/screen/components/payment/Main_Form/top_up.dart';
import 'package:itckfa/screen/Property/Home_Screen_property.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/payment/Main_Form/in_app_purchase_top_up.dart';

class SCard extends StatelessWidget {
  final String svgPic;
  final String title;
  final press;
  const SCard({
    Key? key,
    required this.svgPic,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 90,
          width: 92,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [kDefaultShadow],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: press,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 47,
                    width: 47,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        svgPic,
                        color: kImageColor,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
