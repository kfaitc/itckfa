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
import 'package:getwidget/getwidget.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/models/search_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:itckfa/afa/components/property.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'contants.dart';
import 'numDisplay.dart';

typedef OnChangeCallback = void Function(dynamic value);

class map_cross_verbal extends StatefulWidget {
  const map_cross_verbal({
    super.key,
    required this.get_province,
    required this.get_district,
    required this.get_commune,
    required this.get_log,
    required this.get_lat,
    required this.asking_price,
  });
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
  final Set<Marker> listMarkerIds = {};
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List list = [];
  double adding_price = 0;
  String sendAddrress = '';
  List data = [];
  // ignore: prefer_typing_uninitialized_variables
  var pty;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  var date = DateFormat('yyyy-MM-dd').format(DateTime(2020, 01, 01));
  var date1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isApiCallProcess = false;
  // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
  late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);
  late SearchRequestModel requestModel;

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location services are disabled. Please enable the services',
          ),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

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
    // mapController!.animateCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //     target: LatLng(position.latitude, position.longitude),
    //     zoom: 16.0,
    //   ),
    // ));
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
    _panelHeightOpen = (groupValue == 0)
        ? MediaQuery.of(context).size.height * 0.35
        : MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cross property check"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.indigo[900],
        leading: IconButton(
          onPressed: () {
            setState(() {
              if ((data_adding_correct.length == int.parse(requestModel.num)) &&
                  (groupValue == 0)) {
                widget.asking_price(adding_price ?? 0);
                widget.get_lat(requestModel.lat);
                widget.get_log(requestModel.lng);
              } else {
                widget.asking_price(0);
              }
            });
            Navigator.pop(context);
          },
          icon: Icon(Icons.save_alt_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (groupValue == 0) {
                Dialog(context);
              } else {
                for_market_price();
              }
            },
            icon: Icon(Icons.line_style_rounded, color: Colors.white),
          )
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
                topRight: Radius.circular(18.0),
              ),
              onPanelSlide: (double pos) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  int groupValue = 0;
  bool isChecked = false;
  bool isChecked_all = false;
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
          Row(
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GFRadio(
                      type: GFRadioType.square,
                      size: 25,
                      value: 0,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                      inactiveIcon: null,
                      activeBorderColor: const Color.fromARGB(255, 39, 39, 39),
                      radioColor: GFColors.PRIMARY,
                    ),
                    Text(
                      "By Compereble",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GFRadio(
                      type: GFRadioType.square,
                      size: 25,
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                      inactiveIcon: null,
                      activeBorderColor: const Color.fromARGB(255, 39, 39, 39),
                      radioColor: GFColors.PRIMARY,
                    ),
                    Text(
                      "By Market price",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
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
          if (groupValue == 0)
            NumDisplay(
              onSaved: (newValue) => setState(() {
                requestModel.num = newValue!;
              }),
            ),
          SizedBox(height: 10.0),
          if (groupValue == 0)
            Row(
              children: [
                SizedBox(
                  width: (isChecked == true)
                      ? MediaQuery.of(context).size.width * 0.65
                      : MediaQuery.of(context).size.width * 1,
                  child: PropertyDropdown(
                    name: (value) {
                      // propertyType = value;
                    },
                    check_onclick: (value) {
                      setState(() {
                        isChecked = value;
                        isChecked_all = false;
                      });
                    },
                    id: (value) {
                      pty = value;
                    },
                    // pro: list[0]['property_type_name'],
                  ),
                ),
                Container(
                  width: (isChecked == true)
                      ? MediaQuery.of(context).size.width * 0.35
                      : 0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      GFCheckbox(
                        size: 25,
                        activeBgColor: GFColors.PRIMARY,
                        onChanged: (value) {
                          setState(() {
                            isChecked_all = value;
                            isChecked = false;
                            pty = null;
                          });
                        },
                        value: isChecked_all,
                        inactiveIcon: null,
                      ),
                      Text(
                        "Show All",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
                BitmapDescriptor.hueRed,
              ),
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
                // print(place.description);
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
  double? min, max;
  Map? map;
  Future<void> Show(SearchRequestModel requestModel) async {
    // var rs = await http
    //     .get(Uri.parse('https://kfahrm.cc/laravel/public/api/comparable/list?page=100'));

    if (groupValue == 0) {
      setState(() {
        isApiCallProcess = true;
      });
      final Map<String, dynamic> Jsondata;
      if (pty != null) {
        Jsondata = {
          "property_type_id": pty,
          "num": requestModel.num,
          "lat": requestModel.lat,
          "lng": requestModel.lng,
        };
      } else {
        Jsondata = {
          "num": requestModel.num,
          "lat": requestModel.lat,
          "lng": requestModel.lng,
        };
      }
      final rs = await http.post(
        Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/map_action',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(Jsondata),
      );
      if (rs.statusCode == 200) {
        var jsonData = jsonDecode(rs.body);
        setState(() {
          list = jsonData['autoverbal'];
          map = list.asMap();
        });
      }
      await Find_by_piont(
        double.parse(requestModel.lat),
        double.parse(requestModel.lng),
      );
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
        if (map!.isEmpty) {
          markers.clear();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            headerAnimationLoop: false,
            title: 'No data found!',
            desc: "You can try to change Property.",
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.blue,
          ).show();
        } else {
          setState(() {
            int index = 0;
            for (var i = 1; i < map!.length; i++) {
              if (double.parse(map![i]['comparable_adding_price']) <=
                  (R_avg + (R_avg * 0.50))) {
                print(
                    "\ncomparable_adding_price $i:${map![i]['comparable_adding_price']} ${R_avg + (R_avg * 0.50)}");

                if ((data_adding_correct.length ==
                        int.parse(requestModel.num)) ||
                    (i == map!.length - 1)) {
                  break;
                } else {
                  if ((map![i]['latlong_log'] != map![i - 1]['latlong_log']) &&
                      (map![i]['comparable_adding_price'] !=
                          map![i - 1]['comparable_adding_price'])) {
                    if (map![i]['comparable_adding_price'] == '') {
                      map![i]['comparable_adding_price'] = '0';
                      adding_price +=
                          double.parse(map![i]['comparable_adding_price']);
                    } else if (map![i]['comparable_adding_price']
                        .contains(',')) {
                      // print(map[i]['comparable_adding_price'].replaceAll(",", ""));
                      adding_price += double.parse(map![i]
                              ['comparable_adding_price']
                          .replaceAll(",", ""));
                    } else {
                      adding_price +=
                          (double.parse(map![i]['comparable_adding_price']));
                    }
                    setState(() {
                      data_adding_correct.add(map![i]);
                    });
                  }
                }
                // }
              }
            }
          });
        }
      }
      if (data_adding_correct.length == 5) {
        for (int i = 0; i < data_adding_correct.length; i++) {
          if (data_adding_correct[i]['comparable_property_id'] == 15) {
            MarkerId markerId = MarkerId(i.toString());
            Marker marker = Marker(
              markerId: markerId,
              position: LatLng(
                double.parse(data_adding_correct[i]['latlong_log'].toString()),
                double.parse(data_adding_correct[i]['latlong_la'].toString()),
              ),
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(50, 50)),
                'assets/icons/l.png',
              ),
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
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  'ID\'s property',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text(
                                  'Land-Width',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Length',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Total',
                                  style: TextStyle(fontSize: 12),
                                ),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]['agenttype_name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_width'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_length'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      formatter.format(
                                        double.parse(
                                          data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .replaceAll(",", "")
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(fontSize: 12),
                                ),
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
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(50, 50)),
                'assets/icons/f.png',
              ),
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
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  'ID\'s property',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text(
                                  'Land-Width',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Length',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Total',
                                  style: TextStyle(fontSize: 12),
                                ),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]['agenttype_name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_width'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_length'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      formatter.format(
                                        double.parse(
                                          data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .replaceAll(",", "")
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(fontSize: 12),
                                ),
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
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(50, 50)),
                'assets/icons/v.png',
              ),
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
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  'ID\'s property',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text(
                                  'Land-Width',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Length',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Total',
                                  style: TextStyle(fontSize: 12),
                                ),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]['agenttype_name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_width'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_length'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      formatter.format(
                                        double.parse(
                                          data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .replaceAll(",", "")
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(fontSize: 12),
                                ),
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
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(50, 50)),
                'assets/icons/h.png',
              ),
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
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  'ID\'s property',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text(
                                  'Land-Width',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Length',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Total',
                                  style: TextStyle(fontSize: 12),
                                ),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]['agenttype_name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_width'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_length'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      formatter.format(
                                        double.parse(
                                          data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .replaceAll(",", "")
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(fontSize: 12),
                                ),
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
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(50, 50)),
                'assets/icons/b.png',
              ),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property : ${i + 1} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  'ID\'s property',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text(
                                  'Land-Width',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Length',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Total',
                                  style: TextStyle(fontSize: 12),
                                ),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]['agenttype_name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_width'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_length'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      formatter.format(
                                        double.parse(
                                          data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .replaceAll(",", "")
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(fontSize: 12),
                                ),
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
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(50, 50)),
                'assets/icons/v.png',
              ),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property : ${i + 1} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  'ID\'s property',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text(
                                  'Land-Width',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Length',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Total',
                                  style: TextStyle(fontSize: 12),
                                ),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]['agenttype_name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_width'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_length'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      formatter.format(
                                        double.parse(
                                          data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .replaceAll(",", "")
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(fontSize: 12),
                                ),
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
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(50, 50)),
                'assets/icons/a.png',
              ),
              onTap: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        "Property: ${i + 1} ${data_adding_correct[i]['property_type_name']}",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  'ID\'s property',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Owner', style: TextStyle(fontSize: 12)),
                                Text(
                                  'Land-Width',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Length',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Land-Total',
                                  style: TextStyle(fontSize: 12),
                                ),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_adding_price'] +
                                      '\$',
                                  style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]['agenttype_name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_width'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                          ['comparable_land_length'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '  :   ' +
                                      formatter.format(
                                        double.parse(
                                          data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .replaceAll(",", "")
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(fontSize: 12),
                                ),
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
      }

      if (data_adding_correct.length == 5) {
        await Dialog(context);
      }
    } else {
      await Find_by_piont(
        double.parse(requestModel.lat),
        double.parse(requestModel.lng),
      );
      await for_market_price();
    }
  }

  var route, avg;
  Future Dialog(BuildContext context) {
    if (!route.toString().contains('Preah Norodom Blvd') &&
        !route.toString().contains('Preah Monivong Blvd (93)') &&
        !route.toString().contains('NR1') &&
        !route.toString().contains('AH1') &&
        !route.toString().contains('Yuthapol Khmemarak Phoumin Blvd') &&
        !route.toString().contains('Yothapol Khemarak Phoumin Blvd (271)') &&
        !route.toString().contains('Mao Tse Toung Blvd') &&
        !route.toString().contains('Monireth') &&
        !route.toString().contains('Preah Sihanouk Blvd') &&
        !route.toString().contains('Kampuchea Krom Blvd') &&
        !route.toString().contains('Russian Federation Blvd') &&
        !route.toString().contains('Hun Sen Blvd') &&
        !route.toString().contains('Street 2004') &&
        !route.toString().contains('AH11') &&
        !route.toString().contains('NR2') &&
        !route.toString().contains('Chamkar Doung Street (217)') &&
        !route.toString().contains('Samdach Sothearos Blvd (3)') &&
        !route.toString().contains('Jawaharlal Nehru Blvd (215)') &&
        !route.toString().contains('Charles de Gaulle Blvd (217)') &&
        !route.toString().contains('Veng Sreng Blvd') &&
        !route.toString().contains('Phnom Penh Hanoi Friendship Blvd (1019)') &&
        !route.toString().contains('Samdach Penn Nouth St. (289)') &&
        !route.toString().contains('Street 273') &&
        !route.toString().contains('Street 355') &&
        !route.toString().contains('Oknha Mong Reththy St. (1928)') &&
        !route.toString().contains('NR5') &&
        !route.toString().contains('Oknha Kleang Moeung St. (70)') &&
        !route.toString().contains('Trung Morn St') &&
        !route.toString().contains('មហាវិថី​ សហព័ន្ធរុស្ស៊ី') &&
        !route.toString().contains('NR4') &&
        !route.toString().contains('NR3') &&
        !route.toString().contains('Oknha Tep Phan St. (182)') &&
        !route.toString().contains('Northbridge St. (1019)') &&
        !route.toString().contains('ផ្លូវ​ទំនប់​កប់ស្រូវ') &&
        !route.toString().contains('Street 337') &&
        !route.toString().contains('Saint 315') &&
        !route.toString().contains('St 566') &&
        !route.toString().contains('Street 598') &&
        !route.toString().contains('Angkor Blvd') &&
        !route.toString().contains('Preah Sisowath Quay') &&
        !route.toString().contains('Sola Street (371)') &&
        !route.toString().contains('Street 369') &&
        !route.toString().contains('NR21B') &&
        !route.toString().contains('NR6') &&
        !route.toString().contains('Keo Chenda St') &&
        !route.toString().contains('Tonle Sap St') &&
        !route.toString().contains('Street 2011') &&
        !route.toString().contains('Street 105K') &&
        !route.toString().contains('ផ្លូវទំនប់ថ្មី (៣៧១)') &&
        !route.toString().contains('NR20') &&
        !route.toString().contains('Prey Sa') &&
        !route.toString().contains('ផ្លូវ ៦០ម៉ែត្រ')) {
      setState(() {
        adding_price /= int.parse(requestModel.num.toString());
        var price = (adding_price + R_avg) / 2;
        min = price - (0.03 * price);
        max = price + (0.02 * price);
        avg = price;
      });
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          insetPadding: EdgeInsets.all(0),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Compareble price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 220, 221, 223),
                      boxShadow: const [
                        BoxShadow(blurRadius: 1, color: Colors.grey)
                      ],
                      border: Border.all(
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Avg = ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${formatter.format(adding_price)}\$",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 242, 11, 134)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Text("Min = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    "${formatter.format(adding_price - (0.01 * adding_price))}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Max = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    "${formatter.format(adding_price + (0.01 * adding_price))}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Residential",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 221, 223),
                          boxShadow: const [
                            BoxShadow(blurRadius: 1, color: Colors.grey)
                          ],
                          border: Border.all(
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Avg = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(R_avg)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Text("Min = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(minSqm1))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Max = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(maxSqm1))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Commercial",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 221, 223),
                          border: Border.all(
                            width: 0.2,
                          ),
                          boxShadow: const [
                            BoxShadow(blurRadius: 1, color: Colors.grey)
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Avg = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(C_avg)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Text("Min = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(minSqm2))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Max = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(maxSqm2))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Calculator Compareble and Land_price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 220, 221, 223),
                      border: Border.all(
                        width: 0.2,
                      ),
                      boxShadow: const [
                        BoxShadow(blurRadius: 1, color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Avg = ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${formatter.format(avg)}\$",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 242, 11, 134)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Text("Min = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(min)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Max = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(max)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "$commune /  $district / Route : ${route.toString()}",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (data_adding_correct.length == 5)
                    Text(
                        "\n(${data_adding_correct[0]['comparable_adding_price']}+${data_adding_correct[1]['comparable_adding_price']}+${data_adding_correct[2]['comparable_adding_price']}+${data_adding_correct[3]['comparable_adding_price']}+${data_adding_correct[4]['comparable_adding_price']})/${requestModel.num}=${formatter.format(adding_price)}\$",
                        style: const TextStyle(fontSize: 10)),
                  Text(
                      "+50% of AVG Residential = ${formatter.format(R_avg + (R_avg * 0.50))} \$",
                      style: const TextStyle(fontSize: 10)),
                  Text(
                      "( ${formatter.format(R_avg)}\$ + ${formatter.format(adding_price)}\$ ) / 2 = ${formatter.format(avg)}\$",
                      style: const TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ),
        ),
      );
      // return showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     actions: [
      //       TextButton(
      //         child: const Text('Close'),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       )
      //     ],
      //     insetPadding: EdgeInsets.all(0),
      //     content: SizedBox(
      //       height: MediaQuery.of(context).size.height * 0.55,
      //       width: MediaQuery.of(context).size.width * 1,
      //       child: SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             Text(
      //                 "Price of ${requestModel.num} comparable : ${formatter.format(adding_price)}\$",
      //                 style: const TextStyle(
      //                   fontSize: 15,
      //                   decorationStyle: TextDecorationStyle.dashed,
      //                   decoration: TextDecoration.underline,
      //                 )),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 Text(
      //                     "minimum : ${formatter.format(adding_price - (0.01 * adding_price))}\$",
      //                     style: const TextStyle(
      //                       fontSize: 15,
      //                       decorationStyle: TextDecorationStyle.dashed,
      //                       decoration: TextDecoration.underline,
      //                     )),
      //                 Text(
      //                     "maximum : ${formatter.format(adding_price + (0.03 * adding_price))}\$",
      //                     style: const TextStyle(
      //                       fontSize: 15,
      //                       decorationStyle: TextDecorationStyle.dashed,
      //                       decoration: TextDecoration.underline,
      //                     )),
      //               ],
      //             ),
      //             for (int i = 0; i < data_adding_correct.length; i++)
      //               Card(
      //                 elevation: 10,
      //                 child: ListTile(
      //                   title: Text(
      //                       "comparable id : ${data_adding_correct[i]['comparable_id']}",
      //                       style: const TextStyle(fontSize: 15)),
      //                   subtitle: Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                           "property : ${data_adding_correct[i]['property_type_name']}",
      //                           style: const TextStyle(fontSize: 15)),
      //                       Text(
      //                           "Owner : ${data_adding_correct[i]['agenttype_name']}",
      //                           style: const TextStyle(fontSize: 15)),
      //                       Text(
      //                           "adding price : ${formatter.format(double.parse(data_adding_correct[i]['comparable_adding_price'].replaceAll(",", "").toString()))}\$",
      //                           style: const TextStyle(fontSize: 15)),
      //                       Text(
      //                           "Date : ${data_adding_correct[i]['comparable_survey_date']}",
      //                           style: const TextStyle(fontSize: 15)),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    } else {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          insetPadding: EdgeInsets.all(0),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Compareble price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 220, 221, 223),
                      boxShadow: const [
                        BoxShadow(blurRadius: 1, color: Colors.grey)
                      ],
                      border: Border.all(
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Avg = ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${formatter.format(adding_price)}\$",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 242, 11, 134)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Text("Min = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    "${formatter.format(adding_price - (0.01 * adding_price))}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Max = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    "${formatter.format(adding_price + (0.01 * adding_price))}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Residential",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 221, 223),
                          boxShadow: const [
                            BoxShadow(blurRadius: 1, color: Colors.grey)
                          ],
                          border: Border.all(
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Avg = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(R_avg)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Text("Min = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(minSqm1))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Max = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(maxSqm1))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Commercial",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 221, 223),
                          border: Border.all(
                            width: 0.2,
                          ),
                          boxShadow: const [
                            BoxShadow(blurRadius: 1, color: Colors.grey)
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Avg = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(C_avg)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Text("Min = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(minSqm2))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Max = ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${formatter.format(double.parse(maxSqm2))}\$",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 242, 11, 134)))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Calculator Compareble and Land_price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 220, 221, 223),
                      border: Border.all(
                        width: 0.2,
                      ),
                      boxShadow: const [
                        BoxShadow(blurRadius: 1, color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Avg = ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${formatter.format(avg)}\$",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 242, 11, 134)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Text("Min = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(min)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Max = ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("${formatter.format(max)}\$",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 11, 134)))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "$commune /  $district / Route : ${route.toString()}",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Future for_market_price() {
    return AwesomeDialog(
      btnOkOnPress: () {},
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.infoReverse,
      showCloseIcon: false,
      title: "Check price by KFA",
      customHeader: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/New_KFA_Logo.png',
          filterQuality: FilterQuality.high,
          fit: BoxFit.fitWidth,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Residential",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 220, 221, 223),
              boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.grey)],
              border: Border.all(
                width: 0.2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Avg = ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${formatter.format(R_avg)}\$",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 242, 11, 134),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Min = ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${formatter.format(double.parse(minSqm1))}\$",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 242, 11, 134),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Max = ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${formatter.format(double.parse(maxSqm1))}\$",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 242, 11, 134),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Text(
            "Commercial",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 220, 221, 223),
              border: Border.all(
                width: 0.2,
              ),
              boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.grey)],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Avg = ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${formatter.format(C_avg)}\$",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 242, 11, 134),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Min = ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${formatter.format(double.parse(minSqm2))}\$",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 242, 11, 134),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Max = ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${formatter.format(double.parse(maxSqm2))}\$",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 242, 11, 134),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            ' $commune /  $district',
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).show();
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
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
        ),
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(message),
      //   ),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  var commune, district;
  dynamic R_avg, C_avg;
  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$la,$lo&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
      ),
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      widget.get_lat(lati.toString());
      widget.get_log(longi.toString());
      List ls = jsonResponse['results'];
      List ac;
      bool checkSk = false, checkKn = false;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (checkKn == false || checkSk == false) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "political") {
              setState(() {
                checkKn = true;
                district = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                // Load_khan(district);

                widget.get_district(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                checkSk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                // Load_sangkat(commune);
                widget.get_commune(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            //check Route
            // if (jsonResponse['results'][j]['address_components'][i]['types']
            //         [0] ==
            //     "route") {
            //   setState(() {
            //     route = (jsonResponse['results'][j]['address_components'][i]
            //         ['short_name']);
            //   });
            // }
          }
        }
        if (jsonResponse['results'][j]['types'][0] == "route") {
          List r = jsonResponse['results'][j]['address_components'];
          for (int i = 0; i < r.length; i++) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "route") {
              setState(() {
                route = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
          }
          // setState(() {
          //   route = (jsonResponse['results'][j]['address_components'][0]
          //       ['short_name']);
          // });
        }
      }

      final responseRc = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price?Khan_Name=${district.toString()}&Sangkat_Name=${commune.toString()}'));
      var jsonresponseRc = json.decode(responseRc.body);
      setState(() {
        maxSqm1 = jsonresponseRc['residential'][0]['Max_Value'].toString();
        minSqm1 = jsonresponseRc['residential'][0]['Min_Value'].toString();
        maxSqm2 = jsonresponseRc['commercial'][0]['Max_Value'].toString();
        minSqm2 = jsonresponseRc['commercial'][0]['Min_Value'].toString();
        R_avg = (double.parse(maxSqm1.toString()) +
                double.parse(minSqm1.toString())) /
            2;
        C_avg = (double.parse(maxSqm2.toString()) +
                double.parse(minSqm2.toString())) /
            2;
      });
      if (route != null) {
        if (route.toString().contains('Preah Norodom Blvd') ||
            route.toString().contains('Preah Monivong Blvd (93)') ||
            route.toString().contains('NR1') ||
            route.toString().contains('AH1') ||
            route.toString().contains('Yuthapol Khmemarak Phoumin Blvd') ||
            route.toString().contains('Yothapol Khemarak Phoumin Blvd (271)') ||
            route.toString().contains('Mao Tse Toung Blvd') ||
            route.toString().contains('Monireth') ||
            route.toString().contains('Preah Sihanouk Blvd') ||
            route.toString().contains('Kampuchea Krom Blvd') ||
            route.toString().contains('Russian Federation Blvd') ||
            route.toString().contains('Hun Sen Blvd') ||
            route.toString().contains('Street 2004') ||
            route.toString().contains('AH11') ||
            route.toString().contains('NR2') ||
            route.toString().contains('Chamkar Doung Street (217)') ||
            route.toString().contains('Samdach Sothearos Blvd (3)') ||
            route.toString().contains('Jawaharlal Nehru Blvd (215)') ||
            route.toString().contains('Charles de Gaulle Blvd (217)') ||
            route.toString().contains('Veng Sreng Blvd') ||
            route
                .toString()
                .contains('Phnom Penh Hanoi Friendship Blvd (1019)') ||
            route.toString().contains('Samdach Penn Nouth St. (289)') ||
            route.toString().contains('Street 273') ||
            route.toString().contains('Street 355') ||
            route.toString().contains('Oknha Mong Reththy St. (1928)') ||
            route.toString().contains('NR5') ||
            route.toString().contains('Oknha Kleang Moeung St. (70)') ||
            route.toString().contains('Trung Morn St') ||
            route.toString().contains('មហាវិថី​ សហព័ន្ធរុស្ស៊ី') ||
            route.toString().contains('NR4') ||
            route.toString().contains('NR3') ||
            route.toString().contains('Oknha Tep Phan St. (182)') ||
            route.toString().contains('Northbridge St. (1019)') ||
            route.toString().contains('ផ្លូវ​ទំនប់​កប់ស្រូវ') ||
            route.toString().contains('Street 337') ||
            route.toString().contains('Saint 315') ||
            route.toString().contains('St 566') ||
            route.toString().contains('Street 598') ||
            route.toString().contains('Angkor Blvd') ||
            route.toString().contains('Preah Sisowath Quay') ||
            route.toString().contains('Sola Street (371)') ||
            route.toString().contains('Street 369') ||
            route.toString().contains('NR21B') ||
            route.toString().contains('NR6') ||
            route.toString().contains('Keo Chenda St') ||
            route.toString().contains('Tonle Sap St') ||
            route.toString().contains('Street 2011') ||
            route.toString().contains('Street 105K') ||
            route.toString().contains('ផ្លូវទំនប់ថ្មី (៣៧១)') ||
            route.toString().contains('NR20') ||
            route.toString().contains('Prey Sa') ||
            route.toString().contains('ផ្លូវ ៦០ម៉ែត្រ')) {
          setState(() {
            adding_price /= int.parse(requestModel.num.toString());
            var price = (adding_price + (R_avg + C_avg)) / 2;
            min = price - (0.03 * price);
            max = price + (0.02 * price);
            avg = price;
          });
        }
      }
    } else {
      print(response.statusCode);
    }
  }
}
