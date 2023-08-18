import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Marker? selectedMarker;
  bool isContainerVisible = false;

  void onMarkerTapped(Marker marker) {
    setState(() {
      selectedMarker = marker;
      isContainerVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.7749, -122.4194),
      zoom: 12.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: {
              Marker(
                markerId: MarkerId('markerId'),
                position: LatLng(37.7749, -122.4194),
                onTap: () {},
              ),
            },
          ),
          if (isContainerVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                color: Color.fromARGB(255, 17, 9, 123),
                child: Center(
                  child: Text('Marker tapped'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
