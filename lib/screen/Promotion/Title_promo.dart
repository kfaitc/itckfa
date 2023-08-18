// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:itckfa/screen/Promotion/all_Membership.dart';
import 'package:itckfa/screen/Promotion/all_partner.dart';

class Title_promotion extends StatelessWidget {
  final String title_promo;
  final String title_promo1;

  const Title_promotion({
    Key? key,
    required this.title_promo1,
    required this.title_promo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title_promo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Flexible(
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return All_membership();
                    },
                  ));
                },
                child: Text(title_promo1)))
      ],
    );
  }
}

class Title_promotion2 extends StatelessWidget {
  final String title_promo;
  final String title_promo1;

  const Title_promotion2({
    Key? key,
    required this.title_promo1,
    required this.title_promo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title_promo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        // Flexible(
        //   child: Text(
        //     title_promo1,
        //     style: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        Flexible(
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return All_partner();
                    },
                  ));
                },
                child: Text(title_promo1)))
      ],
    );
  }
}
