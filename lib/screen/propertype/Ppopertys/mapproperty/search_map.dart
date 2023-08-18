// ignore_for_file: depend_on_referenced_packages, unused_import, unused_field, unused_element, prefer_const_constructors, avoid_print, unused_label, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_final_fields, use_build_context_synchronously, non_constant_identifier_names, prefer_collection_literals, unnecessary_brace_in_string_interps, unnecessary_new, no_leading_underscores_for_local_identifiers, await_only_futures

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

import '../../../../../../../contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Search_Map extends StatefulWidget {
  const Search_Map(
      {super.key,
      required this.c_id,
      required this.district,
      required this.commune,
      required this.province,
      required this.log,
      required this.lat,
      this.image_map});
  final String c_id;
  final OnChangeCallback province;
  final OnChangeCallback district;
  final OnChangeCallback commune;
  final OnChangeCallback log;
  final OnChangeCallback lat;
  final OnChangeCallback? image_map;

  @override
  State<Search_Map> createState() => _SearchPlacesScreenState();
}

const kGoogleApiKey =
    'AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI&callback=initMapVerbal';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPlacesScreenState extends State<Search_Map> {
  double latitude = 11.519037; //latitude
  double longitude = 104.915120;
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
  String? _currentAddress;
  Position? _currentPosition;
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
      setState(() => _getAddressFromLatLng(position));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        latitude = _currentPosition!.latitude;
        longitude = _currentPosition!.longitude;
        latLng = LatLng(latitude, longitude);
        Marker newMarker = Marker(
          draggable: true,
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          onDragEnd: (value) {
            latLng = value;
            Find_by_piont(value.latitude, value.longitude);
          },
          infoWindow: InfoWindow(title: 'KFA\'s Developer'),
          //  infoWindow: InfoWindow(
          // onTap: () {
          // setState(() {
          //   Navigator.of(context).push(
          // MaterialPageRoute(
          // builder: (context) => Detail_Map( district: district, commune: commune,  c_id: '', province: (value) {  }, lat: (value) {  }, log: (value) {  },)
          //  ),
          //   );
          // });         
          // },
          // ),
          //infoWindow: InfoWindow(title: 'KFA\'s Developer'),
        );
        _marker.add(newMarker);
        widget.district(place.subLocality);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
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
      // infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      infoWindow: InfoWindow(
         onTap: () {
          setState(() {
  //           Navigator.of(context).push(
  //      MaterialPageRoute(
  //     builder: (context) => Detail_Map( district: district, commune: commune,  c_id: '', province: (value) {  }, lat: (value) {  }, log: (value) {  },)
  //   ),
  //  );
          });
           
        }
      ),
    );

    setState(() {
      latitude = latLng.latitude;
      longitude = latLng.longitude;
      // print('------------------- $latitude');
      // print('------------------- $longitude');
      _marker.clear();
      Find_by_piont(latitude, longitude);
      // add the new marker to the list of markers
      _marker.add(newMarker);
    }
    );
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
      body: Stack(
        children: [
          (latitude != 0)
              ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude), zoom: 20),
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
            margin: EdgeInsets.only(left: 20, right: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromARGB(231, 168, 168, 168),
            ),
            child: TextFormField(
              onFieldSubmitted: (value) {
                print('Lat and log for search =$value');
                setState(() {
                  Find_Lat_log(value);
                });
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search_outlined),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 168, 168, 168), width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromARGB(248, 168, 168, 168),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'latlog',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 168, 168, 168), width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
                hintStyle: TextStyle(
                  color: Colors.grey[850],
                  fontSize: MediaQuery.of(context).textScaleFactor * 0.04,
                ),
              ),
            ),
          ),
          // Container(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           _getCurrentPosition();
          //         });
          //       },
          //       icon: Icon(
          //         Icons.location_history,
          //         size: 50,
          //       )),
          // )
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
      widget.lat(lati.toString());
      widget.log(longi.toString());
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
              widget.commune(jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              district = (jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
              widget.district(jsonResponse['results'][j]['address_components']
                  [i]['short_name']);
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
      print("aaaaaa   ${check_charetor[0]}");
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=${check_charetor[0]}&region=kh&key=AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY';
      final response = await http.get(Uri.parse(url));
      final jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      widget.lat(lati.toString());
      widget.log(longi.toString());
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
        latitude = lati;
        longitude = longi;
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
              widget.commune(jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
              print('Value ');
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              widget.district(jsonResponse['results'][j]['address_components']
                  [i]['short_name']);
            });
          }
        }
      }
    } else {
      // print("It\'s not Place ");
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${check_charetor[0]}${check_charetor[1]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      widget.lat(lati.toString());
      widget.log(longi.toString());
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
        latitude = lati;
        longitude = longi;
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
              widget.commune(jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
              print('Value ');
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              widget.district(jsonResponse['results'][j]['address_components']
                  [i]['short_name']);
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