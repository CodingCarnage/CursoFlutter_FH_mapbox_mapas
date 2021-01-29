import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({Key key}) : super(key: key);

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  static const String accessToken = 'pk.eyJ1IjoiY29kaW5nY2FybmFnZSIsImEiOiJja2tlZzJuYXEwY25iMnhxcnl3YzRnM2plIn0.eSyocRuYbhnY0Pj4Q5M8iQ';
  static const LatLng center = LatLng(37.810575, -122.477174);
  static const String streetsPurpleStyle = 'mapbox://styles/codingcarnage/ckkhlm1cv00ck17mq16y6xex2';
  static const String monochromeStyle = 'mapbox://styles/codingcarnage/ckkhljrrc00b117mn3yksy7cg';

  String selectedStyle = streetsPurpleStyle;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/symbols/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    http.Response response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createMabboxMap(),
      floatingActionButton: floatingButtons(),
    );
  }

  Column floatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          child: Icon(Icons.emoji_symbols),
          onPressed: () {
            mapController.addSymbol(SymbolOptions(
              geometry: center,
              iconImage: 'networkImage',
              fontNames: ['DIN Offc Pro Bold', 'Arial Unicode MS Regular'],
              textField: 'Airport',
              textSize: 12.5,
              textOffset: Offset(0, 0.8),
              textAnchor: 'top',
              textColor: '#000000',
              textHaloBlur: 1,
              textHaloColor: '#ffffff',
              textHaloWidth: 0.8,
            ));
          },
        ),
        const SizedBox(height: 10.0),
        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomIn());
          },
        ),
        const SizedBox(height: 10.0),
        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
        ),
        const SizedBox(height: 10.0),
        FloatingActionButton(
          child: Icon(Icons.color_lens),
          onPressed: () {
            if (selectedStyle == monochromeStyle) {
              selectedStyle = streetsPurpleStyle;
            } else {
              selectedStyle = monochromeStyle;
            }
            setState(() {});
          },
        ),
      ],
    );
  }

  MapboxMap createMabboxMap() {
    return MapboxMap(
      accessToken: accessToken,
      onMapCreated: _onMapCreated,
      styleString: selectedStyle,
      initialCameraPosition: const CameraPosition(
        target: center,
        zoom: 14,
      ),
      onStyleLoadedCallback: onStyleLoadedCallback,
    );
  }

  void onStyleLoadedCallback() {
    _onStyleLoaded();
  }
}
