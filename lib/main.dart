import 'package:approx_teeone/showResultWidget.dart';
import 'package:approx_teeone/showTimeWidget.dart';
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
  NumberFormat MinuteFormatter = new NumberFormat("00");

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

  final myController_abstand = TextEditingController();
  final myController_tee = TextEditingController();

  @override
  void dispose() {
    myController_abstand.dispose();
    myController_tee.dispose();
    super.dispose();
  }

  void _operateTime() {
    // get current time
    // calculate difference
    // calculate time = current - difference
    // show time
    setState(() {
      delta = myController_abstand.text;
      tee = myController_tee.text;
      currentTime = DateTime.now();
      uhrzeit =
          '${currentTime.hour}:${MinuteFormatter.format(currentTime.minute)}';
      playedTime = int.parse(delta) * int.parse(tee);
      approxTeeOne = currentTime.subtract(Duration(minutes: playedTime));
      showApproxTime =
          '${approxTeeOne.hour}:${MinuteFormatter.format(approxTeeOne.minute)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            showTimeWidget(
              text: 'Aktuell     ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              uhrzeit: uhrzeit,
              colorDeep: 200,
              containerHeight: containerHeight,
            ),
            SimpleInputWidget(
              text: 'Abstand:    ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              aFunction: myController_abstand,
              secondText: ' Min.',
              colorDeep: 400,
              containerHeight: containerHeight,
            ),
            SimpleInputWidget(
              text: 'Abschlag:  ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              aFunction: myController_tee,
              secondText: '',
              colorDeep: 600,
              containerHeight: containerHeight,
            ),
            showTimeWidget(
              text: 'approx. Spielzeit:   ',
              normalStyle: normalStyle,
              resultStyle: resultStyle,
              uhrzeit: playedTime.toString() + ' Min.',
              colorDeep: 800,
              containerHeight: containerHeight,
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
