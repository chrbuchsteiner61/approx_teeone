import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String? _currentAddress;
  Position? _currentPosition;

  TextStyle normalStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

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

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // vergleiche die Positionen aller Abschlaege mit der aktuellen Position
  // erforderlich: lies alle Abschlagspositionen ein (sollte in main.dart initial geschehen)

  Future<void> _getCurrentTee() async {
  //Future<int> _getCurrentTee() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            color: Colors.white,
            onPressed: _getCurrentPosition,
            ),
          ),
        Text('Breite: ${_currentPosition?.latitude ?? ""}',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8),),
        Text('Länge:  ${_currentPosition?.longitude ?? ""}',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8),),
      ],
    );
  }
}
