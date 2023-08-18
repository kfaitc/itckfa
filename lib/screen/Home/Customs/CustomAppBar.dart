// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppBarCustom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(100, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height + 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
