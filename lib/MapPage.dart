import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'FirebaseGetTrashs.dart';
import 'FutureMap.dart';

Position _currentPosition;
String _currentAddress;
LatLng latlng = LatLng(-23.6503972, -46.5426122);
var _listLenght = '';
List<TrashData> list = [];

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return FutureMap();
  }
}
