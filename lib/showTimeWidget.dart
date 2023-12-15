import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class showTimeWidget extends StatelessWidget {
  final String text;
  final TextStyle normalStyle;
  final TextStyle resultStyle;
  final String uhrzeit;
  final int colorDeep;
  final double containerHeight;

  const showTimeWidget({required this.text,
    required this.normalStyle,
    required this.resultStyle,
    required this.uhrzeit,
    required this.colorDeep,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        height: containerHeight,
        color: Colors.green[colorDeep],
        child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Row(
            children: <Widget> [
              Text (text,
                style: normalStyle,
              ),
              Text (uhrzeit,
                style: resultStyle,
              )],
          ),
        ),
      );

  }

}