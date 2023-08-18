// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomeListView extends StatelessWidget {
  final ScrollController scrollController;
  final List images;

  const HomeListView({
    Key? key,
    required this.scrollController,
    required this.images,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  images[index],
                  width: 360,
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          }),
    );
  }
}
