// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ImagePromo extends StatelessWidget {
  final ImagPromotion;
  final press;
  const ImagePromo({
    Key? key,
    required this.ImagPromotion, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: press,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                ImagPromotion,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
