// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

/*
Name: Akshath Jain
Date: 3/18/2019 - 4/26/2021
Purpose: Example app that implements the package: sliding_up_panel
Copyright: © 2021, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/screen/Customs/Contants.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:itckfa/models/search_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'numDisplay.dart';

typedef OnChangeCallback = void Function(dynamic value);

class map_cross_verbal extends StatefulWidget {
  const map_cross_verbal(
      {super.key,
      required this.get_province,
      required this.get_district,
      required this.get_commune,
      required this.get_log,
      required this.get_lat,
      required this.asking_price});
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final OnChangeCallback asking_price;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<map_cross_verbal> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 55.0;
  String googleApikey = "AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  final Set<Marker> listMarkerIds = new Set();
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List list = [];
  double adding_price = 0;
  String sendAddrress = '';
  List data = [];
  var formatter = NumberFormat("##,###,###,###", "en_US");
  var date = DateFormat('yyyy-MM-dd').format(DateTime(2020, 01, 01));
  var date1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isApiCallProcess = false;
  // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
  late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);
  late SearchRequestModel requestModel;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
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

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latLng = LatLng(position.latitude, position.longitude);

      Marker marker = Marker(
        markerId: MarkerId('mark'),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      setState(() {
        listMarkerIds.add(marker);
        requestModel.lat = latLng.latitude.toString();
        requestModel.lng = latLng.longitude.toString();
      });
    });
    await Show(requestModel);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.0,
      ),
    ));
  }

  @override
  void initState() {
    _handleLocationPermission();
    Future.delayed(const Duration(seconds: 3), () async {
      await _getCurrentLocation();
    });
    // getAddress(latLng);
    // ignore: unnecessary_new
    requestModel = new SearchRequestModel(
      property_type_id: "",
      num: "5",
      lat: "",
      lng: "",
      land_min: "0",
      land_max: "",
      distance: "",
      fromDate: "",
      toDate: "",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  Widget _uiSteup(BuildContext context) {
    // TextEditingController search = TextEditingController();
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.30;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cross property check"),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            setState(() {
              if (data_adding_correct.length == int.parse(requestModel.num)) {
                widget.asking_price(adding_price);
              }
            });
            Navigator.pop(context);
          },
          icon: Icon(Icons.save_alt_outlined),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Dialog(context);
              },
              icon: Icon(Icons.line_style_rounded, color: Colors.white))
        ],
      ),
      body: Material(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: SearchLocation(
                  apiKey:
                      'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
                  country: 'KH',
                  onSelected: (Place place) {
                    address = place.description;
                    getLatLang(address);
                  },
                ),
              ),
            ),
            SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              parallaxEnabled: true,
              body: MapShow(),
              parallaxOffset: .5,
              panelBuilder: (ScrollController sc) => _panel(sc),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
              onPanelSlide: (double pos) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 18.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "More Option",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          // RoadDropdown(
          //   onChanged: (value) {
          //     // requestModel.comparable_road = value;
          //     //  print(requestModel.comparable_road);
          //   },
          // ),
          SizedBox(height: 10.0),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20),
          //   child: ToFromDate(
          //     fromDate: (value) {
          //       requestModel.fromDate = value;
          //       print(requestModel.fromDate);
          //     },
          //     toDate: (value) {
          //       requestModel.toDate = value;
          //       // print(requestModel.toDate);
          //     },
          //   ),
          // ),
          SizedBox(height: 10.0),
          // LandSize(
          //   land_min: (value) {
          //     setState(() {
          //       requestModel.land_min = value;
          //       print(requestModel.fromDate);
          //     });
          //   },
          //   land_max: (value) {
          //     setState(() {
          //       requestModel.land_max = value;
          //       print(requestModel.toDate);
          //     });
          //   },
          // ),
          SizedBox(height: 10.0),
          NumDisplay(
              onSaved: (newValue) => setState(() {
                    requestModel.num = newValue!;
                  })),
          SizedBox(height: 10.0),
          // Distance(
          //     onSaved: (input) => setState(() {
          //           requestModel.distance = input!;
          //         })),
          addPaddingWhenKeyboardAppears(),
        ],
      ),
    );
  }

  SizedBox addPaddingWhenKeyboardAppears() {
    final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets,
      WidgetsBinding.instance.window.devicePixelRatio,
    );

    final bottomOffset = viewInsets.bottom;
    const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
    final isNeedPadding = bottomOffset != hiddenKeyboard;

    return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
  }

  Stack MapShow() {
    return Stack(
      children: [
        GoogleMap(
          //   markers: getmarkers(),
          markers: listMarkerIds.map((e) => e).toSet(),
          //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          initialCameraPosition: CameraPosition(
            //innital position in map
            target: latLng, //initial position
            zoom: 12.0, //initial zoom level
          ),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.hybrid, //map type
          onMapCreated: (controller) {
            //method called when map is created
            setState(() {
              mapController = controller;
            });
          },
          onTap: (argument) {
            MarkerId markerId = MarkerId('mark');

            Marker marker = Marker(
              markerId: MarkerId('mark'),
              position: argument,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            );
            setState(() {
              adding_price = 0;
              listMarkerIds.clear();
              data_adding_correct.clear();

              listMarkerIds.add(marker);
              requestModel.lat = argument.latitude.toString();
              requestModel.lng = argument.longitude.toString();
              getAddress(argument);
              Show(requestModel);
            });
          },
          onCameraMove: (CameraPosition cameraPositiona) {
            cameraPosition = cameraPositiona; //when map is dragging
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 2),
            width: MediaQuery.of(context).size.width * 0.8,
            child: SearchLocation(
              apiKey:
                  'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
              country: 'KH',
              onSelected: (Place place) {
                address = place.description;
                print(place.description);
                getLatLang(address);
              },
            ),
          ),
        ),
      ],
    );
  }

  void Clear() {
    setState(() {
      for (var i = 0; i < list.length; i++) {
        MarkerId markerId = MarkerId('$i');
        listMarkerIds.remove(markerId);
      }
    });
  }

  List data_adding_correct = [];
  Future<void> Show(SearchRequestModel requestModel) async {
    // var rs = await http
    //     .get(Uri.parse('https://kfahrm.cc/laravel/public/api/comparable/list?page=100'));
    setState(() {
      isApiCallProcess = true;
    });
    final rs = await http.post(
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/map_action'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: requestModel.toJson());
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list = jsonData['autoverbal'];
      });
      await Find_by_piont(
          double.parse(requestModel.lat), double.parse(requestModel.lng));
    }

    print(list.length);

    Map map = list.asMap();
    // List list = [
    //   {"title": "one", "id": "1", "lat": 11.489, "lon": 105.9214},
    //   {"title": "two", "id": "2", "lat": 11.5, "lon": 104.9314},
    //   {"title": "three", "id": "3", "lat": 11.6, "lon": 104.9414},
    // ];
    print(map);
    if (requestModel.lat.isEmpty || requestModel.lng.isEmpty) {
      setState(() {
        isApiCallProcess = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Please tap on map to select location',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else {
      setState(() {
        isApiCallProcess = false;
      });
      if (map.isEmpty) {
        markers.clear();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'No data found!',
          desc: "You can try to change the information. ",
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
      } else {
        int index = 0;
        for (var i = 0; i < map.length; i++) {
          if (i == 0) {
            if (map[i]['comparable_adding_price'] == '') {
              map[i]['comparable_adding_price'] = '0';
              adding_price +=
                  double.parse(map[i]['comparable_adding_price']) / map.length;
              print(map[i]['comparable_adding_price']);
            } else if (map[i]['comparable_adding_price'].contains(',')) {
              print(map[i]['comparable_adding_price'].replaceAll(",", ""));
              adding_price += double.parse(
                      map[i]['comparable_adding_price'].replaceAll(",", "")) /
                  map.length;
              print(map[i]['comparable_adding_price']);
              //print(map[i]['comparable_adding_price'].split(",")[0]);
            } else {
              adding_price +=
                  (double.parse(map[i]['comparable_adding_price'])) /
                      map.length;
            }
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(map[i]['latlong_log'].toString()),
                double.parse(map[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueCyan),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${map[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Land-Width'),
                                Text('Land-Length'),
                                Text('Land-Total'),
                                // Text('Date'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '  :   ' +
                                      map[i]['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' + map[i]['comparable_land_width']),
                                Text('  :   ' +
                                    map[i]['comparable_land_length']),
                                Text('  :   ' +
                                    formatter.format(double.parse(map[i]
                                            ['comparable_land_total']
                                        .toString()))),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);

              // widget.asking_price(adding_price);
            });
          } else if (i > 0) {
            if ((data_adding_correct.length == int.parse(requestModel.num)) ||
                (i == map.length - 1)) {
              break;
            } else {
              if ((map[i]['latlong_log'] != map[i - 1]['latlong_log']) &&
                  (map[i]['comparable_adding_price'] !=
                      map[i - 1]['comparable_adding_price'])) {
                if (map[i]['comparable_adding_price'] == '') {
                  map[i]['comparable_adding_price'] = '0';
                  adding_price +=
                      double.parse(map[i]['comparable_adding_price']) /
                          int.parse(requestModel.num);
                } else if (map[i]['comparable_adding_price'].contains(',')) {
                  // print(map[i]['comparable_adding_price'].replaceAll(",", ""));
                  adding_price += double.parse(map[i]['comparable_adding_price']
                          .replaceAll(",", "")) /
                      int.parse(requestModel.num);
                } else {
                  adding_price +=
                      (double.parse(map[i]['comparable_adding_price'])) /
                          int.parse(requestModel.num);
                }
                setState(() {
                  data_adding_correct.add(map[i]);
                });
              }
            }
          }
        }

        for (int i = 0; i < data_adding_correct.length; i++) {
          if (data_adding_correct[i]['comparable_property_id'] == 15) {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueCyan),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['agenttype_name'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_width'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_length'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        formatter.format(double.parse(
                                            data_adding_correct[i]
                                                    ['comparable_land_total']
                                                .replaceAll(",", "")
                                                .toString())),
                                    style: TextStyle(fontSize: 12)),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);
            });
          } else if (data_adding_correct[i]['comparable_property_id'] == 10) {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['agenttype_name'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_width'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_length'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        formatter.format(double.parse(
                                            data_adding_correct[i]
                                                    ['comparable_land_total']
                                                .replaceAll(",", "")
                                                .toString())),
                                    style: TextStyle(fontSize: 12)),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);
            });
          } else if (data_adding_correct[i]['comparable_property_id'] == 33) {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueMagenta),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['agenttype_name'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_width'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_length'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        formatter.format(double.parse(
                                            data_adding_correct[i]
                                                    ['comparable_land_total']
                                                .replaceAll(",", "")
                                                .toString())),
                                    style: TextStyle(fontSize: 12)),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);
            });
          } else if (data_adding_correct[i]['comparable_property_id'] == 14) {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRose),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['agenttype_name'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_width'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_length'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        formatter.format(double.parse(
                                            data_adding_correct[i]
                                                    ['comparable_land_total']
                                                .replaceAll(",", "")
                                                .toString())),
                                    style: TextStyle(fontSize: 12)),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);
            });
          } else if (data_adding_correct[i]['comparable_property_id'] == 4) {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['agenttype_name'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_width'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_length'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        formatter.format(double.parse(
                                            data_adding_correct[i]
                                                    ['comparable_land_total']
                                                .replaceAll(",", "")
                                                .toString())),
                                    style: TextStyle(fontSize: 12)),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);
            });
          } else if (data_adding_correct[i]['comparable_property_id'] == 29) {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['agenttype_name'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_width'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_length'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        formatter.format(double.parse(
                                            data_adding_correct[i]
                                                    ['comparable_land_total']
                                                .replaceAll(",", "")
                                                .toString())),
                                    style: TextStyle(fontSize: 12)),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);
            });
          } else {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property{${i + 1}} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: 12)),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['agenttype_name'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_width'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]
                                            ['comparable_land_length'],
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                    '  :   ' +
                                        formatter.format(double.parse(
                                            data_adding_correct[i]
                                                    ['comparable_land_total']
                                                .replaceAll(",", "")
                                                .toString())),
                                    style: TextStyle(fontSize: 12)),
                                // Text('  :   ' + map[i]['comparable_survey_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
            setState(() {
              isApiCallProcess = false;
              listMarkerIds.add(marker);
            });
          }
        }
        Dialog(context);
        // print("\n\n\n\n\nkoko ${listMarkerIds.length}  \n\n\n\n\n");
      }
    }
  }

  Future Dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        content: Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < data_adding_correct.length; i++)
                  Card(
                    elevation: 10,
                    child: ListTile(
                      title: Text(
                          "comparable id : " +
                              data_adding_correct[i]['comparable_id']
                                  .toString(),
                          style: TextStyle(fontSize: 12)),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "property : " +
                                  data_adding_correct[i]['property_type_name']
                                      .toString(),
                              style: TextStyle(fontSize: 10)),
                          Text(
                              "Owner : " +
                                  data_adding_correct[i]['agenttype_name']
                                      .toString(),
                              style: TextStyle(fontSize: 10)),
                          Text(
                              "adding price : " +
                                  formatter.format(double.parse(
                                      data_adding_correct[i]
                                              ['comparable_adding_price']
                                          .replaceAll(",", "")
                                          .toString())) +
                                  "\$",
                              style: TextStyle(fontSize: 10)),
                          Text(
                              "Date : " +
                                  data_adding_correct[i]
                                          ['comparable_survey_date']
                                      .toString(),
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                Text(
                    "Avg price of property : " +
                        formatter.format(adding_price).toString() +
                        "\$",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 5,
                      fontSize: 12,
                      decorationStyle: TextDecorationStyle.dashed,
                      decoration: TextDecoration.underline,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///converts `coordinates` to actual `address` using google map api
  Future<void> getAddress(LatLng latLng) async {
    final coordinates = Coordinates(latLng.latitude, latLng.longitude);
    try {
      final address = await geocoder.findAddressesFromCoordinates(coordinates);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  ///converts `address` to actual `coordinates` using google map api
  Future<void> getLatLang(String adds) async {
    try {
      final address = await geocoder.findAddressesFromQuery(adds);
      var message = address.first.coordinates.toString();
      latitude = address.first.coordinates.latitude!;
      longitude = address.first.coordinates.longitude!;
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 10)));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      widget.get_lat(lati.toString());
      widget.get_log(longi.toString());
      List ls = jsonResponse['results'];
      List ac;
      bool check_sk = false, check_kn = false;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (check_kn == false || check_sk == false) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "political") {
              setState(() {
                check_kn = true;
                widget.get_district(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;

                widget.get_commune(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
          }
        }
      }
    } else {
      print(response.statusCode);
    }
  }
}
