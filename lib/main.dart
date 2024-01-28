import 'package:approx_teeone/selectANumberWidget.dart';
import 'package:approx_teeone/showResultWidget.dart';
import 'package:approx_teeone/showATimeWidget.dart';
import 'package:approx_teeone/inputTeeWidget.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:approx_teeone/logger.util.dart';

void main() {
  Logger.level = Level.debug;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appTitle = 'Erster Abschlag wann?';

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golf-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: 'RadioCanada',
        useMaterial3: true,
      ),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(
        currentTime: DateTime.now(),
        approxTeeOne: DateTime.now(),
        minuteFormatter: NumberFormat("00"),
        uhrzeit: 'Knopf drücken',
        showApproxTime: 'Zu berechnen',
        tee: "1",
        delta: "10",
        playedTime: 0,
        startAbstaende: [' 5 Min.', ' 8 Min.', '10 Min.', '12 Min.', '15 Min.'],
        containerHeight: 80,
      );
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime currentTime;
  DateTime approxTeeOne;
  NumberFormat minuteFormatter;

// Uhrzeiten umgewandelt in Strings
  String uhrzeit;
  String showApproxTime;
  String tee;
  String delta;
  int playedTime;

  List<String> startAbstaende;

  double containerHeight;

  _MyHomePageState({
    required this.currentTime,
    required this.approxTeeOne,
    required this.minuteFormatter,
    required this.uhrzeit,
    required this.showApproxTime,
    required this.tee,
    required this.delta,
    required this.playedTime,
    required this.startAbstaende,
    required this.containerHeight,
  });

  final TextStyle normalStyle = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  final TextStyle resultStyle = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  Color? inputColor = Colors.green[500];
  Color? timeColor = Colors.green[700];

  final myControllerAbstand = TextEditingController();
  final myControllerTee = TextEditingController();

  String selectedValue = '';
  String auswahl = '10 Min.';

  String version = '1.4.2';
  // no underlines for input

  @override
  void dispose() {
    myControllerAbstand.dispose();
    myControllerTee.dispose();
    super.dispose();
  }

  void callbackForDropdown(String gewaehlterAbschlag) {
    setState(() {
      auswahl = gewaehlterAbschlag;
    });
  }

  void _operateTime() {
// get current time
// calculate difference
// calculate time = current - difference
// show time
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
//delta = myControllerAbstand.text;
      selectedValue = auswahl;
      delta = selectedValue.replaceAll(' Min.', '');
      tee = myControllerTee.text;
      currentTime = DateTime.now();
      uhrzeit =
          '${currentTime.hour}:${minuteFormatter.format(currentTime.minute)}';
      playedTime = int.parse(delta.trimLeft()) * int.parse(tee);
      approxTeeOne = currentTime.subtract(Duration(minutes: playedTime));
      showApproxTime =
          '${approxTeeOne.hour}:${minuteFormatter.format(approxTeeOne.minute)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: normalStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            showATimeWidget(
              text: 'Aktuell     ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              uhrzeit: uhrzeit,
              aColor: timeColor,
            ),
            showResultWidget(
                text: '1. Abschlag:   ',
                showApproxTime: showApproxTime,
                normalStyle: normalStyle,
                resultStyle: resultStyle,
                aColor: Colors.orange[700],
                containerHeight: containerHeight),
            selectANumberWidget(
              normalStyle: normalStyle,
              aColor: inputColor,
              text: 'Abstand:   ',
              list: startAbstaende,
              dropdownValue: startAbstaende[2],
              onChildChanged: (String auswahlInChild) {
                callbackForDropdown(auswahlInChild);
              },
            ),
            inputTeeWidget(
              text: 'Abschlag:  ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              aFunction: myControllerTee,
              aColor: inputColor,
            ),
            showATimeWidget(
              text: 'approx. Spielzeit:   ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              uhrzeit: playedTime.toString() + ' Min.',
              aColor: timeColor,
            ),
            Text(version),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        height: 100,
        width: 100,
        child: FloatingActionButton(
          onPressed: _operateTime,
          tooltip: 'Starten',
          backgroundColor: Colors.greenAccent[400],
          child: const Icon(Icons.sports_golf_sharp,
              size: 68.0, color: Colors.blue),
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
