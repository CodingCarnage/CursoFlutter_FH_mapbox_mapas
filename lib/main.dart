import 'package:flutter/material.dart';

import 'package:mapbox_mapas/src/pages/fullscreenmap_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapbox GL',
      home: Scaffold(
        body: FullScreenMap(),
      ),
    );
  }
}