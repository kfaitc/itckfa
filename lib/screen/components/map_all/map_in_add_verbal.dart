// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itckfa/Option/components/colors.dart';
import 'package:itckfa/Option/components/contants.dart';
import '../../../Getx/Auth/Auth.dart';
import '../../../Getx/GoogleMap/GoogMap.dart';
import '../../../models/login_model.dart';
import '../../../models/search_model.dart';

typedef OnChangeCallback = void Function(dynamic value);

const kGoogleApiKey = 'AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class Map_verbal_add extends StatefulWidget {
  Map_verbal_add({
    super.key,
    required this.get_province,
    required this.get_district,
    required this.get_commune,
    required this.get_log,
    required this.get_lat,
    this.show_landmarket_price,
    required this.updateNew,
    required this.iduser,
  });
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final bool? show_landmarket_price;
  late int updateNew;
  final String iduser;

  @override
  State<Map_verbal_add> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<Map_verbal_add> {
  String sendAddrress = '';
  var formatter = NumberFormat("##,###,###,##0.00", "en_US");
  final Set<Marker> _marker = {};

  List<String> option = [
    'Residencial',
    'Commercial',
    'Agricultural',
  ];
  GoogleMapController? mapController;

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

  double? lat1;
  double? log1;

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16.0,
          ),
        ),
      );
      lat1 = position.latitude;
      log1 = position.longitude;
      latLng = LatLng(lat1!, log1!);
      _addMarker(latLng);
    });
  }

  final TextEditingController distanceController = TextEditingController();
  Authentication authentication = Authentication();
  double? lat;
  double? log;
  late LoginRequestModel loginRequestModel;
  @override
  void initState() {
    // if (Get.isRegistered<Authentication>()) {
    //   authentication = Get.find<Authentication>();
    // } else {
    //   authentication = Get.put(Authentication());
    //   authentication.login(loginRequestModel, false);
    // }
    _handleLocationPermission();
    distanceController.text = '5';
    // _getCurrentLocation();
    super.initState();
    waitingFuction();
  }

  bool checkFunction = false;
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

  String opionTypeID = '0';
  double areas = 0;
  double? minSqm, maxSqm, totalMin, totalMax, totalArea;
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

  List listBuilding = [];
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
    });
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
      } else {
        totalMin = minSqm! * area;
        totalMax = maxSqm! * area;
      }
    });
    //  }
  }
  // void addItemToList() {
  //   setState(() {
  //     listBuilding.add({
  //       "verbal_land_type": autoverbalType,
  //       "verbal_land_des": controllerDS.text,
  //       "verbal_land_dp": dep,
  //       "verbal_land_area": areas,
  //       "verbal_land_minsqm": minSqm!.toStringAsFixed(0),
  //       "verbal_land_maxsqm": maxSqm!.toStringAsFixed(0),
  //       "verbal_land_minvalue": totalMin!.toStringAsFixed(0),
  //       "verbal_land_maxvalue": totalMax!.toStringAsFixed(0),
  //       "address": '$commune / $district',
  //       "verbal_landid": verbalID
  //     });
  //   });
  // }

  bool clickdone = false;
  String priceCm = '';
  bool haveValue = false;
  List data_adding_correct = [];
  var avg;
  double? min, max;
  double adding_price = 0;
  LatLng latLng = const LatLng(11.519037, 104.915120);
  CameraPosition? cameraPosition;
  var colorbackground = const Color.fromARGB(255, 242, 242, 244);
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

  Future showDailogs() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        children: [
          AlertDialog(
            backgroundColor: Colors.transparent,
            // backgroundColor: Colors.red,
            content: Container(
              height: 450,
              // width: 450,
              decoration: BoxDecoration(
                color: whiteColor,
                // image: const DecorationImage(
                //   image: AssetImage("assets/images/paper1.jpg"),
                //   fit: BoxFit.fitWidth,
                // ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/papersib.png",
                          height: 35,
                          width: 50,
                          fit: BoxFit.fitHeight,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline_outlined,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // if (haveValue == true)
                        //   Card(
                        //     elevation: 10,
                        //     child: Container(
                        //       height: heightModel,
                        //       decoration: BoxDecoration(
                        //         color: colorbackground,
                        //         boxShadow: const [
                        //           BoxShadow(blurRadius: 1, color: Colors.grey)
                        //         ],
                        //         border: Border.all(width: 0.2),
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               textb("Avg = "),
                        //               textPriceb(
                        //                   "${formatter.format(adding_price)}\$"),
                        //             ],
                        //           ),
                        //           const SizedBox(height: 5),
                        //           Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceAround,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   text("Min = "),
                        //                   textPrice(
                        //                       "${formatter.format(adding_price - (0.01 * adding_price))}\$"),
                        //                 ],
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   text("Max = "),
                        //                   textPrice(
                        //                       "${formatter.format(adding_price + (0.01 * adding_price))}\$"),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   )
                        // else
                        //   Card(
                        //     elevation: 10,
                        //     child: Container(
                        //       height: 110,
                        //       decoration: BoxDecoration(
                        //         color: const Color.fromARGB(255, 242, 242, 244),
                        //         boxShadow: const [
                        //           BoxShadow(
                        //               blurRadius: 5,
                        //               offset: Offset(2, 5),
                        //               color: Color.fromARGB(255, 0, 89, 255))
                        //         ],
                        //         border: Border.all(
                        //           width: 0.2,
                        //         ),
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(5),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 textb("Avg = "),
                        //                 textPriceb(
                        //                     "${formatter.format(adding_price)}\$")
                        //               ],
                        //             ),
                        //             const SizedBox(height: 5),
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceAround,
                        //               children: [
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         text("Min = "),
                        //                         textPrice(
                        //                             "${formatter.format(adding_price - (0.01 * adding_price))}\$")
                        //                       ],
                        //                     ),
                        //                     const SizedBox(height: 15),
                        //                     Row(
                        //                       children: [
                        //                         text(
                        //                             "Min after - $add_min% = "),
                        //                         textPrice(
                        //                             "${formatter.format((adding_price - (0.01 * adding_price)) - ((add_min / 100) * (adding_price - (0.01 * adding_price))))}\$")
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         text("Max = "),
                        //                         textPrice(
                        //                             "${formatter.format(adding_price + (0.01 * adding_price))}\$")
                        //                       ],
                        //                     ),
                        //                     const SizedBox(height: 15),
                        //                     Row(
                        //                       children: [
                        //                         text(
                        //                             "Max after - $add_max% = "),
                        //                         textPrice(
                        //                             "${formatter.format((adding_price + (0.01 * adding_price)) - ((add_max / 100) * (adding_price + (0.01 * adding_price))))}\$")
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const SizedBox(height: 5),
                        //     Text("Residential",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: fontsizes)),
                        //     const SizedBox(height: 2),
                        //     Card(
                        //       elevation: 10,
                        //       child: Container(
                        //         height: heightModel,
                        //         decoration: BoxDecoration(
                        //           color: colorbackground,
                        //           boxShadow: const [
                        //             BoxShadow(blurRadius: 1, color: Colors.grey)
                        //           ],
                        //           border: Border.all(width: 0.2),
                        //           borderRadius: BorderRadius.circular(5),
                        //         ),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 textb("Avg = "),
                        //                 textPriceb(
                        //                     "${formatter.format(R_avg)}\$")
                        //               ],
                        //             ),
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceAround,
                        //               children: [
                        //                 Row(
                        //                   children: [
                        //                     text("Min = "),
                        //                     textPrice(
                        //                         "${formatter.format(double.parse(minSqm1))}\$")
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   children: [
                        //                     text("Max = "),
                        //                     textPrice(
                        //                         "${formatter.format(double.parse(maxSqm1))}\$")
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(height: 10),
                        //     Text("Commercial",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: fontsizes)),
                        //     const SizedBox(height: 5),
                        //     Card(
                        //       elevation: 10,
                        //       child: Container(
                        //         height: heightModel,
                        //         decoration: BoxDecoration(
                        //           color: colorbackground,
                        //           boxShadow: const [
                        //             BoxShadow(blurRadius: 1, color: Colors.grey)
                        //           ],
                        //           border: Border.all(width: 0.2),
                        //           borderRadius: BorderRadius.circular(5),
                        //         ),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 textb("Avg = "),
                        //                 textPriceb(
                        //                     "${formatter.format(C_avg)}\$")
                        //               ],
                        //             ),
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceAround,
                        //               children: [
                        //                 Row(
                        //                   children: [
                        //                     text("Min = "),
                        //                     textPrice(
                        //                         "${formatter.format(double.parse(minSqm2))}\$")
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   children: [
                        //                     text("Max = "),
                        //                     textPrice(
                        //                         "${formatter.format(double.parse(maxSqm2))}\$")
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(height: 10),
                        //     if (haveValue == true)
                        //       Text("Calculator Compareble and Land_price",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: fontsizes)),
                        //     if (haveValue == true) const SizedBox(height: 10),
                        //     if (haveValue == true)
                        //       Card(
                        //         elevation: 10,
                        //         child: Container(
                        //           height: 90,
                        //           decoration: BoxDecoration(
                        //             color: colorbackground,
                        //             border: Border.all(
                        //               width: 0.2,
                        //             ),
                        //             boxShadow: const [
                        //               BoxShadow(
                        //                   blurRadius: 5,
                        //                   offset: Offset(2, 5),
                        //                   color:
                        //                       Color.fromARGB(255, 0, 89, 255))
                        //             ],
                        //             borderRadius: BorderRadius.circular(5),
                        //           ),
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   textb("Avg = "),
                        //                   textPriceb(
                        //                       "${formatter.format(avg)}\$")
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 5),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceAround,
                        //                 children: [
                        //                   Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           text("Min = "),
                        //                           textPrice(
                        //                               "${formatter.format(min)}\$")
                        //                         ],
                        //                       ),
                        //                       const SizedBox(height: 10),
                        //                       Row(
                        //                         children: [
                        //                           textb(
                        //                               "Min after - $add_min% = "),
                        //                           textPriceb(
                        //                               "${formatter.format(min! - ((add_min / 100) * min!))}\$")
                        //                         ],
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           text("Max = "),
                        //                           textPrice(
                        //                               "${formatter.format(max)}\$")
                        //                         ],
                        //                       ),
                        //                       const SizedBox(height: 10),
                        //                       Row(
                        //                         children: [
                        //                           textb(
                        //                               "Min after - $add_min% = "),
                        //                           textPriceb(
                        //                               "${formatter.format(max! - ((add_max / 100) * max!))}\$")
                        //                         ],
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //   ],
                        // ),
                        // const SizedBox(height: 10),
                        // if (haveValue == false)
                        //   if (data_adding_correct.length >= 5)
                        //     if (haveValue == false)
                        //       Text.rich(
                        //         TextSpan(
                        //           children: [
                        //             for (int i = 0;
                        //                 i < data_adding_correct.length;
                        //                 i++)
                        //               TextSpan(
                        //                   style: TextStyle(
                        //                     fontSize: fontsize,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                   text:
                        //                       '${(i < data_adding_correct.length - 1) ? '${data_adding_correct[i]['comparable_adding_price']} + ' : data_adding_correct[i]['comparable_adding_price']}'),
                        //             TextSpan(
                        //                 text:
                        //                     ' / ${data_adding_correct.length} = ${formatter.format(adding_price)}\$',
                        //                 style: TextStyle(
                        //                     fontSize: fontsize,
                        //                     fontWeight: FontWeight.bold,
                        //                     color: colorsPrice)),
                        //           ],
                        //         ),
                        //       ),
                        // const SizedBox(height: 5),
                        // Text(
                        //   "$commune /  $district / Route : ${route.toString()}",
                        //   style: const TextStyle(
                        //       fontStyle: FontStyle.italic,
                        //       fontSize: 13,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.bold),
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        // if (haveValue == true)
                        //   Text.rich(
                        //     TextSpan(
                        //       style: TextStyle(
                        //         fontSize: fontsize,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //       text:
                        //           '\n(${formatter.format(adding_price)}\$ + ${formatter.format(R_avg)}\$ + ${formatter.format(C_avg)}\$) /2 = ', // default text style
                        //       children: <TextSpan>[
                        //         TextSpan(
                        //             text: '${formatter.format(avg)}\$',
                        //             style: TextStyle(
                        //                 fontSize: fontsize,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: colorsPrice)),
                        //       ],
                        //     ),
                        //   ),
                        // const SizedBox(height: 5),
                        // if (haveValue == true)
                        //   Card(
                        //     elevation: 10,
                        //     child: Container(
                        //       height: 90,
                        //       decoration: BoxDecoration(
                        //         color: const Color.fromARGB(255, 242, 242, 244),
                        //         boxShadow: const [
                        //           BoxShadow(
                        //               blurRadius: 5,
                        //               offset: Offset(2, 5),
                        //               color: Color.fromARGB(255, 0, 89, 255))
                        //         ],
                        //         border: Border.all(
                        //           width: 0.2,
                        //         ),
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(5),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 for (int i = 0;
                        //                     i < data_adding_correct.length;
                        //                     i++)
                        //                   Text(
                        //                       "${(i < data_adding_correct.length - 1) ? '${data_adding_correct[i]['comparable_adding_price']} + ' : data_adding_correct[i]['comparable_adding_price']}",
                        //                       style: TextStyle(
                        //                           fontSize: fontsize,
                        //                           fontWeight: FontWeight.bold,
                        //                           color: Colors.black)),
                        //                 textPriceb(" Avg = "),
                        //                 textPriceb(
                        //                     "${formatter.format(adding_price)}\$"),
                        //               ],
                        //             ),
                        //             const SizedBox(height: 10),
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceAround,
                        //               children: [
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         textb(
                        //                             "Min after - $add_min% = "),
                        //                         textPriceb(
                        //                             "${formatter.format(adding_price - (0.01 * adding_price) - ((adding_price - (0.01 * adding_price)) * add_min) / 100)}\$"),
                        //                       ],
                        //                     ),
                        //                     const SizedBox(height: 10),
                        //                     Row(
                        //                       children: [
                        //                         text("Min = "),
                        //                         textPrice(
                        //                             "${formatter.format(adding_price - (0.01 * adding_price))}\$"),
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         textb(
                        //                             "Max after - $add_min% = "),
                        //                         textPrice(
                        //                             "${formatter.format(adding_price + (0.01 * adding_price) - ((adding_price + (0.01 * adding_price)) * add_min) / 100)}\$"),
                        //                       ],
                        //                     ),
                        //                     const SizedBox(height: 10),
                        //                     Row(
                        //                       children: [
                        //                         text("Max = "),
                        //                         textPrice(
                        //                             "${formatter.format(adding_price + (0.01 * adding_price))}\$"),
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
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
  }

  var colorstitle = const Color.fromARGB(255, 141, 140, 140);
  var colorsPrice = const Color.fromARGB(255, 241, 31, 23);
  double heightModel = 50;
  double fontsize = 14;
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

  late SearchRequestModel requestModel;
  Future<void> _addMarker(LatLng latLng) async {
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
        findBYPiont(value.latitude, value.longitude);
      },
    );

    setState(() {
      _marker.clear();
      findBYPiont(latLng.latitude, latLng.longitude);
      // add the new marker to the list of markers
      _marker.add(newMarker);
    });
  }

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  // // ignore: non_constant_identifier_names
  // Future<void> Check_price_Area_commercial() async {
  //   var rs1 = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commercial?Khan_ID=${id_khan}&Sangkat_ID=${id_Sangkat}'));
  //   var jsonData = jsonDecode(rs1.body);
  //   setState(() {
  //     maxSqm1 = double.parse(jsonData[0]['Max_Value']);
  //     minSqm1 = double.parse(jsonData[0]['Min_Value']);
  //     print("Max 1 = ${maxSqm1}");
  //   });
  // }

  // // ignore: non_constant_identifier_names
  // Future<void> Check_price_Area_residential() async {
  //   var rs2 = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/residential?Khan_ID=${id_khan}&Sangkat_ID=${id_Sangkat}'));
  //   var jsonData2 = jsonDecode(rs2.body);
  //   setState(() {
  //     maxSqm2 = double.parse(jsonData2[0]['Max_Value']);
  //     minSqm2 = double.parse(jsonData2[0]['Min_Value']);
  //     print("Max 2 = ${maxSqm2}");
  //   });
  //   var rs1 = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commercial?Khan_ID=${id_khan}&Sangkat_ID=${id_Sangkat}'));
  //   var jsonData = jsonDecode(rs1.body);
  //   setState(() {
  //     maxSqm1 = double.parse(jsonData[0]['Max_Value']);
  //     minSqm1 = double.parse(jsonData[0]['Min_Value']);
  //     print("Max 1 = ${maxSqm1}");
  //   });
  // }

  // var id_khan;
  // List list_Khan = [];
  // void Load_khan(var district) async {
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}'));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body);
  //     setState(() {
  //       list_Khan = jsonData;
  //       id_khan = int.parse(list_Khan[0]['Khan_ID'].toString());
  //     });
  //   }
  // }

  // var id_Sangkat;
  // List<dynamic> list_sangkat = [];
  // void Load_sangkat(var commune) async {
  //   setState(() {});
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${commune}'));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body);
  //     setState(() {
  //       list_sangkat = jsonData;
  //       id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID'].toString());
  //     });
  //   }
  // }

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
  final Set<Polyline> _polylines = <Polyline>{};
  List<MapType> style_map = [
    MapType.satellite,
    MapType.normal,
  ];
  TextEditingController Tcon = TextEditingController();
  int index = 0;
  String? name_of_place;

  GlobalKey<FormState> check = GlobalKey<FormState>();
  ControllerMap controller = ControllerMap();
  var input;
  double? wth;
  double? wth2;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        centerTitle: true,
        title: const Text("Property Location"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.system_update_tv_rounded),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 800,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: latLng, zoom: 12),
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
              onLongPress: (argument) {
                _addMarker(argument);
                Dialog(context);
                // Show(requestModel);
              },
              onTap: (argument) {
                // setState(() {
                //   widget.get_lat(argument.latitude.toString());
                //   widget.get_log(argument.longitude.toString());
                // });
                // _addMarker(argument);
              },
            ),
          ),
          Container(
            width: wth,
            margin: const EdgeInsets.only(right: 70, top: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Search",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 2),
                        hintStyle: TextStyle(
                          color: Colors.grey[850],
                          fontSize:
                              MediaQuery.of(context).textScaleFactor * 0.04,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
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
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _getCurrentLocation();
                      });
                    },
                    icon: const Icon(Icons.person_pin_circle_outlined),
                  )
                ],
              ),
            ),
          ),
          if (name_place.isNotEmpty)
            Container(
              height: h,
              color: Colors.white,
              margin: const EdgeInsets.only(left: 10, right: 55, top: 60),
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
                          ln[index].toString(),
                          lg[index].toString(),
                        );
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
                  color: kwhite_new,
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
    );
  }

  String? id_route;
  String? route;
  String province = '';
  Future<void> findBYPiont(double la, double lo) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$la,$lo&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
      ),
    );
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
                // Load_khan(district);

                widget.get_district(
                  jsonResponse['results'][j]['address_components'][i]
                      ['short_name'],
                );
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
                widget.get_commune(
                  jsonResponse['results'][j]['address_components'][i]
                      ['short_name'],
                );
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
              });
            }
          }
        }
      }

      widget.get_province(
        "${(district == "null") ? "" : district}, ${(commune == "null") ? "" : commune}",
      );
      if (checkFunction == false) {
        await checkKhatIDSangID(district, commune);
      }
    }
  }

  double R_avg = 0, C_avg = 0;
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

  List name_place = [];
  Future<void> Find_Lat_log(var place) async {
    var checkCharetor = place.split(',');
    if (checkCharetor.length == 1) {
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=${checkCharetor[0]}&region=kh&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
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
          findBYPiont(value.latitude, value.longitude);
        },
        infoWindow: const InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        _marker.clear();
        findBYPiont(lati, longi);
        _marker.add(newMarker);
      });

      // print('------------------- $latitude');
      // print('------------------- $longitude');

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 13),
        ),
      );
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
              print('Value ');
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
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${checkCharetor[0]},${checkCharetor[1]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
        ),
      );

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
          findBYPiont(value.latitude, value.longitude);
        },
        infoWindow: const InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        _marker.clear();
        findBYPiont(lati, longi);
        _marker.add(newMarker);
      });

      // print('------------------- $latitude');
      // print('------------------- $longitude');

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 13),
        ),
      );
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

  bool doneORudone = false;
  int checkborey = 0;
  var pty;
  String comparedropdown = '';
  // ignore: prefer_typing_uninitialized_variables
  var commune, district;
  bool isApiCallProcess = false;
  List list = [];
  Map? map;
  double addingPriceVerbal = 0;
  double addingPriceSimple = 0;
  Future<void> Show(SearchRequestModel requestModel) async {
    if (controller.listMainRoute.isNotEmpty &&
        controller.listRaod.isNotEmpty &&
        controller.listPriceR.isNotEmpty &&
        controller.listPriceC.isNotEmpty &&
        controller.listKhanP.isNotEmpty &&
        controller.listsang.isNotEmpty &&
        controller.listOption.isNotEmpty &&
        controller.listdropdown.isNotEmpty) {
      try {
        setState(() {
          isApiCallProcess = true;
        });

        if (route != null) {
          for (int i = 0; i < controller.listMainRoute.length; i++) {
            if (route.toString().contains(
                      controller.listMainRoute[i]['name_road'].toString(),
                    ) ||
                comparedropdown == "C") {
              haveValue = true;
              break;
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
            print("list ===> ${list.length}");
          });
        }
        addingPriceSimple = 0;
        addingPriceVerbal = 0;
        if (list.length >= 5) {
          List<dynamic> filteredList = filterDuplicates(
              list, "comparable_adding_price", "latlong_la", "latlong_log");

          setState(() {
            isApiCallProcess = false;
            map = filteredList.asMap();
          });

          // setState(() {
          //   for (var i = 0; i < map!.length; i++) {
          //     if (checkborey == 1) {
          //       if (map![i]['borey'] == 1) {
          //         if (map![i]['type_value'] == "V") {
          //           if (map![i]['comparable_adding_price'] == '') {
          //             map![i]['comparable_adding_price'] = '0';
          //             addingPriceVerbal +=
          //                 double.parse(map![i]['comparable_adding_price']);
          //           } else if (map![i]['comparable_adding_price']
          //               .contains(',')) {
          //             addingPriceVerbal += double.parse(map![i]
          //                     ['comparable_adding_price']
          //                 .replaceAll(",", ""));
          //           } else {
          //             addingPriceVerbal +=
          //                 (double.parse(map![i]['comparable_adding_price']));
          //           }
          //         } else {
          //           {
          //             if (map![i]['comparable_adding_price'] == '') {
          //               map![i]['comparable_adding_price'] = '0';
          //               addingPriceSimple +=
          //                   double.parse(map![i]['comparable_adding_price']);
          //             } else if (map![i]['comparable_adding_price']
          //                 .contains(',')) {
          //               addingPriceSimple += double.parse(map![i]
          //                       ['comparable_adding_price']
          //                   .replaceAll(",", ""));
          //             } else {
          //               addingPriceSimple +=
          //                   (double.parse(map![i]['comparable_adding_price']));
          //             }
          //           }
          //         }
          //         setState(() {
          //           data_adding_correct.add(map![i]);
          //         });
          //       }
          //     } else {
          //       if (map![i]['type_value'] == "V") {
          //         if (map![i]['comparable_adding_price'] == '') {
          //           map![i]['comparable_adding_price'] = '0';
          //           addingPriceVerbal +=
          //               double.parse(map![i]['comparable_adding_price']);
          //         } else if (map![i]['comparable_adding_price'].contains(',')) {
          //           addingPriceVerbal += double.parse(
          //               map![i]['comparable_adding_price'].replaceAll(",", ""));
          //         } else {
          //           addingPriceVerbal +=
          //               (double.parse(map![i]['comparable_adding_price']));
          //         }
          //       } else {
          //         {
          //           if (map![i]['comparable_adding_price'] == '') {
          //             map![i]['comparable_adding_price'] = '0';
          //             addingPriceSimple +=
          //                 double.parse(map![i]['comparable_adding_price']);
          //           } else if (map![i]['comparable_adding_price']
          //               .contains(',')) {
          //             addingPriceSimple += double.parse(map![i]
          //                     ['comparable_adding_price']
          //                 .replaceAll(",", ""));
          //           } else {
          //             addingPriceSimple +=
          //                 (double.parse(map![i]['comparable_adding_price']));
          //           }
          //         }
          //       }
          //       setState(() {
          //         data_adding_correct.add(map![i]);
          //       });
          //     }
          //   }
          // });

          // if (!clickdone) {
          //   if (data_adding_correct.isNotEmpty) {
          //     for (int i = 0; i < data_adding_correct.length; i++) {
          //       // print(
          //       //     "No.${data_adding_correct[i]['comparable_id']} : ${data_adding_correct[i]['comparable_property_id']}\n");
          //       if (data_adding_correct[i]['comparable_property_id']
          //               .toString() ==
          //           '15') {
          //         markerType(i, 'l.png');
          //       } else if (data_adding_correct[i]['comparable_property_id']
          //               .toString() ==
          //           '10') {
          //         markerType(i, 'f.png');
          //       } else if (data_adding_correct[i]['comparable_property_id']
          //               .toString() ==
          //           '33') {
          //         markerType(i, 'v.png');
          //       } else if (data_adding_correct[i]['comparable_property_id']
          //               .toString() ==
          //           '14') {
          //         markerType(i, 'h.png');
          //       } else if (data_adding_correct[i]['comparable_property_id']
          //               .toString() ==
          //           '4') {
          //         markerType(i, 'b.png');
          //       } else if (data_adding_correct[i]['comparable_property_id']
          //               .toString() ==
          //           '29') {
          //         markerType(i, 'v.png');
          //       } else {
          //         markerType(i, 'a.png');
          //       }
          //     }
          //   }
          // }

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
          getxsnackbar("Please Try again", "");
          setState(() {
            isApiCallProcess = false;
          });
        }
      } on Exception catch (_) {
        getxsnackbar("Connect is Slow", "Please Try again");
        setState(() {
          isApiCallProcess = false;
        });
      }
    } else {
      getxsnackbar("Connect is Slow", "Please Try again");
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

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

  double fontsizeD = 14;
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
          // priceController.text =
          //     data_adding_correct[i]['comparable_adding_price'].toString();
          // updateproperty =
          //     data_adding_correct[i]['comparable_property_id'].toString();
          // updateraod = data_adding_correct[i]['comparable_road'].toString();
          // updatepropertyName =
          //     data_adding_correct[i]['comparable_property_id'].toString();
        });
      },
    );
    setState(() {
      isApiCallProcess = false;
      // listMarkerIds.add(marker);
    });
  }

  final Set<Marker> marker = {}; //163
  List ln = [];
  List lg = [];
  Future<void> get_name_search(var name) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$name&radius=1000&language=km&region=KH&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI&libraries=places';
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    List ls = jsonResponse['results'];
    List ac;
    for (int j = 0; j < ls.length; j++) {
      // ac = ls[j]['formatted_address'];

      var name = ls[j]['name'].toString();
      var dataLnlg = jsonResponse['results'][j]['geometry']['location'];
      if (h == 0 || h < 250) {
        h += 40;
      }
      lg.add(dataLnlg["lat"]);
      ln.add(dataLnlg["lng"]);
      setState(() {
        name_place.add(name);
      });
    }
  }

  Future<void> poin_map_by_search(var ln, var lg) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lg,$ln&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
      ),
    );
    var jsonResponse = json.decode(response.body);
    latLng = LatLng(double.parse(lg), double.parse(ln));
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
        findBYPiont(value.latitude, value.longitude);
      },
      infoWindow: const InfoWindow(title: 'KFA\'s Developer'),
    );
    setState(() {
      _marker.clear();
      _marker.add(newMarker);
    });
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 13),
      ),
    );
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
}
