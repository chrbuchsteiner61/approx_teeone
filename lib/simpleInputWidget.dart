import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:approx_teeone/aThemeWidget.dart';

class SimpleInputWidget extends StatelessWidget {
  final String text;
  final TextStyle normalStyle;
  final TextStyle resultStyle;
  final TextEditingController aFunction;
  final String secondText;
  final Color? aColor;

  SimpleInputWidget({
    required this.text,
    required this.normalStyle,
    required this.resultStyle,
    required this.aFunction,
    required this.secondText,
    required this.aColor,
  });

  @override
  Widget build(BuildContext context) {
    return aThemeWidget(
      aColor: aColor,
      aChild: Row(children: <Widget>[
        Text(text, style: normalStyle),
        SizedBox(
          width: 40.0,
          child: TextField(
            style: resultStyle,
            controller: aFunction,
          ),
        ),
        Text(
          secondText,
          style: normalStyle,
        ),
      ]),
    );
  }
}
