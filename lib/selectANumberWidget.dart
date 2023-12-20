import 'package:flutter/material.dart';

const List<String> list = <String>['5', '8', '10', '12'];

class selectANumberWidget extends StatefulWidget {
  final TextStyle normalStyle;

  const selectANumberWidget({super.key,
    required this.normalStyle});

  @override
  State<selectANumberWidget> createState() => _selectANumberWidgetState(normalStyle: normalStyle, );
}

class _selectANumberWidgetState extends State<selectANumberWidget> {
  final TextStyle normalStyle;

  _selectANumberWidgetState({
    required this.normalStyle,
});

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      underline: Container(
        height: 30,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}
