// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itckfa/afa/components/ToFromDate.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/screen/Customs/form.dart';
import 'package:itckfa/screen/components/map_all/detail_verbal_by_id.dart';

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

  // Future<void> _getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   setState(() {
  //     mapController!.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(position.latitude, position.longitude),
  //         zoom: 16.0,
  //       ),
  //     ));
  //     lat1 = position.latitude;
  //     log1 = position.longitude;
  //     latLng = LatLng(lat1!, log1!);
  //     _addMarker(latLng);
  //   });
  // }
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
      latLng = LatLng(position.latitude, position.longitude);
      _addMarker(latLng);
    });
  }

  //  Future<void> _getCurrentLocation() async {
  //   P
  //  }

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
  void _setPolygons() {
    //ខ័ណ្ឌជ្រោយចង្វា
    List<LatLng> CHROUY_CHANGVA = <LatLng>[];
    CHROUY_CHANGVA.add(LatLng(11.671157, 104.861930));
    CHROUY_CHANGVA.add(LatLng(11.672557, 104.862785));
    CHROUY_CHANGVA.add(LatLng(11.672619, 104.878829));
    CHROUY_CHANGVA.add(LatLng(11.672294, 104.885055));
    CHROUY_CHANGVA.add(LatLng(11.672594, 104.899549));
    CHROUY_CHANGVA.add(LatLng(11.682990, 104.899855));
    CHROUY_CHANGVA.add(LatLng(11.683839, 104.899817));
    CHROUY_CHANGVA.add(LatLng(11.684727, 104.898465));
    CHROUY_CHANGVA.add(LatLng(11.685226, 104.897903));
    CHROUY_CHANGVA.add(LatLng(11.686938, 104.898656));
    CHROUY_CHANGVA.add(LatLng(11.688412, 104.899957));
    CHROUY_CHANGVA.add(LatLng(11.691411, 104.900480));
    CHROUY_CHANGVA.add(LatLng(11.695784, 104.905737));
    CHROUY_CHANGVA.add(LatLng(11.700348, 104.909264));
    CHROUY_CHANGVA.add(LatLng(11.704960, 104.910058));
    CHROUY_CHANGVA.add(LatLng(11.707875, 104.910798));
    CHROUY_CHANGVA.add(LatLng(11.712504, 104.912530));
    CHROUY_CHANGVA.add(LatLng(11.715401, 104.915345));
    CHROUY_CHANGVA.add(LatLng(11.717840, 104.916752));
    CHROUY_CHANGVA.add(LatLng(11.725295, 104.917690));
    CHROUY_CHANGVA.add(LatLng(11.732645, 104.917618));
    CHROUY_CHANGVA.add(LatLng(11.736355, 104.917474));
    CHROUY_CHANGVA.add(LatLng(11.736496, 104.920794));
    CHROUY_CHANGVA.add(LatLng(11.736143, 104.923284));
    CHROUY_CHANGVA.add(LatLng(11.735895, 104.940173));
    CHROUY_CHANGVA.add(LatLng(11.735259, 104.943204));
    CHROUY_CHANGVA.add(LatLng(11.734553, 104.945550));
    CHROUY_CHANGVA.add(LatLng(11.732998, 104.947210));
    CHROUY_CHANGVA.add(LatLng(11.726037, 104.949231));
    CHROUY_CHANGVA.add(LatLng(11.721974, 104.952298));
    CHROUY_CHANGVA.add(LatLng(11.716885, 104.957278));
    CHROUY_CHANGVA.add(LatLng(11.715631, 104.958397));
    CHROUY_CHANGVA.add(LatLng(11.711780, 104.960238));
    CHROUY_CHANGVA.add(LatLng(11.711073, 104.963630));
    CHROUY_CHANGVA.add(LatLng(11.710896, 104.967599));
    CHROUY_CHANGVA.add(LatLng(11.697009, 104.963666));
    CHROUY_CHANGVA.add(LatLng(11.690082, 104.962367));
    CHROUY_CHANGVA.add(LatLng(11.678951, 104.958108));
    CHROUY_CHANGVA.add(LatLng(11.675169, 104.954536));
    CHROUY_CHANGVA.add(LatLng(11.669291, 104.951973));
    CHROUY_CHANGVA.add(LatLng(11.655145, 104.946814));
    CHROUY_CHANGVA.add(LatLng(11.651994, 104.943840));
    CHROUY_CHANGVA.add(LatLng(11.648071, 104.941898));
    CHROUY_CHANGVA.add(LatLng(11.642454, 104.937801));
    CHROUY_CHANGVA.add(LatLng(11.639125, 104.936284));
    CHROUY_CHANGVA.add(LatLng(11.631249, 104.933917));
    CHROUY_CHANGVA.add(LatLng(11.623759, 104.932263));
    CHROUY_CHANGVA.add(LatLng(11.611141, 104.935465));
    CHROUY_CHANGVA.add(LatLng(11.605671, 104.939167));
    CHROUY_CHANGVA.add(LatLng(11.600707, 104.939258));
    CHROUY_CHANGVA.add(LatLng(11.592606, 104.942567));
    CHROUY_CHANGVA.add(LatLng(11.588970, 104.943426));
    CHROUY_CHANGVA.add(LatLng(11.577500, 104.945031));
    CHROUY_CHANGVA.add(LatLng(11.563186, 104.945948));
    CHROUY_CHANGVA.add(LatLng(11.562260, 104.942317));
    CHROUY_CHANGVA.add(LatLng(11.563085, 104.939280));
    CHROUY_CHANGVA.add(LatLng(11.563660, 104.938055));
    CHROUY_CHANGVA.add(LatLng(11.587451, 104.922480));
    CHROUY_CHANGVA.add(LatLng(11.588617, 104.923599));
    CHROUY_CHANGVA.add(LatLng(11.589996, 104.922949));
    CHROUY_CHANGVA.add(LatLng(11.591587, 104.922552));
    CHROUY_CHANGVA.add(LatLng(11.593920, 104.922408));
    CHROUY_CHANGVA.add(LatLng(11.598480, 104.922877));
    CHROUY_CHANGVA.add(LatLng(11.602298, 104.923274));
    CHROUY_CHANGVA.add(LatLng(11.604490, 104.923274));
    CHROUY_CHANGVA.add(LatLng(11.606823, 104.923057));
    CHROUY_CHANGVA.add(LatLng(11.609403, 104.922985));
    CHROUY_CHANGVA.add(LatLng(11.611242, 104.922733));
    CHROUY_CHANGVA.add(LatLng(11.613822, 104.921975));
    CHROUY_CHANGVA.add(LatLng(11.616261, 104.921000));
    CHROUY_CHANGVA.add(LatLng(11.623401, 104.916237));
    CHROUY_CHANGVA.add(LatLng(11.626123, 104.914432));
    CHROUY_CHANGVA.add(LatLng(11.629905, 104.911040));
    CHROUY_CHANGVA.add(LatLng(11.633016, 104.908370));
    CHROUY_CHANGVA.add(LatLng(11.637292, 104.902415));
    CHROUY_CHANGVA.add(LatLng(11.638848, 104.899059));
    CHROUY_CHANGVA.add(LatLng(11.641357, 104.891553));
    CHROUY_CHANGVA.add(LatLng(11.643725, 104.885923));
    CHROUY_CHANGVA.add(LatLng(11.645634, 104.882206));
    CHROUY_CHANGVA.add(LatLng(11.648850, 104.877840));
    CHROUY_CHANGVA.add(LatLng(11.651254, 104.875386));
    CHROUY_CHANGVA.add(LatLng(11.656272, 104.871561));
    CHROUY_CHANGVA.add(LatLng(11.664330, 104.866869));
    CHROUY_CHANGVA.add(LatLng(11.667299, 104.864848));
// ខ័ណ្ឌព្រែកព្នៅ
    List<LatLng> Khan_Preaek_Pnov = <LatLng>[];
    Khan_Preaek_Pnov.add(LatLng(11.657514, 104.866861));
    Khan_Preaek_Pnov.add(LatLng(11.665511, 104.861553));
    Khan_Preaek_Pnov.add(LatLng(11.675207, 104.853490));
    Khan_Preaek_Pnov.add(LatLng(11.682077, 104.849790));
    Khan_Preaek_Pnov.add(LatLng(11.688296, 104.846657));
    Khan_Preaek_Pnov.add(LatLng(11.699685, 104.841508));
    Khan_Preaek_Pnov.add(LatLng(11.705106, 104.839533));
    Khan_Preaek_Pnov.add(LatLng(11.713721, 104.837946));
    Khan_Preaek_Pnov.add(LatLng(11.714267, 104.837688));
    Khan_Preaek_Pnov.add(LatLng(11.715402, 104.837388));
    Khan_Preaek_Pnov.add(LatLng(11.715570, 104.836744));
    Khan_Preaek_Pnov.add(LatLng(11.715696, 104.827131));
    Khan_Preaek_Pnov.add(LatLng(11.715360, 104.823140));
    Khan_Preaek_Pnov.add(LatLng(11.715065, 104.822668));
    Khan_Preaek_Pnov.add(LatLng(11.713595, 104.821380));
    Khan_Preaek_Pnov.add(LatLng(11.713027, 104.822367));
    Khan_Preaek_Pnov.add(LatLng(11.711851, 104.823322));
    Khan_Preaek_Pnov.add(LatLng(11.710275, 104.824030));
    Khan_Preaek_Pnov.add(LatLng(11.707985, 104.823151));
    Khan_Preaek_Pnov.add(LatLng(11.708699, 104.819331));
    Khan_Preaek_Pnov.add(LatLng(11.708405, 104.818344));
    Khan_Preaek_Pnov.add(LatLng(11.706934, 104.817743));
    Khan_Preaek_Pnov.add(LatLng(11.705673, 104.816370));
    Khan_Preaek_Pnov.add(LatLng(11.703845, 104.815361));
    Khan_Preaek_Pnov.add(LatLng(11.699559, 104.815984));
    Khan_Preaek_Pnov.add(LatLng(11.697563, 104.815211));
    Khan_Preaek_Pnov.add(LatLng(11.696344, 104.815297));
    Khan_Preaek_Pnov.add(LatLng(11.694264, 104.814932));
    Khan_Preaek_Pnov.add(LatLng(11.691343, 104.814675));
    Khan_Preaek_Pnov.add(LatLng(11.689263, 104.817142));
    Khan_Preaek_Pnov.add(LatLng(11.688339, 104.817057));
    Khan_Preaek_Pnov.add(LatLng(11.686363, 104.815576));
    Khan_Preaek_Pnov.add(LatLng(11.683842, 104.813108));
    Khan_Preaek_Pnov.add(LatLng(11.681299, 104.811306));
    Khan_Preaek_Pnov.add(LatLng(11.678462, 104.810083));
    Khan_Preaek_Pnov.add(LatLng(11.677096, 104.810276));
    Khan_Preaek_Pnov.add(LatLng(11.675604, 104.811306));
    Khan_Preaek_Pnov.add(LatLng(11.674449, 104.812894));
    Khan_Preaek_Pnov.add(LatLng(11.673944, 104.813731));
    Khan_Preaek_Pnov.add(LatLng(11.673125, 104.812143));
    Khan_Preaek_Pnov.add(LatLng(11.672915, 104.810040));
    Khan_Preaek_Pnov.add(LatLng(11.673062, 104.806156));
    Khan_Preaek_Pnov.add(LatLng(11.672739, 104.802303));
    Khan_Preaek_Pnov.add(LatLng(11.672633, 104.800679));
    Khan_Preaek_Pnov.add(LatLng(11.671802, 104.799182));
    Khan_Preaek_Pnov.add(LatLng(11.671449, 104.797143));
    Khan_Preaek_Pnov.add(LatLng(11.672315, 104.794400));
    Khan_Preaek_Pnov.add(LatLng(11.671378, 104.784783));
    Khan_Preaek_Pnov.add(LatLng(11.671378, 104.781030));
    Khan_Preaek_Pnov.add(LatLng(11.669964, 104.779803));
    Khan_Preaek_Pnov.add(LatLng(11.669434, 104.776230));
    Khan_Preaek_Pnov.add(LatLng(11.667968, 104.769807));
    Khan_Preaek_Pnov.add(LatLng(11.666554, 104.766938));
    Khan_Preaek_Pnov.add(LatLng(11.666095, 104.753351));
    Khan_Preaek_Pnov.add(LatLng(11.665653, 104.751492));
    Khan_Preaek_Pnov.add(LatLng(11.664928, 104.749886));
    Khan_Preaek_Pnov.add(LatLng(11.663939, 104.748605));
    Khan_Preaek_Pnov.add(LatLng(11.659795, 104.747411));
    Khan_Preaek_Pnov.add(LatLng(11.656737, 104.748241));
    Khan_Preaek_Pnov.add(LatLng(11.653233, 104.747068));
    Khan_Preaek_Pnov.add(LatLng(11.653163, 104.746328));
    Khan_Preaek_Pnov.add(LatLng(11.647985, 104.742593));
    Khan_Preaek_Pnov.add(LatLng(11.641835, 104.743820));
    Khan_Preaek_Pnov.add(LatLng(11.639343, 104.744001));
    Khan_Preaek_Pnov.add(LatLng(11.635667, 104.743045));
    Khan_Preaek_Pnov.add(LatLng(11.629340, 104.742034));
    Khan_Preaek_Pnov.add(LatLng(11.625682, 104.740933));
    Khan_Preaek_Pnov.add(LatLng(11.621263, 104.740266));
    Khan_Preaek_Pnov.add(LatLng(11.615908, 104.738389));
    Khan_Preaek_Pnov.add(LatLng(11.613540, 104.737234));
    Khan_Preaek_Pnov.add(LatLng(11.608043, 104.734907));
    Khan_Preaek_Pnov.add(LatLng(11.606859, 104.734492));
    Khan_Preaek_Pnov.add(LatLng(11.604579, 104.734582));
    Khan_Preaek_Pnov.add(LatLng(11.600796, 104.736134));
    Khan_Preaek_Pnov.add(LatLng(11.599312, 104.736116));
    Khan_Preaek_Pnov.add(LatLng(11.596696, 104.734907));
    Khan_Preaek_Pnov.add(LatLng(11.594451, 104.733391));
    Khan_Preaek_Pnov.add(LatLng(11.593408, 104.732453));
    Khan_Preaek_Pnov.add(LatLng(11.591853, 104.731677));
    Khan_Preaek_Pnov.add(LatLng(11.590288, 104.731686));
    Khan_Preaek_Pnov.add(LatLng(11.586382, 104.732841));
    Khan_Preaek_Pnov.add(LatLng(11.584420, 104.734104));
    Khan_Preaek_Pnov.add(LatLng(11.583289, 104.734447));
    Khan_Preaek_Pnov.add(LatLng(11.581839, 104.735529));
    Khan_Preaek_Pnov.add(LatLng(11.583006, 104.736377));
    Khan_Preaek_Pnov.add(LatLng(11.583359, 104.737785));
    Khan_Preaek_Pnov.add(LatLng(11.583076, 104.739228));
    Khan_Preaek_Pnov.add(LatLng(11.583324, 104.740022));
    Khan_Preaek_Pnov.add(LatLng(11.588839, 104.741754));
    Khan_Preaek_Pnov.add(LatLng(11.589475, 104.742332));
    Khan_Preaek_Pnov.add(LatLng(11.589528, 104.744443));
    Khan_Preaek_Pnov.add(LatLng(11.589652, 104.745363));
    Khan_Preaek_Pnov.add(LatLng(11.590624, 104.746157));
    Khan_Preaek_Pnov.add(LatLng(11.590394, 104.747186));
    Khan_Preaek_Pnov.add(LatLng(11.590571, 104.748593));
    Khan_Preaek_Pnov.add(LatLng(11.591278, 104.750650));
    Khan_Preaek_Pnov.add(LatLng(11.590324, 104.751877));
    Khan_Preaek_Pnov.add(LatLng(11.591119, 104.752617));
    Khan_Preaek_Pnov.add(LatLng(11.591437, 104.753266));
    Khan_Preaek_Pnov.add(LatLng(11.590995, 104.754241));
    Khan_Preaek_Pnov.add(LatLng(11.591879, 104.754872));
    Khan_Preaek_Pnov.add(LatLng(11.591561, 104.755432));
    Khan_Preaek_Pnov.add(LatLng(11.590925, 104.755792));
    Khan_Preaek_Pnov.add(LatLng(11.590642, 104.757055));
    Khan_Preaek_Pnov.add(LatLng(11.590606, 104.757669));
    Khan_Preaek_Pnov.add(LatLng(11.590854, 104.759203));
    Khan_Preaek_Pnov.add(LatLng(11.592009, 104.761172));
    Khan_Preaek_Pnov.add(LatLng(11.591925, 104.762760));
    Khan_Preaek_Pnov.add(LatLng(11.592619, 104.765421));
    Khan_Preaek_Pnov.add(LatLng(11.592892, 104.768403));
    Khan_Preaek_Pnov.add(LatLng(11.593355, 104.770485));
    Khan_Preaek_Pnov.add(LatLng(11.593880, 104.771922));
    Khan_Preaek_Pnov.add(LatLng(11.594973, 104.772781));
    Khan_Preaek_Pnov.add(LatLng(11.595667, 104.773768));
    Khan_Preaek_Pnov.add(LatLng(11.597075, 104.774712));
    Khan_Preaek_Pnov.add(LatLng(11.598484, 104.775999));
    Khan_Preaek_Pnov.add(LatLng(11.598420, 104.777630));
    Khan_Preaek_Pnov.add(LatLng(11.599261, 104.778381));
    Khan_Preaek_Pnov.add(LatLng(11.602603, 104.778295));
    Khan_Preaek_Pnov.add(LatLng(11.605126, 104.779733));
    Khan_Preaek_Pnov.add(LatLng(11.605357, 104.780377));
    Khan_Preaek_Pnov.add(LatLng(11.605273, 104.781707));
    Khan_Preaek_Pnov.add(LatLng(11.605966, 104.782394));
    Khan_Preaek_Pnov.add(LatLng(11.607354, 104.782995));
    Khan_Preaek_Pnov.add(LatLng(11.608804, 104.784261));
    Khan_Preaek_Pnov.add(LatLng(11.609960, 104.784454));
    Khan_Preaek_Pnov.add(LatLng(11.610317, 104.786213));
    Khan_Preaek_Pnov.add(LatLng(11.609708, 104.786986));
    Khan_Preaek_Pnov.add(LatLng(11.608363, 104.789861));
    Khan_Preaek_Pnov.add(LatLng(11.603886, 104.797114));
    Khan_Preaek_Pnov.add(LatLng(11.595166, 104.799492));
    Khan_Preaek_Pnov.add(LatLng(11.591319, 104.799899));
    Khan_Preaek_Pnov.add(LatLng(11.586632, 104.801015));
    Khan_Preaek_Pnov.add(LatLng(11.585475, 104.802195));
    Khan_Preaek_Pnov.add(LatLng(11.584487, 104.804084));
    Khan_Preaek_Pnov.add(LatLng(11.583205, 104.804835));
    Khan_Preaek_Pnov.add(LatLng(11.581776, 104.807238));
    Khan_Preaek_Pnov.add(LatLng(11.580662, 104.808204));
    Khan_Preaek_Pnov.add(LatLng(11.579968, 104.809233));
    Khan_Preaek_Pnov.add(LatLng(11.579590, 104.810864));
    Khan_Preaek_Pnov.add(LatLng(11.579383, 104.823513));
    Khan_Preaek_Pnov.add(LatLng(11.580045, 104.824419));
    Khan_Preaek_Pnov.add(LatLng(11.581970, 104.826078));
    Khan_Preaek_Pnov.add(LatLng(11.586095, 104.830033));
    Khan_Preaek_Pnov.add(LatLng(11.588545, 104.831564));
    Khan_Preaek_Pnov.add(LatLng(11.593007, 104.832636));
    Khan_Preaek_Pnov.add(LatLng(11.595844, 104.833044));
    Khan_Preaek_Pnov.add(LatLng(11.599981, 104.832534));
    Khan_Preaek_Pnov.add(LatLng(11.602293, 104.832521));
    Khan_Preaek_Pnov.add(LatLng(11.605630, 104.832993));
    Khan_Preaek_Pnov.add(LatLng(11.609529, 104.832751));
    Khan_Preaek_Pnov.add(LatLng(11.612079, 104.832904));
    Khan_Preaek_Pnov.add(LatLng(11.614303, 104.833963));
    Khan_Preaek_Pnov.add(LatLng(11.617365, 104.835098));
    Khan_Preaek_Pnov.add(LatLng(11.618709, 104.835851));
    Khan_Preaek_Pnov.add(LatLng(11.619421, 104.837714));
    Khan_Preaek_Pnov.add(LatLng(11.620321, 104.838620));
    Khan_Preaek_Pnov.add(LatLng(11.634705, 104.836272));
//Khan_Russey_Keo
    List<LatLng> Khan_Russey_Keo = <LatLng>[];
    Khan_Russey_Keo.add(LatLng(11.657242, 104.866782));
    Khan_Russey_Keo.add(LatLng(11.649813, 104.856219));
    Khan_Russey_Keo.add(LatLng(11.648721, 104.857060));
    Khan_Russey_Keo.add(LatLng(11.648308, 104.857877));
    Khan_Russey_Keo.add(LatLng(11.648521, 104.861220));
    Khan_Russey_Keo.add(LatLng(11.643447, 104.863401));
    Khan_Russey_Keo.add(LatLng(11.643131, 104.865789));
    Khan_Russey_Keo.add(LatLng(11.643161, 104.867921));
    Khan_Russey_Keo.add(LatLng(11.642945, 104.868536));
    Khan_Russey_Keo.add(LatLng(11.643145, 104.868955));
    Khan_Russey_Keo.add(LatLng(11.642971, 104.869059));
    Khan_Russey_Keo.add(LatLng(11.642697, 104.869311));
    Khan_Russey_Keo.add(LatLng(11.642367, 104.870013));
    Khan_Russey_Keo.add(LatLng(11.640606, 104.871784));
    Khan_Russey_Keo.add(LatLng(11.638770, 104.872922));
    Khan_Russey_Keo.add(LatLng(11.636504, 104.873969));
    Khan_Russey_Keo.add(LatLng(11.634699, 104.874455));
    Khan_Russey_Keo.add(LatLng(11.632588, 104.874015));
    Khan_Russey_Keo.add(LatLng(11.629765, 104.871890));
    Khan_Russey_Keo.add(LatLng(11.627379, 104.871648));
    Khan_Russey_Keo.add(LatLng(11.624296, 104.872126));
    Khan_Russey_Keo.add(LatLng(11.623709, 104.872998));
    Khan_Russey_Keo.add(LatLng(11.624511, 104.875046));
    Khan_Russey_Keo.add(LatLng(11.624504, 104.875608));
    Khan_Russey_Keo.add(LatLng(11.624501, 104.875922));
    Khan_Russey_Keo.add(LatLng(11.624451, 104.877340));
    Khan_Russey_Keo.add(LatLng(11.622580, 104.877930));
    Khan_Russey_Keo.add(LatLng(11.621065, 104.878091));
    Khan_Russey_Keo.add(LatLng(11.620946, 104.878187));
    Khan_Russey_Keo.add(LatLng(11.620447, 104.878966));
    Khan_Russey_Keo.add(LatLng(11.619653, 104.879214));
    Khan_Russey_Keo.add(LatLng(11.617004, 104.881256));
    Khan_Russey_Keo.add(LatLng(11.615467, 104.882104));
    Khan_Russey_Keo.add(LatLng(11.614685, 104.882359));
    Khan_Russey_Keo.add(LatLng(11.613967, 104.883597));
    Khan_Russey_Keo.add(LatLng(11.612530, 104.885122));
    Khan_Russey_Keo.add(LatLng(11.611036, 104.885702));
    Khan_Russey_Keo.add(LatLng(11.609149, 104.885753));
    Khan_Russey_Keo.add(LatLng(11.607624, 104.885658));
    Khan_Russey_Keo.add(LatLng(11.590327, 104.896356));
    Khan_Russey_Keo.add(LatLng(11.590877, 104.897619));
    Khan_Russey_Keo.add(LatLng(11.585747, 104.900796));
    Khan_Russey_Keo.add(LatLng(11.583288, 104.907941));
    Khan_Russey_Keo.add(LatLng(11.584486, 104.911503));
    Khan_Russey_Keo.add(LatLng(11.585012, 104.914507));
    Khan_Russey_Keo.add(LatLng(11.587849, 104.914550));
    Khan_Russey_Keo.add(LatLng(11.588186, 104.915945));
    Khan_Russey_Keo.add(LatLng(11.588627, 104.918177));
    Khan_Russey_Keo.add(LatLng(11.588690, 104.919722));
    Khan_Russey_Keo.add(LatLng(11.593062, 104.919121));
    Khan_Russey_Keo.add(LatLng(11.595648, 104.919035));
    Khan_Russey_Keo.add(LatLng(11.600272, 104.919250));
    Khan_Russey_Keo.add(LatLng(11.604392, 104.919292));
    Khan_Russey_Keo.add(LatLng(11.608806, 104.919228));
    Khan_Russey_Keo.add(LatLng(11.611875, 104.918777));
    Khan_Russey_Keo.add(LatLng(11.615658, 104.917597));
    Khan_Russey_Keo.add(LatLng(11.618243, 104.916589));
    Khan_Russey_Keo.add(LatLng(11.618558, 104.916245));
    Khan_Russey_Keo.add(LatLng(11.618821, 104.916235));
    Khan_Russey_Keo.add(LatLng(11.621711, 104.914078));
    Khan_Russey_Keo.add(LatLng(11.623298, 104.912694));
    Khan_Russey_Keo.add(LatLng(11.626608, 104.909722));
    Khan_Russey_Keo.add(LatLng(11.629708, 104.906718));
    Khan_Russey_Keo.add(LatLng(11.631295, 104.904862));
    Khan_Russey_Keo.add(LatLng(11.633386, 104.901858));
    Khan_Russey_Keo.add(LatLng(11.634689, 104.899369));
    Khan_Russey_Keo.add(LatLng(11.635898, 104.896247));
    Khan_Russey_Keo.add(LatLng(11.636917, 104.893254));
    Khan_Russey_Keo.add(LatLng(11.639059, 104.886843));
    Khan_Russey_Keo.add(LatLng(11.639973, 104.884332));
    Khan_Russey_Keo.add(LatLng(11.641255, 104.881339));
    Khan_Russey_Keo.add(LatLng(11.642884, 104.878764));
    Khan_Russey_Keo.add(LatLng(11.645896, 104.875229));
    Khan_Russey_Keo.add(LatLng(11.649069, 104.872472));
    Khan_Russey_Keo.add(LatLng(11.655037, 104.868084));
    Khan_Russey_Keo.add(LatLng(11.657286, 104.866872));
//Khan_Sen_Sok
    List<LatLng> Khan_Sen_Sok = <LatLng>[];
    Khan_Sen_Sok.add(LatLng(11.634704, 104.836300));
    Khan_Sen_Sok.add(LatLng(11.649625, 104.856213));
    Khan_Sen_Sok.add(LatLng(11.648743, 104.857028));
    Khan_Sen_Sok.add(LatLng(11.648406, 104.857929));
    Khan_Sen_Sok.add(LatLng(11.648490, 104.861062));
    Khan_Sen_Sok.add(LatLng(11.644960, 104.862864));
    Khan_Sen_Sok.add(LatLng(11.643531, 104.863294));
    Khan_Sen_Sok.add(LatLng(11.643110, 104.865504));
    Khan_Sen_Sok.add(LatLng(11.643215, 104.867639));
    Khan_Sen_Sok.add(LatLng(11.642564, 104.869377));
    Khan_Sen_Sok.add(LatLng(11.642333, 104.869956));
    Khan_Sen_Sok.add(LatLng(11.641587, 104.870739));
    Khan_Sen_Sok.add(LatLng(11.640284, 104.871973));
    Khan_Sen_Sok.add(LatLng(11.638844, 104.872864));
    Khan_Sen_Sok.add(LatLng(11.636564, 104.873883));
    Khan_Sen_Sok.add(LatLng(11.634819, 104.874409));
    Khan_Sen_Sok.add(LatLng(11.632697, 104.873980));
    Khan_Sen_Sok.add(LatLng(11.629691, 104.871920));
    Khan_Sen_Sok.add(LatLng(11.627474, 104.871651));
    Khan_Sen_Sok.add(LatLng(11.624321, 104.872123));
    Khan_Sen_Sok.add(LatLng(11.623649, 104.873025));
    Khan_Sen_Sok.add(LatLng(11.624531, 104.875095));
    Khan_Sen_Sok.add(LatLng(11.624447, 104.877327));
    Khan_Sen_Sok.add(LatLng(11.622871, 104.877906));
    Khan_Sen_Sok.add(LatLng(11.620990, 104.878217));
    Khan_Sen_Sok.add(LatLng(11.620401, 104.878979));
    Khan_Sen_Sok.add(LatLng(11.619655, 104.879204));
    Khan_Sen_Sok.add(LatLng(11.616986, 104.881222));
    Khan_Sen_Sok.add(LatLng(11.615483, 104.882101));
    Khan_Sen_Sok.add(LatLng(11.614779, 104.882294));
    Khan_Sen_Sok.add(LatLng(11.614085, 104.883571));
    Khan_Sen_Sok.add(LatLng(11.612677, 104.884955));
    Khan_Sen_Sok.add(LatLng(11.611122, 104.885631));
    Khan_Sen_Sok.add(LatLng(11.609009, 104.885771));
    Khan_Sen_Sok.add(LatLng(11.607444, 104.885653));
    Khan_Sen_Sok.add(LatLng(11.590344, 104.896167));
    Khan_Sen_Sok.add(LatLng(11.588358, 104.893271));
    Khan_Sen_Sok.add(LatLng(11.586718, 104.891415));
    Khan_Sen_Sok.add(LatLng(11.584879, 104.888400));
    Khan_Sen_Sok.add(LatLng(11.583523, 104.887499));
    Khan_Sen_Sok.add(LatLng(11.565623, 104.888675));
    Khan_Sen_Sok.add(LatLng(11.564351, 104.889243));
    Khan_Sen_Sok.add(LatLng(11.562943, 104.889758));
    Khan_Sen_Sok.add(LatLng(11.561524, 104.890574));
    Khan_Sen_Sok.add(LatLng(11.559800, 104.888718));
    Khan_Sen_Sok.add(LatLng(11.558276, 104.887494));
    Khan_Sen_Sok.add(LatLng(11.556352, 104.886829));
    Khan_Sen_Sok.add(LatLng(11.555028, 104.886904));
    Khan_Sen_Sok.add(LatLng(11.553356, 104.887258));
    Khan_Sen_Sok.add(LatLng(11.551864, 104.887934));
    Khan_Sen_Sok.add(LatLng(11.550729, 104.889039));
    Khan_Sen_Sok.add(LatLng(11.550361, 104.889479));
    Khan_Sen_Sok.add(LatLng(11.549719, 104.890681));
    Khan_Sen_Sok.add(LatLng(11.548563, 104.887012));
    Khan_Sen_Sok.add(LatLng(11.547838, 104.881207));
    Khan_Sen_Sok.add(LatLng(11.547596, 104.877678));
    Khan_Sen_Sok.add(LatLng(11.547281, 104.873772));
    Khan_Sen_Sok.add(LatLng(11.547223, 104.872300));
    Khan_Sen_Sok.add(LatLng(11.545155, 104.861767));
    Khan_Sen_Sok.add(LatLng(11.550632, 104.862293));
    Khan_Sen_Sok.add(LatLng(11.554763, 104.862851));
    Khan_Sen_Sok.add(LatLng(11.560744, 104.863012));
    Khan_Sen_Sok.add(LatLng(11.567587, 104.864417));
    Khan_Sen_Sok.add(LatLng(11.567177, 104.858635));
    Khan_Sen_Sok.add(LatLng(11.566588, 104.856210));
    Khan_Sen_Sok.add(LatLng(11.566252, 104.850438));
    Khan_Sen_Sok.add(LatLng(11.566492, 104.842057));
    Khan_Sen_Sok.add(LatLng(11.566660, 104.834869));
    Khan_Sen_Sok.add(LatLng(11.572925, 104.834912));
    Khan_Sen_Sok.add(LatLng(11.575658, 104.844439));
    Khan_Sen_Sok.add(LatLng(11.585306, 104.842830));
    //Khan_Pou_Senchey​​​
    List<LatLng> Khan_Pou_Senchey = <LatLng>[];
    Khan_Pou_Senchey.add(LatLng(11.562910, 104.863488));
    Khan_Pou_Senchey.add(LatLng(11.562447, 104.863424));
    Khan_Pou_Senchey.add(LatLng(11.561445, 104.863214));
    Khan_Pou_Senchey.add(LatLng(11.560983, 104.863129));
    Khan_Pou_Senchey.add(LatLng(11.560331, 104.863064));
    Khan_Pou_Senchey.add(LatLng(11.558208, 104.863021));
    Khan_Pou_Senchey.add(LatLng(11.557494, 104.863043));
    Khan_Pou_Senchey.add(LatLng(11.556186, 104.862997));
    Khan_Pou_Senchey.add(LatLng(11.555145, 104.862982));
    Khan_Pou_Senchey.add(LatLng(11.553525, 104.862846));
    Khan_Pou_Senchey.add(LatLng(11.552737, 104.862724));
    Khan_Pou_Senchey.add(LatLng(11.544338, 104.861586));
    Khan_Pou_Senchey.add(LatLng(11.542792, 104.861617));
    Khan_Pou_Senchey.add(LatLng(11.541617, 104.861753));
    Khan_Pou_Senchey.add(LatLng(11.539455, 104.861989));
    Khan_Pou_Senchey.add(LatLng(11.536326, 104.862242));
    Khan_Pou_Senchey.add(LatLng(11.534240, 104.862368));
    Khan_Pou_Senchey.add(LatLng(11.531517, 104.862440));
    Khan_Pou_Senchey.add(LatLng(11.528171, 104.862600));
    Khan_Pou_Senchey.add(LatLng(11.524828, 104.862857));
    Khan_Pou_Senchey.add(LatLng(11.522031, 104.863093));
    Khan_Pou_Senchey.add(LatLng(11.522116, 104.872449));
    Khan_Pou_Senchey.add(LatLng(11.521905, 104.874702));
    Khan_Pou_Senchey.add(LatLng(11.522073, 104.875624));
    Khan_Pou_Senchey.add(LatLng(11.520665, 104.876826));
    Khan_Pou_Senchey.add(LatLng(11.519067, 104.877727));
    Khan_Pou_Senchey.add(LatLng(11.517974, 104.878285));
    Khan_Pou_Senchey.add(LatLng(11.516649, 104.878435));
    Khan_Pou_Senchey.add(LatLng(11.514609, 104.877234));
    Khan_Pou_Senchey.add(LatLng(11.511308, 104.872749));
    Khan_Pou_Senchey.add(LatLng(11.509900, 104.865711));
    Khan_Pou_Senchey.add(LatLng(11.506472, 104.860861));
    Khan_Pou_Senchey.add(LatLng(11.505526, 104.857214));
    Khan_Pou_Senchey.add(LatLng(11.505589, 104.853265));
    Khan_Pou_Senchey.add(LatLng(11.505905, 104.850369));
    Khan_Pou_Senchey.add(LatLng(11.506094, 104.846034));
    Khan_Pou_Senchey.add(LatLng(11.506073, 104.843760));
    Khan_Pou_Senchey.add(LatLng(11.505884, 104.840326));
    Khan_Pou_Senchey.add(LatLng(11.504979, 104.838867));
    Khan_Pou_Senchey.add(LatLng(11.503718, 104.838095));
    Khan_Pou_Senchey.add(LatLng(11.502772, 104.838031));
    Khan_Pou_Senchey.add(LatLng(11.501300, 104.838674));
    Khan_Pou_Senchey.add(LatLng(11.500206, 104.838545));
    Khan_Pou_Senchey.add(LatLng(11.499231, 104.838615));
    Khan_Pou_Senchey.add(LatLng(11.500135, 104.836534));
    Khan_Pou_Senchey.add(LatLng(11.500198, 104.836019));
    Khan_Pou_Senchey.add(LatLng(11.500030, 104.833980));
    Khan_Pou_Senchey.add(LatLng(11.500261, 104.832328));
    Khan_Pou_Senchey.add(LatLng(11.500387, 104.830955));
    Khan_Pou_Senchey.add(LatLng(11.500219, 104.826706));
    Khan_Pou_Senchey.add(LatLng(11.499904, 104.821235));
    Khan_Pou_Senchey.add(LatLng(11.500156, 104.819690));
    Khan_Pou_Senchey.add(LatLng(11.500576, 104.818703));
    Khan_Pou_Senchey.add(LatLng(11.495635, 104.817887));
    Khan_Pou_Senchey.add(LatLng(11.494331, 104.818488));
    Khan_Pou_Senchey.add(LatLng(11.492523, 104.820076));
    Khan_Pou_Senchey.add(LatLng(11.491135, 104.820290));
    Khan_Pou_Senchey.add(LatLng(11.490294, 104.819282));
    Khan_Pou_Senchey.add(LatLng(11.489810, 104.817780));
    Khan_Pou_Senchey.add(LatLng(11.481904, 104.815505));
    Khan_Pou_Senchey.add(LatLng(11.481336, 104.813510));
    Khan_Pou_Senchey.add(LatLng(11.481042, 104.809883));
    Khan_Pou_Senchey.add(LatLng(11.480832, 104.807094));
    Khan_Pou_Senchey.add(LatLng(11.480558, 104.803403));
    Khan_Pou_Senchey.add(LatLng(11.478518, 104.799326));
    Khan_Pou_Senchey.add(LatLng(11.476458, 104.790915));
    Khan_Pou_Senchey.add(LatLng(11.476079, 104.786495));
    Khan_Pou_Senchey.add(LatLng(11.455996, 104.781130));
    Khan_Pou_Senchey.add(LatLng(11.455659, 104.779843));
    Khan_Pou_Senchey.add(LatLng(11.456143, 104.778684));
    Khan_Pou_Senchey.add(LatLng(11.457005, 104.777847));
    Khan_Pou_Senchey.add(LatLng(11.457615, 104.777740));
    Khan_Pou_Senchey.add(LatLng(11.457258, 104.776474));
    Khan_Pou_Senchey.add(LatLng(11.457090, 104.775079));
    Khan_Pou_Senchey.add(LatLng(11.457678, 104.774178));
    Khan_Pou_Senchey.add(LatLng(11.459150, 104.773813));
    Khan_Pou_Senchey.add(LatLng(11.461527, 104.774221));
    Khan_Pou_Senchey.add(LatLng(11.463819, 104.776152));
    Khan_Pou_Senchey.add(LatLng(11.464534, 104.778512));
    Khan_Pou_Senchey.add(LatLng(11.465480, 104.778727));
    Khan_Pou_Senchey.add(LatLng(11.466301, 104.778362));
    Khan_Pou_Senchey.add(LatLng(11.466763, 104.777311));
    Khan_Pou_Senchey.add(LatLng(11.466532, 104.776495));
    Khan_Pou_Senchey.add(LatLng(11.465312, 104.775444));
    Khan_Pou_Senchey.add(LatLng(11.464555, 104.774414));
    Khan_Pou_Senchey.add(LatLng(11.462993, 104.773491));
    Khan_Pou_Senchey.add(LatLng(11.462194, 104.772525));
    Khan_Pou_Senchey.add(LatLng(11.461690, 104.771302));
    Khan_Pou_Senchey.add(LatLng(11.461732, 104.769478));
    Khan_Pou_Senchey.add(LatLng(11.463414, 104.766903));
    Khan_Pou_Senchey.add(LatLng(11.463687, 104.765573));
    Khan_Pou_Senchey.add(LatLng(11.463309, 104.764500));
    Khan_Pou_Senchey.add(LatLng(11.462762, 104.763942));
    Khan_Pou_Senchey.add(LatLng(11.461227, 104.765058));
    Khan_Pou_Senchey.add(LatLng(11.459671, 104.765594));
    Khan_Pou_Senchey.add(LatLng(11.458178, 104.765079));
    Khan_Pou_Senchey.add(LatLng(11.456895, 104.762955));
    Khan_Pou_Senchey.add(LatLng(11.457084, 104.760187));
    Khan_Pou_Senchey.add(LatLng(11.458556, 104.758621));
    Khan_Pou_Senchey.add(LatLng(11.458808, 104.758106));
    Khan_Pou_Senchey.add(LatLng(11.458661, 104.756968));
    Khan_Pou_Senchey.add(LatLng(11.457562, 104.755896));
    Khan_Pou_Senchey.add(LatLng(11.456616, 104.755960));
    Khan_Pou_Senchey.add(LatLng(11.455017, 104.757698));
    Khan_Pou_Senchey.add(LatLng(11.453982, 104.759522));
    Khan_Pou_Senchey.add(LatLng(11.452699, 104.760359));
    Khan_Pou_Senchey.add(LatLng(11.451500, 104.760466));
    Khan_Pou_Senchey.add(LatLng(11.450533, 104.759683));
    Khan_Pou_Senchey.add(LatLng(11.450280, 104.757666));
    Khan_Pou_Senchey.add(LatLng(11.450974, 104.755048));
    Khan_Pou_Senchey.add(LatLng(11.451984, 104.754168));
    Khan_Pou_Senchey.add(LatLng(11.452972, 104.753718));
    Khan_Pou_Senchey.add(LatLng(11.455727, 104.753889));
    Khan_Pou_Senchey.add(LatLng(11.456253, 104.752795));
    Khan_Pou_Senchey.add(LatLng(11.456358, 104.751765));
    Khan_Pou_Senchey.add(LatLng(11.454802, 104.748396));
    Khan_Pou_Senchey.add(LatLng(11.454423, 104.746830));
    Khan_Pou_Senchey.add(LatLng(11.454718, 104.745607));
    Khan_Pou_Senchey.add(LatLng(11.454613, 104.744255));
    Khan_Pou_Senchey.add(LatLng(11.459849, 104.744641));
    Khan_Pou_Senchey.add(LatLng(11.463845, 104.744555));
    Khan_Pou_Senchey.add(LatLng(11.478123, 104.744877));
    Khan_Pou_Senchey.add(LatLng(11.479112, 104.746207));
    Khan_Pou_Senchey.add(LatLng(11.483927, 104.746336));
    Khan_Pou_Senchey.add(LatLng(11.484705, 104.748332));
    Khan_Pou_Senchey.add(LatLng(11.486493, 104.748589));
    Khan_Pou_Senchey.add(LatLng(11.486619, 104.749684));
    Khan_Pou_Senchey.add(LatLng(11.488133, 104.749855));
    Khan_Pou_Senchey.add(LatLng(11.489500, 104.749812));
    Khan_Pou_Senchey.add(LatLng(11.489121, 104.751808));
    Khan_Pou_Senchey.add(LatLng(11.489121, 104.758288));
    Khan_Pou_Senchey.add(LatLng(11.490635, 104.758782));
    Khan_Pou_Senchey.add(LatLng(11.491666, 104.758717));
    Khan_Pou_Senchey.add(LatLng(11.491497, 104.760391));
    Khan_Pou_Senchey.add(LatLng(11.491834, 104.762365));
    Khan_Pou_Senchey.add(LatLng(11.492486, 104.762794));
    Khan_Pou_Senchey.add(LatLng(11.495577, 104.762601));
    Khan_Pou_Senchey.add(LatLng(11.497490, 104.763953));
    Khan_Pou_Senchey.add(LatLng(11.499929, 104.765219));
    Khan_Pou_Senchey.add(LatLng(11.501317, 104.766700));
    Khan_Pou_Senchey.add(LatLng(11.502074, 104.767987));
    Khan_Pou_Senchey.add(LatLng(11.507310, 104.768395));
    Khan_Pou_Senchey.add(LatLng(11.515089, 104.768159));
    Khan_Pou_Senchey.add(LatLng(11.518516, 104.768159));
    Khan_Pou_Senchey.add(LatLng(11.520640, 104.764210));
    Khan_Pou_Senchey.add(LatLng(11.523605, 104.760842));
    Khan_Pou_Senchey.add(LatLng(11.527557, 104.757430));
    Khan_Pou_Senchey.add(LatLng(11.530669, 104.756035));
    Khan_Pou_Senchey.add(LatLng(11.530627, 104.754876));
    Khan_Pou_Senchey.add(LatLng(11.527431, 104.748868));
    Khan_Pou_Senchey.add(LatLng(11.528461, 104.745671));
    Khan_Pou_Senchey.add(LatLng(11.529723, 104.744384));
    Khan_Pou_Senchey.add(LatLng(11.532141, 104.744062));
    Khan_Pou_Senchey.add(LatLng(11.534558, 104.743504));
    Khan_Pou_Senchey.add(LatLng(11.536261, 104.742560));
    Khan_Pou_Senchey.add(LatLng(11.538406, 104.743396));
    Khan_Pou_Senchey.add(LatLng(11.541097, 104.743289));
    Khan_Pou_Senchey.add(LatLng(11.543830, 104.741680));
    Khan_Pou_Senchey.add(LatLng(11.545638, 104.739749));
    Khan_Pou_Senchey.add(LatLng(11.545722, 104.738654));
    Khan_Pou_Senchey.add(LatLng(11.543431, 104.735543));
    Khan_Pou_Senchey.add(LatLng(11.543725, 104.732153));
    Khan_Pou_Senchey.add(LatLng(11.544124, 104.730565));
    Khan_Pou_Senchey.add(LatLng(11.544061, 104.727861));
    Khan_Pou_Senchey.add(LatLng(11.548203, 104.727689));
    Khan_Pou_Senchey.add(LatLng(11.550999, 104.727174));
    Khan_Pou_Senchey.add(LatLng(11.554846, 104.725866));
    Khan_Pou_Senchey.add(LatLng(11.557894, 104.724406));
    Khan_Pou_Senchey.add(LatLng(11.559240, 104.722990));
    Khan_Pou_Senchey.add(LatLng(11.560669, 104.720651));
    Khan_Pou_Senchey.add(LatLng(11.562435, 104.719192));
    Khan_Pou_Senchey.add(LatLng(11.563886, 104.721767));
    Khan_Pou_Senchey.add(LatLng(11.565042, 104.722926));
    Khan_Pou_Senchey.add(LatLng(11.566829, 104.723205));
    Khan_Pou_Senchey.add(LatLng(11.568490, 104.721059));
    Khan_Pou_Senchey.add(LatLng(11.572021, 104.721274));
    Khan_Pou_Senchey.add(LatLng(11.571769, 104.717111));
    Khan_Pou_Senchey.add(LatLng(11.572021, 104.713957));
    Khan_Pou_Senchey.add(LatLng(11.572820, 104.713163));
    Khan_Pou_Senchey.add(LatLng(11.573997, 104.712626));
    Khan_Pou_Senchey.add(LatLng(11.575553, 104.712948));
    Khan_Pou_Senchey.add(LatLng(11.576120, 104.714300));
    Khan_Pou_Senchey.add(LatLng(11.575994, 104.719364));
    Khan_Pou_Senchey.add(LatLng(11.575217, 104.720737));
    Khan_Pou_Senchey.add(LatLng(11.574754, 104.722540));
    Khan_Pou_Senchey.add(LatLng(11.575111, 104.724085));
    Khan_Pou_Senchey.add(LatLng(11.576183, 104.725029));
    Khan_Pou_Senchey.add(LatLng(11.574649, 104.728398));
    Khan_Pou_Senchey.add(LatLng(11.577613, 104.731080));
    Khan_Pou_Senchey.add(LatLng(11.581481, 104.733011));
    Khan_Pou_Senchey.add(LatLng(11.581670, 104.734599));
    Khan_Pou_Senchey.add(LatLng(11.581523, 104.734749));
    Khan_Pou_Senchey.add(LatLng(11.581859, 104.735564));
    Khan_Pou_Senchey.add(LatLng(11.583057, 104.736509));
    Khan_Pou_Senchey.add(LatLng(11.583373, 104.737860));
    Khan_Pou_Senchey.add(LatLng(11.583226, 104.738611));
    Khan_Pou_Senchey.add(LatLng(11.582973, 104.739169));
    Khan_Pou_Senchey.add(LatLng(11.583289, 104.740092));
    Khan_Pou_Senchey.add(LatLng(11.587430, 104.741058));
    Khan_Pou_Senchey.add(LatLng(11.589448, 104.742238));
    Khan_Pou_Senchey.add(LatLng(11.589532, 104.744362));
    Khan_Pou_Senchey.add(LatLng(11.589763, 104.745456));
    Khan_Pou_Senchey.add(LatLng(11.590520, 104.746143));
    Khan_Pou_Senchey.add(LatLng(11.590393, 104.747216));
    Khan_Pou_Senchey.add(LatLng(11.591192, 104.750714));
    Khan_Pou_Senchey.add(LatLng(11.590246, 104.751915));
    Khan_Pou_Senchey.add(LatLng(11.591066, 104.752666));
    Khan_Pou_Senchey.add(LatLng(11.591402, 104.753353));
    Khan_Pou_Senchey.add(LatLng(11.590898, 104.754318));
    Khan_Pou_Senchey.add(LatLng(11.591802, 104.754898));
    Khan_Pou_Senchey.add(LatLng(11.591571, 104.755434));
    Khan_Pou_Senchey.add(LatLng(11.590856, 104.755842));
    Khan_Pou_Senchey.add(LatLng(11.590667, 104.757215));
    Khan_Pou_Senchey.add(LatLng(11.590772, 104.758996));
    Khan_Pou_Senchey.add(LatLng(11.591613, 104.760133));
    Khan_Pou_Senchey.add(LatLng(11.592012, 104.762236));
    Khan_Pou_Senchey.add(LatLng(11.591907, 104.762880));
    Khan_Pou_Senchey.add(LatLng(11.592601, 104.765584));
    Khan_Pou_Senchey.add(LatLng(11.592832, 104.768223));
    Khan_Pou_Senchey.add(LatLng(11.593294, 104.770605));
    Khan_Pou_Senchey.add(LatLng(11.593946, 104.772000));
    Khan_Pou_Senchey.add(LatLng(11.594892, 104.772751));
    Khan_Pou_Senchey.add(LatLng(11.595669, 104.773823));
    Khan_Pou_Senchey.add(LatLng(11.596931, 104.774639));
    Khan_Pou_Senchey.add(LatLng(11.598444, 104.776077));
    Khan_Pou_Senchey.add(LatLng(11.598486, 104.777729));
    Khan_Pou_Senchey.add(LatLng(11.599285, 104.778394));
    Khan_Pou_Senchey.add(LatLng(11.602606, 104.778394));
    Khan_Pou_Senchey.add(LatLng(11.605107, 104.779810));
    Khan_Pou_Senchey.add(LatLng(11.605401, 104.780518));
    Khan_Pou_Senchey.add(LatLng(11.605170, 104.781763));
    Khan_Pou_Senchey.add(LatLng(11.605864, 104.782407));
    Khan_Pou_Senchey.add(LatLng(11.607209, 104.782986));
    Khan_Pou_Senchey.add(LatLng(11.608785, 104.784316));
    Khan_Pou_Senchey.add(LatLng(11.610005, 104.784359));
    Khan_Pou_Senchey.add(LatLng(11.610446, 104.785067));
    Khan_Pou_Senchey.add(LatLng(11.610341, 104.786205));
    Khan_Pou_Senchey.add(LatLng(11.609584, 104.787127));
    Khan_Pou_Senchey.add(LatLng(11.608428, 104.789917));
    Khan_Pou_Senchey.add(LatLng(11.606957, 104.792041));
    Khan_Pou_Senchey.add(LatLng(11.603888, 104.797148));
    Khan_Pou_Senchey.add(LatLng(11.601429, 104.798371));
    Khan_Pou_Senchey.add(LatLng(11.595606, 104.799422));
    Khan_Pou_Senchey.add(LatLng(11.591276, 104.799852));
    Khan_Pou_Senchey.add(LatLng(11.586589, 104.801010));
    Khan_Pou_Senchey.add(LatLng(11.585412, 104.802298));
    Khan_Pou_Senchey.add(LatLng(11.584445, 104.804336));
    Khan_Pou_Senchey.add(LatLng(11.581691, 104.807383));
    Khan_Pou_Senchey.add(LatLng(11.579841, 104.809250));
    Khan_Pou_Senchey.add(LatLng(11.579589, 104.811074));
    Khan_Pou_Senchey.add(LatLng(11.579610, 104.814421));
    Khan_Pou_Senchey.add(LatLng(11.579274, 104.820043));
    Khan_Pou_Senchey.add(LatLng(11.579421, 104.823412));
    Khan_Pou_Senchey.add(LatLng(11.579925, 104.824313));
    Khan_Pou_Senchey.add(LatLng(11.586084, 104.830085));
    Khan_Pou_Senchey.add(LatLng(11.588291, 104.831437));
    Khan_Pou_Senchey.add(LatLng(11.592222, 104.832532));
    Khan_Pou_Senchey.add(LatLng(11.595922, 104.833090));
    Khan_Pou_Senchey.add(LatLng(11.599768, 104.832532));
    Khan_Pou_Senchey.add(LatLng(11.602291, 104.832489));
    Khan_Pou_Senchey.add(LatLng(11.605633, 104.833047));
    Khan_Pou_Senchey.add(LatLng(11.609185, 104.832875));
    Khan_Pou_Senchey.add(LatLng(11.612106, 104.832982));
    Khan_Pou_Senchey.add(LatLng(11.614713, 104.834162));
    Khan_Pou_Senchey.add(LatLng(11.617592, 104.835192));
    Khan_Pou_Senchey.add(LatLng(11.618475, 104.835900));
    Khan_Pou_Senchey.add(LatLng(11.619358, 104.837703));
    Khan_Pou_Senchey.add(LatLng(11.620430, 104.838840));
    Khan_Pou_Senchey.add(LatLng(11.585328, 104.842917));
    Khan_Pou_Senchey.add(LatLng(11.575763, 104.844612));
    Khan_Pou_Senchey.add(LatLng(11.572862, 104.835042));
    Khan_Pou_Senchey.add(LatLng(11.566598, 104.834956));
    Khan_Pou_Senchey.add(LatLng(11.566451, 104.850985));
    Khan_Pou_Senchey.add(LatLng(11.566598, 104.854011));
    Khan_Pou_Senchey.add(LatLng(11.567375, 104.859719));
    Khan_Pou_Senchey.add(LatLng(11.567796, 104.864418));
    Khan_Pou_Senchey.add(LatLng(11.562910, 104.863488));
//ដូនពេញ
    List<LatLng> Daun_Penh = <LatLng>[];
    //  Daun_Penh.add(LatLng(11.560808, 104.937000));
    //  Daun_Penh.add(LatLng(11.560808, 104.937000));
    Daun_Penh.add(LatLng(11.588611, 104.918210));
    Daun_Penh.add(LatLng(11.588730, 104.919682));
    Daun_Penh.add(LatLng(11.586590, 104.920350));
    Daun_Penh.add(LatLng(11.585103, 104.920957));
    Daun_Penh.add(LatLng(11.582740, 104.922353));
    Daun_Penh.add(LatLng(11.579663, 104.924173));
    Daun_Penh.add(LatLng(11.577211, 104.926131));
    Daun_Penh.add(LatLng(11.574877, 104.927936));
    Daun_Penh.add(LatLng(11.573762, 104.928953));
    Daun_Penh.add(LatLng(11.572707, 104.929742));
    Daun_Penh.add(LatLng(11.572045, 104.929947));
    Daun_Penh.add(LatLng(11.571547, 104.930242));
    Daun_Penh.add(LatLng(11.571131, 104.930409));
    Daun_Penh.add(LatLng(11.566601, 104.932344));
    Daun_Penh.add(LatLng(11.566315, 104.932469));
    Daun_Penh.add(LatLng(11.565672, 104.933065));
    Daun_Penh.add(LatLng(11.565170, 104.933470));
    Daun_Penh.add(LatLng(11.564207, 104.934099));
    Daun_Penh.add(LatLng(11.563720, 104.934501));
    Daun_Penh.add(LatLng(11.563248, 104.935042));
    Daun_Penh.add(LatLng(11.563093, 104.935155));
    Daun_Penh.add(LatLng(11.562646, 104.935719));
    Daun_Penh.add(LatLng(11.561683, 104.936202));
    Daun_Penh.add(LatLng(11.560808, 104.937000));
    Daun_Penh.add(LatLng(11.560684, 104.937027));
    Daun_Penh.add(LatLng(11.560331, 104.937483));
    Daun_Penh.add(LatLng(11.559836, 104.937731));
    Daun_Penh.add(LatLng(11.559447, 104.938019));
    Daun_Penh.add(LatLng(11.556591, 104.938367));
    Daun_Penh.add(LatLng(11.558855, 104.938556));
    Daun_Penh.add(LatLng(11.558333, 104.939228));
    Daun_Penh.add(LatLng(11.557957, 104.939576));
    Daun_Penh.add(LatLng(11.558249, 104.940424));
    Daun_Penh.add(LatLng(11.558161, 104.942278));
    Daun_Penh.add(LatLng(11.557630, 104.943126));
    Daun_Penh.add(LatLng(11.557132, 104.936986));
    Daun_Penh.add(LatLng(11.557161, 104.932630));
    Daun_Penh.add(LatLng(11.556596, 104.929158));
    Daun_Penh.add(LatLng(11.556310, 104.924772));
    Daun_Penh.add(LatLng(11.556179, 104.922916));
    Daun_Penh.add(LatLng(11.555896, 104.920561));
    Daun_Penh.add(LatLng(11.571730, 104.918201));
    Daun_Penh.add(LatLng(11.570207, 104.905057));
    Daun_Penh.add(LatLng(11.574572, 104.903581));
    Daun_Penh.add(LatLng(11.574587, 104.904119));
    Daun_Penh.add(LatLng(11.577845, 104.904895));
    Daun_Penh.add(LatLng(11.583414, 104.907474));
    Daun_Penh.add(LatLng(11.585131, 104.914097));
    Daun_Penh.add(LatLng(11.587912, 104.914582));
// Daun Penh
    List<LatLng> K7_Makara = <LatLng>[];
    K7_Makara.add(LatLng(11.570400, 104.906354));
    K7_Makara.add(LatLng(11.571711, 104.918185));
    K7_Makara.add(LatLng(11.555896, 104.920561));
    K7_Makara.add(LatLng(11.555635, 104.911449));
    K7_Makara.add(LatLng(11.555773, 104.910608));
    K7_Makara.add(LatLng(11.557696, 104.908259));
    K7_Makara.add(LatLng(11.570400, 104.906354));
// Khan Tuol Kouk
    List<LatLng> Khan_Tuol_Kouk = <LatLng>[];
    Khan_Tuol_Kouk.add(LatLng(11.570474, 104.906428));
    Khan_Tuol_Kouk.add(LatLng(11.557632, 104.908255));
    Khan_Tuol_Kouk.add(LatLng(11.548301, 104.898532));
    Khan_Tuol_Kouk.add(LatLng(11.548548, 104.897783));
    Khan_Tuol_Kouk.add(LatLng(11.548064, 104.897247));
    Khan_Tuol_Kouk.add(LatLng(11.549578, 104.895784));
    Khan_Tuol_Kouk.add(LatLng(11.549600, 104.890874));
    Khan_Tuol_Kouk.add(LatLng(11.550494, 104.889210));
    Khan_Tuol_Kouk.add(LatLng(11.553534, 104.887170));
    Khan_Tuol_Kouk.add(LatLng(11.556682, 104.886910));
    Khan_Tuol_Kouk.add(LatLng(11.558316, 104.887560));
    Khan_Tuol_Kouk.add(LatLng(11.561454, 104.890608));
    Khan_Tuol_Kouk.add(LatLng(11.565733, 104.888681));
    Khan_Tuol_Kouk.add(LatLng(11.570383, 104.888337));
    Khan_Tuol_Kouk.add(LatLng(11.583487, 104.887425));
    Khan_Tuol_Kouk.add(LatLng(11.584915, 104.888584));
    Khan_Tuol_Kouk.add(LatLng(11.587511, 104.891861));
    Khan_Tuol_Kouk.add(LatLng(11.589653, 104.895042));
    Khan_Tuol_Kouk.add(LatLng(11.590868, 104.897605));
    Khan_Tuol_Kouk.add(LatLng(11.585721, 104.900786));
    Khan_Tuol_Kouk.add(LatLng(11.583318, 104.907914));
    Khan_Tuol_Kouk.add(LatLng(11.577802, 104.904778));
    Khan_Tuol_Kouk.add(LatLng(11.574599, 104.904121));
    Khan_Tuol_Kouk.add(LatLng(11.574611, 104.903662));
    Khan_Tuol_Kouk.add(LatLng(11.570294, 104.904799));
    Khan_Tuol_Kouk.add(LatLng(11.570474, 104.906428));
//Chbar Ampov
    List<LatLng> Chbar_Ampov = <LatLng>[];
    Chbar_Ampov.add(LatLng(11.518354, 105.027058));
    Chbar_Ampov.add(LatLng(11.515482, 105.026347));
    Chbar_Ampov.add(LatLng(11.510274, 105.027151));
    Chbar_Ampov.add(LatLng(11.510211, 105.026925));
    Chbar_Ampov.add(LatLng(11.510337, 105.026518));
    Chbar_Ampov.add(LatLng(11.510154, 105.026490));
    Chbar_Ampov.add(LatLng(11.509550, 105.026862));
    Chbar_Ampov.add(LatLng(11.509297, 105.027108));
    Chbar_Ampov.add(LatLng(11.509089, 105.027218));
    Chbar_Ampov.add(LatLng(11.508939, 105.027249));
    Chbar_Ampov.add(LatLng(11.508727, 105.027376));
    Chbar_Ampov.add(LatLng(11.508673, 105.027450));
    Chbar_Ampov.add(LatLng(11.500335, 105.028473));
    Chbar_Ampov.add(LatLng(11.494456, 105.028189));
    Chbar_Ampov.add(LatLng(11.491206, 105.029107));
    Chbar_Ampov.add(LatLng(11.483504, 105.029413));
    Chbar_Ampov.add(LatLng(11.483104, 105.044647));
    Chbar_Ampov.add(LatLng(11.480403, 105.044571));
    Chbar_Ampov.add(LatLng(11.477727, 105.038319));
    Chbar_Ampov.add(LatLng(11.472526, 105.031404));
    Chbar_Ampov.add(LatLng(11.469114, 105.028884));
    Chbar_Ampov.add(LatLng(11.467442, 105.028637));
    Chbar_Ampov.add(LatLng(11.467652, 105.023938));
    Chbar_Ampov.add(LatLng(11.468136, 105.017941));
    Chbar_Ampov.add(LatLng(11.468273, 105.013188));
    Chbar_Ampov.add(LatLng(11.467789, 105.003124));
    Chbar_Ampov.add(LatLng(11.466285, 104.998554));
    Chbar_Ampov.add(LatLng(11.465592, 104.996204));
    Chbar_Ampov.add(LatLng(11.464719, 104.992567));
    Chbar_Ampov.add(LatLng(11.464477, 104.990893));
    Chbar_Ampov.add(LatLng(11.464172, 104.990067));
    Chbar_Ampov.add(LatLng(11.463720, 104.986816));
    Chbar_Ampov.add(LatLng(11.464287, 104.970319));
    Chbar_Ampov.add(LatLng(11.465447, 104.967163));
    Chbar_Ampov.add(LatLng(11.468629, 104.963370));
    Chbar_Ampov.add(LatLng(11.472807, 104.960108));
    Chbar_Ampov.add(LatLng(11.482539, 104.953881));
    Chbar_Ampov.add(LatLng(11.496543, 104.947241));
    Chbar_Ampov.add(LatLng(11.509910, 104.942442));
    Chbar_Ampov.add(LatLng(11.521402, 104.938111));
    Chbar_Ampov.add(LatLng(11.531692, 104.933673));
    Chbar_Ampov.add(LatLng(11.534109, 104.932547));
    Chbar_Ampov.add(LatLng(11.536590, 104.932343));
    Chbar_Ampov.add(LatLng(11.537841, 104.932729));
    Chbar_Ampov.add(LatLng(11.539375, 104.933910));
    Chbar_Ampov.add(LatLng(11.539680, 104.934521));
    Chbar_Ampov.add(LatLng(11.540103, 104.935075));
    Chbar_Ampov.add(LatLng(11.540144, 104.935321));
    Chbar_Ampov.add(LatLng(11.540155, 104.935727));
    Chbar_Ampov.add(LatLng(11.540427, 104.937206));
    Chbar_Ampov.add(LatLng(11.540713, 104.938765));
    Chbar_Ampov.add(LatLng(11.540802, 104.939479));
    Chbar_Ampov.add(LatLng(11.541006, 104.940029));
    Chbar_Ampov.add(LatLng(11.541229, 104.940408));
    Chbar_Ampov.add(LatLng(11.541504, 104.940981));
    Chbar_Ampov.add(LatLng(11.542099, 104.941785));
    Chbar_Ampov.add(LatLng(11.543249, 104.943546));
    Chbar_Ampov.add(LatLng(11.544743, 104.945064));
    Chbar_Ampov.add(LatLng(11.546762, 104.946537));
    Chbar_Ampov.add(LatLng(11.547549, 104.947494));
    Chbar_Ampov.add(LatLng(11.548012, 104.947890));
    Chbar_Ampov.add(LatLng(11.548326, 104.948367));
    Chbar_Ampov.add(LatLng(11.548428, 104.948366));
    Chbar_Ampov.add(LatLng(11.546698, 104.951505));
    Chbar_Ampov.add(LatLng(11.546575, 104.951860));
    Chbar_Ampov.add(LatLng(11.546425, 104.952102));
    Chbar_Ampov.add(LatLng(11.546309, 104.952150));
    Chbar_Ampov.add(LatLng(11.546077, 104.952165));
    Chbar_Ampov.add(LatLng(11.545769, 104.952326));
    Chbar_Ampov.add(LatLng(11.545630, 104.952467));
    Chbar_Ampov.add(LatLng(11.545561, 104.952602));
    Chbar_Ampov.add(LatLng(11.545558, 104.952664));
    Chbar_Ampov.add(LatLng(11.545572, 104.952735));
    Chbar_Ampov.add(LatLng(11.545639, 104.952876));
    Chbar_Ampov.add(LatLng(11.545651, 104.952946));
    Chbar_Ampov.add(LatLng(11.545646, 104.953056));
    Chbar_Ampov.add(LatLng(11.545623, 104.953138));
    Chbar_Ampov.add(LatLng(11.545558, 104.953307));
    Chbar_Ampov.add(LatLng(11.545548, 104.953371));
    Chbar_Ampov.add(LatLng(11.545517, 104.953433));
    Chbar_Ampov.add(LatLng(11.545446, 104.953535));
    Chbar_Ampov.add(LatLng(11.545172, 104.953903));
    Chbar_Ampov.add(LatLng(11.545199, 104.954152));
    Chbar_Ampov.add(LatLng(11.545117, 104.954306));
    Chbar_Ampov.add(LatLng(11.545032, 104.954396));
    Chbar_Ampov.add(LatLng(11.544960, 104.954509));
    Chbar_Ampov.add(LatLng(11.544942, 104.954578));
    Chbar_Ampov.add(LatLng(11.544940, 104.954620));
    Chbar_Ampov.add(LatLng(11.544903, 104.954708));
    Chbar_Ampov.add(LatLng(11.544869, 104.954752));
    Chbar_Ampov.add(LatLng(11.544745, 104.954792));
    Chbar_Ampov.add(LatLng(11.544705, 104.954811));
    Chbar_Ampov.add(LatLng(11.544383, 104.955455));
    Chbar_Ampov.add(LatLng(11.544205, 104.955857));
    Chbar_Ampov.add(LatLng(11.543841, 104.956024));
    Chbar_Ampov.add(LatLng(11.542629, 104.958505));
    Chbar_Ampov.add(LatLng(11.542451, 104.958702));
    Chbar_Ampov.add(LatLng(11.542346, 104.959294));
    Chbar_Ampov.add(LatLng(11.541856, 104.960651));
    Chbar_Ampov.add(LatLng(11.541670, 104.961425));
    Chbar_Ampov.add(LatLng(11.541707, 104.961752));
    Chbar_Ampov.add(LatLng(11.541618, 104.962047));
    Chbar_Ampov.add(LatLng(11.541469, 104.962639));
    Chbar_Ampov.add(LatLng(11.541246, 104.962897));
    Chbar_Ampov.add(LatLng(11.541291, 104.963542));
    Chbar_Ampov.add(LatLng(11.541715, 104.963807));
    Chbar_Ampov.add(LatLng(11.540473, 104.979906));
    Chbar_Ampov.add(LatLng(11.542281, 104.994368));
    Chbar_Ampov.add(LatLng(11.542071, 105.001964));
    Chbar_Ampov.add(LatLng(11.540725, 105.013637));
    Chbar_Ampov.add(LatLng(11.539758, 105.027241));
    Chbar_Ampov.add(LatLng(11.537908, 105.036082));
    Chbar_Ampov.add(LatLng(11.536605, 105.039815));
    Chbar_Ampov.add(LatLng(11.531475, 105.037412));
    Chbar_Ampov.add(LatLng(11.527985, 105.035223));
    Chbar_Ampov.add(LatLng(11.524578, 105.031361));
    Chbar_Ampov.add(LatLng(11.518354, 105.027058));
    ////////Khan_Dangkor
    List<LatLng> Khan_Dangkor = <LatLng>[];
    Khan_Dangkor.add(LatLng(11.482224, 104.913889));
    Khan_Dangkor.add(LatLng(11.484495, 104.921527));
    Khan_Dangkor.add(LatLng(11.466537, 104.918266));
    Khan_Dangkor.add(LatLng(11.451627, 104.922922));
    Khan_Dangkor.add(LatLng(11.446979, 104.923094));
    Khan_Dangkor.add(LatLng(11.443551, 104.922751));
    Khan_Dangkor.add(LatLng(11.428787, 104.922729));
    Khan_Dangkor.add(LatLng(11.430154, 104.914296));
    Khan_Dangkor.add(LatLng(11.430175, 104.913695));
    Khan_Dangkor.add(LatLng(11.431163, 104.912665));
    Khan_Dangkor.add(LatLng(11.432341, 104.913116));
    Khan_Dangkor.add(LatLng(11.435306, 104.907859));
    Khan_Dangkor.add(LatLng(11.435517, 104.905885));
    Khan_Dangkor.add(LatLng(11.435412, 104.903675));
    Khan_Dangkor.add(LatLng(11.434823, 104.901422));
    Khan_Dangkor.add(LatLng(11.434865, 104.899984));
    Khan_Dangkor.add(LatLng(11.435285, 104.898503));
    Khan_Dangkor.add(LatLng(11.435349, 104.896615));
    Khan_Dangkor.add(LatLng(11.430196, 104.888783));
    Khan_Dangkor.add(LatLng(11.430364, 104.887388));
    Khan_Dangkor.add(LatLng(11.432614, 104.886358));
    Khan_Dangkor.add(LatLng(11.434297, 104.885049));
    Khan_Dangkor.add(LatLng(11.435895, 104.882689));
    Khan_Dangkor.add(LatLng(11.436064, 104.880779));
    Khan_Dangkor.add(LatLng(11.422550, 104.873473));
    Khan_Dangkor.add(LatLng(11.426328, 104.864675));
    Khan_Dangkor.add(LatLng(11.425992, 104.863881));
    Khan_Dangkor.add(LatLng(11.424436, 104.862330));
    Khan_Dangkor.add(LatLng(11.423516, 104.857837));
    Khan_Dangkor.add(LatLng(11.424100, 104.856321));
    Khan_Dangkor.add(LatLng(11.425019, 104.855654));
    Khan_Dangkor.add(LatLng(11.428150, 104.854751));
    Khan_Dangkor.add(LatLng(11.428539, 104.853127));
    Khan_Dangkor.add(LatLng(11.430308, 104.852261));
    Khan_Dangkor.add(LatLng(11.430679, 104.830970));
    Khan_Dangkor.add(LatLng(11.435702, 104.827668));
    Khan_Dangkor.add(LatLng(11.437240, 104.826946));
    Khan_Dangkor.add(LatLng(11.439009, 104.826874));
    Khan_Dangkor.add(LatLng(11.439628, 104.825683));
    Khan_Dangkor.add(LatLng(11.442670, 104.823644));
    Khan_Dangkor.add(LatLng(11.444031, 104.822327));
    Khan_Dangkor.add(LatLng(11.443536, 104.820577));
    Khan_Dangkor.add(LatLng(11.440547, 104.818123));
    Khan_Dangkor.add(LatLng(11.439699, 104.816517));
    Khan_Dangkor.add(LatLng(11.439433, 104.815651));
    Khan_Dangkor.add(LatLng(11.438797, 104.815272));
    Khan_Dangkor.add(LatLng(11.437948, 104.815705));
    Khan_Dangkor.add(LatLng(11.437311, 104.818844));
    Khan_Dangkor.add(LatLng(11.436674, 104.819404));
    Khan_Dangkor.add(LatLng(11.435737, 104.819422));
    Khan_Dangkor.add(LatLng(11.432359, 104.818105));
    Khan_Dangkor.add(LatLng(11.430827, 104.816225));
    Khan_Dangkor.add(LatLng(11.430585, 104.813735));
    Khan_Dangkor.add(LatLng(11.429923, 104.810731));
    Khan_Dangkor.add(LatLng(11.430417, 104.809229));
    Khan_Dangkor.add(LatLng(11.430669, 104.808629));
    Khan_Dangkor.add(LatLng(11.431500, 104.804949));
    Khan_Dangkor.add(LatLng(11.432310, 104.803994));
    Khan_Dangkor.add(LatLng(11.433887, 104.801558));
    Khan_Dangkor.add(LatLng(11.436117, 104.801086));
    Khan_Dangkor.add(LatLng(11.439082, 104.798973));
    Khan_Dangkor.add(LatLng(11.440218, 104.797674));
    Khan_Dangkor.add(LatLng(11.440975, 104.797503));
    Khan_Dangkor.add(LatLng(11.441921, 104.797792));
    Khan_Dangkor.add(LatLng(11.442931, 104.799209));
    Khan_Dangkor.add(LatLng(11.444708, 104.799455));
    Khan_Dangkor.add(LatLng(11.445013, 104.798576));
    Khan_Dangkor.add(LatLng(11.444887, 104.797267));
    Khan_Dangkor.add(LatLng(11.444445, 104.796473));
    Khan_Dangkor.add(LatLng(11.443772, 104.795647));
    Khan_Dangkor.add(LatLng(11.443351, 104.794842));
    Khan_Dangkor.add(LatLng(11.443393, 104.793265));
    Khan_Dangkor.add(LatLng(11.444329, 104.793093));
    Khan_Dangkor.add(LatLng(11.446243, 104.793823));
    Khan_Dangkor.add(LatLng(11.447053, 104.793436));
    Khan_Dangkor.add(LatLng(11.447147, 104.791548));
    Khan_Dangkor.add(LatLng(11.445297, 104.789488));
    Khan_Dangkor.add(LatLng(11.445244, 104.788619));
    Khan_Dangkor.add(LatLng(11.446033, 104.787396));
    Khan_Dangkor.add(LatLng(11.446380, 104.786634));
    Khan_Dangkor.add(LatLng(11.446800, 104.785862));
    Khan_Dangkor.add(LatLng(11.447400, 104.783630));
    Khan_Dangkor.add(LatLng(11.449114, 104.782397));
    Khan_Dangkor.add(LatLng(11.450092, 104.782246));
    Khan_Dangkor.add(LatLng(11.452847, 104.784692));
    Khan_Dangkor.add(LatLng(11.454287, 104.785261));
    Khan_Dangkor.add(LatLng(11.455370, 104.784714));
    Khan_Dangkor.add(LatLng(11.456043, 104.783598));
    Khan_Dangkor.add(LatLng(11.455854, 104.781098));
    Khan_Dangkor.add(LatLng(11.476105, 104.786396));
    Khan_Dangkor.add(LatLng(11.476684, 104.790988));
    Khan_Dangkor.add(LatLng(11.478745, 104.799228));
    Khan_Dangkor.add(LatLng(11.480742, 104.803337));
    Khan_Dangkor.add(LatLng(11.481247, 104.808873));
    Khan_Dangkor.add(LatLng(11.481378, 104.815230));
    Khan_Dangkor.add(LatLng(11.488170, 104.817059));
    Khan_Dangkor.add(LatLng(11.488703, 104.817164));
    Khan_Dangkor.add(LatLng(11.489982, 104.817726));
    Khan_Dangkor.add(LatLng(11.491045, 104.820138));
    Khan_Dangkor.add(LatLng(11.492398, 104.820085));
    Khan_Dangkor.add(LatLng(11.494219, 104.818431));
    Khan_Dangkor.add(LatLng(11.495401, 104.817711));
    Khan_Dangkor.add(LatLng(11.500813, 104.818644));
    Khan_Dangkor.add(LatLng(11.500129, 104.819638));
    Khan_Dangkor.add(LatLng(11.500077, 104.821527));
    Khan_Dangkor.add(LatLng(11.500494, 104.829159));
    Khan_Dangkor.add(LatLng(11.500248, 104.836601));
    Khan_Dangkor.add(LatLng(11.499921, 104.837792));
    Khan_Dangkor.add(LatLng(11.499542, 104.838573));
    Khan_Dangkor.add(LatLng(11.501296, 104.838573));
    Khan_Dangkor.add(LatLng(11.502620, 104.837944));
    Khan_Dangkor.add(LatLng(11.503675, 104.837966));
    Khan_Dangkor.add(LatLng(11.505028, 104.838687));
    Khan_Dangkor.add(LatLng(11.505950, 104.840235));
    Khan_Dangkor.add(LatLng(11.506322, 104.845318));
    Khan_Dangkor.add(LatLng(11.505623, 104.853329));
    Khan_Dangkor.add(LatLng(11.505608, 104.857183));
    Khan_Dangkor.add(LatLng(11.506604, 104.860931));
    Khan_Dangkor.add(LatLng(11.510039, 104.865695));
    Khan_Dangkor.add(LatLng(11.511466, 104.872735));
    Khan_Dangkor.add(LatLng(11.514529, 104.877257));
    Khan_Dangkor.add(LatLng(11.516179, 104.878304));
    Khan_Dangkor.add(LatLng(11.517919, 104.878182));
    Khan_Dangkor.add(LatLng(11.520431, 104.876771));
    Khan_Dangkor.add(LatLng(11.521812, 104.875641));
    Khan_Dangkor.add(LatLng(11.521972, 104.883841));
    Khan_Dangkor.add(LatLng(11.522184, 104.887252));
    Khan_Dangkor.add(LatLng(11.522557, 104.888650));
    Khan_Dangkor.add(LatLng(11.521679, 104.894059));
    Khan_Dangkor.add(LatLng(11.522951, 104.896805));
    Khan_Dangkor.add(LatLng(11.522594, 104.898004));
    Khan_Dangkor.add(LatLng(11.521479, 104.902252));
    Khan_Dangkor.add(LatLng(11.520051, 104.907623));
    Khan_Dangkor.add(LatLng(11.518867, 104.913378));
///////////meanchen
    List<LatLng> meanchen = <LatLng>[];

    meanchen.add(LatLng(11.545208, 104.861411));
    meanchen.add(LatLng(11.541514, 104.861714));
    meanchen.add(LatLng(11.536478, 104.862122));
    meanchen.add(LatLng(11.531559, 104.862336));
    meanchen.add(LatLng(11.528300, 104.862594));
    meanchen.add(LatLng(11.521941, 104.863028));
    meanchen.add(LatLng(11.521916, 104.863666));
    meanchen.add(LatLng(11.522182, 104.868666));
    meanchen.add(LatLng(11.522161, 104.872314));
    meanchen.add(LatLng(11.521441, 104.876633));
    meanchen.add(LatLng(11.522203, 104.882507));
    meanchen.add(LatLng(11.522549, 104.889148));
    meanchen.add(LatLng(11.521971, 104.893911));
    meanchen.add(LatLng(11.522907, 104.897699));
    meanchen.add(LatLng(11.520153, 104.907891));
    meanchen.add(LatLng(11.519112, 104.912880));
    meanchen.add(LatLng(11.514802, 104.913717));
    meanchen.add(LatLng(11.505161, 104.913824));
    meanchen.add(LatLng(11.502292, 104.912504));
    meanchen.add(LatLng(11.482315, 104.913813));
    meanchen.add(LatLng(11.484495, 104.921424));
    // meanchen.add(LatLng(11.493768, 104.947023));
    meanchen.add(LatLng(11.492927, 104.944820));
    meanchen.add(LatLng(11.495019, 104.944047));
    meanchen.add(LatLng(11.496428, 104.943554));
    meanchen.add(LatLng(11.497841, 104.942963));
    meanchen.add(LatLng(11.499019, 104.942598));
    meanchen.add(LatLng(11.501421, 104.941509));
    meanchen.add(LatLng(11.506031, 104.939830));
    meanchen.add(LatLng(11.523157, 104.934674));
    meanchen.add(LatLng(11.530752, 104.932603));
    meanchen.add(LatLng(11.530885, 104.930831));
    meanchen.add(LatLng(11.529797, 104.928335));
    meanchen.add(LatLng(11.526913, 104.921674));
    meanchen.add(LatLng(11.526630, 104.918897));
    meanchen.add(LatLng(11.527151, 104.917228));
    meanchen.add(LatLng(11.528860, 104.915180));
    meanchen.add(LatLng(11.536175, 104.911371));
    meanchen.add(LatLng(11.540233, 104.909095));
    meanchen.add(LatLng(11.541946, 104.908150));
    meanchen.add(LatLng(11.543102, 104.906734));
    meanchen.add(LatLng(11.543528, 104.904859));
    meanchen.add(LatLng(11.543851, 104.902697));
    meanchen.add(LatLng(11.544703, 104.900691));
    meanchen.add(LatLng(11.545764, 104.899425));
    meanchen.add(LatLng(11.546900, 104.898845));
    meanchen.add(LatLng(11.547877, 104.898641));
    meanchen.add(LatLng(11.548445, 104.898588));
    meanchen.add(LatLng(11.548576, 104.898234));
    meanchen.add(LatLng(11.548681, 104.897729));
    meanchen.add(LatLng(11.548545, 104.897086));
    meanchen.add(LatLng(11.548650, 104.896699));
    meanchen.add(LatLng(11.549302, 104.896028));
    meanchen.add(LatLng(11.549700, 104.895755));
    meanchen.add(LatLng(11.549733, 104.895458));
    meanchen.add(LatLng(11.549677, 104.891173));
    meanchen.add(LatLng(11.549901, 104.890661));
    meanchen.add(LatLng(11.548451, 104.886899));
    meanchen.add(LatLng(11.547462, 104.875377));
    meanchen.add(LatLng(11.547303, 104.872292));
    //Khan_Chamkar_Mon
    List<LatLng> Khan_Chamkar_Mon = <LatLng>[];
    Khan_Chamkar_Mon.add(LatLng(11.555881, 104.920626));
    Khan_Chamkar_Mon.add(LatLng(11.555987, 104.924704));
    Khan_Chamkar_Mon.add(LatLng(11.556836, 104.928836));
    Khan_Chamkar_Mon.add(LatLng(11.556977, 104.931958));
    Khan_Chamkar_Mon.add(LatLng(11.556890, 104.933198));
    Khan_Chamkar_Mon.add(LatLng(11.556660, 104.934152));
    Khan_Chamkar_Mon.add(LatLng(11.556922, 104.935708));
    Khan_Chamkar_Mon.add(LatLng(11.557016, 104.939753));
    Khan_Chamkar_Mon.add(LatLng(11.557203, 104.943550));
    Khan_Chamkar_Mon.add(LatLng(11.556910, 104.943873));
    Khan_Chamkar_Mon.add(LatLng(11.556125, 104.944408));
    Khan_Chamkar_Mon.add(LatLng(11.555375, 104.944650));
    Khan_Chamkar_Mon.add(LatLng(11.554650, 104.944639));
    Khan_Chamkar_Mon.add(LatLng(11.551096, 104.944752));
    Khan_Chamkar_Mon.add(LatLng(11.551076, 104.944989));
    Khan_Chamkar_Mon.add(LatLng(11.550944, 104.944929));
    Khan_Chamkar_Mon.add(LatLng(11.549930, 104.944794));
    Khan_Chamkar_Mon.add(LatLng(11.549777, 104.944795));
    Khan_Chamkar_Mon.add(LatLng(11.549573, 104.944858));
    Khan_Chamkar_Mon.add(LatLng(11.549415, 104.944848));
    Khan_Chamkar_Mon.add(LatLng(11.549004, 104.944778));
    Khan_Chamkar_Mon.add(LatLng(11.548796, 104.944687));
    Khan_Chamkar_Mon.add(LatLng(11.548429, 104.944376));
    Khan_Chamkar_Mon.add(LatLng(11.547483, 104.943877));
    Khan_Chamkar_Mon.add(LatLng(11.545769, 104.942702));
    Khan_Chamkar_Mon.add(LatLng(11.544571, 104.941324));
    Khan_Chamkar_Mon.add(LatLng(11.544082, 104.940556));
    Khan_Chamkar_Mon.add(LatLng(11.543909, 104.940063));
    Khan_Chamkar_Mon.add(LatLng(11.543089, 104.938126));
    Khan_Chamkar_Mon.add(LatLng(11.542868, 104.937381));
    Khan_Chamkar_Mon.add(LatLng(11.542493, 104.935370));
    Khan_Chamkar_Mon.add(LatLng(11.542359, 104.934964));
    Khan_Chamkar_Mon.add(LatLng(11.542102, 104.934443));
    Khan_Chamkar_Mon.add(LatLng(11.541492, 104.933437));
    Khan_Chamkar_Mon.add(LatLng(11.541292, 104.933080));
    Khan_Chamkar_Mon.add(LatLng(11.541080, 104.932939));
    Khan_Chamkar_Mon.add(LatLng(11.540755, 104.932429));
    Khan_Chamkar_Mon.add(LatLng(11.539304, 104.931421));
    Khan_Chamkar_Mon.add(LatLng(11.537704, 104.930732));
    Khan_Chamkar_Mon.add(LatLng(11.536454, 104.930502));
    Khan_Chamkar_Mon.add(LatLng(11.533842, 104.930911));
    Khan_Chamkar_Mon.add(LatLng(11.532066, 104.931561));
    Khan_Chamkar_Mon.add(LatLng(11.530931, 104.932033));
    Khan_Chamkar_Mon.add(LatLng(11.529948, 104.928478));
    Khan_Chamkar_Mon.add(LatLng(11.526822, 104.921027));
    Khan_Chamkar_Mon.add(LatLng(11.526622, 104.918730));
    Khan_Chamkar_Mon.add(LatLng(11.527922, 104.916204));
    Khan_Chamkar_Mon.add(LatLng(11.529247, 104.914979));
    Khan_Chamkar_Mon.add(LatLng(11.541099, 104.908728));
    Khan_Chamkar_Mon.add(LatLng(11.542099, 104.907962));
    Khan_Chamkar_Mon.add(LatLng(11.543074, 104.906584));
    Khan_Chamkar_Mon.add(LatLng(11.543541, 104.905135));
    Khan_Chamkar_Mon.add(LatLng(11.543801, 104.902836));
    Khan_Chamkar_Mon.add(LatLng(11.544151, 104.901569));
    Khan_Chamkar_Mon.add(LatLng(11.545028, 104.900211));
    Khan_Chamkar_Mon.add(LatLng(11.546002, 104.899278));
    Khan_Chamkar_Mon.add(LatLng(11.547265, 104.898664));
    Khan_Chamkar_Mon.add(LatLng(11.548328, 104.898520));
    Khan_Chamkar_Mon.add(LatLng(11.557671, 104.908230));
    Khan_Chamkar_Mon.add(LatLng(11.555646, 104.910758));
    Khan_Chamkar_Mon.add(LatLng(11.555881, 104.920626));

    _pg = [
      Khan_Chamkar_Mon,
      Daun_Penh,
      K7_Makara,
      Khan_Tuol_Kouk,
      meanchen,
      Chbar_Ampov,
      CHROUY_CHANGVA,
      Khan_Sen_Sok,
      Khan_Russey_Keo,
      Khan_Dangkor,
      Khan_Pou_Senchey,
      Khan_Preaek_Pnov
    ];
  }

  @override
  void initState() {
    _handleLocationPermission();
    _getCurrentLocation();
    _setPolygons();
    super.initState();
  }

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
      },
    );

    setState(() {
      _marker.add(newMarker);
      lat_verbal = latLng.latitude;
      log_verbal = latLng.longitude;
      Find_by_piont(latLng.latitude, latLng.longitude);
      // add the new marker to the list of markers
    });
  }

  var formatter = NumberFormat("##,###,###,###.00", "en_US");
  Future<void> _addMarker_by_datavelbal(LatLng latLng, String min, String max,
      String Type, String id_verbal) async {
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      infoWindow: InfoWindow(
          snippet: "${Type} More ...",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => detail_verbal_by_id(
                  id_verbal: id_verbal.toString(),
                ),
              ),
            );
          },
          title:
              '${formatter.format(double.parse(min))}\$ ~ ${formatter.format(double.parse(max))}\$'),
    );

    setState(() {
      _marker.add(newMarker);
    });
  }

  String? start, end;
  int? number_for_count_verbal;
  List data_of_verbal = [];
  List data_of_price = [];
  Future<void> Get_data_verbal(
      double la, double lo, String number_for_count_verbal) async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal_models/${la}/${lo}/${number_for_count_verbal}?start=${start}&end=${end}'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        data_of_verbal = jsonResponse['data'];
        data_of_price = jsonResponse['number'];
        for (int i = 0; i < data_of_verbal.length; i++) {
          _addMarker_by_datavelbal(
            LatLng(data_of_verbal[i]['latlong_log'],
                data_of_verbal[i]['latlong_la']),
            data_of_price[i][0].toString(),
            data_of_price[i][1].toString(),
            data_of_price[i][3].toString(),
            data_of_verbal[i]['verbal_id'].toString(),
          );
        }
      });
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  SizedBox(
                      child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: latLng, zoom: 12),
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
                    margin: EdgeInsets.only(right: 70, top: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
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
                                      MediaQuery.of(context).textScaleFactor *
                                          0.04,
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
                                num =
                                    1; // use num for when user click on list search
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ToFromDate(
                      fromDate: (value) {
                        setState(() {
                          start = value.toString();
                        });
                      },
                      toDate: (value) {
                        setState(() {
                          end = value.toString();
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: FormS(
                      label: 'Count Verbal',
                      onSaved: (input) {
                        setState(() {
                          number_for_count_verbal = int.parse(input.toString());
                        });
                      },
                      iconname: Icon(
                        Icons.location_on_rounded,
                        color: kImageColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: GFButtonBadge(
                      onPressed: () async {
                        await Get_data_verbal(lat_verbal!, log_verbal!,
                            number_for_count_verbal.toString());
                      },
                      text: "Show",
                      shape: GFButtonShape.pills,
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).textScaleFactor * 16),
                      fullWidthButton: true,
                    ),
                  ),
                ],
              ),
            ),
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
      // final response_rc = await http.get(Uri.parse(
      //     'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price?Khan_Name=${district.toString()}&Sangkat_Name=${commune.toString()}'));
      // var jsonResponse_rc = json.decode(response_rc.body);
      // _Find_polygons.clear();
      // // await maker_of_verbal_in_map(jsonResponse_rc['auto_verbal'],
      // //     jsonResponse_rc['data_min'], jsonResponse_rc['data_max']);
      // setState(() {
      //   maxSqm1 = jsonResponse_rc['residential'][0]['Min_Value'].toString();
      //   minSqm1 = jsonResponse_rc['residential'][0]['Max_Value'].toString();
      //   index_map =
      //       int.parse(jsonResponse_rc['residential'][0]['Khan_ID'].toString());
      //   maxSqm2 = jsonResponse_rc['commercial'][0]['Min_Value'].toString();
      //   minSqm2 = jsonResponse_rc['commercial'][0]['Max_Value'].toString();
      //   widget.get_max1(maxSqm1);
      //   widget.get_min1(minSqm1);
      //   widget.get_max2(maxSqm2);
      //   widget.get_min2(minSqm2);
      //   AwesomeDialog(
      //     btnOkOnPress: () {},
      //     context: context,
      //     animType: AnimType.leftSlide,
      //     headerAnimationLoop: false,
      //     dialogType: DialogType.infoReverse,
      //     showCloseIcon: false,
      //     title: "Check price by KFA",
      //     customHeader: Image.asset(
      //       'assets/images/new_logo.png',
      //       filterQuality: FilterQuality.high,
      //       fit: BoxFit.contain,
      //     ),
      //     body: Column(
      //       children: [
      //         const Text(
      //           "Price for commercial",
      //           style: TextStyle(fontWeight: FontWeight.bold),
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //             color: const Color.fromARGB(255, 220, 221, 223),
      //             boxShadow: const [
      //               BoxShadow(blurRadius: 1, color: Colors.grey)
      //             ],
      //             border: Border.all(
      //               width: 0.2,
      //             ),
      //             borderRadius: BorderRadius.circular(5),
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Row(
      //                 children: [
      //                   const Text("Max = ",
      //                       style: TextStyle(fontWeight: FontWeight.bold)),
      //                   Text("${maxSqm1}0\$",
      //                       style: const TextStyle(color: Colors.red))
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   const Text("Min = ",
      //                       style: TextStyle(fontWeight: FontWeight.bold)),
      //                   Text("${minSqm1}0\$",
      //                       style: const TextStyle(color: Colors.red))
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //         const Text(
      //           "Price for residential",
      //           style: TextStyle(fontWeight: FontWeight.bold),
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //             color: const Color.fromARGB(255, 220, 221, 223),
      //             border: Border.all(
      //               width: 0.2,
      //             ),
      //             boxShadow: const [
      //               BoxShadow(blurRadius: 1, color: Colors.grey)
      //             ],
      //             borderRadius: BorderRadius.circular(5),
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Row(
      //                 children: [
      //                   const Text("Max = ",
      //                       style: TextStyle(fontWeight: FontWeight.bold)),
      //                   Text("${maxSqm2}0\$",
      //                       style: const TextStyle(color: Colors.red))
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   const Text("Min = ",
      //                       style: TextStyle(fontWeight: FontWeight.bold)),
      //                   Text("${minSqm2}0\$",
      //                       style: const TextStyle(color: Colors.red))
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //         Text(
      //           ' $commune /  $district',
      //           style:
      //               const TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
      //           overflow: TextOverflow.ellipsis,
      //         ),
      //       ],
      //     ),
      //   ).show();
      // });
      // await Check_price_Area_commercial();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     action: SnackBarAction(
      //         label: "View",
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return AlertDialog(
      //                 title: const Text('Delial Image'),
      //                 content: Container(
      //                   height: 200,
      //                   decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                           image: NetworkImage(
      //                               'https://maps.googleapis.com/maps/api/staticmap?center=${lati},${longi}&zoom=20&size=500x500&maptype=hybrid&markers=color:red%7Clabel:K%7C${lati},${longi}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'))),
      //                 ),
      //               );
      //             },
      //           );
      //         }),
      //     content: Text(' $commune /  $district'),
      //   ),
      // );
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
