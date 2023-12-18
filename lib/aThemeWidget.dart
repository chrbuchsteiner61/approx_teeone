import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class aThemeWidget extends StatelessWidget {
  final Color? aColor;
  final double containerHeight = 80.0;
  final Widget aChild;

  const aThemeWidget({
    required this.aColor,
    required this.aChild
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: containerHeight,
      color: aColor,
      child: Padding(padding: const EdgeInsets.all(8.0),
        child: aChild),
    );
  }
}
