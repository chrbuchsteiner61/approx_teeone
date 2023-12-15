import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SimpleInputWidget extends StatelessWidget {
  final String text;
  final TextStyle normalStyle;
  final TextStyle resultStyle;
  final TextEditingController aFunction;
  final String secondText;
  final int colorDeep;
  final double containerHeight;

  const SimpleInputWidget({
    required this.text,
    required this.normalStyle,
    required this.resultStyle,
    required this.aFunction,
    required this.secondText,
    required this.containerHeight,
    required this.colorDeep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: containerHeight,
      color: Colors.green[colorDeep],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: <Widget>[
          Text(text, style: normalStyle),
          SizedBox(
            width: 30.0,
            child: TextField(
              style: resultStyle,
              controller: aFunction,
              // decoration: InputDecoration(
              // border: OutlineInputBorder(),
            ),
          ),
          Text(
            secondText,
            style: normalStyle,
          ),
        ]),
      ),
    );
  }
}
