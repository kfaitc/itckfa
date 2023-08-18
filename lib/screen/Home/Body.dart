// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, non_constant_identifier_names, deprecated_member_use, unused_local_variable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/afa/screens/AutoVerbal/Add.dart';
import 'package:itckfa/screen/Account/account.dart';
import 'package:itckfa/screen/Home/Customs/Model-responsive.dart';
import 'package:itckfa/screen/Promotion/membership_real.dart';
import 'package:itckfa/screen/Promotion/partnerList_real.dart';

// import 'package:itckfa/screen/Home/Customs/MenuCard.dart';
import 'package:http/http.dart' as http;
import 'package:itckfa/screen/Promotion/Title_promo.dart';
import 'package:itckfa/screen/Promotion/promotion.dart';
import 'package:itckfa/screen/Home/Customs/titleBar.dart';
import 'package:itckfa/screen/components/map_all/map_in_add_body.dart';
// import 'package:itckfa/screen/components/map_all/map_in_add_verbal.dart';

// import '../../afa/components/slideUp.dart';
import '../../models/autoVerbal.dart';

// import 'Customs/googlemapkfa/detailmap.dart';

class Body extends StatefulWidget {
  final String user;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  final double? lat;
  final double? log;
  // final String? c_id;
  // final String? district;
  // final String? commune;
  // final String? province;
  // final String? log;
  // final String? lat;

  const Body({
    Key? key,
    // required this.c_id,
    // required this.commune,
    // required this.district,
    // required this.province,
    // required this.log,
    // required this.lat,

    required this.lat,
    required this.log,
    required this.user,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AutoVerbalRequestModel requestModelAuto;
  String? _currentAddress;
  Position? _currentPosition;
  Uint8List? get_bytes;
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
    _getCurrentPosition();
    return true;
  }

  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      log = position.longitude;
      Find_by_piont(lat, log);
    });
  }

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  var formatter = NumberFormat("##,###,###,##0.00", "en_US");
  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
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
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
          }
        }
      }
      final response_rc = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price?Khan_Name=${district.toString()}&Sangkat_Name=${commune.toString()}'));
      var jsonResponse_rc = json.decode(response_rc.body);
      setState(() {
        maxSqm1 = jsonResponse_rc['residential'][0]['Min_Value'].toString();
        minSqm1 = jsonResponse_rc['residential'][0]['Max_Value'].toString();
        maxSqm2 = jsonResponse_rc['commercial'][0]['Min_Value'].toString();
        minSqm2 = jsonResponse_rc['commercial'][0]['Max_Value'].toString();
        R_avg = (double.parse(maxSqm1.toString()) +
                double.parse(minSqm1.toString())) /
            2;
        C_avg = (double.parse(maxSqm2.toString()) +
                double.parse(minSqm2.toString())) /
            2;
      });
    } else {
      print(response.statusCode);
    }
  }

  double? R_avg;
  double? C_avg;
  Future<void> change_price() async {
    final response_rc = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price?Khan_Name=${district.toString()}&Sangkat_Name=${commune.toString()}'));
    var jsonResponse_rc = json.decode(response_rc.body);
    setState(() {
      maxSqm1 = jsonResponse_rc['residential'][0]['Min_Value'].toString();
      minSqm1 = jsonResponse_rc['residential'][0]['Max_Value'].toString();
      maxSqm2 = jsonResponse_rc['commercial'][0]['Min_Value'].toString();
      minSqm2 = jsonResponse_rc['commercial'][0]['Max_Value'].toString();
      R_avg = (double.parse(maxSqm1.toString()) +
              double.parse(minSqm1.toString())) /
          2;
      C_avg = (double.parse(maxSqm2.toString()) +
              double.parse(minSqm2.toString())) /
          2;
    });
  }

  @override
  void initState() {
    _handleLocationPermission();
    super.initState();

    requestModelAuto = AutoVerbalRequestModel(
      property_type_id: "",
      lat: "",
      lng: "",
      address: '',
      approve_id: "", agent: "",
      bank_branch_id: "",
      bank_contact: "",
      bank_id: "",
      bank_officer: "",
      code: "",
      comment: "",
      contact: "",
      date: "",
      image: "",
      option: "",
      owner: "",
      user: "10",
      verbal_com: '',
      verbal_con: "",
      verbal: [],
      verbal_id: "0", verbal_khan: '',

      // autoVerbal: [requestModelVerbal],
      // data: requestModelVerbal,
    );
    // Future.delayed(const Duration(seconds: 5), () {
    //   if (maxSqm1 == null) {
    //     _getCurrentPosition();
    //   }
    // });
  }

  var lat;
  var log;
  var district;
  double? wth;
  double? wth2;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    if (w < 600) {
      wth = w * 0.6;
      wth2 = w * 0.3;
    } else {
      wth = w * 0.5;
      wth2 = w * 0.3;
    }
    DateTime timeNow = DateTime.now();

    String formattedDate = DateFormat('dd MM yyyy').format(timeNow);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        title: TitleBar(),
        actions: [
          GFIconBadge(
            position: GFBadgePosition.topEnd(top: 15),
            counterChild: GFBadge(
              shape: GFBadgeShape.circle,
              child: Text("0"),
            ),
            child: GFIconButton(
              padding: const EdgeInsets.all(1),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Account(
                    username: widget.user,
                    email: widget.email,
                    first_name: widget.first_name,
                    last_name: widget.last_name,
                    gender: widget.gender,
                    from: widget.from,
                    tel: widget.tel,
                    id: widget.id,
                  );
                }));
              },
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 30,
              ),
              color: Colors.white,
              type: GFButtonType.outline2x,
              size: 40,
              disabledColor: Colors.white,
              shape: GFIconButtonShape.circle,
            ),
          ),
        ],
      ),
      backgroundColor: kwhite_new,
      body: Container(
        color: kwhite_new,
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40),
                margin: EdgeInsets.only(top: 170),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Scard(
                        username: widget.user,
                        email: widget.email,
                        first_name: widget.first_name,
                        last_name: widget.last_name,
                        gender: widget.gender,
                        from: widget.from,
                        tel: widget.tel,
                        id: widget.id,
                      ),
                    ),
                    // Menu(
                    //   user: widget.user,
                    //   email: widget.email,
                    //   first_name: widget.first_name,
                    //   last_name: widget.last_name,
                    //   gender: widget.gender,
                    //   from: widget.from,
                    //   tel: widget.tel,
                    //   id: widget.id,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    if (commune != null)
                      Text(
                        '   $commune /  $district',
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    Stack(
                      children: [
                        if (lat != null)
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Map_verbal_body(
                                        get_commune: (value) {
                                          setState(() {
                                            commune = value.toString();
                                          });
                                        },
                                        get_district: (value) {
                                          setState(() {
                                            district = value.toString();
                                          });
                                        },
                                        get_lat: (value) {
                                          setState(() {
                                            lat = value;
                                          });
                                        },
                                        get_log: (value) {
                                          setState(() {
                                            log = value;
                                          });
                                        },
                                        get_province: (value) {},
                                        get_max1: (value) {
                                          setState(() {
                                            maxSqm1 = value;
                                          });
                                        },
                                        get_max2: (value) {
                                          setState(() {
                                            maxSqm2 = value;
                                          });
                                        },
                                        get_min1: (value) {
                                          setState(() {
                                            minSqm1 = value;
                                          });
                                        },
                                        get_min2: (value) {
                                          setState(() {
                                            minSqm2 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width * 1,
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 3),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                            ),
                          ),
                        Positioned(
                          child: Container(
                            width: wth,
                            height: 25,
                            padding: EdgeInsets.only(left: 10),
                            margin:
                                EdgeInsets.only(right: 70, top: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: wth2,
                                  child: TextFormField(
                                    onFieldSubmitted: (value) {},
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    readOnly: true,
                                    textInputAction: TextInputAction.search,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: "Search",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 2),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[850],
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            0.04,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    // splashRadius: 30,
                                    hoverColor: Colors.black,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.search,
                                      size: 10,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.person_pin_circle_outlined,
                                      size: 10,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            top: 15,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.mp_sharp,
                                  color: Color.fromRGBO(0, 184, 212, 1),
                                  size: 10,
                                ),
                                onPressed: () {},
                              ),
                            )),
                      ],
                    ),
                    if (maxSqm1 != null && R_avg != null)
                      Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width * 1,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 7, 9, 145),
                          border: Border.all(
                            width: 0.01,
                          ),
                          image: DecorationImage(
                            opacity: 0.2,
                            image: AssetImage('assets/images/KFA-Logo.png'),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Residential",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dashed,
                                  color: Colors.white),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(234, 255, 255, 255),
                                border:
                                    Border.all(width: 0.2, color: Colors.green),

                                borderRadius: BorderRadius.circular(5),

                                // gradient: LinearGradient(
                                //   begin: Alignment.topLeft,
                                //   end: Alignment.bottomRight,
                                //   colors: [
                                //     Color.fromARGB(255, 244, 249, 255),
                                //     Color.fromARGB(255, 246, 254, 255)
                                //   ],
                                // ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Avg = ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                      Text("${formatter.format(R_avg!)}\$",
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: Color.fromARGB(
                                                  255, 242, 11, 134)))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Min = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                          Text(
                                              "${formatter.format(double.parse(maxSqm1))}\$",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Max = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                          Text(
                                              "${formatter.format(double.parse(minSqm1))}\$",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                color: Colors.white, height: 10, thickness: 3),
                            Text(
                              "Commercial",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dashed,
                                  color: Colors.white),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(234, 255, 255, 255),
                                border:
                                    Border.all(width: 0.2, color: Colors.green),
                                // boxShadow: const [
                                //   BoxShadow(blurRadius: 1, color: Colors.grey)
                                // ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Avg = ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                      Text("${formatter.format(C_avg!)}\$",
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: Color.fromARGB(
                                                  255, 242, 11, 134)))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Min = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                          Text(
                                              "${formatter.format(double.parse(maxSqm2))}\$",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Max = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                          Text(
                                              "${formatter.format(double.parse(minSqm2))}\$",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Title_promotion2(
                      title_promo: 'Our Partners',
                      title_promo1: 'Show all',
                    ),
                    Divider(
                      color: Colors.blueAccent,
                      thickness: 0.5,
                    ),
                    Screen_slider(),
                    SizedBox(
                      height: 15,
                    ),
                    Title_promotion(
                      title_promo: 'Our Membership',
                      title_promo1: 'Show all',
                    ),
                    Divider(
                      color: Colors.blueAccent,
                      thickness: 0.5,
                    ),
                    Membership_real(),
                    SizedBox(
                      height: 15,
                    ),
                    Title_promo(),
                    Promotion(),
                  ],
                ),
              ),
              Positioned(
                top: 2.0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1.0,
                  padding: EdgeInsets.only(top: 10),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Add_with_property(
                                    id: widget.id,
                                  )));
                        },
                        child: Container(
                          height: 130,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(0, 255, 193, 7),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 15,
                                color: kImageColor,
                                blurStyle: BlurStyle.outer,
                              )
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/earth.gif')),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 16,
                              backgroundColor: Colors.black45,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 15.0,
                                  color: Color.fromARGB(255, 248, 195, 195),
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                TypewriterAnimatedText('Cross Check'),
                                TypewriterAnimatedText('Your Property'),
                              ],
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Add_with_property(
                                          id: widget.id,
                                        )));
                              },
                              pause: const Duration(milliseconds: 300),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 95.0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.87,
                          decoration: BoxDecoration(
                            color: kImageColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: kImageColor,
                                blurStyle: BlurStyle.solid,
                                spreadRadius: 0.0,
                                offset: Offset(0.2, 0.1),
                              )
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Main Balance : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              10,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "0",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white,
                                  endIndent: 15,
                                  indent: 15,
                                  height: 1,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "My Plans : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              10,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "គម្រោង ឬ កញ្ចប់សេវាកម្ម",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white,
                                  endIndent: 15,
                                  indent: 15,
                                  height: 1,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Valid Until : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              10,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${formattedDate}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              10,
                                        ),
                                      ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? options;
  String? commune;

  var id_Sangkat;
  List<dynamic> list_sangkat = [];
  void Load_sangkat(String id) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_sangkat = jsonData;
        id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID']);
      });
    }
  }

  String? province;

  late List<dynamic> list_Khan;

  int id_khan = 0;
  void Load_khan(String district) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_Khan = jsonData;
        id_khan = int.parse(list_Khan[0]['Khan_ID']);
      });
    }
  }
}
