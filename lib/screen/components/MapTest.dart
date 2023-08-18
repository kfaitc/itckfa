// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:location_geocoder/location_geocoder.dart';
// import 'package:search_map_location/utils/google_search/place.dart';
// import 'package:search_map_location/widget/search_widget.dart';
// import 'contants.dart';

// class HomeMap extends StatefulWidget {
//   @override
//   _HomeMapState createState() => _HomeMapState();
// }

// class _HomeMapState extends State<HomeMap> {
//   String googleApikey = "AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI";
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   double latitude = 11.5489; //latitude
//   double longitude = 104.9214;
//   String location = "Location Name:";
//   String address = "";
//   final Set<Marker> markers = new Set();
//   List list = [];
//   // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
//   late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);

//   ///converts `coordinates` to actual `address` using google map api
//   Future<void> getAddress(double lat, double lng) async {
//     try {
//       final address =
//           await geocoder.findAddressesFromCoordinates(Coordinates(lat, lng));
//       var message = address.first.addressLine;
//       if (message == null) return;
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

//   ///converts `address` to actual `coordinates` using google map api
//   Future<void> getLatLang(String adds) async {
//     try {
//       final address = await geocoder.findAddressesFromQuery(adds);
//       var message = address.first.coordinates.toString();
//       latitude = address.first.coordinates.latitude!;
//       longitude = address.first.coordinates.longitude!;
//       mapController?.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(latitude, longitude), zoom: 10)));
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

//   @override
//   void initState() {
//     getAddress(latitude, longitude); //call convert to address
//     super.initState();
//     // Load();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController search = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text("GoogleMap")), actions: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.save_alt_outlined),
//           color: kwhite,
//           style: IconButton.styleFrom(backgroundColor: kImageColor),
//           onPressed: () {},
//         ),
//       ]),
//       body: Stack(
//         children: [
//           GoogleMap(
//             //   markers: getmarkers(),
//             //Map widget from google_maps_flutter package
//             zoomGesturesEnabled: true, //enable Zoom in, out on map
//             initialCameraPosition: CameraPosition(
//               //innital position in map
//               target: LatLng(latitude, longitude), //initial position
//               zoom: 10.0, //initial zoom level
//             ),
//             mapType: MapType.normal, //map type
//             onMapCreated: (controller) {
//               //method called when map is created
//               setState(() {
//                 mapController = controller;
//               });
//             },
//             onCameraMove: (CameraPosition cameraPositiona) {
//               cameraPosition = cameraPositiona; //when map is dragging
//             },
//             onCameraIdle: () {
//               //when map drag stops
//               getAddress(cameraPosition!.target.latitude,
//                   cameraPosition!.target.longitude);
//               setState(() {
//                 //get place name from lat and lang
//               });
//             },
//           ),
//           Center(
//             //picker image on google map
//             child: Image.asset(
//               "assets/images/marker.png",
//               width: 60,
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: SearchLocation(
//               apiKey:
//                   'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
//               country: 'KH',
//               onSelected: (Place place) {
//                 address = place.description;
//                 print(place.description);
//                 getLatLang(address);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Set<Marker> getmarkers() {
//     //markers to place on map
//     setState(() {
//       List list = [
//         {"title": "one", "id": "1", "lat": 11.489, "lon": 105.9214},
//         {"title": "two", "id": "2", "lat": 11.5, "lon": 104.9314},
//         {"title": "three", "id": "3", "lat": 11.6, "lon": 104.9414},
//       ];
//       Map map = list.asMap();
//       print(map);
//       for (var i = 0; i < map.length; i++)
//         // ignore: curly_braces_in_flow_control_structures
//         [
//           markers.add(Marker(
//             //add first marker
//             markerId: MarkerId(const LatLng(11.5489, 104.9214).toString()),
//             position: LatLng(
//               map[i]['lat'],
//               map[i]['lon'],
//             ), //position of marker
//             infoWindow: InfoWindow(
//               //popup info
//               title: map[i]['tittle'],
//               snippet: 'My Custom Subtitle',
//             ),
//             icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//           )),
//         ];
//       //add more markers here
//     });

//     return markers;
//   }

//   // void Load() async {
//   //   var rs = await http
//   //       .get(Uri.parse('https://kfahrm.cc/laravel/public/api/comparable/list?page=100'));
//   //   if (rs.statusCode == 200) {
//   //     var jsonData = jsonDecode(rs.body);
//   //     setState(() {
//   //       list = jsonData['data'];
//   //     });

//   //     // print(list.length);
//   //   }
//   // }

//   // Set<Marker> getmarkers() {
//   //   setState(() {
//   //     Map map = list.asMap();
//   //     // print(list);
//   //     print(map);
//   //     print(map.length);
//   //     print(map[0]['latlong_la']);

//   //     for (var i = 0; i < map.length; i++)
//   //       // ignore: curly_braces_in_flow_control_structures
//   //       [
//   //         markers.add(Marker(
//   //           //add first marker
//   //           markerId: MarkerId(const LatLng(11.5489, 104.9214).toString()),
//   //           position: LatLng(
//   //             map[i]['latlong_log'],
//   //             map[i]['latlong_la'],
//   //           ), //position of marker
//   //           // infoWindow: InfoWindow(
//   //           //   //popup info
//   //           //   title: map[i]['title'],
//   //           //   snippet: 'My Custom Subtitle',
//   //           // ),
//   //           icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//   //         )),
//   //       ];
//   //   });

//   //   return markers;
//   // }
// }
