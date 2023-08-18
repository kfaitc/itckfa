// ignore_for_file: depend_on_referenced_packages, unused_import, unused_field, unused_element, prefer_const_constructors, avoid_print, unused_label, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_final_fields, use_build_context_synchronously, non_constant_identifier_names, prefer_collection_literals, unnecessary_brace_in_string_interps, unnecessary_new, no_leading_underscores_for_local_identifiers, await_only_futures

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/utils/google_search/place.dart';

import '../../../../contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Google_map_verbal extends StatefulWidget {
  const Google_map_verbal({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.lat,
    required this.log,
  });
  final double latitude; //latitude
  final double longitude;
  final OnChangeCallback? lat;
  final OnChangeCallback? log;

  @override
  State<Google_map_verbal> createState() => _SearchPlacesScreenState();
}

const kGoogleApiKey =
    'AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI&callback=initMapVerbal';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPlacesScreenState extends State<Google_map_verbal> {
  String sendAddrress = '';
  late LocatitonGeocoder geocoder = LocatitonGeocoder(kGoogleApiKey);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // final Set<Marker> _marker1 = new Set();
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Set<Marker> _marker = new Set();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController? mapController;
  List data = [];
  Uint8List? get_bytes;

  @override
  void initState() {
    _addMarker(LatLng(widget.latitude, widget.longitude));
    super.initState();
  }

  Uint8List? _imageFile;
  LatLng latLng = LatLng(11.519037, 104.915120);
  CameraPosition? cameraPosition;
  // list of marker
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  // var listMarkerIds = List.empty(growable: true); // []

  void _addMarker(LatLng latLng) {
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
        Find_by_piont(value.latitude, value.longitude);
      },
      infoWindow: InfoWindow(title: 'KFA\'s Developer'),
    );

    setState(() {
      _marker.clear();
      Find_by_piont(latLng.latitude, latLng.longitude);
      // add the new marker to the list of markers
      _marker.add(newMarker);
    });
  }

  int num = 0;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 24.0);
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  int id = 1;
  Set<Polyline> _polylines = Set<Polyline>();
  List<MapType> style_map = [
    MapType.hybrid,
    MapType.normal,
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        title: const Text("KFA's GoogleMap"),
        // leading: IconButton(
        //   icon: Icon(Icons.keyboard_backspace),
        //   onPressed: () {
        //     showDialog(
        //         context: context,
        //         builder: (context) {
        //           return AlertDialog(
        //             contentPadding: EdgeInsets.all(50),
        //             content: Column(
        //               children: [
        //                 if (latitude != null)
        //                   Container(
        //                     margin: EdgeInsets.all(10),
        //                     child: Image.network(
        //                         'https://maps.googleapis.com/maps/api/staticmap?center=${latitude},${longitude}&zoom=19&size=400x400&maptype=hybrid&markers=color:red%7Clabel:K%7C${latitude},${longitude}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
        //                   )
        //                 else
        //                   Text("Please poin the map"),
        //                 TextButton(
        //                     onPressed: () async {
        //                       final response = await http.get(Uri.parse(
        //                           'https://maps.googleapis.com/maps/api/staticmap?center=${latitude},${longitude}&zoom=19&size=400x400&maptype=hybrid&markers=color:red%7Clabel:K%7C${latitude},${longitude}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
        //                       final bytes = response.bodyBytes;
        //                       get_bytes = Uint8List.fromList(bytes);
        //                       setState(() {
        //                         // widget.image_map!(get_bytes);
        //                       });
        //                       Navigator.pop(context);
        //                       Navigator.pop(context);
        //                     },
        //                     child: Text("Back"))
        //               ],
        //             ),
        //           );
        //         });
        //   },
        // ),
        leading: IconButton(
            onPressed: () {
              widget.lat!(latLng.latitude);
              widget.log!(latLng.longitude);
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          (widget.latitude != 0)
              ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude, widget.longitude),
                      zoom: 12),
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,

                  // markers: Set.from(_marker),
                  zoomGesturesEnabled: true,

                  markers: _marker.map((e) => e).toSet(),
                  polylines: _polylines,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  onCameraMove: (CameraPosition cameraPositiona) {
                    cameraPosition = cameraPositiona; //when map is dragging
                  },
                  mapType: style_map[index],
                  onTap: (argument) {
                    _addMarker(argument);
                  },
                )
              : Center(
                  child: Text('Error'),
                ),
          Container(
            margin: EdgeInsets.only(left: 1, right: 55, top: 5),
            padding: EdgeInsets.only(left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromARGB(255, 254, 254, 254),
            ),
            child: TextFormField(
              onFieldSubmitted: (value) {
                setState(() {
                  Find_Lat_log(value);
                });
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search_outlined),
                hintText: 'latlog',
                border: null,
                enabledBorder: null,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
                hintStyle: TextStyle(
                  color: Colors.grey[850],
                  fontSize: MediaQuery.of(context).textScaleFactor * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 10),
            child: FloatingActionButton(
              onPressed: () {
                if (index < 1) {
                  index = index + 1;
                } else {
                  index = 0;
                }
              },
              backgroundColor: Colors.blue[300],
              child: Icon(
                Icons.mp_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$la,$lo&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      // widget.lat(lati.toString());
      // widget.log(longi.toString());
      // Use the latitude and longitude to display a marker on the map
      // var marker = Marker(
      //   markerId: MarkerId('Commune Location'),
      //   position: LatLng(latitude, longitude),
      //   // infoWindow: InfoWindow(title: communeName),
      // );
      List ls = jsonResponse['results'];
      List ac;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_3") {
            setState(() {
              commune = (jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
              // widget.commune(jsonResponse['results'][j]['address_components'][i]
              //     ['short_name']);
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              district = (jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
              // widget.district(jsonResponse['results'][j]['address_components']
              //     [i]['short_name']);
            });
          }
          // if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
          //     "administrative_area_level_1") {
          //   setState(() {
          //     widget.province(jsonResponse['results'][j]['address_components']
          //         [i]['short_name']);
          //   });
          // }
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('sangkat = $commune / khan = $district'),
        ),
      );
    } else {
      // Error or invalid response
      print(response.statusCode);
    }
  }

  Future<void> Find_Lat_log(var place) async {
    var check_charetor = place.split(',');
    if (check_charetor.length == 1) {
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=${check_charetor[0]}&region=kh&key=AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY';
      final response = await http.get(Uri.parse(url));
      final jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      // widget.lat(lati.toString());
      // widget.log(longi.toString());
      latLng = LatLng(lati, longi);
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onDragEnd: (value) {
          latLng = value;
          Find_by_piont(value.latitude, value.longitude);
        },
        infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        _marker.clear();
        Find_by_piont(lati, longi);
        _marker.add(newMarker);
      });

      // print('------------------- $latitude');
      // print('------------------- $longitude');

      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 13)));
      List ls = jsonResponse['results'];
      List ac;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_3") {
            setState(() {
              // widget.commune(jsonResponse['results'][j]['address_components'][i]
              //     ['short_name']);
              print('Value ');
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              // widget.district(jsonResponse['results'][j]['address_components']
              //     [i]['short_name']);
            });
          }
        }
      }
    } else {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${check_charetor[0]},${check_charetor[1]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      // widget.lat(lati.toString());
      // widget.log(longi.toString());
      latLng = LatLng(lati, longi);
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onDragEnd: (value) {
          latLng = value;
          Find_by_piont(value.latitude, value.longitude);
        },
        infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        _marker.clear();
        Find_by_piont(lati, longi);
        _marker.add(newMarker);
      });

      // print('------------------- $latitude');
      // print('------------------- $longitude');

      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 13)));
      List ls = jsonResponse['results'];
      List ac;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_3") {
            setState(() {
              // widget.commune(jsonResponse['results'][j]['address_components'][i]
              //     ['short_name']);
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              // widget.district(jsonResponse['results'][j]['address_components']
              //     [i]['short_name']);
            });
          }
        }
      }
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var commune, district;

  List list = [];
  void Clear() {
    setState(() {
      for (var i = 0; i < list.length; i++) {
        MarkerId markerId = MarkerId('$i');
        listMarkerIds.remove(markerId);
      }
    });
  }

  final Set<Marker> marker = Set(); //163
}







// Container(
//           child: Stack(
//             children: [
//               (lat != null)
//                   ? GoogleMap(
//                       // markers: getmarkers(),
//                       markers: ((num > 0)
//                           ? Set<Marker>.of(markers.values)
//                           : getmarkers()),
//                       zoomGesturesEnabled: true,
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(lat, log),
//                         zoom: 16,
//                       ),
//                       mapType: style_map[index],

//                       onMapCreated: (GoogleMapController controller) {
//                         takeSnapShot();
//                         setState(() async {
//                           Future<void>.delayed(const Duration(seconds: 10),
//                               () async {
//                             imageInUnit8List = await controller.takeSnapshot();
//                           });
//                           mapController = controller;
//                         });
//                       },
//                       myLocationButtonEnabled: true,
//                       myLocationEnabled: true,
//                       onTap: (argument) {
//                         MarkerId markerId = MarkerId('mark');
//                         listMarkerIds.add(markerId);
//                         Marker marker = Marker(
//                           markerId: MarkerId('mark'),
//                           position: argument,
//                           icon: BitmapDescriptor.defaultMarkerWithHue(
//                               BitmapDescriptor.hueRed),
//                         );
//                         setState(() {
//                           num = num + 1;
//                           markers[markerId] = marker;
//                           requestModel.lat = argument.latitude.toString();
//                           requestModel.lng = argument.longitude.toString();
//                           Find_by_piont(argument.latitude, argument.longitude);
//                           getAddress(argument);
//                         });
//                       },
//                       onCameraMove: (CameraPosition cameraPositiona) {
//                         cameraPosition = cameraPositiona; //when map is dragging
//                       },
//                     )
//                   : Center(
//                       child: CircularProgressIndicator(),
//                     ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, left: 3, right: 2),
//                 width: MediaQuery.of(context).size.width * 0.42,
//                 child: SearchLocation(
//                   apiKey:
//                       'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
//                   country: 'KH',

// strictBounds: true,
//                   onSelected: (Place place) {
//                     setState(() {
//                       ++num;
//                       address = place.description;
//                       // print(place.description);
//                       getLatLang(address);
//                     });
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, left: 155),
//                 width: MediaQuery.of(context).size.width * 0.42,
//                 alignment: Alignment.centerLeft,
//                 decoration: BoxDecoration(
//                   color: Colors.white70,
//                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black12, blurRadius: 20, spreadRadius: 10)
//                   ],
//                 ),
//                 height: 49,
//                 padding: EdgeInsets.only(left: 10),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   onFieldSubmitted: (value) {
//                     setState(() {
//                       print(value);
//                       Find_by_search(value);
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'By LatLng',
//                     border: InputBorder.none,
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
//                     hintStyle: TextStyle(
//                       color: Colors.grey[850],
//                       fontSize: MediaQuery.of(context).size.width * 0.04,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           height: MediaQuery.of(context).size.height * 1,
//         ),


// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_import, unused_field, unnecessary_new, prefer_collection_literals, prefer_final_fields, unused_element, sized_box_for_whitespace, sort_child_properties_last, avoid_print, unnecessary_brace_in_string_interps

// /*
// Name: Akshath Jain
// Date: 3/18/2019 - 4/26/2021
// Purpose: Example app that implements the package: sliding_up_panel
// Copyright: © 2021, Akshath Jain. All rights reserved.
// Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
// */

// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:circular_menu/circular_menu.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// import 'package:location_geocoder/location_geocoder.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:search_map_location/utils/google_search/place.dart';
// import 'package:search_map_location/widget/search_widget.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../../../models/search_model.dart';
// import '../ToFromDate.dart';
// import '../contants.dart';
// import '../distance.dart';
// import '../landsize.dart';
// import '../numDisplay.dart';
// import '../road.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

// typedef OnChangeCallback = void Function(dynamic value);

// class HomePage extends StatefulWidget {
//   const HomePage(
//       {super.key,
//       required this.c_id,
//       required this.district,
//       required this.commune,
//       required this.province,
//       required this.log,
//       required this.lat});
//   final String c_id;
//   final OnChangeCallback province;
//   final OnChangeCallback district;
//   final OnChangeCallback commune;
//   final OnChangeCallback log;
//   final OnChangeCallback lat;
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   ScreenshotController screenshotController = ScreenshotController();
//   Uint8List? _imageFile;
//   double _panelHeightOpen = 0;
//   final double _panelHeightClosed = 95.0;
//   String googleApikey = "AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI";
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
//   double latitude = 11.519037; //latitude
//   double longitude = 104.915120;
//   LatLng latLng = LatLng(11.519037, 104.915120);
//   String address = "";
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   List list = [];
//   double adding_price = 0.0;
//   String sendAddrress = '';
//   List data = [];
//   var date = DateFormat('yyyy-MM-dd').format(DateTime(2020, 01, 01));
//   var date1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   bool isApiCallProcess = false;
//   // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
//   late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);
//   late SearchRequestModel requestModel;
//   String? _currentAddress;
//   Position? _currentPosition;
// // use for check user access to the location
//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//             _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//         lat = _currentPosition!.latitude;
//         log = _currentPosition!.longitude;
//         MarkerId markerId = MarkerId('mark');
//         listMarkerIds.add(markerId);
//         Marker marker = Marker(
//           markerId: MarkerId('mark'),
//           position: LatLng(lat, log),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         );
//         markers[markerId] = marker;
//         widget.district(place.subLocality);
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   String imageUrl = '';
//   Future showLocation() async {}
//   dynamic lat, log;
//   final Set<Marker> marker = new Set();
//   int num = 0;
//   Uint8List? imageInUnit8List;
//   @override
//   void initState() {
//     // getmarkers();
//     _getCurrentPosition();
//     // getAddress(LatLng(lat, log));

//     requestModel = new SearchRequestModel(
//       property_type_id: "",
//       num: "5",
//       lat: "",
//       lng: "",
//       land_min: "0",
//       land_max: "10000000",
//       distance: "50000",
//       fromDate: "$date",
//       toDate: "$date1",
//     );

//     super.initState();
//   }

//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   void takeSnapShot() async {
//     GoogleMapController controller = await _mapController.future;
//     Future<void>.delayed(const Duration(seconds: 2), () async {
//       imageInUnit8List = await controller.takeSnapshot();
//       setState(() {});
//     });
//   }

//   // var latitude;
//   // var longitude;
//   // final String apiKey = 'YOUR_API_KEY';
//   // final String communeName = 'YOUR_COMMUNE_NAME';
//   // final String url =
//   //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=11.5279091,104.9171695&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
//   Future<void> Find_by_piont(double la, double lo) async {
//     final response = await http.get(Uri.parse(
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

//     if (response.statusCode == 200) {
//       // Successful response
//       var jsonResponse = json.decode(response.body);
//       var location = jsonResponse['results'][0]['geometry']['location'];
//       var lati = location['lat'];
//       var longi = location['lng'];
//       widget.lat(lati.toString());
//       widget.log(longi.toString());

//       // Use the latitude and longitude to display a marker on the map
//       // var marker = Marker(
//       //   markerId: MarkerId('Commune Location'),
//       //   position: LatLng(latitude, longitude),
//       //   // infoWindow: InfoWindow(title: communeName),
//       // );
//       List ls = jsonResponse['results'];
//       List ac;
//       for (int j = 0; j < ls.length; j++) {
//         ac = jsonResponse['results'][j]['address_components'];
//         for (int i = 0; i < ac.length; i++) {
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_3") {
//             setState(() {
//               widget.commune(jsonResponse['results'][j]['address_components'][i]
//                   ['short_name']);
//             });
//           }
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_2") {
//             setState(() {
//               widget.district(jsonResponse['results'][j]['address_components']
//                   [i]['short_name']);
//             });
//           }
//           // if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//           //     "administrative_area_level_1") {
//           //   setState(() {
//           //     widget.province(jsonResponse['results'][j]['address_components']
//           //         [i]['short_name']);
//           //   });
//           // }
//         }
//       }
//     } else {
//       // Error or invalid response
//       print(response.statusCode);
//     }
//   }

//   Future<void> Find_by_search(String place) async {
//     final response = await http.get(Uri.parse(
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=${place}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

//     if (response.statusCode == 200) {
//       // Successful response
//       var jsonResponse = json.decode(response.body);
//       var location = jsonResponse['results'][0]['geometry']['location'];
//       var lati = location['lat'];
//       var longi = location['lng'];
//       widget.lat(lati.toString());
//       widget.log(longi.toString());
//       // requestModel.lat =;
//       // requestModel.lng = ;
//       // latitude = location['lat'];
//       // longitude = location['lng'];
//       MarkerId markerId = MarkerId('mark');
//       // Use the latitude and longitude to display a marker on the map
//       var marker = Marker(
//         markerId: MarkerId('Commune Location'),
//         position: LatLng(lati, longi),
//         // infoWindow: InfoWindow(title: communeName),
//       );
//       markers[markerId] = marker;
//       mapController?.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(lati, longi), zoom: 14)));
//       num = num + 1;
//       List ls = jsonResponse['results'];
//       List ac;
//       for (int j = 0; j < ls.length; j++) {
//         ac = jsonResponse['results'][j]['address_components'];
//         for (int i = 0; i < ac.length; i++) {
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_3") {
//             setState(() {
//               widget.commune(jsonResponse['results'][j]['address_components'][i]
//                   ['short_name']);
//             });
//           }
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_2") {
//             setState(() {
//               widget.district(jsonResponse['results'][j]['address_components']
//                   [i]['short_name']);
//             });
//           }
//           // if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//           //     "administrative_area_level_1") {
//           //   setState(() {
//           //     widget.province(jsonResponse['results'][j]['address_components']
//           //         [i]['short_name']);
//           //   });
//           // }
//         }
//       }
//     } else {
//       // Error or invalid response
//       print(response.statusCode);
//     }
//   }

//   Random random = new Random();
//   Future<dynamic> uploadt_image(File _image) async {
//     var request = await http.MultipartRequest(
//         "POST",
//         Uri.parse(
//             "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image_map"));
//     Map<String, String> headers = {
//       "content-type": "application/json",
//       "Connection": "keep-alive",
//       "Accept-Encoding": " gzip"
//     };
//     request.headers.addAll(headers);
//     // request.files.add(picture);
//     request.fields['cid'] = widget.c_id.toString();
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         "image",
//         _image.path,
//       ),
//     );
//     var response = await request.send();
//     var responseData = await response.stream.toBytes();
//     var result = String.fromCharCodes(responseData);
//     print(result);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Screenshot(
//       controller: screenshotController,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("Google"),
//           elevation: 0.0,
//           backgroundColor: kPrimaryColor,
//           // leading: IconButton(
//           //   icon: Icon(
//           //     Icons.file_download_done,
//           //     size: 40,
//           //     shadows: [
//           //       Shadow(color: Color.fromARGB(255, 178, 63, 254), blurRadius: 10)
//           //     ],
//           //   ),
//           //   color: kwhite,
//           //   onPressed: () async {
//           //     // Navigator.pushReplacement(
//           //     //   context,
//           //     //   MaterialPageRoute(
//           //     //     builder: (context) => Add(
//           //     //       asking_price: adding_price,
//           //     //     ),
//           //     //   ),
//           //     // );
//           //     //=============================
//           //     screenshotController.capture().then((image) {
//           //       setState(() {
//           //         _imageFile = image;
//           //       });
//           //     }).catchError((onError) {
//           //       print(onError);
//           //     });
//           //     if (imageInUnit8List == null) {
//           //       AwesomeDialog(
//           //         context: context,
//           //         dialogType: DialogType.info,
//           //         borderSide: const BorderSide(
//           //           color: Colors.green,
//           //           width: 2,
//           //         ),
//           //         width: 280,
//           //         buttonsBorderRadius: const BorderRadius.all(
//           //           Radius.circular(2),
//           //         ),
//           //         dismissOnTouchOutside: true,
//           //         dismissOnBackKeyPress: false,
//           //         headerAnimationLoop: false,
//           //         animType: AnimType.bottomSlide,
//           //         title: 'Can`t save',
//           //         desc: 'Please Click again!',
//           //         showCloseIcon: true,
//           //         // btnCancelOnPress: () {},
//           //         btnOkOnPress: () {},
//           //       ).show();
//           //     }
//           //     final tempDir = await getTemporaryDirectory();
//           //     File file = await File('${tempDir.path}/image.png').create();
//           //     file.writeAsBytesSync(imageInUnit8List!);
//           //     var compressed = await FlutterImageCompress.compressAndGetFile(
//           //       file.absolute.path,
//           //       file.path + 'compressed.jpg',
//           //       quality: 50,
//           //     );
//           //     uploadt_image(compressed!);

//           //     Navigator.pop(context, data);
//           //   },
//           // ),
//           // actions: <Widget>[
//           //   IconButton(
//           //     icon: const Icon(Icons.save),
//           //     color: kwhite,
//           //     onPressed: () async {
//           //       // Navigator.pushReplacement(
//           //       //   context,
//           //       //   MaterialPageRoute(
//           //       //     builder: (context) => Add(
//           //       //       asking_price: adding_price,
//           //       //     ),
//           //       //   ),
//           //       // );
//           //       screenshotController.capture().then((image) {
//           //         setState(() {
//           //           _imageFile = image;
//           //         });
//           //       }).catchError((onError) {
//           //         print(onError);
//           //       });
//           //       if (imageInUnit8List == null) {
//           //         AwesomeDialog(
//           //           context: context,
//           //           dialogType: DialogType.info,
//           //           borderSide: const BorderSide(
//           //             color: Colors.green,
//           //             width: 2,
//           //           ),
//           //           width: 280,
//           //           buttonsBorderRadius: const BorderRadius.all(
//           //             Radius.circular(2),
//           //           ),
//           //           dismissOnTouchOutside: true,
//           //           dismissOnBackKeyPress: false,
//           //           headerAnimationLoop: false,
//           //           animType: AnimType.bottomSlide,
//           //           title: 'Can`t save',
//           //           desc: 'Please Click again!',
//           //           showCloseIcon: true,
//           //           // btnCancelOnPress: () {},
//           //           btnOkOnPress: () {},
//           //         ).show();
//           //       }
//           //       // final result =
//           //       //     await ImageGallerySaver.saveImage(imageInUnit8List!);
//           //       // Uint8List imageInUnit8List = _imageFile!;

//           //       final tempDir = await getTemporaryDirectory();
//           //       File file = await File(
//           //               '${tempDir.path}/kfa${widget.c_id}${random.nextInt(99)}')
//           //           .create();
//           //       file.writeAsBytesSync(imageInUnit8List!);
//           //       var compressed = await FlutterImageCompress.compressAndGetFile(
//           //         file.absolute.path,
//           //         file.path + '${random.nextInt(99)}.jpg',
//           //         quality: 10,
//           //       );
//           //       uploadt_image(compressed!);
//           //       Navigator.pop(context, data);
//           //     },
//           //   ),
//           // ],
//         ),
//         backgroundColor: kPrimaryColor,
//         body: Container(
//           child: Stack(
//             children: [
//               (lat != null)
//                   ? GoogleMap(
//                       // markers: getmarkers(),
//                       markers: ((num > 0)
//                           ? Set<Marker>.of(markers.values)
//                           : getmarkers()),
//                       zoomGesturesEnabled: true,
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(lat, log),
//                         zoom: 16,
//                       ),
//                       mapType: style_map[index],

//                       onMapCreated: (GoogleMapController controller) {
//                         takeSnapShot();
//                         setState(() async {
//                           Future<void>.delayed(const Duration(seconds: 10),
//                               () async {
//                             imageInUnit8List = await controller.takeSnapshot();
//                           });
//                           mapController = controller;
//                         });
//                       },
//                       myLocationButtonEnabled: true,
//                       myLocationEnabled: true,
//                       onTap: (argument) {
//                         MarkerId markerId = MarkerId('mark');
//                         listMarkerIds.add(markerId);
//                         Marker marker = Marker(
//                           markerId: MarkerId('mark'),
//                           position: argument,
//                           icon: BitmapDescriptor.defaultMarkerWithHue(
//                               BitmapDescriptor.hueRed),
//                         );
//                         setState(() {
//                           num = num + 1;
//                           markers[markerId] = marker;
//                           requestModel.lat = argument.latitude.toString();
//                           requestModel.lng = argument.longitude.toString();
//                           Find_by_piont(argument.latitude, argument.longitude);
//                           getAddress(argument);
//                         });
//                       },
//                       onCameraMove: (CameraPosition cameraPositiona) {
//                         cameraPosition = cameraPositiona; //when map is dragging
//                       },
//                     )
//                   : Center(
//                       child: CircularProgressIndicator(),
//                     ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, left: 3, right: 2),
//                 width: MediaQuery.of(context).size.width * 0.42,
//                 child: SearchLocation(
//                   apiKey:
//                       'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
//                   country: 'KH',

//                   strictBounds: true,
//                   onSelected: (Place place) {
//                     setState(() {
//                       address = place.description;
//                       // print(place.description);
//                       getLatLang(address);
//                     });
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, left: 155),
//                 width: MediaQuery.of(context).size.width * 0.42,
//                 alignment: Alignment.centerLeft,
//                 decoration: BoxDecoration(
//                   color: Colors.white70,
//                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black12, blurRadius: 20, spreadRadius: 10)
//                   ],
//                 ),
//                 height: 49,
//                 padding: EdgeInsets.only(left: 10),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   onFieldSubmitted: (value) {
//                     setState(() {
//                       print(value);
//                       Find_by_search(value);
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'By LatLng',
//                     border: InputBorder.none,
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
//                     hintStyle: TextStyle(
//                       color: Colors.grey[850],
//                       fontSize: MediaQuery.of(context).size.width * 0.04,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           height: MediaQuery.of(context).size.height * 1,
//         ),
//         bottomNavigationBar: Container(
//           height: MediaQuery.of(context).size.height * 0.06,
//           color: Colors.blue[50],
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.person_pin_circle,
//                     size: 40, color: Colors.black),
//                 onPressed: () {
//                   setState(() {
//                     num = 0;
//                   });
//                 },
//               ),
//               // IconButton(
//               //   icon: Icon(Icons.photo_camera_back,
//               //       size: 40, color: Colors.black),
//               //   onPressed: () async {
//               //     setState(() async {
//               //       screenshotController.capture().then((image) {
//               //         setState(() {
//               //           _imageFile = image;
//               //         });
//               //       }).catchError((onError) {
//               //         print(onError);
//               //       });
//               //       final result =
//               //           await ImageGallerySaver.saveImage(imageInUnit8List!);
//               //       // Uint8List imageInUnit8List = _imageFile!;

//               //       final tempDir = await getTemporaryDirectory();
//               //       File file =
//               //           await File('${tempDir.path}/image.png').create();
//               //       file.writeAsBytesSync(imageInUnit8List!);
//               //       var compressed =
//               //           await FlutterImageCompress.compressAndGetFile(
//               //         file.absolute.path,
//               //         file.path + 'compressed.jpg',
//               //         quality: 10,
//               //       );
//               //       // XFile file = await imagePath.writeAsBytes(_imageFile);
//               //       String uniqueFileName =
//               //           DateTime.now().millisecondsSinceEpoch.toString();
//               //       Reference referenceRoot = FirebaseStorage.instance.ref();
//               //       Reference referenceDirImages =
//               //           referenceRoot.child('${widget.c_id}+m');
//               //       Reference referenceImageToUpload =
//               //           referenceDirImages.child('name');
//               //       try {
//               //         await referenceImageToUpload
//               //             .putFile(File(compressed!.path));
//               //         imageUrl = await referenceImageToUpload.getDownloadURL();
//               //       } catch (error) {}
//               //       if (imageUrl != null) {
//               //         setState(() {
//               //           Map<String, String> dataToSend = {
//               //             'com_id': widget.c_id,
//               //             'lat&lng': requestModel.lat + "/" + requestModel.lng,
//               //             'image': imageUrl,
//               //           };
//               //           _reference.add(dataToSend);
//               //         });
//               //         ScaffoldMessenger.of(context).showSnackBar(
//               //           SnackBar(
//               //             content: Center(
//               //               child: Text("Photo was successfully"),
//               //             ),
//               //             duration: Duration(seconds: 1),
//               //           ),
//               //         );
//               //       }
//               //     });
//               //   },
//               // ),
//               IconButton(
//                 icon: Icon(Icons.business, size: 40, color: Colors.black),
//                 onPressed: () {
//                   setState(() {
//                     if (index < 1) {
//                       index = index + 1;
//                     } else {
//                       index = 0;
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         // floatingActionButton: circularMenu,
//       ),
//     );
//   }

//   int _selectedIndex = 0;
//   void _onItemTapped(int index) {
//     index = _selectedIndex;
//     setState(() {
//       if (_selectedIndex == 0) {
//         num = 0;
//       } else {
//         if (index < 1) {
//           index = index + 1;
//         } else {
//           index = 0;
//         }
//       }
//     });
//   }

//   // Widget _uiSteup(BuildContext context) {
//   //   // TextEditingController search = TextEditingController();
//   //   _panelHeightOpen = MediaQuery.of(context).size.height * .80;
//   //   return Screenshot(
//   //     controller: screenshotController,
//   //     child: Scaffold(
//   //       appBar: AppBar(
//   //         title: Center(child: Text("GoogleMap")),
//   //         elevation: 0.0,
//   //         backgroundColor: kPrimaryColor,
//   //         actions: <Widget>[
//   //           IconButton(
//   //             icon: const Icon(Icons.save),
//   //             color: kwhite,
//   //             //style: IconButton.styleFrom(backgroundColor: kImageColor),
//   //             //onPressed: () => Show(),S
//   //             onPressed: () async {
//   //               // Navigator.pushReplacement(
//   //               //   context,
//   //               //   MaterialPageRoute(
//   //               //     builder: (context) => Add(
//   //               //       asking_price: adding_price,
//   //               //     ),
//   //               //   ),
//   //               // );
//   //               screenshotController.capture().then((image) {
//   //                 setState(() {
//   //                   _imageFile = image;
//   //                 });
//   //               }).catchError((onError) {
//   //                 print(onError);
//   //               });
//   //               XFile? file = Image.memory(_imageFile!) as XFile?;
//   //               String uniqueFileName =
//   //                   DateTime.now().millisecondsSinceEpoch.toString();
//   //               Reference referenceRoot = FirebaseStorage.instance.ref();
//   //               Reference referenceDirImages = referenceRoot.child('images');
//   //               Reference referenceImageToUpload =
//   //                   referenceDirImages.child('name');
//   //               try {
//   //                 await referenceImageToUpload.putFile(File(file!.path));
//   //                 imageUrl = await referenceImageToUpload.getDownloadURL();
//   //               } catch (error) {}
//   //               if (imageUrl != null) {
//   //                 setState(() {
//   //                   Map<String, String> dataToSend = {
//   //                     'com_id': widget.c_id,
//   //                     'lat&lng': requestModel.lat + "/" + requestModel.lng,
//   //                     'image': imageUrl,
//   //                   };
//   //                   _reference.add(dataToSend);
//   //                 });
//   //               }
//   //               data = [
//   //                 {
//   //                   'adding_price': adding_price,
//   //                   'address': sendAddrress,
//   //                   'lat': requestModel.lat,
//   //                   'lng': requestModel.lng
//   //                 }
//   //               ];
//   //               Navigator.pop(context, data);
//   //             },
//   //           ),
//   //         ],
//   //       ),
//   //       backgroundColor: kPrimaryColor,
//   //       body: Container(
//   //         child: MapShow(),
//   //         height: MediaQuery.of(context).size.height * 1,
//   //       ),
//   //       bottomNavigationBar: Container(
//   //         height: MediaQuery.of(context).size.height * 0.06,
//   //         color: Colors.blue[50],
//   //         child: Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //           children: [
//   //             IconButton(
//   //               icon: Icon(Icons.person_pin_circle,
//   //                   size: 40, color: Colors.black),
//   //               onPressed: () {
//   //                 setState(() {
//   //                   num = 0;
//   //                 });
//   //               },
//   //             ),
//   //             IconButton(
//   //               icon: Icon(Icons.business, size: 40, color: Colors.black),
//   //               onPressed: () {
//   //                 setState(() {
//   //                   if (index < 1) {
//   //                     index = index + 1;
//   //                   } else {
//   //                     index = 0;
//   //                   }
//   //                 });
//   //               },
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//   //       // floatingActionButton: circularMenu,
//   //     ),
//   //   );
//   // }
// // set defual lat and log
//   Set<Marker> getmarkers() {
//     //markers to place on map
//     setState(() {
//       marker.add(Marker(
//         //add second marker
//         markerId: MarkerId("showLocation.toString()"),
//         // position: LatLng(lat, log),
//         position: ((num > 0) ? latLng : LatLng(lat, log)), //position of marker
//         infoWindow: InfoWindow(
//           //popup info
//           title: 'Thanks for using us',
//         ),
//         icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//       ));
//       requestModel.lat = lat.toString();
//       requestModel.lng = log.toString();
//       //add more markers here
//     });

//     return marker;
//   }

//   Widget _panel(ScrollController sc) {
//     return MediaQuery.removePadding(
//       context: context,
//       removeTop: true,
//       child: ListView(
//         controller: sc,
//         children: <Widget>[
//           SizedBox(
//             height: 12.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: 30,
//                 height: 5,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 18.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 "More Option",
//                 style: TextStyle(
//                   fontWeight: FontWeight.normal,
//                   fontSize: 24.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 36.0),
//           // RoadDropdown(
//           //   onChanged: (value) {
//           //     // requestModel.comparable_road = value;
//           //     //  print(requestModel.comparable_road);
//           //   },
//           // ),
//           // SizedBox(height: 10.0),
//           ToFromDate(
//             fromDate: (value) {
//               requestModel.fromDate = value;
//               print(requestModel.fromDate);
//             },
//             toDate: (value) {
//               requestModel.toDate = value;
//               // print(requestModel.toDate);
//             },
//           ),
//           SizedBox(height: 10.0),
//           LandSize(
//             land_min: (value) {
//               requestModel.land_min = value;
//               print(requestModel.fromDate);
//             },
//             land_max: (value) {
//               requestModel.land_max = value;
//               print(requestModel.toDate);
//             },
//           ),
//           SizedBox(height: 10.0),
//           NumDisplay(onSaved: (newValue) => requestModel.num = newValue!),
//           SizedBox(height: 10.0),
//           Distance(onSaved: (input) => requestModel.distance = input!),
//           addPaddingWhenKeyboardAppears(),
//         ],
//       ),
//     );
//   }

//   SizedBox addPaddingWhenKeyboardAppears() {
//     final viewInsets = EdgeInsets.fromWindowPadding(
//       WidgetsBinding.instance.window.viewInsets,
//       WidgetsBinding.instance.window.devicePixelRatio,
//     );
//     final bottomOffset = viewInsets.bottom;
//     const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
//     final isNeedPadding = bottomOffset != hiddenKeyboard;
//     return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
//   }

//   List<MapType> style_map = [
//     MapType.hybrid,
//     MapType.normal,
//   ];
//   int index = 0;
//   Stack MapShow() {
//     return Stack(
//       children: [
//         (lat != null)
//             ? GoogleMap(
//                 // markers: getmarkers(),
//                 markers:
//                     ((num > 0) ? Set<Marker>.of(markers.values) : getmarkers()),
//                 //Map widget from google_maps_flutter package
//                 zoomGesturesEnabled: true, //enable Zoom in, out on map
//                 initialCameraPosition: CameraPosition(
//                   //innital position in map
//                   target: LatLng(latitude, longitude),
//                   // target: ((num < 0)
//                   //     ? LatLng(lat, log)
//                   //     : latLng), //initial position
//                   zoom: 16, //initial zoom level
//                 ),
//                 mapType: style_map[index], //map type
//                 onMapCreated: (controller) {
//                   //method called when map is created
//                   setState(() {
//                     mapController = controller;
//                   });
//                 },
//                 myLocationButtonEnabled: true,
//                 myLocationEnabled: true,
//                 onTap: (argument) {
//                   MarkerId markerId = MarkerId('mark');
//                   listMarkerIds.add(markerId);
//                   Marker marker = Marker(
//                     markerId: MarkerId('mark'),
//                     position: argument,
//                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                         BitmapDescriptor.hueRed),
//                   );
//                   setState(() {
//                     num = num + 1;
//                     markers[markerId] = marker;
//                     requestModel.lat = argument.latitude.toString();
//                     requestModel.lng = argument.longitude.toString();
//                     getAddress(argument);
//                   });
//                 },
//                 onCameraMove: (CameraPosition cameraPositiona) {
//                   cameraPosition = cameraPositiona; //when map is dragging
//                 },
//               )
//             : Center(
//                 child: CircularProgressIndicator(),
//               ),
//         Container(
//           margin: EdgeInsets.only(left: 5),
//           alignment: Alignment.topLeft,
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: SearchLocation(
//             apiKey:
//                 'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
//             country: 'KH',
//             onSelected: (Place place) {
//               setState(() {
//                 address = place.description;
//                 print(place.description);
//                 getLatLang(address);
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   void Load() async {
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/list?page=100'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         list = jsonData['data'];
//       });

//       // print(list.length);
//     }
//   }

//   void Clear() {
//     setState(() {
//       for (var i = 0; i < list.length; i++) {
//         MarkerId markerId = MarkerId('$i');
//         listMarkerIds.remove(markerId);
//       }
//     });
//   }

//   Future<void> Show(SearchRequestModel requestModel) async {
//     setState(() {
//       isApiCallProcess = true;
//     });
//     final rs = await http.post(
//         Uri.parse(
//             'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/map_action'),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/x-www-form-urlencoded"
//         },
//         body: requestModel.toJson());
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         list = jsonData['autoverbal'];
//       });
//     }
//     Map map = list.asMap();
//     if (requestModel.lat.isEmpty || requestModel.lng.isEmpty) {
//       setState(() {
//         isApiCallProcess = false;
//       });
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.rightSlide,
//         headerAnimationLoop: false,
//         title: 'Please tap on map to select location',
//         btnOkOnPress: () {},
//         btnOkIcon: Icons.cancel,
//         btnOkColor: Colors.red,
//       ).show();
//     } else {
//       setState(() {
//         isApiCallProcess = false;
//       });
//       if (map.isEmpty) {
//         markers.clear();
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.error,
//           animType: AnimType.rightSlide,
//           headerAnimationLoop: false,
//           title: 'No data found!',
//           desc: "You can try to change the information. ",
//           btnOkOnPress: () {},
//           btnOkIcon: Icons.cancel,
//           btnOkColor: Colors.red,
//         ).show();
//       } else {
//         adding_price = 0;
//         for (var i = 0; i < map.length; i++) {
//           print("Index $i");
//           if (map[i]['comparable_adding_price'] == '') {
//             map[i]['comparable_adding_price'] = '0';
//             adding_price +=
//                 double.parse(map[i]['comparable_adding_price']) / map.length;
//             print(map[i]['comparable_adding_price']);
//           } else if (map[i]['comparable_adding_price'].contains(',')) {
//             print(map[i]['comparable_adding_price'].replaceAll(",", ""));
//             adding_price += double.parse(
//                     map[i]['comparable_adding_price'].replaceAll(",", "")) /
//                 map.length;
//             print(map[i]['comparable_adding_price']);
//             //print(map[i]['comparable_adding_price'].split(",")[0]);
//           } else {
//             adding_price +=
//                 (double.parse(map[i]['comparable_adding_price'])) / map.length;
//             print(map[i]['comparable_adding_price']);
//           }
//           MarkerId markerId = MarkerId('$i');
//           listMarkerIds.add(markerId);
//           Marker marker = Marker(
//             markerId: markerId,
//             position: LatLng(
//               double.parse(map[i]['latlong_log']),
//               double.parse(map[i]['latlong_la']),
//             ),
//             icon:
//                 BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//             onTap: () {
//               setState(() {
//                 showDialog<String>(
//                   context: context,
//                   builder: (BuildContext context) => AlertDialog(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     title: Text(
//                       map[i]['property_type_name'],
//                       style: TextStyle(
//                           color: kPrimaryColor, fontWeight: FontWeight.bold),
//                     ),
//                     content: SizedBox(
//                       height: 100,
//                       child: Row(
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Price',
//                                 style: TextStyle(
//                                     color: kImageColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text('Land-Width'),
//                               Text('Land-Length'),
//                               Text('Land-Total'),
//                               Text('Date'),
//                             ],
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '  :   ' +
//                                     map[i]['comparable_adding_price'] +
//                                     '\$',
//                                 style: TextStyle(
//                                     color: kImageColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text('  :   ' + map[i]['comparable_land_width']),
//                               Text('  :   ' + map[i]['comparable_land_length']),
//                               Text('  :   ' + map[i]['comparable_land_total']),
//                               Text('  :   ' + map[i]['comparable_survey_date']),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () => Navigator.pop(context, 'OK'),
//                         child: const Text('OK'),
//                       ),
//                     ],
//                   ),
//                 );
//               });
//             },
//           );
//           setState(() {
//             isApiCallProcess = false;
//             markers[markerId] = marker;
//           });
//         }
//         print(adding_price);
//       }
//     }
//   }

//   ///converts `coordinates` to actual `address` using google map api
//   Future<void> getAddress(LatLng latLng) async {
//     final coordinates = Coordinates(latLng.latitude, latLng.longitude);
//     // var commune;
//     // List<Placemark> placemarks =
//     //     await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
//     // Placemark placeMark = placemarks[0];
//     // setState(() {
//     //   commune = placeMark.subAdministrativeArea;
//     // });
//     try {
//       final address = await geocoder.findAddressesFromCoordinates(coordinates);
//       var message = address.first.subLocality;
//       // final commune=  await geocoder.findAddressesFromQuery(address);
//       if (message == null) return;
//       sendAddrress = message;
//       widget.district(address.first.subLocality);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Address: ${message}"),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
//         ),
//       );
//       rethrow;
//     }
//   }

//   ///converts `address` to actual `coordinates` using google map api
//   Future<void> getLatLang(String adds) async {
//     try {
//       final address = await geocoder.findAddressesFromQuery(adds);
//       var message = address.first.coordinates.toString();
//       latitude = address.first.coordinates.latitude!;
//       longitude = address.first.coordinates.longitude!;
//       latLng = LatLng(latitude, longitude);
//       mapController?.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(latitude, longitude), zoom: 13)));
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
//         ),
//       );
//       rethrow;
//     }
//   }

//   // bool _isShowDial = false;
//   // Widget _getFloatingActionButton() {
//   //   return SpeedDialMenuButton(
//   //     //if needed to close the menu after clicking sub-FAB
//   //     isShowSpeedDial: _isShowDial,
//   //     //manually open or close menu
//   //     updateSpeedDialStatus: (isShow) {
//   //       //return any open or close change within the widget
//   //       this._isShowDial = isShow;
//   //     },
//   //     //general init
//   //     isMainFABMini: false,
//   //     mainMenuFloatingActionButton: MainMenuFloatingActionButton(
//   //         mini: false,
//   //         child: Icon(Icons.menu),
//   //         onPressed: () {},
//   //         closeMenuChild: Icon(Icons.close),
//   //         closeMenuForegroundColor: Colors.white,
//   //         closeMenuBackgroundColor: Colors.red),
//   //     floatingActionButtonWidgetChildren: <FloatingActionButton>[
//   //       FloatingActionButton(
//   //         mini: true,
//   //         child: Icon(Icons.location_history),
//   //         onPressed: () {
//   //           //if need to close menu after click
//   //           _isShowDial = false;
//   //           setState(() {
//   //             num = 0;
//   //           });
//   //         },
//   //         backgroundColor: Colors.pink,
//   //       ),
//   //       FloatingActionButton(
//   //         mini: true,
//   //         child: Icon(Icons.photo_size_select_large),
//   //         onPressed: () {
//   //           //if need to toggle menu after click
//   //           _isShowDial = !_isShowDial;
//   //           setState(() {
//   //             if (index < 1) {
//   //               index = index + 1;
//   //             } else {
//   //               index = 0;
//   //             }
//   //           });
//   //         },
//   //         backgroundColor: Colors.orange,
//   //       ),
//   //     ],
//   //     isSpeedDialFABsMini: true,
//   //     paddingBtwSpeedDialButton: 80.0,
//   //   );
//   // }

//   // Widget _getBodyWidget() {
//   //   return Container();
//   // }
// }
