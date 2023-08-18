import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget phone;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive(
      {Key? key,
      required this.phone,
      required this.mobile,
      required this.tablet,
      required this.desktop})
      : super(key: key);

//This size work fine with the design
  static bool isMobiles(BuildContext context) =>
      MediaQuery.of(context).size.width < 375;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width > 375 &&
      MediaQuery.of(context).size.width <= 500;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 500;
  static bool isDestop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 500) {
          return tablet;
        } else if (constraints.maxWidth <= 340) {
          return phone;
        } else if (constraints.maxWidth >= 340) {
          return mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
