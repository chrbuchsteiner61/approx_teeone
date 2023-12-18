import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class aThemeWidget extends StatelessWidget {
  final Color? aColor;
  final double containerHeight = 90.0;
  final Widget aChild;
  final double inset = 8.0;

  const aThemeWidget({
    required this.aColor,
    required this.aChild
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(inset),
      height: containerHeight,
      color: aColor,
      child: Padding(padding: EdgeInsets.all(inset),
        child: aChild),
    );
  }
}
