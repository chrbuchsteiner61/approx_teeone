import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:csv/csv.dart';

import 'logger.util.dart';

class LocationWidget extends StatefulWidget {
  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Position? currentPosition;
  String? currentTee;

  TextStyle normalStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white);

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    String aTee;

    Logger.level = Level.debug;
    final log = getLogger();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // setState(() => currentPosition = position);
      aTee =
          showNearestTee(locationLatLon, position.latitude, position.longitude);
      setState(() {
        currentPosition = position;
        currentTee = aTee;
      });
    }).catchError((e) {
      debugPrint(e);
    });

    log.d(currentPosition);
  }

  bool test = true;

  String testFile = 'assets/files/test_location.csv';
  String rhgcFile = 'assets/files/rhgc_koordinaten.csv';

  Position? aPosition;

//initialize
  List<List<dynamic>> locationLatLon = [
    [0, 0.0, 0.0]
  ];

  void readCSV(String file_name) async {
    final rawdata = await rootBundle.loadString(file_name);
    List<List<dynamic>> _listData = const CsvToListConverter().convert(rawdata);
    setState(() {
      locationLatLon = _listData;
    });
  }

  String showNearestTee(
      List<List<dynamic>> positionList, double lat, double lon) {
    final log = getLogger();

    String _ergebnis = '1';
    double distance = 1000000000.0;
    double aPositionLat;
    double aPositionLon;

    int numberOfRows = positionList.length;
    for (var i = 0; i < numberOfRows; i++) {
      //for (final positionOfATee in positionList) {
      if (i > 0) {
        var aTee = positionList[i];

        aPositionLat = aTee[1];
        aPositionLon = aTee[2];

        double calculatedDistance =
            Geolocator.distanceBetween(aPositionLat, aPositionLon, lat, lon);

        // log.d(calculatedDistance);

        if (calculatedDistance < distance) {
          distance = calculatedDistance;
          _ergebnis = aTee[0].toString();
        }
      }
    }

    return _ergebnis;
  }

  @override
  Widget build(BuildContext context) {
    Logger.level = Level.debug;
    final log = getLogger();

    String file;
    bool test = true;

    if (test) {
      file = testFile;
    } else {
      file = rhgcFile;
    }

    readCSV(file);

    // currentPosition.latitude and currentPosition.longitude
    //final currentTee = showNearestTee(locationLatLon, 37.4, -0.25);
    //log.d(currentTee);

    return Center(
      child: Row(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 56,
              color: Colors.white,
              onPressed: _getCurrentPosition,
            ),
          ),
          Text(currentTee ?? '?', style: normalStyle),
        ],
      ),
    );
  }
}
