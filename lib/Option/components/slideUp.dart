// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Option/components/property35.dart';
import 'package:itckfa/Option/components/property35_search.dart';
import 'package:itckfa/Option/components/raod_type.dart';
import 'package:itckfa/models/search_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../Getx/GoogleMap/GoogMap.dart';
import '../../Memory_local/database.dart';
import '../Customs/formnum.dart';
import '../screens/AutoVerbal/dailog.dart';
import '../screens/AutoVerbal/local_Map/api/service.dart';
import '../screens/AutoVerbal/local_Map/data/MyDB.dart';
import 'autoVerbalType_search.dart';
import 'colors.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class map_cross_verbal extends StatefulWidget {
  map_cross_verbal({
    super.key,
    required this.get_province,
    required this.get_district,
    required this.get_commune,
    required this.get_log,
    required this.get_lat,
    required this.asking_price,
    required this.updateNew,
    required this.iduser,
    required this.verbID,
    required this.listBuilding,
    required this.listBuildings,
  });
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final OnChangeCallback asking_price;
  final OnChangeCallback listBuilding;
  late int updateNew;
  final String iduser;
  final String verbID;
  final List listBuildings;
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
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
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

  MyDBmap myDBmap = MyDBmap();
  @override
  void dispose() {
    distanceController.dispose();
    searchlatlog.dispose();
    super.dispose();
  }

  bool checkFunction = false;

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

  API_Controller api_controller = API_Controller();
  @override
  void initState() {
    distanceController.text = '5';
    listBuilding = widget.listBuildings;
    _handleLocationPermission();
    requestModel = SearchRequestModel(
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
    listOptin = listRaodNBorey;
    waitingFuction();
    super.initState();
  }

  ControllerMap controller = ControllerMap();
  Future<void> waitingFuction() async {
    setState(() {
      checkFunction = true;
    });
    await Future.wait([
      _loadStringList(),
    ]);
    setState(() {
      checkFunction = false;
    });
  }

  Future<void> _loadStringList() async {
    await controller.mainAPI(widget.updateNew);
    // await controller.roadAPI(widget.updateNew);
    await controller.checkPriceListRAPI(widget.updateNew);
    await controller.checkPriceListCAPI(widget.updateNew);
    await controller.khanAPI(widget.updateNew);
    await controller.songkatAPI(widget.updateNew);
    await controller.optionAPI(widget.updateNew);
    await controller.comparaCRAPI(widget.updateNew);

    if (widget.updateNew != 0) {
      //  await controller.comparaCRAPI(widget.updateNew);
      widget.updateNew = 0;
      await controller.checkGoogle(widget.iduser);
    }
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

  List<Marker> markers = [];
  List listModel = [];
  final TextEditingController priceController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  TextEditingController searchraod = TextEditingController();
  TextEditingController searchlatlog = TextEditingController();
  MyDb mydb = MyDb();
  Widget _uiSteup(BuildContext context) {
    // TextEditingController search = TextEditingController();
    _panelHeightOpen = (groupValue == 0)
        ? MediaQuery.of(context).size.height * 0.8
        : MediaQuery.of(context).size.height * 0.25;
    return Scaffold(
      appBar: AppBar(
        title: Text("GoogleMap", style: TextStyle(color: whiteColor)),
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
                widget.listBuilding(listBuilding);
              } else {
                widget.asking_price(0);
              }
            });
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (groupValue == 0) {
                if (adding_price > 0) {
                  Dialog(context);
                } else {
                  getxsnackbar("Google Map!", "Please find Price");
                }
              } else {
                for_market_price();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 7, bottom: 7),
              child: Image.asset(
                "assets/icons/papersib.png",
                height: 35,
                width: 50,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(width: 10)
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
              borderRadius: const BorderRadius.only(
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

  List listassetImage = [
    {"image": "assets/icons/Approved.png"},
    {"image": "assets/icons/house.png"},
    {"image": "assets/icons/Comparable.png"},
    {"image": "assets/icons/land.png"},
    {"image": "assets/icons/area.png"},
    {"image": "assets/icons/condo.png"},
    {"image": "assets/icons/Appraiser.png"},
    {"image": "assets/icons/locations.png"},
  ];
  List<LatLng> points = [];
  Set<Polygon> polygons = {};
  void _createPolygon() {
    for (Marker marker in markers) {
      points.add(marker.position);
    }
    final Polygon polygon = Polygon(
      polygonId: const PolygonId('polygon'),
      points: points,
      strokeWidth: 2,
      strokeColor: const Color.fromARGB(255, 5, 94, 167),
      fillColor: Colors.blue.withOpacity(0.2),
    );

    setState(() {
      polygons.add(polygon);
    });
  }

  bool check = false;
  bool checkpoint = false;
  bool clickMap = false;
  BitmapDescriptor? customIcon;
  Future<void> addManyMarkers(LatLng latLng) async {
    if (checkpoint == false) {
      // clearMarkers();
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(40, 40)),
              'assets/images/pin.png')
          .then((d) {
        customIcon = d;
      });

      final int markerCount = markers.length;
      final MarkerId markerId = MarkerId(markerCount.toString());
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        icon: customIcon ?? BitmapDescriptor.defaultMarker,
        onDragEnd: (value) {
          latLng = value;
        },
      );

      setState(() {
        markers.add(marker);
        listMarkerIds.add(marker);
        _createPolygon();

        LatLng centroid = _calculatePolygonCentroid(
            markers.map((marker) => marker.position).toList());
        requestModel.lat = centroid.latitude.toString();
        requestModel.lng = centroid.longitude.toString();
        haveValue = false;
        routeNo = "";
        clickMap == false;
      });
    }
  }

  LatLng _calculatePolygonCentroid(List<LatLng> points) {
    double centroidLat = 0.0;
    double centroidLng = 0.0;

    for (LatLng point in points) {
      centroidLat += point.latitude;
      centroidLng += point.longitude;
    }

    centroidLat /= points.length;
    centroidLng /= points.length;

    return LatLng(centroidLat, centroidLng);
  }

  int groupValue = 0;
  bool isChecked = false;
  bool isChecked_all = false;
  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SizedBox(
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Option & Add (Land/Building)",
                  style: TextStyle(color: greyColor, fontSize: 17),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Text(
                    "Borey",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: greyColor,
                        fontSize: 14),
                  ),
                  IconButton(
                      onPressed: () async {
                        setState(() {
                          waitingCheck = true;
                        });
                        setState(() {
                          boreybutton = !boreybutton;

                          if (boreybutton) {
                            checkborey = 1;
                            listOptin = listRaodNBorey;
                          } else {
                            checkborey = 0;
                            listOptin = listRaodBorey;
                          }
                        });
                        setState(() {
                          if (boreybutton) {
                            checkborey = 1;
                            listOptin = listRaodBorey;
                          } else {
                            checkborey = 0;
                            listOptin = listRaodNBorey;
                          }
                        });
                        await Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            waitingCheck = false;
                          });
                        });
                      },
                      icon: Icon(boreybutton
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank)),
                  waitingCheck
                      ? const Center(child: CircularProgressIndicator())
                      : OptionRoadNew(
                          hight: 35,
                          pwidth: 250,
                          list: listOptin,
                          valueId: "road_id",
                          valueName: "road_name",
                          lable: "Road Name",
                          onbackValue: (value) {
                            setState(() {
                              List<String> parts = value!.split(',');

                              id_route = parts[0];

                              lable = parts[1];
                            });
                          },
                        ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                        activeBorderColor:
                            const Color.fromARGB(255, 39, 39, 39),
                        radioColor: GFColors.PRIMARY,
                      ),
                      const Text(" By Compereble",
                          style: TextStyle(fontSize: 11))
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
                        activeBorderColor:
                            const Color.fromARGB(255, 39, 39, 39),
                        radioColor: GFColors.PRIMARY,
                      ),
                      const Text(" By Market price",
                          style: TextStyle(fontSize: 11))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
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
            // const SizedBox(height: 10.0),
            // if (groupValue == 0)
            //   NumDisplay(
            //     onSaved: (newValue) => setState(() {
            //       requestModel.num = newValue!;
            //     }),
            //   ),
            if (groupValue == 0)
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 35,
                        child: DropdownButtonFormField<String>(
                          //value: genderValue,

                          value: searchlatlog.text.isNotEmpty
                              ? searchlatlog.text
                              : null,
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              searchlatlog.text = newValue ?? "";
                              if (newValue == 'N') {
                                comparedropdown = '';
                              } else {
                                comparedropdown = newValue!;
                                comparedropdown2 = 'P';
                              }

                              // print('==> $comparedropdown');
                            });
                          },

                          items: controller.listdropdown
                              .map<DropdownMenuItem<String>>(
                                (value) => DropdownMenuItem<String>(
                                  value: value["type"].toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: SizedBox(
                                                  height: 70,
                                                  // radius: 15,
                                                  // backgroundColor: Colors.white,
                                                  child: (value['id'] == 1)
                                                      ? Image.asset(
                                                          listassetImage[0]
                                                                  ['image']
                                                              .toString(),
                                                        )
                                                      : (value['id'] == 2)
                                                          ? Image.asset(
                                                              listassetImage[1]
                                                                      ['image']
                                                                  .toString())
                                                          : (value['id'] == 3)
                                                              ? Image.asset(
                                                                  listassetImage[2]
                                                                          [
                                                                          'image']
                                                                      .toString())
                                                              : (value['id'] ==
                                                                      4)
                                                                  ? Image.asset(
                                                                      listassetImage[3]['image']
                                                                          .toString())
                                                                  : (value['id'] ==
                                                                          5)
                                                                      ? Image.asset(
                                                                          listassetImage[4]['image']
                                                                              .toString())
                                                                      : (value['id'] ==
                                                                              6)
                                                                          ? Image.asset(listassetImage[5]['image'].toString())
                                                                          : (value['id'] == 7)
                                                                              ? Image.asset(listassetImage[6]['image'].toString())
                                                                              : Image.asset(listassetImage[7]['image'].toString())),
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(value["title"].toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11)),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Text(value["name"],
                                                style: const TextStyle(
                                                    fontSize: 11))),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          // add extra sugar..
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: kImageColor,
                          ),

                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Special Option',
                            labelStyle: const TextStyle(fontSize: 12),
                            hintText: 'Select one',
                            prefixIcon: const Icon(
                              Icons.home_outlined,
                              color: kImageColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: SizedBox(
                    //     height: 35,
                    //     child: DropdownButtonFormField<String>(
                    //       isExpanded: true,

                    //       onChanged: (newValue) {
                    //         setState(() {
                    //           if (newValue == "2024") {
                    //             id_route = null;
                    //           } else {
                    //             roadType = true;
                    //             id_route = newValue;
                    //           }
                    //           print("===> $id_route");
                    //         });
                    //       },

                    //       items: controller.listRaod
                    //           .map<DropdownMenuItem<String>>(
                    //             (value) =>
                    //                 DropdownMenuItem<String>(
                    //               value: value["road_id"]
                    //                   .toString(),
                    //               child: Text(value["road_name"]
                    //                   .toString()),
                    //               // child: Text(
                    //               //   value["name"],

                    //               //   style: TextStyle(
                    //               //       fontWeight: FontWeight.bold,
                    //               //       color: Colors.red),
                    //               // ),
                    //             ),
                    //           )
                    //           .toList(),
                    //       // add extra sugar..
                    //       icon: const Icon(
                    //         Icons.arrow_drop_down,
                    //         color: kImageColor,
                    //       ),

                    //       decoration: InputDecoration(
                    //         contentPadding:
                    //             const EdgeInsets.symmetric(
                    //                 vertical: 0, horizontal: 0),
                    //         fillColor: Colors.white,
                    //         filled: true,
                    //         labelText: (searchraod.text == "")
                    //             ? 'Road'
                    //             : searchraod.text,
                    //         hintStyle: TextStyle(
                    //             color: blackColor,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 15),
                    //         hintText: 'Select one',
                    //         prefixIcon: const Icon(
                    //           Icons.edit_road_outlined,
                    //           color: kImageColor,
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               color: kPrimaryColor,
                    //               width: 2.0),
                    //           borderRadius:
                    //               BorderRadius.circular(5),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //             width: 1,
                    //             color: kPrimaryColor,
                    //           ),
                    //           borderRadius:
                    //               BorderRadius.circular(5),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            if (groupValue == 0)
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        // width: double.infinity,
                        child: PropertySearch(
                          // pro: "Land",
                          name: (value) {
                            // propertyType = value;
                          },
                          checkOnclick: (value) {
                            setState(() {
                              isChecked = value;
                              isChecked_all = false;
                            });
                          },
                          id: (value) {
                            setState(() {
                              if (value == '37') {
                                pty = null;
                                // showAll = true;
                              } else {
                                pty = value;
                                // showAll = true;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // if (groupValue == 0)
            //   Row(
            //     children: [
            //       SizedBox(
            //         width: (isChecked == true)
            //             ? MediaQuery.of(context).size.width * 0.65
            //             : MediaQuery.of(context).size.width * 1,
            //         child: PropertyDropdown(
            //           name: (value) {
            //             // propertyType = value;
            //           },
            //           check_onclick: (value) {
            //             setState(() {
            //               isChecked = value;
            //               isChecked_all = false;
            //             });
            //           },
            //           id: (value) {
            //             pty = value;
            //           },
            //           // pro: list[0]['property_type_name'],
            //         ),
            //       ),
            //       Container(
            //         width: (isChecked == true)
            //             ? MediaQuery.of(context).size.width * 0.35
            //             : 0,
            //         alignment: Alignment.centerLeft,
            //         padding: const EdgeInsets.symmetric(vertical: 8),
            //         child: Row(
            //           children: [
            //             GFCheckbox(
            //               size: 25,
            //               activeBgColor: GFColors.PRIMARY,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isChecked_all = value;
            //                   isChecked = false;
            //                   pty = null;
            //                 });
            //               },
            //               value: isChecked_all,
            //               inactiveIcon: null,
            //             ),
            //             const Text("Show All", style: TextStyle(fontSize: 12))
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            if (groupValue == 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 1,
                  color: greyColor,
                ),
              ),
            if (adding_price > 0 && groupValue == 0)
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 10),
                  Text(
                    "Add (Land / Building)",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            if (adding_price > 0 && groupValue == 0) addLandBuilding(),

            if (listBuilding.isNotEmpty && adding_price > 0 && groupValue == 0)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listBuilding.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                      width: 230,
                      //height: 210,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 233, 239, 243),
                            offset: Offset(8, 10),
                            blurRadius: 6.0,
                          ),
                        ],
                        border: Border.all(width: 1, color: kPrimaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),

                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${listBuilding[index]['verbal_landid']}',
                                      style: NameProperty(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            check = true;
                                            listBuilding.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${listBuilding[index]['address'] ?? ""} ',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 60, 59, 59),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: kPrimaryColor,
                          ),
                          const SizedBox(height: 3.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Depreciation",
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  if (listBuilding[index]['verbal_land_des'] !=
                                      "LS")
                                    Text(
                                      "Floor",
                                      style: Label(),
                                    ),
                                  const SizedBox(height: 3),
                                  Text(
                                    "Area",
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Max Value/Sqm',
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Min Value/Sqm',
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Max Value',
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Min Value',
                                    style: Label(),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    ' : ${listBuilding[index]['verbal_land_des'] ?? ""}',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  if (listBuilding[index]['verbal_land_des'] !=
                                      "LS")
                                    Text(
                                      ' : ${listBuilding[index]['verbal_land_dp'] ?? ""}',
                                      style: Name(),
                                    ),
                                  const SizedBox(height: 2),
                                  Text(
                                    // ':   ' +
                                    //     (formatter.format(lb[i]
                                    //             .verbal_land_area
                                    //             .toInt()))
                                    //         .toString() +
                                    ' : ${listBuilding[index]['verbal_land_area'] ?? ""}m\u00B2',
                                    // area + 'm' + '\u00B2',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ' : ${listBuilding[index]['verbal_land_minsqm'] ?? ""}\$',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ' : ${listBuilding[index]['verbal_land_maxsqm'] ?? ""}\$',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ' : ${listBuilding[index]['verbal_land_minvalue'] ?? ""}\$',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ' : ${listBuilding[index]['verbal_land_maxvalue'] ?? ""}\$',
                                    style: Name(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Distance(
            //     onSaved: (input) => setState(() {
            //           requestModel.distance = input!;
            //         })),
            addPaddingWhenKeyboardAppears(),
          ],
        ),
      ),
    );
  }

  Future<void> addMarkers(LatLng latLng) async {
    Marker marker = Marker(
      // draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
      },
    );

    setState(() {
      haveValue = false;
      routeNo = "";
      listMarkerIds.clear();
      data_adding_correct.clear();
      listMarkerIds.add(marker);
      requestModel.lat = latLng.latitude.toString();
      requestModel.lng = latLng.longitude.toString();
    });
  }

  Future<void> addMarker(LatLng latLng) async {
    Marker marker = Marker(
      visible: true,
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
      },
    );

    setState(() {
      haveValue = false;
      routeNo = "";
      listMarkerIds.clear();
      data_adding_correct.clear();
      listMarkerIds.add(marker);
      requestModel.lat = latLng.latitude.toString();
      requestModel.lng = latLng.longitude.toString();
    });
  }

  bool checktypeMarker = false;
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

  late Timer _timer;
  bool closeDialog = false;
  Stack MapShow() {
    return Stack(
      children: [
        GoogleMap(
          markers: listMarkerIds.map((e) => e).toSet(),
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: latLng,
            zoom: 12.0,
          ),
          polygons: Set<Polygon>.of(polygons),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.hybrid,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          onTap: (argument) async {
            setState(() {
              requestModel.lat = latLng.latitude.toString();
              requestModel.lng = latLng.longitude.toString();
            });
            if (closeDialog == false) {
              addMarker(argument);
              findByPiont(argument.latitude, argument.longitude);
              await optionSearch();
            } else {
              if (checktypeMarker == false) {
                addMarker(argument);
                findByPiont(argument.latitude, argument.longitude);
                await Show(requestModel);
              } else {
                addManyMarkers(argument);
              }
            }
          },
          onCameraMove: (CameraPosition cameraPositiona) {
            cameraPosition = cameraPositiona; //when map is dragging
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 2),
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

  List listOptin = [];
  List listRaodNBorey = [
    {"road_id": 1, "road_name": "Main Roads"},
    {"road_id": 2, "road_name": "Sub Road"},
  ];
  List listRaodBorey = [
    {"road_id": 38, "road_name": "Borey Residential"},
    {"road_id": 39, "road_name": "Borey Commercial"},
  ];
  String lable = "Road Name";
  bool waitingCheck = false;
  bool boreybutton = false;
  Future<void> optionSearch() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 420,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                size: 30,
                              ))
                        ],
                      ),
                      Image.asset("assets/images/searchMan.png", height: 120),
                      const SizedBox(height: 10),
                      ((routeNo != "Unnamed Road" && checkborey != 0))
                          ? Text(
                              (routeNo == "Unnamed Road" && checkborey == 0)
                                  ? "Specail Zone"
                                  : "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 55, 52, 52),
                                  fontSize: 15))
                          : const Text("Select Property Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 55, 52, 52),
                                  fontSize: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                  (routeNo == "Unnamed Road" && checkborey == 0)
                                      ? "Specail Zone"
                                      : "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 55, 52, 52),
                                      fontSize: 15)),
                              (routeNo == "Unnamed Road" && checkborey == 0)
                                  ? IconButton(
                                      onPressed: () {
                                        setModalState(() {
                                          doneORudone = !doneORudone;
                                        });
                                        setState(() {
                                          haveValue = !haveValue;
                                        });
                                      },
                                      icon: !doneORudone
                                          ? Icon(
                                              Icons.check_box_outline_blank,
                                              size: 25,
                                              color: greyColorNolots,
                                            )
                                          : Icon(
                                              Icons.check_box_outlined,
                                              size: 25,
                                              color: greyColor,
                                            ))
                                  : const SizedBox(),
                              Row(
                                children: [
                                  Text(
                                    "Borey",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: greyColor,
                                        fontSize: 14),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          waitingCheck = true;
                                        });
                                        setModalState(() {
                                          boreybutton = !boreybutton;

                                          if (boreybutton) {
                                            checkborey = 1;
                                            listOptin = listRaodNBorey;
                                          } else {
                                            checkborey = 0;
                                            listOptin = listRaodBorey;
                                          }
                                        });
                                        setState(() {
                                          if (boreybutton) {
                                            checkborey = 1;
                                            listOptin = listRaodBorey;
                                          } else {
                                            checkborey = 0;
                                            listOptin = listRaodNBorey;
                                          }
                                        });
                                        await Future.delayed(
                                            const Duration(seconds: 1), () {
                                          setModalState(() {
                                            waitingCheck = false;
                                          });
                                        });
                                      },
                                      icon: Icon(boreybutton
                                          ? Icons.check_box_outlined
                                          : Icons.check_box_outline_blank)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          waitingCheck
                              ? const Center(child: CircularProgressIndicator())
                              : OptionRoadNew(
                                  hight: 35,
                                  pwidth: 250,
                                  list: listOptin,
                                  valueId: "road_id",
                                  valueName: "road_name",
                                  lable: "Road Name",
                                  onbackValue: (value) {
                                    setModalState(() {
                                      List<String> parts = value!.split(',');

                                      id_route = parts[0];

                                      lable = parts[1];
                                    });
                                  },
                                ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      (routeNo == "Unnamed Road" || checkborey == 1)
                          ? const SizedBox()
                          : Container(
                              height: 35,
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: DropdownButtonFormField<String>(
                                //value: genderValue,
                                value: searchlatlog.text.isNotEmpty
                                    ? searchlatlog.text
                                    : null,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    comparedropdown = newValue!;
                                    for (int j = 0;
                                        j < controller.listdropdown.length;
                                        j++) {
                                      if (controller.listdropdown[j]['type']
                                              .toString() ==
                                          newValue) {
                                        // valuedropdown = controller
                                        //     .listdropdown[j]['title']
                                        //     .toString();
                                      }
                                    }
                                  });
                                },
                                items: controller.listdropdown
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                        value: value["type"].toString(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 7),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                    height: 70,
                                                    // radius: 15,
                                                    // backgroundColor: Colors.white,
                                                    child: (value['id'] == 1)
                                                        ? Image.asset(
                                                            listassetImage[0]
                                                                    ['image']
                                                                .toString(),
                                                          )
                                                        : (value['id'] == 2)
                                                            ? Image.asset(
                                                                listassetImage[
                                                                            1][
                                                                        'image']
                                                                    .toString())
                                                            : (value['id'] == 3)
                                                                ? Image.asset(
                                                                    listassetImage[2]
                                                                            [
                                                                            'image']
                                                                        .toString())
                                                                : (value['id'] ==
                                                                        4)
                                                                    ? Image.asset(
                                                                        listassetImage[3]['image']
                                                                            .toString())
                                                                    : (value['id'] ==
                                                                            5)
                                                                        ? Image.asset(
                                                                            listassetImage[4]['image'].toString())
                                                                        : (value['id'] == 6)
                                                                            ? Image.asset(listassetImage[5]['image'].toString())
                                                                            : (value['id'] == 7)
                                                                                ? Image.asset(listassetImage[6]['image'].toString())
                                                                                : Image.asset(listassetImage[7]['image'].toString())),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7),
                                                  child: Text(
                                                    "${value["title"]}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  style: const TextStyle(
                                                      fontSize: 11),
                                                  value["name"].toString(),
                                                  maxLines: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        // child: Text(
                                        //   value["name"],

                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       color: Colors.red),
                                        // ),
                                      ),
                                    )
                                    .toList(),
                                // add extra sugar..
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: kImageColor,
                                ),

                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Special Option',
                                  hintText: 'Select one',
                                  prefixIcon: const Icon(
                                    Icons.edit_road_outlined,
                                    color: kImageColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: kPrimaryColor),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 150,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 20, 23, 167)),
                                ),
                                onPressed: () async {
                                  Get.back();
                                  // await getAddress(latLng);
                                  await Show(requestModel);
                                },
                                child: const Text('Search')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  var colorstitle = const Color.fromARGB(255, 141, 140, 140);
  var colorsPrice = const Color.fromARGB(255, 241, 31, 23);
  List<dynamic> filterDuplicates(
      List<dynamic> list, String priceKey, String lat, String log) {
    Set<String> seenPriceAndLatLog = {};
    Set<String> seenLatLog = {};
    List<dynamic> uniqueList = [];

    for (var item in list) {
      String priceAndLatLogKey = "${item[priceKey]}_${item[lat]}_${item[log]}";
      String latLogKey = "${item[lat]}_${item[log]}";

      if (list.length == 5 ||
          (!seenPriceAndLatLog.contains(priceAndLatLogKey) &&
              !seenLatLog.contains(latLogKey))) {
        seenPriceAndLatLog.add(priceAndLatLogKey);
        seenLatLog.add(latLogKey);
        uniqueList.add(item);
      }
    }

    return uniqueList;
  }

  List listBorey = [
    {
      "title": "Borey",
      "check": 1,
    },
    {
      "title": "No Borey",
      "check": 0,
    }
  ];
  Widget textEdit() {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 100,
      child: TextFormField(
        controller: priceController,
        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          labelStyle: const TextStyle(color: kPrimaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kPrimaryColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  double fontsizeD = 14;
  Future<void> dailogMarkers(i) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: whiteColor),
                height: 500,
                width: 330,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Price : ',
                                style: TextStyle(
                                    color: kImageColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            textEdit(),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  // updatePrice(
                                  //     data_adding_correct[i]['comparable_id']
                                  //         .toString(),
                                  //     priceController.text);
                                },
                                child: const Text('Save')),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                              },
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: greyColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 35,
                          // width: double.infinity,
                          child: PropertyDropdown35(
                            name: (value) {
                              // propertyType = value;
                              setState(() {
                                // updatepropertyName = value;
                              });
                            },
                            check_onclick: (value) {},
                            id: (value) {
                              setState(() {
                                // updateproperty = value;
                              });
                            },
                            // pro: list[0]['property_type_name'],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Property (${i + 1}) ${data_adding_correct[i]['property_type_name']}",
                              style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Block Comparable Price : ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: greyColor),
                            ),
                            TextButton(
                              onPressed: () {
                                // blocComparable(
                                //     data_adding_correct[i]['comparable_id']);
                              },
                              child: Icon(
                                Icons.block,
                                color: greyColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 35,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,

                            onChanged: (newValue) {
                              setState(() {
                                // checkborey = int.parse(newValue!);
                                // String roadDrop = newValue as String;
                              });
                            },

                            items: listBorey
                                .map<DropdownMenuItem<String>>(
                                  (value) => DropdownMenuItem<String>(
                                    value: value["check"].toString(),
                                    child: Text(value["title"].toString()),
                                    // child: Text(
                                    //   value["name"],

                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.red),
                                    // ),
                                  ),
                                )
                                .toList(),
                            // add extra sugar..
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: kImageColor,
                            ),

                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: (data_adding_correct[i]['borey'] == 0)
                                  ? "No Borey"
                                  : "Borey",
                              hintStyle: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              hintText: 'Select one',
                              prefixIcon: const Icon(
                                Icons.edit_road_outlined,
                                color: kImageColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 35,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,

                            onChanged: (newValue) {
                              setState(() {
                                // String roadDrop = newValue as String;

                                // updateraod = newValue!.split(",")[0];
                                // updateraodName = newValue.split(",")[1];
                              });
                            },

                            items: controller.listRaod
                                .map<DropdownMenuItem<String>>(
                                  (value) => DropdownMenuItem<String>(
                                    value: value["road_id"].toString() +
                                        "," +
                                        "${value["road_name"].toString()}",
                                    child: Text(value["road_name"].toString()),
                                    // child: Text(
                                    //   value["name"],

                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.red),
                                    // ),
                                  ),
                                )
                                .toList(),
                            // add extra sugar..
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: kImageColor,
                            ),

                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              fillColor: Colors.white,
                              filled: true,
                              labelText:
                                  "${data_adding_correct[i]['road_name']}",
                              // labelText: (searchraod.text == "")
                              //     ? 'Road'
                              //     : searchraod.text,
                              hintStyle: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              hintText: 'Select one',
                              prefixIcon: const Icon(
                                Icons.edit_road_outlined,
                                color: kImageColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID\'s property',
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: fontsizeD,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text('Owner',
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text('Land-Width',
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text('Land-Length',
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text('Land-Total',
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text('Date Created',
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text('Type of Route',
                                    style: TextStyle(fontSize: fontsizeD)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '  :   ${(data_adding_correct[i]['type_value'] ?? "")} ${data_adding_correct[i]['comparable_id']}',
                                    style: TextStyle(fontSize: fontsizeD)),

                                const SizedBox(height: 10),
                                Text(
                                  '${priceController.text}\$',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 242, 11, 134),
                                      fontSize: fontsizeD,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   '${'  :   ' + data_adding_correct[i]['comparable_adding_price']}\$',
                                //   style: TextStyle(
                                //       color: const Color.fromARGB(
                                //           255, 242, 11, 134),
                                //       fontSize: fontsizeD,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                const SizedBox(height: 10),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['agenttype_name']
                                            .toString(),
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text(
                                    '  :   ' +
                                        "${data_adding_correct[i]['comparable_land_width'] ?? ""}",
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text(
                                    '  :   ' +
                                        "${data_adding_correct[i]['comparable_land_length'] ?? ""}",
                                    style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                if (data_adding_correct[i]
                                                ['comparable_land_total']
                                            .toString() ==
                                        "" ||
                                    data_adding_correct[i]
                                                ['comparable_land_total']
                                            .toString() ==
                                        "null")
                                  Text('  :   ',
                                      style: TextStyle(fontSize: fontsizeD))
                                else
                                  Text(
                                      '  :   ${formatter.format(double.parse(data_adding_correct[i]['comparable_land_total'].replaceAll(",", "").toString()))}',
                                      style: TextStyle(fontSize: fontsizeD)),
                                const SizedBox(height: 10),
                                Text(
                                  '  :   ' +
                                      data_adding_correct[i]
                                              ['comparable_survey_date']
                                          .toString(),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    '  :   ' +
                                        data_adding_correct[i]['road_name']
                                            .toString(),
                                    style: TextStyle(fontSize: fontsizeD))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String comparedropdown = '';
  Future<void> markerType(int i, typeMarker) async {
    MarkerId markerId = MarkerId(i.toString());
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        double.parse(data_adding_correct[i]['latlong_log'].toString()),
        double.parse(data_adding_correct[i]['latlong_la'].toString()),
      ),
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(50, 50)),
          'assets/icons/$typeMarker'),
      onTap: () {
        setState(() {
          priceController.text =
              data_adding_correct[i]['comparable_adding_price'].toString();
          // updateproperty =
          //     data_adding_correct[i]['comparable_property_id'].toString();
          // updateraod = data_adding_correct[i]['comparable_road'].toString();
          // updatepropertyName =
          //     data_adding_correct[i]['comparable_property_id'].toString();
        });
        dailogMarkers(i);
      },
    );
    setState(() {
      isApiCallProcess = false;
      listMarkerIds.add(marker);
    });
  }

  String opionTypeID = '0';
  double areas = 0;
  double? minSqm, maxSqm, totalMin, totalMax, totalArea;
  void calLs() {
    setState(() {
      if (haveValue == true) {
        if (areas <= 300) {
          double avgmin = caculateCom(0.85);
          double avgmax = caculateCom(0.80);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 301 && areas <= 1000) {
          double avgmin = caculateCom(0.8);
          double avgmax = caculateCom(0.75);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 1001 && areas <= 3000) {
          double avgmin = caculateCom(0.75);
          double avgmax = caculateCom(0.7);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 3000) {
          double avgmin = caculateCom(0.7);
          double avgmax = caculateCom(0.65);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        }
      } else {
        if (areas <= 300) {
          double avgmin = caculateRen(0.85);
          double avgmax = caculateRen(0.80);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 301 && areas <= 1000) {
          double avgmin = caculateRen(0.8);
          double avgmax = caculateRen(0.75);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 1001 && areas <= 3000) {
          double avgmin = caculateRen(0.75);
          double avgmax = caculateRen(0.7);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 3000) {
          double avgmin = caculateRen(0.7);
          double avgmax = caculateRen(0.65);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        }
      }
      totalMin = (minSqm! * areas);
      totalMax = (maxSqm! * areas);
      addItemToList();
    });
  }

  double h = 0;
  String dep = "0";
  List listBuilding = [];
  void addItemToList() {
    setState(() {
      listBuilding.add({
        "verbal_land_type": "",
        "verbal_land_des": controllerDS.text,
        "verbal_land_dp": dep,
        "verbal_land_area": areas,
        "verbal_land_minsqm": minSqm!.toStringAsFixed(0),
        "verbal_land_maxsqm": maxSqm!.toStringAsFixed(0),
        "verbal_land_minvalue": totalMin!.toStringAsFixed(0),
        "verbal_land_maxvalue": totalMax!.toStringAsFixed(0),
        "address": '$commune / $district',
        "verbal_landid": widget.verbID
      });
    });
    print("listBuilding : $listBuilding");
  }

  double caculateCom(double p) {
    double avgCaculate =
        (((addingPriceSimple * p) + addingPriceVerbal) / 5 + (R_avg + C_avg)) /
            2;
    return avgCaculate;
  }

  double caculateRen(double p) {
    double avgCaculate = ((addingPriceSimple * p) + addingPriceVerbal) / 5;
    return avgCaculate;
  }

  Future<void> calElse(double area, String autoverbalTypeValue) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/type?autoverbal_id=$autoverbalTypeValue'));

    setState(() {
      var jsonData = jsonDecode(rs.body);

      maxSqm = double.parse(jsonData[0]['max'].toString());
      minSqm = double.parse(jsonData[0]['min'].toString());
      // ignore: unnecessary_null_comparison
      if (opionTypeID != null) {
        totalMin =
            ((minSqm! * area) + (double.parse(opionTypeID.toString()) / 100)) +
                (minSqm! * area);
        totalMax =
            ((maxSqm! * area) + (double.parse(opionTypeID.toString()) / 100)) +
                (maxSqm! * area);

        addItemToList();
      } else {
        totalMin = minSqm! * area;
        totalMax = maxSqm! * area;
        addItemToList();
      }
    });
    //  }
  }

  int optionValue = 0;
  double hL = 0, lL = 0;
  bool checkmap = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkMap = false;
  bool checkHlandbuilding = false;
  late String autoverbalTypeValue = '';
  Widget addLandBuilding() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 2,
              color: greyColorNolots,
            )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: whiteColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 290,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            !checkmap
                                ? const Text(
                                    'Please Find Price on Map',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 240, 24, 9),
                                    ),
                                  )
                                : const SizedBox(),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (validateAndSave()) {
                                    // print(adding_price.toString());
                                    if (adding_price > 0) {
                                      if (checkHlandbuilding == false) {
                                        // hscreen = hscreen + 280;
                                      }
                                      checkMap = true;
                                      if (autoverbalTypeValue == '100') {
                                        calLs();
                                      } else {
                                        calElse(areas, autoverbalTypeValue);
                                      }
                                      checkHlandbuilding = true;
                                      checkmap = true;
                                    } else {
                                      checkmap = false;
                                    }
                                  }
                                });
                              },
                              child: const Text(
                                "Calculator price",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Land / Building',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: greyColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 35,
                                width: double.infinity,
                                child: ApprovebyAndVerifybySearch(
                                  name: (value) {
                                    setState(() {
                                      controllerDS.text = value;
                                    });
                                  },
                                  id: (value) {
                                    setState(() {
                                      autoverbalTypeValue = value;
                                      // print(autoverbalTypeValue);
                                    });
                                  },
                                  defaultValue: const {
                                    'type': 'LS',
                                    'autoverbal_id': '100'
                                  },
                                ),
                              ),
                            ),
                            if (autoverbalTypeValue != "100")
                              const SizedBox(width: 10),
                            if (autoverbalTypeValue != "100")
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 35,
                                  child: FormN(
                                    label: "Floors",
                                    iconname: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: kImageColor,
                                    ),
                                    onSaved: (newValue) {
                                      setState(() {
                                        dep = newValue!;

                                        if (totalArea != null) {
                                          totalArea =
                                              totalArea! * double.parse(dep);
                                        }
                                        totalArea;
                                        areas = totalArea!;
                                      });
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 35,
                                child: FormN(
                                  label: "Head",
                                  iconname: const Icon(
                                    Icons.h_plus_mobiledata_outlined,
                                    color: kImageColor,
                                  ),
                                  onSaved: (newValue) {
                                    setState(() {
                                      if (newValue == "") {
                                        controllerArea.clear();
                                      }
                                      h = double.parse(newValue!);
                                      if (lL != 0) {
                                        totalArea = h * lL;
                                        areas = totalArea!;
                                      } else {
                                        totalArea = h;
                                      }
                                      controllerArea.text = areas.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 35,
                                child: FormN(
                                  label: "Length",
                                  iconname: const Icon(
                                    Icons.blur_linear_outlined,
                                    color: kImageColor,
                                  ),
                                  onSaved: (newValue) {
                                    setState(() {
                                      if (newValue == "") {
                                        controllerArea.clear();
                                      }
                                      lL = double.parse(newValue!);

                                      if (h != 0) {
                                        totalArea = h * lL;
                                        areas = totalArea!;
                                      } else {
                                        totalArea = lL;
                                      }
                                      controllerArea.text = areas.toString();
                                      // controllerArea.text = totalArea!.toString();
                                      // if (controllerArea == null ||
                                      //     controllerArea.text == "") {
                                      //   controllerArea.clear();
                                      // }
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        // if (autoverbalTypeValue != '100')
                        // SizedBox(
                        //   height: 35,
                        //   child: FormN(
                        //     label: "Depreciation(Age)",
                        //     iconname: const Icon(Icons.calendar_month_outlined,
                        //         color: kImageColor),
                        //     onSaved: (newValue) {
                        //       setState(() {
                        //         dep = newValue!;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // const SizedBox(height: 10),

                        SizedBox(
                            height: 35,
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  controller: controllerArea,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      areas = double.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    filled: true,
                                    labelText: "Area (m\u00B2)",
                                    labelStyle: const TextStyle(fontSize: 12),
                                    prefixIcon: const Icon(
                                      Icons.layers,
                                      color: kImageColor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(0, 126, 250, 1),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(0, 126, 250, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 2,
                                        color: Color.fromARGB(255, 249, 0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 249, 0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    errorStyle: const TextStyle(
                                        height: 0), // Hide error text
                                  ),
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return ''; // Return empty string to trigger error state
                                    }
                                    return null;
                                  },
                                )),
                                // Expanded(
                                //   flex: 1,
                                //   child: FormValidateN(
                                //       // label: "Area",
                                //       label: ((totalArea != 0)
                                //           ? "Area (m\u00B2): ${formatter.format(totalArea ?? 0)}"
                                //           : "Area"),
                                //       iconname:
                                //           const Icon(Icons.layers, color: kImageColor),
                                //       onSaved: (newValue) {
                                //         setState(() {
                                //           areas = double.parse(newValue!);
                                //         });
                                //       }),
                                // ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 35,
                                    child: DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          opionTypeID = newValue!
                                              .split(" ")[0]
                                              .toString();
                                          optionValue = int.parse(newValue
                                              .split(" ")[1]
                                              .toString());
                                        });
                                      },
                                      items: controller.listOption
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem<String>(
                                              value:
                                                  "${value["opt_value"]} ${value["opt_id"]}",
                                              child: Text(value["opt_des"]),
                                              onTap: () {
                                                setState(() {
                                                  opionTypeID =
                                                      value["opt_value"]
                                                          .toString();
                                                });
                                              },
                                            ),
                                          )
                                          .toList(),
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: kImageColor),
                                      decoration: InputDecoration(
                                        fillColor: kwhite,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8),
                                        labelText: 'OptionType',
                                        labelStyle:
                                            const TextStyle(fontSize: 12),
                                        hintText: 'Select one',
                                        prefixIcon: const Icon(
                                            Icons.my_library_books_rounded,
                                            color: kImageColor),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   child: CommentAndOption(
                                //     value: (value) {
                                //       setState(() {
                                //         // opt = int.parse(value);
                                //       });
                                //     },
                                //     comment1: (opt != null) ? opt.toString() : null,
                                //     id: (value) {
                                //       setState(() {
                                //         optionValue = int.parse(value.toString());
                                //       });
                                //     },
                                //     comment: (newValue) {
                                //       setState(() {
                                //         // comment = newValue!.toString();
                                //       });
                                //     },
                                //     opt_type_id: (value) {
                                //       setState(() {
                                //         opionTypeID = value.toString();
                                //       });
                                //     },
                                //   ),
                                // ),
                              ],
                            )),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 35,
                          child: TextFormField(
                            readOnly: true,
                            controller: controllerDS,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: kwhite,
                              filled: true,
                              labelText: "Description",
                              labelStyle: const TextStyle(fontSize: 14),
                              prefixIcon: const Icon(
                                Icons.description,
                                color: kImageColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Add(
            //     checkMap: checkMap,
            //     addressController: addressController,
            //     lat: (requestModel.lat == "") ? "" : requestModel.lat,
            //     lng: (requestModel.lng == "") ? "" : requestModel.lng,
            //     verbalID: verbalID,
            //     hscreen: hscreen,
            //     listLandBuilding: listBuilding,
            //     backvalue: (value) {
            //       setState(() {
            //         widget.type(100);
            //         if (value == 100) {
            //           widget.addNew(31);
            //         }
            //       });
            //     },
            //     email: widget.listUser[0]['email'].toString(),
            //     id_control_user: widget.listUser[0]['control_user'].toString(),
            //     listUser: widget.listUser,
            //     device: "m")
          ],
        ),
      ),
    );
  }

  String comparedropdown2 = '';
  int checkborey = 0;
  var id_route;
  bool doneORudone = false;
  List data_adding_correct = [];
  double? min, max;
  Map? map;
  bool haveValue = false;
  double addingPriceVerbal = 0;
  double addingPriceSimple = 0;
  Future<void> Show(SearchRequestModel requestModel) async {
    try {
      if (groupValue == 0) {
        setState(() {
          isApiCallProcess = true;
          print("routeNo : (${routeNo!.toString()})");
        });

        if (routeNo != null) {
          for (int i = 0; i < controller.listMainRoute.length; i++) {
            if (routeNo!.contains(
                  controller.listMainRoute[i]['name_road'].toString(),
                ) ||
                comparedropdown == "C") {
              setState(() {
                haveValue = true;
              });

              break;
            } else {
              // print("No.2 Route");
            }
          }
        }
        setState(() {
          pty;
          if (checkborey == 0) {
            if (haveValue == true) {
              id_route = '1';
            } else {
              id_route = '2';
            }
          } else {
            id_route = null;
          }
        });
        var headers = {'Content-Type': 'application/json'};
        var data = json.encode({
          "distance": distanceController.text,
          "property_type_id": (pty == null) ? null : pty,
          "type": (comparedropdown == "") ? "" : comparedropdown,
          "road": id_route,
          "num": requestModel.num,
          "lat": requestModel.lat,
          "lng": requestModel.lng,
          "borey": checkborey,
        });
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mapNew/map_action',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          setState(() {
            doneORudone = false;
            list = jsonDecode(json.encode(response.data))['autoverbal'];
            print("list => ${list.length}");
            // if (list.length >= 5) {
            //   if (comparedropdown2 == "" && haveValue == true) {
            //     searchraod.text = controller.listRaod.first['road_name']!;
            //     searchlatlog.text = controller.listdropdown.first['type']!;
            //   } else if (comparedropdown2 == "" && haveValue == false) {
            //     searchraod.text = controller.listRaod[1]['road_name']!;
            //     searchlatlog.text = controller.listdropdown[1]['type']!;
            //   }
            // }
          });
        }
        if (list.length >= 5) {
          List<dynamic> filteredList = filterDuplicates(
            list,
            "comparable_adding_price",
            "latlong_la",
            "latlong_log",
          );

          setState(() {
            isApiCallProcess = false;
            map = filteredList.asMap();
          });

          setState(() {
            for (var i = 0; i < map!.length; i++) {
              if (checkborey == 1) {
                if (map![i]['borey'] == 1) {
                  if (map![i]['type_value'] == "V") {
                    if (map![i]['comparable_adding_price'] == '') {
                      map![i]['comparable_adding_price'] = '0';
                      addingPriceVerbal +=
                          double.parse(map![i]['comparable_adding_price']);
                    } else if (map![i]['comparable_adding_price']
                        .contains(',')) {
                      addingPriceVerbal += double.parse(map![i]
                              ['comparable_adding_price']
                          .replaceAll(",", ""));
                    } else {
                      addingPriceVerbal +=
                          (double.parse(map![i]['comparable_adding_price']));
                    }
                  } else {
                    {
                      if (map![i]['comparable_adding_price'] == '') {
                        map![i]['comparable_adding_price'] = '0';
                        addingPriceSimple +=
                            double.parse(map![i]['comparable_adding_price']);
                      } else if (map![i]['comparable_adding_price']
                          .contains(',')) {
                        addingPriceSimple += double.parse(map![i]
                                ['comparable_adding_price']
                            .replaceAll(",", ""));
                      } else {
                        addingPriceSimple +=
                            (double.parse(map![i]['comparable_adding_price']));
                      }
                    }
                  }
                }
              } else {
                if (map![i]['type_value'] == "V") {
                  if (map![i]['comparable_adding_price'] == '') {
                    map![i]['comparable_adding_price'] = '0';
                    addingPriceVerbal +=
                        double.parse(map![i]['comparable_adding_price']);
                  } else if (map![i]['comparable_adding_price'].contains(',')) {
                    addingPriceVerbal += double.parse(
                        map![i]['comparable_adding_price'].replaceAll(",", ""));
                  } else {
                    addingPriceVerbal +=
                        (double.parse(map![i]['comparable_adding_price']));
                  }
                } else {
                  {
                    if (map![i]['comparable_adding_price'] == '') {
                      map![i]['comparable_adding_price'] = '0';
                      addingPriceSimple +=
                          double.parse(map![i]['comparable_adding_price']);
                    } else if (map![i]['comparable_adding_price']
                        .contains(',')) {
                      addingPriceSimple += double.parse(map![i]
                              ['comparable_adding_price']
                          .replaceAll(",", ""));
                    } else {
                      addingPriceSimple +=
                          (double.parse(map![i]['comparable_adding_price']));
                    }
                  }
                }
              }
              setState(() {
                data_adding_correct.add(map![i]);
              });
              // }
            }
          });
          if (!clickdone) {
            if (data_adding_correct.isNotEmpty) {
              for (int i = 0; i < data_adding_correct.length; i++) {
                if (data_adding_correct[i]['comparable_property_id']
                        .toString() ==
                    '15') {
                  markerType(i, 'l.png');
                } else if (data_adding_correct[i]['comparable_property_id']
                        .toString() ==
                    '10') {
                  markerType(i, 'f.png');
                } else if (data_adding_correct[i]['comparable_property_id']
                        .toString() ==
                    '33') {
                  markerType(i, 'v.png');
                } else if (data_adding_correct[i]['comparable_property_id']
                        .toString() ==
                    '14') {
                  markerType(i, 'h.png');
                } else if (data_adding_correct[i]['comparable_property_id']
                        .toString() ==
                    '4') {
                  markerType(i, 'b.png');
                } else if (data_adding_correct[i]['comparable_property_id']
                        .toString() ==
                    '29') {
                  markerType(i, 'v.png');
                } else {
                  markerType(i, 'a.png');
                }
              }
            }
          }
          // print("No.2 : ${data_adding_correct.length}");
          if (data_adding_correct.isNotEmpty) {
            if (data_adding_correct.length < 5) {
              setState(() {
                pty = null;
                comparedropdown = '';
              });

              // await Show(requestModel);
            } else {
              await Dialog(context);
            }
          }
        } else {
          // nodata("We are devoloping!");
          getxsnackbar("updating!", "will coming soon!");

          // await Show(requestModel);
          setState(() {
            isApiCallProcess = false;
          });
        }
      } else {
        // for_market_price();
        getxsnackbar("We are Develop", "Please Try again");

        setState(() {
          isApiCallProcess = false;
        });
      }
    } on Exception catch (_) {
      // nodata("Please Try again");

      getxsnackbar("Connect is Slow", "Please Try again");
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  Future<void> getxsnackbar(title, subtitle) async {
    Get.snackbar(
      "",
      "",
      titleText: Text(title, style: TextStyle(fontSize: 14, color: greyColor)),
      messageText: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: greyColorNolot),
      ),
      colorText: Colors.black,
      padding: const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
      borderColor: const Color.fromARGB(255, 48, 47, 47),
      borderWidth: 1.0,
      borderRadius: 5,
      backgroundColor: const Color.fromARGB(255, 235, 242, 246),
      icon: const Icon(Icons.add_alert),
    );
  }

  bool clickdone = false;
  String priceCm = '';
  var avg;
  Future? Dialog(BuildContext context) {
    if (haveValue == true) {
      setState(() {
        // print("addingPriceSimple : $addingPriceSimple");
        // print("addingPriceVerbal : $addingPriceVerbal");
        var numberPrice = 0.0;
        for (int i = 0; i < data_adding_correct.length; i++) {
          numberPrice += double.parse(
            data_adding_correct[i]['comparable_adding_price'].toString(),
          );
        }
        adding_price = numberPrice;
        adding_price /= int.parse(data_adding_correct.length.toString());
        var price = (adding_price + (R_avg + C_avg)) / 2;
        min = price - (0.03 * price);
        max = price + (0.02 * price);
        avg = price;
        priceCm = price.toString();
      });
      return (!clickdone) ? showDailogs() : null;
    } else {
      setState(() {
        var numberPrice = 0.0;
        for (int i = 0; i < data_adding_correct.length; i++) {
          numberPrice += double.parse(
            data_adding_correct[i]['comparable_adding_price'].toString(),
          );
        }
        adding_price = numberPrice;
        adding_price /= int.parse(data_adding_correct.length.toString());
        // var price = (adding_price + R_avg) / 2;
        min = adding_price - (0.2 * adding_price);
        max = adding_price + (0.2 * adding_price);
        avg = adding_price;
      });
      return (!clickdone) ? showDailogs() : null;
    }
  }

  double fontsizes = 15;
  double add_min = 20.0, add_max = 20.0;
  var colorbackground = const Color.fromARGB(255, 242, 242, 244);
  double heightModel = 50;
  Future showDailogs() {
    return showDialog(
      context: context,
      // builder: (context) => AlertDialog(
      //   content: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text("adding_price : $adding_price"),
      //       Text("add_min : $add_min"),
      //       Text("add_max : $add_max"),
      //       Text("R_avg : $R_avg"),
      //       Text("minSqm1 : $minSqm1"),
      //       Text("maxSqm1 : $maxSqm1"),
      //       Text("C_avg : $C_avg"),
      //       Text("minSqm2 : $minSqm2"),
      //       Text("maxSqm2 : $maxSqm2"),
      //       Text("avg : $avg"),
      //       Text("min : $min"),
      //       Text("max : $max"),
      //       Text("data_adding_correct : ${data_adding_correct.length}"),
      //       Text("commune : $commune"),
      //       Text("district : $district"),
      //       Text("route : $route"),
      //     ],
      //   ),
      // ),
      builder: (context) => AlertDialogScreen(
          haveValue: haveValue,
          adding_price: adding_price,
          add_min: add_min,
          add_max: add_max,
          R_avg: R_avg,
          minSqm1: minSqm1,
          maxSqm1: maxSqm1,
          C_avg: C_avg,
          minSqm2: minSqm2,
          maxSqm2: maxSqm2,
          avg: avg,
          min: min!,
          max: max!,
          data_adding_correct: data_adding_correct,
          commune: commune,
          district: district,
          route: routeNo!),
    );
  }

  double fontsize = 10;
  Widget textPriceb(txt) {
    return Text(txt,
        style: TextStyle(
          fontSize: fontsize,
          color: colorsPrice,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget textPrice(txt) {
    return Text(txt, style: TextStyle(fontSize: fontsize, color: colorsPrice));
  }

  Widget textb(txt) {
    return Text(txt,
        style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: colorstitle));
  }

  Widget text(txt) {
    return Text(txt, style: TextStyle(fontSize: fontsize, color: colorstitle));
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

  TextEditingController addressController = TextEditingController();
  final TextEditingController controllerDrop = TextEditingController();
  final TextEditingController controllerDS = TextEditingController();
  final TextEditingController controllerArea = TextEditingController();

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  var commune, district;
  dynamic R_avg, C_avg;
  String? routeNo;
  var province;
  Future<void> findByPiont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$la,$lo&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

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
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                checkSk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_1") {
              province = (jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
            }
          }
        }

        if (jsonResponse['results'][j]['types'][0] == "route") {
          List r = jsonResponse['results'][j]['address_components'];
          for (int i = 0; i < r.length; i++) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "route") {
              setState(() {
                routeNo = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                if (routeNo != "Unnamed Road") {
                  checkborey = 0;
                  boreybutton = false;
                  listOptin = listRaodNBorey;
                  print("routeNo : $routeNo || checkborey : $checkborey");
                }
              });
            }
          }
        }
      }

      addressController.text =
          "${(province == "null") ? "" : province}, ${(district == "null") ? "" : district}, ${(commune == "null") ? "" : commune}, ${(routeNo == "null") ? "" : routeNo}";
      widget.get_province(addressController.text);
      if (checkFunction == false) {
        await checkKhatIDSangID(district, commune);
      }
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool waitngOne = false;
  int khanID = 0;
  int sangkatID = 0;
  Future<void> checkKhatIDSangID(district, commune) async {
    setState(() {
      for (int i = 0; i < controller.listKhanP.length; i++) {
        for (int j = 0; j < controller.listsang.length; j++) {
          if (controller.listKhanP[i]['Khan_Name'] == district &&
              controller.listsang[j]['Sangkat_Name'] == commune) {
            khanID = controller.listKhanP[i]['Khan_ID'];
            sangkatID = controller.listsang[j]['Sangkat_ID'];
          }
        }
      }
      for (int r = 0; r < controller.listPriceR.length; r++) {
        if (controller.listPriceR[r]['Sangkat_ID'] == sangkatID &&
            controller.listPriceR[r]['Khan_ID'] == khanID) {
          setState(() {
            maxSqm1 = controller.listPriceR[r]['Max_Value'].toString();
            minSqm1 = controller.listPriceR[r]['Min_Value'].toString();
          });
        }
      }
      for (int c = 0; c < controller.listPriceC.length; c++) {
        if (controller.listPriceC[c]['Sangkat_ID'] == sangkatID &&
            controller.listPriceC[c]['Khan_ID'] == khanID) {
          setState(() {
            maxSqm2 = controller.listPriceC[c]['Max_Value'].toString();
            minSqm2 = controller.listPriceC[c]['Min_Value'].toString();
          });
        }
      }

      R_avg = (double.parse(maxSqm1.toString()) +
              double.parse(minSqm1.toString())) /
          2;
      C_avg = (double.parse(maxSqm2.toString()) +
              double.parse(minSqm2.toString())) /
          2;
      print('No.3 R_avg : $R_avg || C_avg : $C_avg');
    });
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 11);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 12, fontWeight: FontWeight.bold);
  }
}
