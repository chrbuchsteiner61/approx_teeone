import 'package:approx_teeone/aThemeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class showATimeWidget extends StatelessWidget {
  final String text;
  final TextStyle normalStyle;
  final TextStyle resultStyle;
  final String uhrzeit;
  final aColor = Colors.greenAccent[700];

  showATimeWidget({
    required this.text,
    required this.normalStyle,
    required this.resultStyle,
    required this.uhrzeit,
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
                uhrzeit,
                style: resultStyle,
              )
            ],
          ),
        );
  }
}
