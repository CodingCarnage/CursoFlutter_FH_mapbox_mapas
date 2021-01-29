import 'package:flutter/material.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({Key key}) : super(key: key);

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: 'pk.eyJ1IjoiY29kaW5nY2FybmFnZSIsImEiOiJja2tlZzJuYXEwY25iMnhxcnl3YzRnM2plIn0.eSyocRuYbhnY0Pj4Q5M8iQ',
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(target: LatLng(26.925738, -101.447115)),
        onStyleLoadedCallback: onStyleLoadedCallback,
      ),
    );
  }

  void onStyleLoadedCallback() {}
}
