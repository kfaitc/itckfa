// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print, unnecessary_new, prefer_collection_literals, unused_field, unused_element, unused_local_variable, prefer_is_empty, use_build_context_synchronously

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itckfa/afa/components/ToFromDate_ForSale.dart';

import '../Detail_Screen/Detail_all_list_Screen.dart';

typedef OnChangeCallback = void Function(dynamic value);

const kGoogleApiKey = 'AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class Map_List_search extends StatefulWidget {
  const Map_List_search({
    super.key,
    required this.get_province,
    required this.get_district,
    required this.get_commune,
    required this.get_log,
    required this.get_lat,
    required this.get_min1,
    required this.get_max1,
    required this.get_min2,
    required this.get_max2,
  });
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final OnChangeCallback get_min1;
  final OnChangeCallback get_max1;
  final OnChangeCallback get_min2;
  final OnChangeCallback get_max2;
  @override
  State<Map_List_search> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<Map_List_search> {
  String sendAddrress = '';

  final Set<Marker> _marker = new Set();
  var _selectedValue;
  List<String> option = [
    'Residencial',
    'Commercial',
    'Agricultural',
  ];
  GoogleMapController? mapController;

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

  double? lat1;
  double? log1;

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        ),
      ));
      lat1 = position.latitude;
      log1 = position.longitude;
      latLng = LatLng(lat1!, log1!);
      _addMarker(latLng);
    });
  }

  double? lat;
  double? log;
  Set<Polygon> _Find_polygons = HashSet<Polygon>();
  List<Color> FillColors = [
    Color.fromARGB(24, 252, 189, 0),
    Color.fromARGB(22, 155, 252, 0),
    Color.fromARGB(20, 0, 252, 42),
    Color.fromARGB(31, 0, 252, 218),
    Color.fromARGB(22, 181, 0, 252),
    Color.fromARGB(28, 252, 0, 55),
    Color.fromARGB(14, 160, 0, 252),
    Color.fromARGB(17, 21, 252, 0),
    Color.fromARGB(14, 252, 143, 0),
    Color.fromARGB(19, 252, 189, 0),
    Color.fromARGB(20, 0, 17, 252),
    Color.fromARGB(20, 252, 0, 0),
  ];
  List<String> Title = [
    "Khan Chamkar Mon",
    "Khan Daun Penh",
    "Khan 7 Makara",
    "Khan Tuol Kouk",
    "Khan Mean Chey",
    "Khan Chbar Ampov",
    "Khan Chroy Changvar",
    "Khan Sensok",
    "Khan Russey Keo",
    "Khan Dangkor",
    "Khan Pou Senchey",
    "Khan Preaek Pnov",
  ];

  List _pg = [];
  String? onTAP_MAP;
  double? lat_verbal;
  double? log_verbal;
  Uint8List? _imageFile;
  LatLng latLng = const LatLng(11.519037, 104.915120);
  CameraPosition? cameraPosition;

  Future<void> _addMarker(LatLng latLng) async {
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
        Find_by_piont(value.latitude, value.longitude);
        // print('marker');
      },
      onTap: () {
        AwesomeDialog(
          context: context,
          title: 'Property',
          desc: 'Which One?',
          btnOkText: 'For Rent',
          btnOkColor: Color.fromARGB(255, 17, 9, 123),
          btnCancelText: 'For Sale',
          btnCancelColor: Color.fromARGB(255, 57, 121, 12),
          btnOkOnPress: () {
            setState(() {
              choose_2 = 'For Rent';
              _marker.clear();
              _addMarker(latLng);
            });
            Get_data_verbal_sale();
          },
          btnCancelOnPress: () {
            setState(() {
              choose_2 = 'For Sale';
              _marker.clear();
              _addMarker(latLng);
            });
            Get_data_verbal_sale();
          },
        ).show();
      },
    );

    setState(() {
      _marker.add(newMarker);
      lat_verbal = latLng.latitude;
      log_verbal = latLng.longitude;
      Find_by_piont(latLng.latitude, latLng.longitude);
      log_verbal;
      lat_verbal;
      // print('Pointer');
      // print('lat = ${lat_verbal} and log =${log_verbal}');
      // add the new marker to the list of markers
    });
  }

  var formatter = NumberFormat("##,###,###,##0.00", "en_US");
  Future<void> _addMarker_by_datavelbal(LatLng latLng, String price, String bed,
      String Type, String bath, String vebal, List list_winget) async {
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(50, 50)), 'assets/images/pin.png'),
      infoWindow: InfoWindow(
          snippet: "${Type} More ...",
          onTap: () {
            // print('Ok');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Detail_property_sale_all(
                  list_get_sale: list_winget,
                  verbal_ID: vebal,
                ),
              ),
            );
          },
          title: 'Price:${price}\$ ~ bath:$bath ~ bed:$bed'),
    );
    setState(() {
      _marker.add(newMarker);
    });
  }

  String? start, end;
  int? number_for_count_verbal;
  List data_of_verbal = [];
  List data_of_price = [];
  Future<void> Get_data_verbal_sale() async {
    if (choose_2 == 'For Sale' && choose_2 != 'For Rent') {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_map/$lat_verbal/$log_verbal?start=$start&end=$end'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        setState(() {
          data_of_verbal = jsonResponse;
          data_of_verbal;

          // print('data = ${data_of_verbal}');
          for (int i = 0; i < data_of_verbal.length; i++) {
            _addMarker_by_datavelbal(
                LatLng(data_of_verbal[i]['lat'], data_of_verbal[i]['log']),
                data_of_verbal[i]['price'].toString(),
                data_of_verbal[i]['land'].toString(),
                data_of_verbal[i]['hometype'].toString(),
                data_of_verbal[i]['bath'].toString(),
                data_of_verbal[i]['id_ptys'].toString(),
                data_of_verbal);
          }
        });
      }
    } else {
      // print('For Rent');

      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_map_rent/$lat_verbal/$log_verbal?start=$start&end=$end'));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        setState(() {
          data_of_verbal = jsonResponse;
          data_of_verbal;
          // print('latlog Rent = ${data_of_verbal.toString()}');
          for (int i = 0; i < data_of_verbal.length; i++) {
            _addMarker_by_datavelbal(
                LatLng(data_of_verbal[i]['lat'], data_of_verbal[i]['log']),
                data_of_verbal[i]['price'].toString(),
                data_of_verbal[i]['land'].toString(),
                data_of_verbal[i]['hometype'].toString(),
                data_of_verbal[i]['bath'].toString(),
                data_of_verbal[i]['id_ptys'].toString(),
                data_of_verbal);
          }
        });
      }
    }
  }

  List data_of_verbal_rent = [];

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;

  int num = 0;
  double h = 0;
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
  String? choose_2;
  TextEditingController Tcon = new TextEditingController();
  int index = 0;
  String? name_of_place;
  GlobalKey<FormState> check = GlobalKey<FormState>();
  var input;
  double? wth;
  double? wth2;
  ScrollController? controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    if (w < 600) {
      wth = w * 0.8;
      wth2 = w * 0.5;
    } else {
      wth = w * 0.5;
      wth2 = w * 0.3;
    }
    if (index_map != null) {
      _Find_polygons.add(
        Polygon(
          visible: false,
          polygonId: PolygonId("${index_map! - 1}"),
          points: _pg.elementAt(index_map! - 1),
          fillColor: FillColors.elementAt(index_map! - 1),
          strokeWidth: 2,
          strokeColor: Color.fromARGB(160, 190, 30, 30),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 20, 163),
        centerTitle: true,
        title: const Text(
          "KFA's Map for verbal check",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            SizedBox(
                child: GoogleMap(
              initialCameraPosition: CameraPosition(target: latLng, zoom: 12),
              polygons: _Find_polygons,
              // markers: Set.from(_marker),
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              markers: _marker.map((e) => e).toSet(),

              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona; //when map is dragging
              },
              mapType: style_map[index],
              onTap: (argument) {
                setState(() {
                  _marker.clear();
                  lat_verbal = argument.latitude;
                  log_verbal = argument.longitude;
                  widget.get_lat(argument.latitude.toString());
                  widget.get_log(argument.longitude.toString());
                  _addMarker(argument);
                });
              },
            )),
            Container(
              width: wth,
              margin: EdgeInsets.only(
                right: 70,
                top: 10,
              ),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Form(
                key: check,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: wth2,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Tcon,
                        onFieldSubmitted: (value) {
                          setState(() {
                            h = 0;
                            input = value;
                            if (num == 0) {
                              Find_Lat_log(value);
                            }
                          });
                        },
                        onChanged: (value) {
                          // name_place.clear();
                          setState(() {
                            input = value;
                            name_place.clear();
                            lg.clear();
                            ln.clear();
                            h = 0;
                            num = 0;
                            get_name_search(value);
                          });
                        },
                        textInputAction: TextInputAction.search,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Search",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 2),
                          hintStyle: TextStyle(
                            color: Colors.grey[850],
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 0.04,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        // splashRadius: 30,
                        hoverColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            name_place.clear();
                            lg.clear();
                            ln.clear();

                            h = 0;
                            num = 0;
                            Find_Lat_log(input);
                          });
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _getCurrentLocation();
                          });
                        },
                        icon: Icon(Icons.person_pin_circle_outlined))
                  ],
                ),
              ),
            ),
            if (name_place.length >= 1)
              Container(
                height: h,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, right: 55, top: 60),
                child: ListView.builder(
                  itemCount: name_place.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: InkWell(
                        onTap: () {
                          Tcon;
                          // print(name_place[index]);
                          h = 0;
                          Tcon;
                          num = 1; // use num for when user click on list search
                          name_of_place != name_place[index].toString();
                          poin_map_by_search(
                              ln[index].toString(), lg[index].toString());
                        },
                        child: Text(
                          name_place[index],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
            Positioned(
              right: 10,
              top: 15,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 21,
                child: IconButton(
                  icon: const Icon(
                    Icons.mp_sharp,
                    color: Color.fromRGBO(0, 184, 212, 1),
                    size: 25,
                  ),
                  onPressed: () {
                    setState(() {
                      if (index < 1) {
                        index = index + 1;
                      } else {
                        index = 0;
                      }
                    });
                  },
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ToFromDate_p(
                      fromDate: (value) {
                        setState(() {
                          start = value.toString();
                          start;
                        });
                      },
                      toDate: (value) {
                        setState(() {
                          end = value.toString();
                          end;
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int? index_map;
  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      lat_verbal = double.parse(lati.toString());
      log_verbal = double.parse(longi.toString());
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
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                // Load_sangkat(commune);
                widget.get_commune(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
          }
        }
      }
    } else {
      // Error or invalid response
      // print(response.statusCode);
    }
  }

  List name_place = [];
  Future<void> Find_Lat_log(var place) async {
    var check_charetor = place.split(',');
    if (check_charetor.length == 1) {
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=${check_charetor[0]}&region=kh&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
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
              // print('Value ');
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

  final Set<Marker> marker = Set(); //163
  List ln = [];
  List lg = [];
  Future<void> get_name_search(var name) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=${name}&radius=1000&language=km&region=KH&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI&libraries=places';
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    List ls = jsonResponse['results'];
    List ac;
    for (int j = 0; j < ls.length; j++) {
      // ac = ls[j]['formatted_address'];

      var name = ls[j]['name'].toString();
      var data_lnlg = jsonResponse['results'][j]['geometry']['location'];
      if (h == 0 || h < 250) {
        h += 40;
      }
      lg.add(data_lnlg["lat"]);
      ln.add(data_lnlg["lng"]);
      setState(() {
        name_place.add(name);
      });
    }
  }

  Future<void> poin_map_by_search(var ln, var lg) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lg},${ln}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
    var jsonResponse = json.decode(response.body);
    latLng = LatLng(double.parse(lg), double.parse(ln));
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
      lat_verbal = latLng.latitude;
      log_verbal = latLng.longitude;
      _marker.add(newMarker);
    });
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 13)));
    List ls = jsonResponse['results'];
    List ac;
    for (int j = 0; j < ls.length; j++) {
      ac = jsonResponse['results'][j]['address_components'];
      for (int i = 0; i < ac.length; i++) {
        if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
            "administrative_area_level_3") {
          setState(() {});
        }
        if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
            "administrative_area_level_2") {
          setState(() {});
        }
      }
    }
  }

  Future<dynamic> maker_of_verbal_in_map(
      List data_latlog, List values_min, List values_max) async {
    for (int i = 0; i < data_latlog.length; i++) {
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(i.toString()),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(80, 80)), 'assets/images/pin.png'),
        position:
            LatLng(data_latlog[i]['latlong_log'], data_latlog[i]['latlong_la']),
        infoWindow: InfoWindow(
            title:
                '${values_min[i].toString()}\$ ~ ${values_max[i].toString()}\$'),
      );
      setState(() {
        _marker.add(newMarker);
      });
    }
  }
}
