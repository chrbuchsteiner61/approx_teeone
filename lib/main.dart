import 'package:approx_teeone/showResultWidget.dart';
import 'package:approx_teeone/showATimeWidget.dart';
import 'package:approx_teeone/simpleInputWidget.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golf-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        // fontFamily: Arial, Helvetica,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Erster Abschlag wann?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime currentTime = DateTime.now();
  DateTime approxTeeOne = DateTime.now();
  NumberFormat minuteFormatter = NumberFormat("00");

  // Uhrzeiten umgewandelt in Strings
  String uhrzeit = 'Knopf drücken';
  String showApproxTime = 'Zu berechnen';
  String tee = "1";
  String delta = "10";
  int playedTime = 60;

  double containerHeight = 80;

  final TextStyle normalStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  final TextStyle resultStyle = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white70,
  );

  final myControllerAbstand = TextEditingController();
  final myControllerTee = TextEditingController();

  @override
  void dispose() {
    myControllerAbstand.dispose();
    myControllerTee.dispose();
    super.dispose();
  }

  void _operateTime() {
    // get current time
    // calculate difference
    // calculate time = current - difference
    // show time
    setState(() {
      delta = myControllerAbstand.text;
      tee = myControllerTee.text;
      currentTime = DateTime.now();
      uhrzeit =
          '${currentTime.hour}:${minuteFormatter.format(currentTime.minute)}';
      playedTime = int.parse(delta) * int.parse(tee);
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
        title: Text(widget.title,
        style: normalStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            showATimeWidget(
              text: 'Aktuell     ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              uhrzeit: uhrzeit,
            ),
            SimpleInputWidget(
              text: 'Abstand:    ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              aFunction: myControllerAbstand,
              secondText: ' Min.',
            ),
            SimpleInputWidget(
              text: 'Abschlag:  ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              aFunction: myControllerTee,
              secondText: '',
            ),
            showATimeWidget(
              text: 'approx. Spielzeit:   ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              uhrzeit: playedTime.toString() + ' Min.',
            ),
            showResultWidget(
                text: '1. Abschlag:   ',
                showApproxTime: showApproxTime,
                normalStyle: normalStyle,
                resultStyle: resultStyle,
                aColor: Colors.orange[400],
                containerHeight: containerHeight)
          ],
        ),
      ),

      floatingActionButton: Container(
        height: 100,
        width: 100,
        child: FloatingActionButton(
          onPressed: _operateTime,
          tooltip: 'Starten',
          child: const Icon(Icons.sports_golf_sharp),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
