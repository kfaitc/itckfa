// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class SilderPromo extends StatefulWidget {
  final List<Map<String, dynamic>> promoList;
  const SilderPromo({
    Key? key,
    required this.promoList,
  }) : super(key: key);

  @override
  State<SilderPromo> createState() => _SilderPromoState();
}

class _SilderPromoState extends State<SilderPromo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: ListView.builder(
          itemCount: widget.promoList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return PromoItem(
              img: widget.promoList[index]["img_promo"],
              isPromo: true,
            );
          }),
    );
  }
}

class PromoItem extends StatelessWidget {
  final String img;
  final bool isPromo;
  const PromoItem({
    Key? key,
    required this.img,
    required this.isPromo,
  }) : super(key: key);

  Widget promoBadge() {
    if (isPromo) {
      return Positioned(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.black26,
          ),
          child: Text(
            'Promo',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 150),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  // Can't use Image.network with android emulator
                  // if we run in web , it's okay
                  children: [
                    Image.asset(
                      img,
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                    //promoBadge(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
