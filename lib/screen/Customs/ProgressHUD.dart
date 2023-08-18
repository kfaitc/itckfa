// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  //final Animation<Color> valueColor;
  const ProgressHUD({
    Key? key,
    required this.child,
    required this.color,
    required this.inAsyncCall,
    required this.opacity,
    //required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final model = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
      widgetList.add(model);
    }
    return Stack(
      children: widgetList,
    );
  }
}
