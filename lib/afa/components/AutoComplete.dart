// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  final Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
      //add second marker
      markerId: MarkerId(AppConstant.list[index]['id']),
      position: LatLng(
        AppConstant.list[index]['lat'],
        AppConstant.list[index]['lon'],
      ), //position of marker
      infoWindow: InfoWindow(title: AppConstant.list[index]["title"]),
      icon: BitmapDescriptor.defaultMarkerWithHue(20.0), //Icon for Marker
    );
    // Marker(
    //     markerId: MarkerId(AppConstant.list[index]['id']),
    //     position: LatLng(
    //       AppConstant.list[index]['lat'],
    //       AppConstant.list[index]['lon'],
    //     ),
    //     infoWindow: InfoWindow(title: AppConstant.list[index]["title"]));
  });

  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
              target: LatLng(23.7985053, 90.3842538), zoom: 13),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
        ),
      ),
    );
  }
}

class AppConstant {
  static List<Map<String, dynamic>> list = [
    {"title": "one", "id": "1", "lat": 23.7985053, "lon": 90.3842538},
    {"title": "two", "id": "2", "lat": 23.802236, "lon": 90.3700},
    {"title": "three", "id": "3", "lat": 23.8061939, "lon": 90.3771193},
  ];
}
