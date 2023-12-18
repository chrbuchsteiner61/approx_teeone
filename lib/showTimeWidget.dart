import 'package:approx_teeone/aThemeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class showTimeWidget extends StatelessWidget {
  final String text;
  final TextStyle normalStyle;
  final TextStyle resultStyle;
  final String uhrzeit;
  final Color? aColor;
  final double containerHeight;

  const showTimeWidget({
    required this.text,
    required this.normalStyle,
    required this.resultStyle,
    required this.uhrzeit,
    required this.aColor,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: const EdgeInsets.all(8.0),
        height: containerHeight,
        color: aColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(text, style: normalStyle,
              ),
              Text(
                uhrzeit,
                style: resultStyle,
              )
            ],
          ),
        ),
      );
  }
}
