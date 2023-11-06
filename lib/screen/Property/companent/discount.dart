import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Discount_Url extends StatefulWidget {
  Discount_Url({super.key, required this.a, required this.list});
  var list;
  var a;
  @override
  State<Discount_Url> createState() => _Discount_UrlState();
}

class _Discount_UrlState extends State<Discount_Url> {
  @override
  Widget build(BuildContext context) {
    return _reload(widget.list, widget.a);
  }

  Widget _reload(List list, a) {
    var _size5 = SizedBox(height: 5);
    var _size10w = SizedBox(width: 1);
    return SizedBox(
        child: Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 151, 150, 150),
      highlightColor: Color.fromARGB(255, 221, 221, 219),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: list.length,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 70, 70),
                        borderRadius: BorderRadius.circular(5)),
                  ));
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              viewportFraction: 1,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                setState(() {
                  a = index;
                });
              },
            ),
          ),
        ),
      ),
    ));
  }
}
