// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SearchLocation(
            apiKey:
                'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
            country: 'KH',
            onSelected: (Place place) {
              print(place.description);
            },
          ),
        ),
      ),
    );
  }
}
