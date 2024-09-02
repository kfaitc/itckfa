import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Option/components/property.dart';
import 'package:itckfa/Option/components/property35.dart';
import 'package:itckfa/models/search_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../Memory_local/database.dart';
import '../screens/AutoVerbal/dailog.dart';
import '../screens/AutoVerbal/local_Map/api/service.dart';
import '../screens/AutoVerbal/local_Map/data/MyDB.dart';
import 'colors.dart';
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
  List listMainRoute = [];
  List listRaod = [];
  List listPriceR = [];
  List listPriceC = [];
  List listKhanP = [];
  List listsang = [];
  List listOption = [];
  List listdropdown = [];
  Future<void> watingGoogleMap() async {
    setState(() {
      checkFunction = true;
    });
    await Future.wait([
      mainRaod(),
      roadModel(),
      checkPriceListR(),
      checkPriceListC(),
      khanModel(),
      sangkatIDModel(),
      optionFetch(),
      dropdown()
    ]);
    setState(() {
      checkFunction = false;
    });
  }

  Future<void> mainRaod() async {
    await myDBmap.createMainRaodT();
    listMainRoute = await myDBmap.db.rawQuery('SELECT * FROM mainRaod_Table');
    // print("No.1");
    if (listMainRoute.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/raods',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listMainRoute = response.data;
        for (var value in listMainRoute) {
          await myDBmap.db.rawInsert(
            "INSERT INTO mainRaod_Table(name_road) VALUES (?);",
            [value['name_road'].toString()],
          );
        }
      }
    }
  }

  Future<void> roadModel() async {
    await myDBmap.createRoadT();
    listRaod = await myDBmap.db.rawQuery('SELECT * FROM roads_Table');
    // print("No.1");
    if (listRaod.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/road',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listRaod = response.data['roads'];
        for (var value in listRaod) {
          await myDBmap.db.rawInsert(
            "INSERT INTO roads_Table(road_id,road_name) VALUES (?,?);",
            [value['road_id'], value['road_name'].toString()],
          );
        }
      }
    }
  }

  bool checkpoint = false;
  Future<void> checkPriceListR() async {
    await myDBmap.createlistRT();
    listPriceR = await myDBmap.db.rawQuery('SELECT * FROM listR_Table');
    // print("No.1");
    if (listPriceR.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price/listR',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listPriceR = response.data['r'];
        for (var value in listPriceR) {
          await myDBmap.db.rawInsert(
            "INSERT INTO listR_Table(Min_Value,Max_Value,Khan_ID,Sangkat_ID) VALUES (?,?,?,?);",
            [
              value['Min_Value'].toString(),
              value['Max_Value'].toString(),
              value['Khan_ID'],
              value['Sangkat_ID']
            ],
          );
        }
      }
    }
  }

  Future<void> checkPriceListC() async {
    await myDBmap.createlistCT();
    listPriceC = await myDBmap.db.rawQuery('SELECT * FROM listC_Table');
    // print("No.1");
    if (listPriceC.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price/listC',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listPriceC = response.data['c'];
        for (var value in listPriceC) {
          await myDBmap.db.rawInsert(
            "INSERT INTO listC_Table(Min_Value,Max_Value,Khan_ID,Sangkat_ID) VALUES (?,?,?,?);",
            [
              value['Min_Value'].toString(),
              value['Max_Value'].toString(),
              value['Khan_ID'],
              value['Sangkat_ID']
            ],
          );
        }
      }
    }
  }

  Future<void> khanModel() async {
    await myDBmap.createKhanT();
    listKhanP = await myDBmap.db.rawQuery('SELECT * FROM Khan_Table');
    // print("No.1");
    if (listKhanP.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan/list',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listKhanP = response.data;
        for (var value in listKhanP) {
          await myDBmap.db.rawInsert(
            "INSERT INTO Khan_Table(Khan_ID,province,Khan_Name) VALUES (?,?,?);",
            [
              value['Khan_ID'],
              value['province'].toString(),
              value['Khan_Name'].toString()
            ],
          );
        }
      }
    }
  }

  Future<void> sangkatIDModel() async {
    await myDBmap.createsangkatT();
    listsang = await myDBmap.db.rawQuery('SELECT * FROM sangkat_Table');
    // print("No.1");
    if (listsang.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat/list',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listsang = response.data;
        for (var value in listsang) {
          await myDBmap.db.rawInsert(
            "INSERT INTO sangkat_Table(Sangkat_ID,Sangkat_Name) VALUES (?,?);",
            [value['Sangkat_ID'], value['Sangkat_Name'].toString()],
          );
        }
      }
    }
  }

  Future<void> optionFetch() async {
    await myDBmap.createoptionT();
    listOption = await myDBmap.db.rawQuery('SELECT * FROM option_Table');
    // print("No.1");
    if (listOption.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listOption = response.data;
        for (var value in listOption) {
          await myDBmap.db.rawInsert(
            "INSERT INTO option_Table(opt_id,opt_des,opt_value) VALUES (?,?,?);",
            [value['opt_id'], value['opt_des'].toString(), value['opt_value']],
          );
        }
      }
    }
  }

  Future<void> dropdown() async {
    await myDBmap.createdropdownT();
    listdropdown = await myDBmap.db.rawQuery('SELECT * FROM dropdown_Table');
    // print("No.1");
    if (listdropdown.isEmpty) {
      // print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/compare/dropdown',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listdropdown = response.data;
        for (var value in listdropdown) {
          await myDBmap.db.rawInsert(
            "INSERT INTO dropdown_Table(id,title,name,type) VALUES (?,?,?,?);",
            [
              value['id'],
              value['title'].toString(),
              value['name'].toString(),
              value['type'].toString()
            ],
          );
        }
      }
    }
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

  API_Controller api_controller = API_Controller();
  @override
  void initState() {
    distanceController.text = '5';
    _handleLocationPermission();
    watingGoogleMap();
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
        ? MediaQuery.of(context).size.height * 0.35
        : MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      appBar: AppBar(
        title: Text("$haveValue"),
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
          InkWell(
            onTap: () {
              if (groupValue == 0) {
                Dialog(context);
              } else {
                for_market_price();
              }
            },
            child: Image.asset(
              "assets/icons/papersib.png",

              width: 30,
              // fit: BoxFit.fitHeight,
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
        route = "";
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
          // SizedBox(
          //   height: 18.0,
          // ),
          const Row(
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
          const SizedBox(height: 15),
          // RoadDropdown(
          //   onChanged: (value) {
          //     // requestModel.comparable_road = value;
          //     //  print(requestModel.comparable_road);
          //   },
          // ),

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
                    const Text("By Compereble", style: TextStyle(fontSize: 12))
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
                    const Text("By Market price",
                        style: TextStyle(fontSize: 12))
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
          const SizedBox(height: 10.0),
          if (groupValue == 0)
            NumDisplay(
              onSaved: (newValue) => setState(() {
                requestModel.num = newValue!;
              }),
            ),
          const SizedBox(height: 10.0),
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
                      const Text("Show All", style: TextStyle(fontSize: 12))
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
      route = "";
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
      route = "";
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
            if (checktypeMarker == false) {
              addMarker(argument);
              // getAddress(argument);
              await findByPiont(argument.latitude, argument.longitude);
              await Show(requestModel);
            } else {
              addManyMarkers(argument);
            }
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

      if (!seenPriceAndLatLog.contains(priceAndLatLogKey) &&
          !seenLatLog.contains(latLogKey)) {
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

                            items: listRaod
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

  String comparedropdown2 = '';
  int checkborey = 0;
  var id_route;
  bool doneORudone = false;
  List data_adding_correct = [];
  double? min, max;
  Map? map;
  bool haveValue = false;
  Future<void> Show(SearchRequestModel requestModel) async {
    try {
      if (groupValue == 0) {
        setState(() {
          isApiCallProcess = true;
        });
        print("==> No.0 Route : $route");
        if (route != null) {
          for (int i = 0; i < listMainRoute.length; i++) {
            if (route
                    .toString()
                    .contains(listMainRoute[i]['name_road'].toString()) ||
                comparedropdown == "C") {
              setState(() {
                // print("No.1 Route : ${listMainRoute[i]['name_road']}");
                haveValue = true;
              });

              break;
            } else {
              // print("No.2 Route : ${listMainRoute[i]['name_road']}");
            }
          }
        }
        setState(() {
          pty;
          if (haveValue == true) {
            id_route = '1';
            print("==> Main Road");
          } else {
            print("==> Sub Road");
            id_route = '2';
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
            if (list.length >= 5) {
              if (comparedropdown2 == "" && haveValue == true) {
                searchraod.text = listRaod.first['road_name']!;
                searchlatlog.text = listdropdown.first['type']!;
              } else if (comparedropdown2 == "" && haveValue == false) {
                searchraod.text = listRaod[1]['road_name']!;
                searchlatlog.text = listdropdown[1]['type']!;
              }
            }
          });
        }
        if (list.length >= 5) {
          List<dynamic> filteredList = filterDuplicates(
              list, "comparable_adding_price", "latlong_la", "latlong_log");

          setState(() {
            isApiCallProcess = false;
            map = filteredList.asMap();
          });

          setState(() {
            for (var i = 0; i < map!.length; i++) {
              if (i > 0) {
                if ((data_adding_correct.length ==
                        int.parse(requestModel.num)) ||
                    (i == map!.length - 1)) {
                  // print(
                  //     'ComID : ${map![i]['comparable_id']}\nPropertyID : ${map![i]['comparable_property_id']}');
                  break;
                } else {
                  if (checkborey == 1) {
                    if (map![i]['borey'] == 1) {
                      if (map![i]['comparable_adding_price'] == '') {
                        map![i]['comparable_adding_price'] = '0';
                        adding_price +=
                            double.parse(map![i]['comparable_adding_price']);
                      } else if (map![i]['comparable_adding_price']
                          .contains(',')) {
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
                  } else {
                    if (map![i]['comparable_adding_price'] == '') {
                      map![i]['comparable_adding_price'] = '0';
                      adding_price +=
                          double.parse(map![i]['comparable_adding_price']);
                    } else if (map![i]['comparable_adding_price']
                        .contains(',')) {
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
              } else {
                print("===> Else Check Borey");
                if (
                    // (map![i]['latlong_log'] != map![i + 1]['latlong_log']) &&
                    (map![i]['comparable_adding_price'] !=
                        map![i + 1]['comparable_adding_price'])) {
                  if (map![i]['comparable_adding_price'] == '') {
                    map![i]['comparable_adding_price'] = '0';
                    adding_price +=
                        double.parse(map![i]['comparable_adding_price']);
                  } else if (map![i]['comparable_adding_price'].contains(',')) {
                    adding_price += double.parse(
                        map![i]['comparable_adding_price'].replaceAll(",", ""));
                  } else {
                    adding_price +=
                        (double.parse(map![i]['comparable_adding_price']));
                  }
                  setState(() {
                    data_adding_correct.add(map![i]);
                  });
                }
              }
            }
          });

          if (data_adding_correct.isNotEmpty) {
            for (int i = 0; i < data_adding_correct.length; i++) {
              print(
                  "No.${data_adding_correct[i]['comparable_id']} : ${data_adding_correct[i]['comparable_property_id']}\n");
              if (data_adding_correct[i]['comparable_property_id'].toString() ==
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
          getxsnackbar("Please Try again", "");

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
      title,
      subtitle,
      colorText: Colors.black,
      padding: const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
      borderColor: const Color.fromARGB(255, 48, 47, 47),
      borderWidth: 1.0,
      borderRadius: 5,
      backgroundColor: const Color.fromARGB(255, 235, 242, 246),
      icon: const Icon(Icons.add_alert),
    );
  }

  String priceCm = '';
  var route, avg;
  Future Dialog(BuildContext context) {
    if (haveValue == true) {
      setState(() {
        var numberPrice = 0.0;
        for (int i = 0; i < data_adding_correct.length; i++) {
          numberPrice += double.parse(
              data_adding_correct[i]['comparable_adding_price'].toString());
        }
        adding_price = numberPrice;
        adding_price /= int.parse(data_adding_correct.length.toString());
        var price = (adding_price + (R_avg + C_avg)) / 2;
        min = price - (0.03 * price);
        max = price + (0.02 * price);
        // avg = price;
        avg = price;
        priceCm = price.toString();
        // print("${route.toString()}\n");
      });
      return showDailogs();
    } else {
      setState(() {
        var numberPrice = 0.0;
        for (int i = 0; i < data_adding_correct.length; i++) {
          numberPrice += double.parse(
              data_adding_correct[i]['comparable_adding_price'].toString());
        }
        adding_price = numberPrice;
        adding_price /= int.parse(data_adding_correct.length.toString());
        // var price = (adding_price + R_avg) / 2;
        min = adding_price - (0.3 * adding_price);
        max = adding_price + (0.2 * adding_price);
        avg = adding_price;
      });
      return showDailogs();
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
          route: route),
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
  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  var commune, district;
  dynamic R_avg, C_avg;
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
                route = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                print("route => $route");
              });
            }
          }
        }
      }

      addressController.text =
          "${(district == "null") ? "" : district}, ${(commune == "null") ? "" : commune}";
      if (checkFunction == false) {
        await checkKhatIDSangID(district, commune);
      }
    }
  }

  bool waitngOne = false;
  int khanID = 0;
  int sangkatID = 0;
  Future<void> checkKhatIDSangID(district, commune) async {
    setState(() {
      for (int i = 0; i < listKhanP.length; i++) {
        for (int j = 0; j < listsang.length; j++) {
          if (listKhanP[i]['Khan_Name'] == district &&
              listsang[j]['Sangkat_Name'] == commune) {
            khanID = listKhanP[i]['Khan_ID'];
            sangkatID = listsang[j]['Sangkat_ID'];
          }
        }
      }
      for (int r = 0; r < listPriceR.length; r++) {
        if (listPriceR[r]['Sangkat_ID'] == sangkatID &&
            listPriceR[r]['Khan_ID'] == khanID) {
          setState(() {
            maxSqm1 = listPriceR[r]['Max_Value'].toString();
            minSqm1 = listPriceR[r]['Min_Value'].toString();
          });
        }
      }
      for (int c = 0; c < listPriceC.length; c++) {
        if (listPriceC[c]['Sangkat_ID'] == sangkatID &&
            listPriceC[c]['Khan_ID'] == khanID) {
          setState(() {
            maxSqm2 = listPriceC[c]['Max_Value'].toString();
            minSqm2 = listPriceC[c]['Min_Value'].toString();
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
}
