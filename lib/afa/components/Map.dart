// // ignore: import_of_legacy_library_into_null_safe
// // ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application/components/TestNew.dart';
// import 'package:flutter_application/screens/AutoVerbal/Add.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:location_geocoder/location_geocoder.dart';
// import 'package:search_map_location/utils/google_search/place.dart';
// import 'package:search_map_location/widget/search_widget.dart';
// import '../models/search_model.dart';
// import 'contants.dart';

// class HomeMap extends StatefulWidget {
//   @override
//   _HomeMapState createState() => _HomeMapState();
// }

// class _HomeMapState extends State<HomeMap> {
//   String googleApikey = "AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI";
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
//   double latitude = 11.5489; //latitude
//   double longitude = 104.9214;
//   LatLng latLng = const LatLng(11.5489, 104.9214);
//   String address = "";
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   List list = [];
//   late SearchRequestModel requestModel;
//   // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
//   late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);

//   @override
//   void initState() {
//     getAddress(latLng); //call convert to address
//     super.initState();
//     requestModel = new SearchRequestModel(
//       property_type_id: "12",
//       num: "5",
//       lat: "11.3699",
//       lng: "104.7283",
//       land_min: "0",
//       land_max: "10000000",
//       distance: "500",
//       fromDate: "2015-01-01",
//       toDate: "2020-01-01",
//     );
//     super.initState();
//     // Load();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController search = TextEditingController();
//     return MapShow();
//   }

//   Scaffold MapShow() {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Center(child: Text("GoogleMap")),
//       //   actions: <Widget>[
//       //     IconButton(
//       //       icon: const Icon(Icons.find_replace_outlined),
//       //       color: kwhite,
//       //       style: IconButton.styleFrom(backgroundColor: kImageColor),
//       //       onPressed: () => Show(requestModel),
//       //     ),
//       //   ],
//       // ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GoogleMap(
//               //   markers: getmarkers(),
//               markers: Set<Marker>.of(markers.values),
//               //Map widget from google_maps_flutter package
//               zoomGesturesEnabled: true, //enable Zoom in, out on map
//               initialCameraPosition: CameraPosition(
//                 //innital position in map
//                 target: LatLng(latitude, longitude), //initial position
//                 zoom: 10.0, //initial zoom level
//               ),
//               mapType: MapType.normal, //map type
//               onMapCreated: (controller) {
//                 //method called when map is created
//                 setState(() {
//                   mapController = controller;
//                 });
//               },
//               onTap: (argument) {
//                 MarkerId markerId = MarkerId('mark');
//                 listMarkerIds.add(markerId);
//                 Marker marker = Marker(
//                   markerId: MarkerId('mark'),
//                   position: argument,
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                       BitmapDescriptor.hueRed),
//                 );
//                 setState(() {
//                   markers[markerId] = marker;
//                   getAddress(argument);
//                 });
//               },
//               onCameraMove: (CameraPosition cameraPositiona) {
//                 cameraPosition = cameraPositiona; //when map is dragging
//               },
//               onCameraIdle: () {
//                 //when map drag stops
//                 // getAddress(cameraPosition!.target.latitude,
//                 //     cameraPosition!.target.longitude);
//                 setState(() {
//                   //get place name from lat and lang
//                 });
//               },
//             ),
//             // Align(
//             //     alignment: Alignment.topRight,
//             //     child: FractionallySizedBox(
//             //       widthFactor: 1,
//             //       child: SizedBox(height: 130, child: TestAuto()),
//             //     )),
//             Align(
//               alignment: Alignment.topCenter,
//               child: SearchLocation(
//                 apiKey:
//                     'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
//                 country: 'KH',
//                 onSelected: (Place place) {
//                   address = place.description;
//                   print(place.description);
//                   getLatLang(address);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void Load() async {
//     var rs = await http.get(Uri.parse(
//         'https://kfahrm.cc/Laravel/public/api/comparable/list?page=100'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         list = jsonData['data'];
//       });

//       // print(list.length);
//     }
//   }

//   // Future<void> Show(SearchRequestModel requestModel) async {
//   //   // var rs = await http
//   //   //     .get(Uri.parse('https://kfahrm.cc/laravel/public/api/comparable/list?page=100'));
//   //   setState(() {
//   //     //    isApiCallProcess = true;
//   //   });
//   //   final rs = await http.post(
//   //       Uri.parse('https://kfahrm.cc/laravel/public/api/comparable/map_action'),
//   //       headers: {
//   //         "Accept": "application/json",
//   //         "Content-Type": "application/x-www-form-urlencoded"
//   //       },
//   //       body: requestModel.toJson());
//   //   if (rs.statusCode == 200) {
//   //     var jsonData = jsonDecode(rs.body);
//   //     setState(() {
//   //       //    isApiCallProcess = false;
//   //       list = jsonData['data'];
//   //       print(list);
//   //       //  print(requestModel.comparable_road);
//   //       print(requestModel.distance);
//   //       print(requestModel.fromDate);
//   //       print(requestModel.land_max);
//   //       print(requestModel.land_min);
//   //       print(requestModel.lat);
//   //       print(requestModel.lng);
//   //       print(requestModel.num);
//   //       print(requestModel.property_type_id);
//   //       print(requestModel.toDate);
//   //     });
//   //   }

//   //   print(list.length);
//   //   Map map = list.asMap();
//   //   // List list = [
//   //   //   {"title": "one", "id": "1", "lat": 11.489, "lon": 105.9214},
//   //   //   {"title": "two", "id": "2", "lat": 11.5, "lon": 104.9314},
//   //   //   {"title": "three", "id": "3", "lat": 11.6, "lon": 104.9414},
//   //   // ];
//   //   print(map);
//   //   if (requestModel.lat.isEmpty || requestModel.lng.isEmpty) {
//   //     // isApiCallProcess = true;
//   //     AwesomeDialog(
//   //       context: context,
//   //       dialogType: DialogType.error,
//   //       animType: AnimType.rightSlide,
//   //       headerAnimationLoop: false,
//   //       title: 'Please tap on map to select location',
//   //       btnOkOnPress: () {},
//   //       btnOkIcon: Icons.cancel,
//   //       btnOkColor: Colors.red,
//   //     ).show();
//   //   } else if (requestModel.fromDate.isEmpty || requestModel.toDate.isEmpty) {
//   //     //  isApiCallProcess = true;
//   //     AwesomeDialog(
//   //       context: context,
//   //       dialogType: DialogType.error,
//   //       animType: AnimType.rightSlide,
//   //       headerAnimationLoop: false,
//   //       title: 'Please select date!',
//   //       btnOkOnPress: () {},
//   //       btnOkIcon: Icons.cancel,
//   //       btnOkColor: Colors.red,
//   //     ).show();
//   //   } else {
//   //     //  isApiCallProcess = true;
//   //     if (map.isEmpty) {
//   //       //   isApiCallProcess = true;
//   //       AwesomeDialog(
//   //         context: context,
//   //         dialogType: DialogType.error,
//   //         animType: AnimType.rightSlide,
//   //         headerAnimationLoop: false,
//   //         title: 'No data found!',
//   //         desc: "You can try to change the information. ",
//   //         btnOkOnPress: () {},
//   //         btnOkIcon: Icons.cancel,
//   //         btnOkColor: Colors.red,
//   //       ).show();
//   //     } else {
//   //       //  isApiCallProcess = true;
//   //       for (var i = 0; i < map.length; i++)
//   //       // ignore: curly_braces_in_flow_control_structures
//   //       {
//   //         MarkerId markerId = MarkerId('$i');
//   //         listMarkerIds.add(markerId);
//   //         Marker marker = Marker(
//   //           markerId: MarkerId('$i'),
//   //           position: LatLng(
//   //             map[i]['latlong_log'],
//   //             map[i]['latlong_la'],
//   //           ),
//   //           icon:
//   //               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//   //         );
//   //         setState(() {
//   //           markers[markerId] = marker;
//   //         });
//   //       }
//   //     }
//   //   }
//   // }

//   Future<void> Show(SearchRequestModel requestModel) async {
//     var rs = await http.post(
//         Uri.parse('https://kfahrm.cc/Laravel/public/api/comparable/map_action'),
//         headers: {
//           "Accept": "application/json",
//           // "Content-Type": "application/x-www-form-urlencoded"
//         },
//         body: requestModel.toJson());
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         list = jsonData['data'];
//       });
//     }
//     print(requestModel.toJson());
//     print(list.length);
//     Map map = list.asMap();
//     // List list = [
//     //   {"title": "one", "id": "1", "lat": 11.489, "lon": 105.9214},
//     //   {"title": "two", "id": "2", "lat": 11.5, "lon": 104.9314},
//     //   {"title": "three", "id": "3", "lat": 11.6, "lon": 104.9414},
//     // ];
//     print(map);
//     for (var i = 0; i < map.length; i++)
//     // ignore: curly_braces_in_flow_control_structures
//     {
//       MarkerId markerId = MarkerId('$i');
//       listMarkerIds.add(markerId);
//       Marker marker = Marker(
//         markerId: MarkerId('$i'),
//         position: LatLng(
//           map[i]['latlong_log'],
//           map[i]['latlong_la'],
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       );
//       setState(() {
//         markers[markerId] = marker;
//       });
//     }
//   }

//   ///converts `coordinates` to actual `address` using google map api
//   Future<void> getAddress(LatLng latLng) async {
//     final coordinates = Coordinates(latLng.latitude, latLng.longitude);
//     try {
//       final address = await geocoder.findAddressesFromCoordinates(coordinates);
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
// }
