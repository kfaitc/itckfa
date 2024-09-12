// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, non_constant_identifier_names, deprecated_member_use, unused_local_variable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/Option/components/contants.dart';
import 'package:itckfa/Option/screens/AutoVerbal/Verbal/Add.dart';
import 'package:itckfa/Option/screens/AutoVerbal/List.dart';
import 'package:itckfa/Option/screens/walletscreen.dart';
import 'package:itckfa/screen/Home/Customs/Model-responsive.dart';
import 'package:itckfa/screen/Promotion/membership_real.dart';
import 'package:itckfa/screen/Promotion/partnerList_real.dart';
import 'package:itckfa/screen/Promotion/Title_promo.dart';
import 'package:itckfa/screen/Promotion/promotion.dart';
import 'package:itckfa/screen/Home/Customs/titleBar.dart';
import 'package:itckfa/screen/Property/Home_Screen_property.dart';
import 'package:itckfa/screen/components/payment/Main_Form/in_app_purchase_top_up.dart';
import 'package:itckfa/screen/components/payment/Main_Form/top_up.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crypto/crypto.dart';
import '../../Getx/Auto_Verbal/autu_verbal.dart';
import '../../Option/screens/AutoVerbal/Verbal/add_PropertyPrce.dart';
import '../../Option/screens/AutoVerbal/Verbal/menu_add.dart';
import '../../models/autoVerbal.dart';

class Body extends StatefulWidget {
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  final String password;
  final String control_user;
  const Body({
    Key? key,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
    required this.password,
    required this.control_user,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AutoVerbalRequestModel requestModelAuto;
  int check_ios_pay = 0;
  Uint8List? get_bytes;

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  var formatter = NumberFormat("##,###,###,###.00", "en_US");

  String user = "";
  String first_name = "";
  String last_name = "";
  String email = "";
  String gender = "";
  String from = "";
  String tel = "";
  String id = "";
  String control_user = "";
  String password = "";
  String? number_of_vpoint;

  // String? expiry;
  List<Map> DataAutoVerbal = [];
  String? v_point;
  AuthVerbal authVerbal = AuthVerbal(Iduser: "");
  Future<void> check_v_point() async {
    await mydb_vb.open_verbal();

    setState(() {
      user = '${widget.first_name} ${widget.last_name}';
      first_name = widget.first_name.toString();
      last_name = widget.last_name.toString();
      email = widget.email.toString();
      gender = widget.gender.toString();
      from = widget.from.toString();
      tel = widget.tel.toString();
      id = widget.id.toString();
      control_user = widget.control_user.toString();
      password = widget.password.toString();
      // print(id);
    });
    DataAutoVerbal = await mydb_vb.db.rawQuery(
      "SELECT * FROM verbal_models WHERE verbal_user = ? ",
      [control_user.toString()],
    );

    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/ios_pay_option',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      // var jsonData = jsonDecode(response.body);

      setState(() {
        check_ios_pay = int.parse(jsonDecode(json.encode(response.data)));
      });
    }
  }

  String? formattedDate;
  final List<String> imageList = [
    "assets/effect_property.gif",
    "assets/effect_offline.png",
  ];
  @override
  void initState() {
    super.initState();
    requestModelAuto = AutoVerbalRequestModel(
      borey: "0",
      road: "",
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
    check_v_point();
    mainCheck();
  }

  void mainCheck() async {
    Future.delayed(Duration(seconds: 2), () {
      print("===> ${widget.control_user.toString()}");
      authVerbal.checkVpoint(widget.control_user.toString());
      authVerbal = Get.put(AuthVerbal(Iduser: widget.control_user));
    });
  }

  String generateHmacSha256(String data, String key) {
    List<int> keyBytes = utf8.encode(key);
    List<int> dataBytes = utf8.encode(data);

    Hmac hmacSha256 = Hmac(sha256, keyBytes); // HMAC-SHA256
    Digest digest = hmacSha256.convert(dataBytes);

    return base64.encode(digest.bytes);
  }

  var lat;
  var log;
  var district;
  double? wth;
  double? wth2;
  MyDb mydb_vb = MyDb();
  double minX = 0.0;
  double minY = 0.0;
  double maxX = 0.0;
  double maxY = 0.0;
  Offset position = Offset(300.4, 340.9);
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

    return (user != "")
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: kwhite_new,
              // elevation: 0,
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
                  position: GFBadgePosition.topEnd(top: 5, end: -3),
                  counterChild: GFBadge(
                    shape: GFBadgeShape.circle,
                    child: Text("${DataAutoVerbal.length}"),
                  ),
                  child: GFIconButton(
                    padding: const EdgeInsets.all(1),
                    onPressed: () {
                      authVerbal.checkVpoint(widget.control_user.toString());
                      // setState(() {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return ProtectDataCrossCheck(
                      //           id_user: control_user,
                      //         );
                      //       },
                      //     ),
                      //   );
                      // });
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    color: Colors.white,
                    type: GFButtonType.outline2x,
                    size: 35,
                    disabledColor: Colors.white,
                    shape: GFIconButtonShape.circle,
                  ),
                ),
              ],
            ),
            backgroundColor: kwhite_new,
            body: RefreshIndicator(
              onRefresh: () => check_v_point(),
              child: GestureDetector(
                onPanUpdate: (details) {
                  double newPosX = position.dx + details.delta.dx;
                  double newPosY = position.dy + details.delta.dy;

                  // Check if the new position is within the specified boundary
                  if (newPosX >= minX &&
                      newPosX <= maxX &&
                      newPosY >= minY &&
                      newPosY <= maxY) {
                    setState(() {
                      position = Offset(newPosX, newPosY);
                    });
                  }
                },
                onPanEnd: (details) {
                  setState(() {
                    double dataX = MediaQuery.of(context).size.width / 2;
                    if (position.dx > dataX) {
                      position = Offset(
                          MediaQuery.of(context).size.width * 0.9, position.dy);
                    } else {
                      position = Offset(
                          MediaQuery.of(context).size.width * 0.0, position.dy);
                    }
                  });
                },
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 70),
                              margin: EdgeInsets.only(top: 160),
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
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Add(
                                              id: widget.id,
                                              id_control_user: widget
                                                  .control_user
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      height: 70,
                                      width: double.infinity,
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: kwhite_new,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey,
                                            offset: Offset(-1, 1),
                                          )
                                        ],
                                        border: Border.all(
                                          color: kImageColor,
                                          width: 2,
                                          style: BorderStyle.solid,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Search your property anywhere",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: MediaQuery.of(
                                                          context,
                                                        ).textScaleFactor *
                                                        14,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 2,
                                                        color: Colors.grey,
                                                        offset: Offset(-2, 1),
                                                      )
                                                    ],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "by land market price and  can also add/view more properties listing  here, only 1\$.",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(
                                                          context,
                                                        ).textScaleFactor *
                                                        8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons
                                                  .keyboard_arrow_right_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Wrap(
                                      spacing: 15.0,
                                      runSpacing: 15.0,
                                      children: <Widget>[
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 92,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: const [
                                                  kDefaultShadow
                                                ],
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    if (Platform.isAndroid ||
                                                        check_ios_pay == 1) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TopUp(
                                                            set_phone: tel,
                                                            id_user:
                                                                id.toString(),
                                                            set_id_user: widget
                                                                .control_user,
                                                            set_email: widget
                                                                .email
                                                                .toString(),
                                                          ),
                                                        ),
                                                      );
                                                    } else if (Platform.isIOS &&
                                                        check_ios_pay == 0) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TopUp_ios(
                                                            set_phone: tel,
                                                            id_user:
                                                                id.toString(),
                                                            set_id_user:
                                                                control_user,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                            8.0,
                                                          ),
                                                          child: Image.asset(
                                                            'assets/images/topup.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Top Up",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SCard(
                                          svgPic: 'assets/icons/wallet.svg',
                                          title: 'Wallet',
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Walletscreen();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        SCard(
                                          svgPic: 'assets/icons/addverbal.svg',
                                          title: 'Cross Check',
                                          press: () {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return Menu_Add_verbal(
                                                      id: id,
                                                      id_control_user:
                                                          widget.control_user,
                                                    );
                                                  },
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                        SCard(
                                          svgPic: 'assets/icons/verballist.svg',
                                          title: 'Verbal List',
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Menu_of_Autoverval(
                                                    id: id,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        SCard(
                                          svgPic: 'assets/icons/property.svg',
                                          title: 'Property',
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Home_Screen_property();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        SCard(
                                          svgPic:
                                              'assets/icons/list-property.svg',
                                          title: 'News',
                                          press: () async {
                                            const url = 'https://kfa.com.kh/';
                                            await launch(
                                              url,
                                              forceSafariVC: false,
                                              forceWebView: false,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Text(
                                  //   "\t\tWhat's hot",
                                  //   style:
                                  //       TextStyle(fontWeight: FontWeight.bold),
                                  // ),
                                  // Divider(
                                  //   height: 1,
                                  //   thickness: 2,
                                  //   indent: 10,
                                  //   color: kImageColor,
                                  // ),
                                  // GFCarousel(
                                  //   items: imageList.map(
                                  //     (url) {
                                  //       return Container(
                                  //         margin: EdgeInsets.symmetric(
                                  //             vertical: 10),
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10)),
                                  //         child: Image.asset(url,
                                  //             fit: BoxFit.contain),
                                  //       );
                                  //     },
                                  //   ).toList(),
                                  //   onPageChanged: (index) {
                                  //     setState(() {
                                  //       index;
                                  //     });
                                  //   },
                                  //   autoPlay: true,
                                  //   enlargeMainPage: false,
                                  //   autoPlayCurve: Curves.linear,
                                  //   viewportFraction: 1.5,
                                  //   autoPlayAnimationDuration:
                                  //       const Duration(seconds: 5),
                                  //   autoPlayInterval:
                                  //       const Duration(seconds: 10),
                                  // ),
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
                                  // if (commune != null)
                                  //   Text(
                                  //     '   $commune /  $district',
                                  //     style: const TextStyle(
                                  //         fontStyle: FontStyle.italic, fontSize: 10),
                                  //     overflow: TextOverflow.ellipsis,
                                  //   ),
                                  // Stack(
                                  //   children: [
                                  //     if (lat != null)
                                  //       InkWell(
                                  //         onTap: () {
                                  //           setState(
                                  //             () {
                                  //               Navigator.of(context).push(
                                  //                 MaterialPageRoute(
                                  //                   builder: (context) =>
                                  //                       Map_verbal_body(
                                  //                     get_commune: (value) {
                                  //                       setState(() {
                                  //                         commune = value.toString();
                                  //                       });
                                  //                     },
                                  //                     get_district: (value) {
                                  //                       setState(() {
                                  //                         district = value.toString();
                                  //                       });
                                  //                     },
                                  //                     get_lat: (value) {
                                  //                       setState(() {
                                  //                         lat = value;
                                  //                       });
                                  //                     },
                                  //                     get_log: (value) {
                                  //                       setState(() {
                                  //                         log = value;
                                  //                       });
                                  //                     },
                                  //                     get_province: (value) {},
                                  //                     get_max1: (value) {
                                  //                       setState(() {
                                  //                         maxSqm1 = value;
                                  //                       });
                                  //                     },
                                  //                     get_max2: (value) {
                                  //                       setState(() {
                                  //                         maxSqm2 = value;
                                  //                       });
                                  //                     },
                                  //                     get_min1: (value) {
                                  //                       setState(() {
                                  //                         minSqm1 = value;
                                  //                       });
                                  //                     },
                                  //                     get_min2: (value) {
                                  //                       setState(() {
                                  //                         minSqm2 = value;
                                  //                       });
                                  //                     },
                                  //                   ),
                                  //                 ),
                                  //               );
                                  //             },
                                  //           );
                                  //         },
                                  //         child: Container(
                                  //           height: 180,
                                  //           width:
                                  //               MediaQuery.of(context).size.width * 1,
                                  //           margin: EdgeInsets.only(
                                  //               left: 5, right: 5, top: 3),
                                  //           decoration: BoxDecoration(
                                  //             image: DecorationImage(
                                  //               image: NetworkImage(
                                  //                   'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                  //               fit: BoxFit.cover,
                                  //             ),
                                  //             border: Border.all(
                                  //               width: 0.2,
                                  //             ),
                                  //             borderRadius: BorderRadius.only(
                                  //                 topLeft: Radius.circular(20),
                                  //                 topRight: Radius.circular(20)),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     Positioned(
                                  //       child: Container(
                                  //         width: wth,
                                  //         height: 25,
                                  //         padding: EdgeInsets.only(left: 10),
                                  //         margin: EdgeInsets.only(
                                  //             right: 70, top: 10, left: 10),
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             borderRadius: BorderRadius.circular(30)),
                                  //         child: Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceAround,
                                  //           children: [
                                  //             SizedBox(
                                  //               width: wth2,
                                  //               child: TextFormField(
                                  //                 onFieldSubmitted: (value) {},
                                  //                 onChanged: (value) {
                                  //                   setState(() {});
                                  //                 },
                                  //                 readOnly: true,
                                  //                 textInputAction:
                                  //                     TextInputAction.search,
                                  //                 style: TextStyle(
                                  //                     fontWeight: FontWeight.bold),
                                  //                 decoration: InputDecoration(
                                  //                   fillColor: Colors.white,
                                  //                   hintText: "Search",
                                  //                   border: InputBorder.none,
                                  //                   contentPadding:
                                  //                       EdgeInsets.only(top: 2),
                                  //                   hintStyle: TextStyle(
                                  //                     color: Colors.grey[850],
                                  //                     fontSize: MediaQuery.of(context)
                                  //                             .textScaleFactor *
                                  //                         0.04,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             IconButton(
                                  //                 // splashRadius: 30,
                                  //                 hoverColor: Colors.black,
                                  //                 onPressed: () {},
                                  //                 icon: const Icon(
                                  //                   Icons.search,
                                  //                   size: 10,
                                  //                 )),
                                  //             IconButton(
                                  //                 onPressed: () {
                                  //                   setState(() {});
                                  //                 },
                                  //                 icon: Icon(
                                  //                   Icons.person_pin_circle_outlined,
                                  //                   size: 10,
                                  //                 ))
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Positioned(
                                  //         right: 10,
                                  //         top: 15,
                                  //         child: CircleAvatar(
                                  //           backgroundColor: Colors.white,
                                  //           radius: 15,
                                  //           child: IconButton(
                                  //             icon: const Icon(
                                  //               Icons.mp_sharp,
                                  //               color: Color.fromRGBO(0, 184, 212, 1),
                                  //               size: 10,
                                  //             ),
                                  //             onPressed: () {},
                                  //           ),
                                  //         )),
                                  //   ],
                                  // ),
                                  // if (maxSqm1 != null && R_avg != null)
                                  //   Container(
                                  //     height: 180,
                                  //     width: MediaQuery.of(context).size.width * 1,
                                  //     margin: EdgeInsets.all(5),
                                  //     decoration: BoxDecoration(
                                  //       color: Color.fromARGB(255, 7, 9, 145),
                                  //       border: Border.all(
                                  //         width: 0.01,
                                  //       ),
                                  //       image: DecorationImage(
                                  //         opacity: 0.2,
                                  //         image:
                                  //             AssetImage('assets/images/KFA-Logo.png'),
                                  //       ),
                                  //       borderRadius: BorderRadius.only(
                                  //           bottomLeft: Radius.circular(10),
                                  //           bottomRight: Radius.circular(10)),
                                  //     ),
                                  //     child: Column(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         Text(
                                  //           "Residential",
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 14,
                                  //               decoration: TextDecoration.underline,
                                  //               decorationStyle:
                                  //                   TextDecorationStyle.dashed,
                                  //               color: Colors.white),
                                  //         ),
                                  //         Container(
                                  //           padding: EdgeInsets.all(7),
                                  //           margin:
                                  //               EdgeInsets.only(left: 10, right: 10),
                                  //           decoration: BoxDecoration(
                                  //             color: Color.fromARGB(234, 255, 255, 255),
                                  //             border: Border.all(
                                  //                 width: 0.2, color: Colors.green),

                                  //             borderRadius: BorderRadius.circular(5),

                                  //             // gradient: LinearGradient(
                                  //             //   begin: Alignment.topLeft,
                                  //             //   end: Alignment.bottomRight,
                                  //             //   colors: [
                                  //             //     Color.fromARGB(255, 244, 249, 255),
                                  //             //     Color.fromARGB(255, 246, 254, 255)
                                  //             //   ],
                                  //             // ),
                                  //           ),
                                  //           child: Column(
                                  //             children: [
                                  //               Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.center,
                                  //                 children: [
                                  //                   const Text("Avg = ",
                                  //                       style: TextStyle(
                                  //                           fontWeight: FontWeight.bold,
                                  //                           fontSize: 10)),
                                  //                   Text(
                                  //                       "${formatter.format(R_avg!)}\$",
                                  //                       style: const TextStyle(
                                  //                           fontSize: 11,
                                  //                           color: Color.fromARGB(
                                  //                               255, 242, 11, 134)))
                                  //                 ],
                                  //               ),
                                  //               Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.spaceAround,
                                  //                 children: [
                                  //                   Row(
                                  //                     children: [
                                  //                       const Text("Min = ",
                                  //                           style: TextStyle(
                                  //                               fontWeight:
                                  //                                   FontWeight.bold,
                                  //                               fontSize: 10)),
                                  //                       Text(
                                  //                           "${formatter.format(double.parse(maxSqm1))}\$",
                                  //                           style: const TextStyle(
                                  //                               fontSize: 11,
                                  //                               color: Color.fromARGB(
                                  //                                   255, 242, 11, 134)))
                                  //                     ],
                                  //                   ),
                                  //                   Row(
                                  //                     children: [
                                  //                       const Text("Max = ",
                                  //                           style: TextStyle(
                                  //                               fontWeight:
                                  //                                   FontWeight.bold,
                                  //                               fontSize: 10)),
                                  //                       Text(
                                  //                           "${formatter.format(double.parse(minSqm1))}\$",
                                  //                           style: const TextStyle(
                                  //                               fontSize: 11,
                                  //                               color: Color.fromARGB(
                                  //                                   255, 242, 11, 134)))
                                  //                     ],
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //         Divider(
                                  //             color: Colors.white,
                                  //             height: 10,
                                  //             thickness: 3),
                                  //         Text(
                                  //           "Commercial",
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 14,
                                  //               decoration: TextDecoration.underline,
                                  //               decorationStyle:
                                  //                   TextDecorationStyle.dashed,
                                  //               color: Colors.white),
                                  //         ),
                                  //         Container(
                                  //           padding: EdgeInsets.all(7),
                                  //           margin:
                                  //               EdgeInsets.only(left: 10, right: 10),
                                  //           decoration: BoxDecoration(
                                  //             color: Color.fromARGB(234, 255, 255, 255),
                                  //             border: Border.all(
                                  //                 width: 0.2, color: Colors.green),
                                  //             // boxShadow: const [
                                  //             //   BoxShadow(blurRadius: 1, color: Colors.grey)
                                  //             // ],
                                  //             borderRadius: BorderRadius.circular(5),
                                  //           ),
                                  //           child: Column(
                                  //             children: [
                                  //               Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.center,
                                  //                 children: [
                                  //                   const Text("Avg = ",
                                  //                       style: TextStyle(
                                  //                           fontWeight: FontWeight.bold,
                                  //                           fontSize: 10)),
                                  //                   Text(
                                  //                       "${formatter.format(C_avg!)}\$",
                                  //                       style: const TextStyle(
                                  //                           fontSize: 11,
                                  //                           color: Color.fromARGB(
                                  //                               255, 242, 11, 134)))
                                  //                 ],
                                  //               ),
                                  //               Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.spaceAround,
                                  //                 children: [
                                  //                   Row(
                                  //                     children: [
                                  //                       const Text("Min = ",
                                  //                           style: TextStyle(
                                  //                               fontWeight:
                                  //                                   FontWeight.bold,
                                  //                               fontSize: 10)),
                                  //                       Text(
                                  //                           "${formatter.format(double.parse(maxSqm2))}\$",
                                  //                           style: const TextStyle(
                                  //                               fontSize: 11,
                                  //                               color: Color.fromARGB(
                                  //                                   255, 242, 11, 134)))
                                  //                     ],
                                  //                   ),
                                  //                   Row(
                                  //                     children: [
                                  //                       const Text("Max = ",
                                  //                           style: TextStyle(
                                  //                               fontWeight:
                                  //                                   FontWeight.bold,
                                  //                               fontSize: 10)),
                                  //                       Text(
                                  //                           "${formatter.format(double.parse(minSqm2))}\$",
                                  //                           style: const TextStyle(
                                  //                               fontSize: 11,
                                  //                               color: Color.fromARGB(
                                  //                                   255, 242, 11, 134)))
                                  //                     ],
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
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
                            Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Add_with_property(
                                              id: id,
                                              id_control_user: control_user,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     blurRadius: 15,
                                        //     color: kImageColor,
                                        //     blurStyle: BlurStyle.outer,
                                        //   )
                                        // ],
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/earth.gif'),
                                        ),
                                        borderRadius: BorderRadius.circular(90),
                                      ),
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              16,
                                          backgroundColor: Colors.black45,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 15.0,
                                              color: Color.fromARGB(
                                                255,
                                                248,
                                                195,
                                                195,
                                              ),
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: AnimatedTextKit(
                                          repeatForever: true,
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              'Cross Check',
                                            ),
                                            TypewriterAnimatedText(
                                              'Your Property',
                                            ),
                                          ],
                                          onTap: () {
                                            setState(() {
                                              print(
                                                "id $id \n control_user $control_user",
                                              );
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Add_with_property(
                                                    id: id,
                                                    id_control_user:
                                                        control_user,
                                                  ),
                                                ),
                                              );
                                            });
                                          },
                                          pause:
                                              const Duration(milliseconds: 300),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 90.0,
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width *
                                          0.87,
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Obx(() {
                                          if (authVerbal.isAuthGet.value) {
                                            return Center(
                                              child:
                                                  const CircularProgressIndicator(),
                                            );
                                          } else if (authVerbal
                                              .listCheckVP.isEmpty) {
                                            return SizedBox();
                                          } else {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "Main Balance : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery
                                                                  .of(
                                                                context,
                                                              ).textScaleFactor *
                                                              10,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            authVerbal
                                                                .countAccount
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.red,
                                                              fontSize: MediaQuery
                                                                      .of(
                                                                    context,
                                                                  ).textScaleFactor *
                                                                  14,
                                                            ),
                                                          ),
                                                          Text(
                                                            "  VPoint",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: MediaQuery
                                                                      .of(
                                                                    context,
                                                                  ).textScaleFactor *
                                                                  11,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Image.asset(
                                                            "assets/images/v.png",
                                                            height: 25,
                                                            width: 25,
                                                          )
                                                        ],
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "My Plans : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery
                                                                  .of(
                                                                context,
                                                              ).textScaleFactor *
                                                              10,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        authVerbal
                                                            .listCheckVP[0]
                                                                ['their_plans']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery
                                                                  .of(
                                                                context,
                                                              ).textScaleFactor *
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "Valid Until : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery
                                                                  .of(
                                                                context,
                                                              ).textScaleFactor *
                                                              10,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        authVerbal
                                                            .formattedDate.value
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery
                                                                  .of(
                                                                context,
                                                              ).textScaleFactor *
                                                              10,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      left: position.dx,
                      top: position.dy,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Add_with_property(
                                  id: id,
                                  id_control_user: control_user,
                                ),
                              ),
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 90,
                              // height: 90,
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/bubble.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: kImageColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Cross Check \nYour Property",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
          )
        : Container(
            decoration: BoxDecoration(
              color: kwhite_new,
              image: DecorationImage(
                image: AssetImage("assets/images/KFA_CRM.png"),
                opacity: 0.5,
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
