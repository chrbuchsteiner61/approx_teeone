import 'package:approx_teeone/aThemeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class showATimeWidget extends StatelessWidget {
  final String text;
  final TextStyle normalStyle;
  final TextStyle resultStyle;
  final String aTimeOfTheDay;
  final Color? aColor;

  const showATimeWidget({
    required this.text,
    required this.normalStyle,
    required this.resultStyle,
    required this.aTimeOfTheDay,
    required this.aColor,
  });

  @override
  Widget build(BuildContext context) {
    return
      aThemeWidget(aColor: aColor,
        aChild: Row(
            children: <Widget>[
              Text(text, style: normalStyle,
              ),
              Text(
                aTimeOfTheDay,
                style: resultStyle,
              )
            ],
          ),
        );
  }
}
