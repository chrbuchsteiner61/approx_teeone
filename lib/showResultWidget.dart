import 'package:approx_teeone/aThemeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class showResultWidget extends StatelessWidget {
  final String text;
  final String showApproxTime;
  final TextStyle normalStyle;
  final TextStyle resultStyle;
  final Color? aColor;
  final double containerHeight;

  const showResultWidget({
    required this.text,
    required this.showApproxTime,
    required this.normalStyle,
    required this.resultStyle,
    required this.aColor,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return
      aThemeWidget(aColor: aColor,
        aChild: Row(children: <Widget>[
        Text(text, style: normalStyle),
        Text(showApproxTime, style: resultStyle),
      ]),
      );
  }
}
