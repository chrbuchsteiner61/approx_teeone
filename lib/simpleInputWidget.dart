import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:approx_teeone/aThemeWidget.dart';
import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}

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
            inputFormatters: [
              NumericalRangeFormatter(min: 1, max: 18),
            ],
            style: resultStyle,
            controller: aFunction,
            keyboardType: TextInputType.number,
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
