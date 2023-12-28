import 'package:flutter/material.dart';

import 'aThemeWidget.dart';

//const List<String> list = <String>[' 5 Min.', ' 8 Min.', '10 Min.', '12 Min.'];

typedef void IntCallback(String auswahl);

class selectANumberWidget extends StatefulWidget {
  final IntCallback onChildChanged;
  final TextStyle normalStyle;
  final Color? aColor;
  final String text;
  final List<String> list;
  String dropdownValue;


  selectANumberWidget({super.key,
    required this.normalStyle,
    required this.aColor,
    required this.text,
    required this.list,
    required this.dropdownValue,
    required this.onChildChanged,
  });

  @override
  State<selectANumberWidget> createState() => _selectANumberWidgetState(
        normalStyle: normalStyle,
        aColor: aColor,
        text: text,
        list: list,
        dropdownValue: dropdownValue,
        onChildChanged: onChildChanged,
      );
}

class _selectANumberWidgetState extends State<selectANumberWidget> {
  final IntCallback onChildChanged;
  final TextStyle normalStyle;
  final Color? aColor;
  final String text;
  List<String> list;
  String dropdownValue;

  _selectANumberWidgetState({
    required this.normalStyle,
    required this.aColor,
    required this.text,
    required this.list,
    required this.dropdownValue,
    required this.onChildChanged,
    //required this.dropdownValue,
  });

  @override
  Widget build(BuildContext context) {
    return aThemeWidget(
      aColor: aColor,
      aChild: Row(children: <Widget>[
        Text(text, style: normalStyle),
        SizedBox(
          width: 150.0,
          child: DropdownButton<String>(
            value: dropdownValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down_circle_rounded),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                onChildChanged(dropdownValue);
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
