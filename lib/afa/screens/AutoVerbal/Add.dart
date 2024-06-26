// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unnecessary_new, unused_local_variable, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, await_only_futures, unnecessary_null_comparison, empty_catches, unused_field, unrelated_type_equality_checks, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Memory_local/convert_data_verbal_to_image.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/afa/components/LandBuilding.dart';
import 'package:itckfa/afa/components/Sharp_Property.dart';
import 'package:itckfa/afa/components/slideUp.dart';
import 'package:itckfa/afa/screens/AutoVerbal/Detail.dart';
import 'package:itckfa/afa/screens/AutoVerbal/printer/save_image_for_Autoverbal.dart';
import 'package:itckfa/afa/screens/AutoVerbal/search/protect.dart';
import 'package:itckfa/screen/components/map_all/map_in_add_verbal.dart';
import 'package:itckfa/screen/components/map_all/map_in_edit_verbal.dart';
import 'package:itckfa/screen/components/payment/Main_Form/top_up.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../contants.dart';
import '../../../api/api_service.dart';
import '../../../models/autoVerbal.dart';
import '../../../models/model_bl_new.dart';
import '../../../screen/Customs/form.dart';
import '../../../screen/Customs/formTwinN.dart';
import '../../../screen/Profile/components/Drop.dart';
import '../../../screen/components/payment/Main_Form/in_app_purchase_top_up.dart';
import '../../components/code.dart';
import '../../components/comment.dart';
import '../../../screen/components/map_all/map_in_list_search.dart';
import '../../components/property.dart';

class Menu_Add_verbal extends StatefulWidget {
  const Menu_Add_verbal({
    super.key,
    required this.id,
    required this.id_control_user,
  });
  final String id;
  final String id_control_user;
  @override
  State<Menu_Add_verbal> createState() => _Menu_Add_verbalState();
}

class _Menu_Add_verbalState extends State<Menu_Add_verbal> {
  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      // setState(() {
      //   permissionGranted = true;
      // });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      // setState(() {
      //   permissionGranted = false;
      // });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.yellow,
      Colors.lightGreen,
      Color.fromRGBO(169, 255, 194, 1),
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Horizon',
      color: Colors.white,
      shadows: [Shadow(blurRadius: 2, color: Colors.deepPurpleAccent)],
    );
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: ui.Color.fromARGB(255, 191, 197, 186),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(250),
                  bottomRight: Radius.circular(250),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Add_with_property(
                            id: widget.id,
                            id_control_user: widget.id_control_user,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 50),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(90)),
                        boxShadow: [
                          BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                        ],
                      ),
                      child: Text(
                        "Cross check price",
                        style: colorizeTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Add_with_Approval(
                            id: widget.id,
                            id_control_user: widget.id_control_user,
                          ),
                        ),
                      );
                    },
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 50, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                          ],
                        ),
                        child: Text(
                          "Verbal Check by Approval",
                          style: colorizeTextStyle,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => List_Auto(
                            verbal_id: widget.id,
                            id_control_user: widget.id_control_user,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 50),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                        ],
                      ),
                      child: Text(
                        "List Auto Verbal",
                        style: colorizeTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Map_List_search(
                            get_commune: (value) {},
                            get_district: (value) {},
                            get_lat: (value) {},
                            get_log: (value) {},
                            get_max1: (value) {},
                            get_max2: (value) {},
                            get_min1: (value) {},
                            get_min2: (value) {},
                            get_province: (value) {},
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 50),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                        ),
                        boxShadow: [
                          BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                        ],
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Search Map',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                            speed: Duration(milliseconds: 70),
                          )
                        ],
                        //child: Text("Search Map")
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Map_List_search(
                                get_commune: (value) {},
                                get_district: (value) {},
                                get_lat: (value) {},
                                get_log: (value) {},
                                get_max1: (value) {},
                                get_max2: (value) {},
                                get_min1: (value) {},
                                get_min2: (value) {},
                                get_province: (value) {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              right: 1,
              child: SizedBox(
                height: 90,
                child: Image.asset("assets/images/KFA_CRM.png"),
              ),
            ),
            Positioned(
              top: 1,
              left: 1,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.chevron_left_outlined,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

String RandomString(int strlen) {
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

// ===========================          Add_Auto_verbal by landmarket_price       =====================
class Add extends StatefulWidget {
  const Add({super.key, required this.id, required this.id_control_user});
  final String id;
  final String id_control_user;
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with TickerProviderStateMixin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int? opt;
  double asking_price = 1;
  Uint8List? get_image_byte;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel requestModelAuto;
  var from = [
    'Bank',
    'Private',
    'Other',
  ];
  var gender = [
    'Female',
    'Male',
    'Other',
  ];
  var district;

  late List<dynamic> list_Khan;

  int id_khan = 0;
  double? lat1;
  double? log2;
  var a;
  String? filePath;
  MyDb mydb_lb = new MyDb();
  MyDb mydb_vb = new MyDb();
  var opt_type_id = '0';
  var list;
  List<L_B> lb = [L_B('null', 'null', 'null', 'null', '', 0, 0, 0, 0, 0)];
  void deleteItemToList(int Id) {
    setState(() {
      lb.removeAt(Id);
    });
  }

  File? file;
  Uint8List? get_bytes;
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;
  var id_verbal;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  int? number;
  String? control_user;
  Future get_control_user(String id) async {
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        control_user = jsonData[0]['control_user'].toString();
        get_count();
      });
    }
  }

  Future<void> get_count() async {
    await mydb_vb.open_verbal();
    await mydb_lb.open_land_verbal();
    setState(() {
      control_user = widget.id_control_user;
    });
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_count?id_user_control=${control_user}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        number = jsonData['number_count'];
        // list_user = jsonData['user'];
      });
    }
  }

  Future<void> payment_done(BuildContext context) async {
    final Data = {
      "id_user_control": control_user.toString(),
      "count_autoverbal": "-1",
    };
    final response = await http.post(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/0',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(Data),
    );
    if (response.statusCode == 200) {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: false,
        // title: value.message,
        autoHide: Duration(seconds: 10),
        body: Center(
          child: Text("Do you want to save photo"),
        ),
        btnOkOnPress: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => save_image_after_add_verbal(
                set_data_verbal: code.toString(),
              ),
            ),
          );
        },
        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        onDismissCallback: (type) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => List_Auto(
                verbal_id: widget.id,
                id_control_user: widget.id_control_user,
              ),
            ),
          );
        },
      ).show();
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  var verbal_id;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    verbal_id = widget.id_control_user.toString() + RandomString(9);
    _getCurrentPosition();
    get_count();
    mydb_vb.open_verbal();
    mydb_lb.open_land_verbal();
    lat1;
    log2;
    controller =
        AnimationController(duration: Duration(milliseconds: 645), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.reset();
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack,
      ),
    );
    lb;

    super.initState();

    requestModelAuto = AutoVerbalRequestModel(
      property_type_id: "0",
      lat: "0",
      lng: "0",
      address: '0',
      approve_id: "0",
      agent: "0",
      bank_branch_id: "0",
      bank_contact: "0",
      bank_id: "0",
      bank_officer: "0",
      code: "0",
      comment: "0",
      contact: "0",
      date: "0",
      image: "0",
      option: "0",
      owner: "0",
      user: widget.id_control_user,
      verbal_com: '0',
      verbal_con: "30",
      verbal: [],
      verbal_id: '0',
      verbal_khan: '0',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (number != null) {
      setState(() {
        number;
      });
    }

    return (number != null)
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(235, 7, 9, 145),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () async {
                    await get_count();
                    setState(() {
                      requestModelAuto.user = widget.id;
                      requestModelAuto.verbal_id = code.toString();
                      requestModelAuto.verbal_khan = '${commune}.${district}';
                    });
                    List<Map<String, dynamic>> jsonList =
                        lb.map((item) => item.toJson()).toList();
                    if (number! >= 1) {
                      Uint8List? imagebytes =
                          await FlutterImageCompress.compressWithFile(
                        _image!.absolute.path,
                        minHeight: 1280,
                        minWidth: 720,
                        quality: 80,
                      );
                      String base64string = base64.encode(imagebytes!);
                      requestModelAuto.image = base64string;
                      requestModelAuto.verbal = jsonList;
                      APIservice apIservice = APIservice();
                      apIservice.saveAutoVerbal(requestModelAuto).then(
                        (value) async {
                          if (requestModelAuto.verbal.isEmpty) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "Please add Land/Building at least 1!",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          } else {
                            if (value.message == "Save Successfully") {
                              if (_file != null) {
                                uploadt_image(_file!);
                              }
                              uploadt_image_map();
                              const snackBar = SnackBar(
                                content: Text('processing payment...'),
                                duration: Duration(seconds: 7),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              payment_done(context);
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Error',
                                desc: value.message,
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.red,
                              ).show();
                            }
                          }
                        },
                      );
                    } else {
                      if (jsonList.length <= 1) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: "Please add Land/Building at least 1!",
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else {
                        int lb = 0, vb = 0;
                        for (int i = 1; i < jsonList.length; i++) {
                          lb = await mydb_lb.db.rawInsert(
                              "INSERT INTO comverbal_land_models (verbal_landid, verbal_land_dp, verbal_land_type, verbal_land_des, verbal_land_area, verbal_land_minsqm, verbal_land_maxsqm, verbal_land_minvalue, verbal_land_maxvalue, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);",
                              [
                                verbal_id.toString(),
                                int.parse(jsonList[i]['verbal_land_dp']),
                                (jsonList[i]['verbal_land_type'].toString() ??
                                    "0"),
                                (jsonList[i]['verbal_land_des'].toString() ??
                                    "0"),
                                double.parse(
                                  jsonList[i]['verbal_land_area'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_minsqm'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_maxsqm'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_minvalue']
                                      .toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_maxvalue']
                                      .toString(),
                                ),
                                (jsonList[i]['address'].toString() ?? "0")
                              ]);
                        }
                        if (_image != null) {
                          Uint8List? imagebytes =
                              await FlutterImageCompress.compressWithFile(
                            _image!.absolute.path,
                            minHeight: 1280,
                            minWidth: 720,
                            quality: 80,
                          );
                          String base64string = base64.encode(imagebytes!);
                          vb = await mydb_vb.db.rawInsert(
                              "INSERT INTO verbal_models (verbal_id, verbal_khan, verbal_property_id, verbal_bank_id, verbal_bank_branch_id, verbal_bank_contact, verbal_owner, verbal_contact, verbal_date, verbal_bank_officer,verbal_address,verbal_approve_id,VerifyAgent,verbal_comment,latlong_log,latlong_la,verbal_image,verbal_com,verbal_con,verbal_property_code,verbal_user,verbal_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?);",
                              [
                                verbal_id ?? "No",
                                requestModelAuto.verbal_khan,
                                requestModelAuto.property_type_id,
                                requestModelAuto.bank_id,
                                requestModelAuto.bank_branch_id,
                                requestModelAuto.bank_contact,
                                requestModelAuto.owner,
                                requestModelAuto.contact,
                                requestModelAuto.date,
                                requestModelAuto.bank_officer,
                                requestModelAuto.address,
                                requestModelAuto.approve_id,
                                requestModelAuto.agent,
                                requestModelAuto.comment,
                                requestModelAuto.lat,
                                requestModelAuto.lng,
                                base64string,
                                requestModelAuto.verbal_com,
                                requestModelAuto.verbal_con,
                                "No",
                                widget.id_control_user,
                                requestModelAuto.option
                              ]);
                        } else {
                          vb = await mydb_vb.db.rawInsert(
                              "INSERT INTO verbal_models (verbal_id, verbal_khan, verbal_property_id, verbal_bank_id, verbal_bank_branch_id, verbal_bank_contact, verbal_owner, verbal_contact, verbal_date, verbal_bank_officer,verbal_address,verbal_approve_id,VerifyAgent,verbal_comment,latlong_log,latlong_la,verbal_image ,verbal_com,verbal_con,verbal_property_code,verbal_user,verbal_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?,?,?);",
                              [
                                verbal_id,
                                requestModelAuto.verbal_khan,
                                requestModelAuto.property_type_id,
                                requestModelAuto.bank_id,
                                requestModelAuto.bank_branch_id,
                                requestModelAuto.bank_contact,
                                requestModelAuto.owner,
                                requestModelAuto.contact,
                                requestModelAuto.date,
                                requestModelAuto.bank_officer,
                                requestModelAuto.address,
                                requestModelAuto.approve_id,
                                requestModelAuto.agent,
                                requestModelAuto.comment,
                                requestModelAuto.lat,
                                requestModelAuto.lng,
                                "null",
                                requestModelAuto.verbal_com,
                                requestModelAuto.verbal_con,
                                "No",
                                widget.id_control_user,
                                requestModelAuto.option
                              ]);
                        }
                        setState(() {
                          if (lb == 1 && vb == 1) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Success',
                              desc:
                                  "Please go to payment for processing this Data",
                              autoHide: Duration(seconds: 3),
                              onDismissCallback: (type) {
                                // debugPrint('Dialog Dissmiss from callback $type');

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProtectDataCrossCheck(
                                      id_user: widget.id_control_user,
                                    ),
                                  ),
                                );
                              },
                            ).show();
                          } else if (lb == 0 && vb == 1) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "Please add Land/Building at least 1!",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          } else if (lb == 1 && vb == 0) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "Please check find that your input",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          } else {}
                        });
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopUp(
                            set_phone: "",
                            id_user: widget.id,
                            set_id_user: widget.id_control_user,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[700],
                      boxShadow: [
                        BoxShadow(color: Colors.green, blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        bottomLeft: Radius.circular(80),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text("Submit"),
                        Icon(Icons.save_alt_outlined),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 10,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.red[700],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.topRight,
                        )
                      ],
                    ),
                  ),
                ),
              ],
              title: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Auto Verbal',
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ),
                    ),
                  ],
                  pause: const Duration(milliseconds: 900),
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  onTap: () {},
                ),
              ),
              toolbarHeight: 80,
            ),
            backgroundColor: Color.fromARGB(235, 7, 9, 145),
            body: RefreshIndicator(
              onRefresh: () => get_count(),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: addVerbal(context),
                ),
              ),
            ),
            floatingActionButton: (number! > 0)
                ? FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        number;
                        _controller.dispose();
                      });
                    },
                    backgroundColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${number}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.amber[800],
                          ),
                        ),
                        RotationTransition(
                          turns: _animation,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/v.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    child: Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Please, Top up now for cross check value',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[800],
                        ),
                      ),
                    ),
                  ),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(235, 7, 9, 145),
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
            ),
          );
  }

  Widget addVerbal(BuildContext context) {
    return Column(
      children: [
        Code(
          cd: verbal_id,
          code: (value) {
            setState(() {
              // code = value;
            });
          },
          check_property: 1,
        ),
        if (lat != null && lat1 == null)
          InkWell(
            onTap: () async {
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 120,
                placeholderCacheWidth: 120,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.contain,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else if (lat1 != null)
          InkWell(
            onTap: () async {
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 50,
                placeholderCacheWidth: 50,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.fill,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else
          SizedBox(height: 12),
        SizedBox(height: 12),
        CommentAndOption(
          value: (value) {
            setState(() {
              opt = int.parse(value);
            });
          },
          comment1: (opt != null) ? opt.toString() : null,
          id: (value) {
            setState(() {
              requestModelAuto.option = value.toString();
            });
          },
          comment: (newValue) {
            setState(() {
              requestModelAuto.comment = newValue!.toString();
            });
          },
          opt_type_id: (value) {
            setState(() {
              opt_type_id = value.toString();
            });
          },
        ),
        if (id_khan != 0)
          InkWell(
            onTap: () {
              _asyncInputDialog(context);
              ++i;
            },
            child: Container(
              height: 37,
              margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("land~Building"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Horizon',
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('land'),
                          RotateAnimatedText('Building'),
                        ],
                        pause: const Duration(milliseconds: 100),
                        repeatForever: true,
                      ),
                    ),
                  ),
                  GFAnimation(
                    controller: controller,
                    slidePosition: offsetAnimation,
                    type: GFAnimationType.slideTransition,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 30,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (i >= 0)
          Container(
            width: 500,
            height: (lb.length > 1) ? 280 : 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 1; i < lb.length; i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        width: 290,
                        //height: 210,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${lb[i].verbal_land_type} ',
                                        style: NameProperty(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              deleteItemToList(i);
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${lb[i].address} ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                                    SizedBox(height: 3),
                                    Text(
                                      "Floor",
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Area",
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value/Sqm',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Max Value/Sqm',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Man Value',
                                      style: Label(),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      ':   ' + lb[i].verbal_land_dp,
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' + lb[i].verbal_land_des,
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (formatter.format(
                                            lb[i].verbal_land_area.toInt(),
                                          )).toString() +
                                          'm' +
                                          '\u00B2',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (lb[i].verbal_land_minsqm)
                                              .toString() +
                                          '\$',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (lb[i].verbal_land_maxsqm)
                                              .toString() +
                                          '\$',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (formatter.format(
                                            lb[i].verbal_land_minvalue,
                                          )).toString() +
                                          '\$',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (formatter
                                                  .format(
                                                    lb[i].verbal_land_maxvalue,
                                                  )
                                                  .toString() +
                                              '\$'),
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
                ],
              ),
            ),
          ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: [
            if (_file != null)
              Container(
                height: 200,
                width: 400,
                // child: Image.file(File(_file!.path)),
                child: Image.file(_image!),
              ),
            // if (_file == null)
            TextButton(
              onPressed: () async {
                await openImage();
                setState(() {
                  _file;
                });
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    // padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.map_sharp,
                            color: kImageColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            (imagepath == "")
                                ? 'Choose Photo'
                                : 'choosed Photo',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        PropertyDropdown(
          name: (value) {
            propertyType = value;
          },
          id: (value) {
            requestModelAuto.property_type_id = value;
          },
          // pro: list[0]['property_type_name'],
        ),

        BankDropdown(
          bank: (value) {
            requestModelAuto.bank_id = value;
          },
          bankbranch: (value) {
            requestModelAuto.bank_branch_id = value;
          },
        ),
        SizedBox(
          height: 5.0,
        ),
        FormTwinN(
          Label1: 'Owner',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.owner = input!;
          },
          onSaved2: (input) {
            requestModelAuto.contact = input!;
          },
          icon1: Icon(
            Icons.person,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        // DateComponents(
        //   date: (value) {
        //     requestModelAuto.date = value;
        //   },
        // ),

        FormTwinN(
          Label1: 'Bank Officer',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.bank_officer = input!;
          },
          onSaved2: (input) {
            setState(() {
              requestModelAuto.bank_contact = input!;
            });
          },
          icon1: Icon(
            Icons.work,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),

        SizedBox(
          height: 5,
        ),
        // ForceSaleAndValuation(
        //   value: (value) {
        //     requestModelAuto.verbal_con = value;
        //   },
        //   // fsl: list[0]['verbal_con'],
        // ),

        // ApprovebyAndVerifyby(
        //   approve: (value) {
        //     setState(() {
        //       requestModelAuto.approve_id = value.toString();
        //     });
        //   },
        //   verify: (value) {
        //     setState(() {
        //       requestModelAuto.agent = value.toString();
        //     });
        //   },
        //   // appro: list[0]['approve_name'],
        //   // vfy: list[0]['VerifyAgent'],
        // ),

        FormS(
          label: 'Phum optional',
          onSaved: (input) {
            requestModelAuto.address = input!.toString();
          },
          iconname: Icon(
            Icons.location_on_rounded,
            color: kImageColor,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  var dropdown;
  String? options;
  String? commune;

  //MAP
  Future<void> SlideUp(BuildContext context) async {
//=============================================================
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Map_verbal_add(
          get_commune: (value) {
            setState(() {
              commune = value;
              Load_sangkat(value);
            });
          },
          get_district: (value) {
            setState(() {
              district = value;
              Load_khan(district);
            });
          },
          get_lat: (value) {
            setState(() {
              lat1 = double.parse(value);
              requestModelAuto.lat = value;
            });
          },
          get_log: (value) {
            setState(() {
              log2 = double.parse(value);
              requestModelAuto.lng = value;
            });
          },
          get_province: (value) {},
        ),
      ),
    );

    if (!mounted) return;
  }

  Future<File> convertImageByteToFile(
    Uint8List imageBytes,
    String fileName,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('$path/$fileName');
    await file.writeAsBytes(imageBytes);
    return file;
  }

  Random random = new Random();
  Future<dynamic> uploadt_image_map() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image_map',
      ),
    );
    request.fields['cid'] = code.toString();
    if (lat1 == null) {
      final response1 = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
        ),
      );
      final byte = response1.bodyBytes;
      Uint8List get_image_byte1 = Uint8List.fromList(byte);
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          get_image_byte1,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
        ),
      );
    } else {
      final response2 = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
        ),
      );
      final byte = response2.bodyBytes;
      Uint8List get_image_byte2 = Uint8List.fromList(byte);
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          get_image_byte2,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
        ),
      );
    }

    var res = await request.send();
  }

//===================== Upload Image to MySql Server
  File? _image;
  final picker = ImagePicker();
  late String base64string;
  XFile? _file;
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  Future openImage() async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        CroppedFile? cropFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
              lockAspectRatio: false,
              backgroundColor: Colors.blue,
              initAspectRatio: CropAspectRatioPreset.original,
            )
          ],
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.square,
          ],
        );

        setState(() {
          _file = XFile(cropFile!.path);
          // imagebytes = _file.path;
          // imagepath = pickedFile.path;
          _image = File(cropFile.path); //
        });
      } else {
        // print("No image is selected.");
      }
    } catch (e) {
      // print("error while picking file.");
    }
  }

  Future<dynamic> uploadt_image(XFile _image) async {
    var request = await http.MultipartRequest(
      "POST",
      Uri.parse(
        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image",
      ),
    );
    Map<String, String> headers = {
      "content-type": "application/json",
      "Connection": "keep-alive",
      "Accept-Encoding": " gzip"
    };
    request.headers.addAll(headers);
    // request.files.add(picture);
    request.fields['cid'] = code.toString();
    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        _image.path,
      ),
    );
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
  }

  //get khan
  void Load_khan(String district) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_Khan = jsonData;
        id_khan = int.parse(list_Khan[0]['Khan_ID'].toString());
      });
    }
  }

  var id_Sangkat;
  List<dynamic> list_sangkat = [];
  void Load_sangkat(String id) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${id}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_sangkat = jsonData;
        id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID'].toString());
      });
    }
  }

  int i = 0;
  Future _asyncInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding:
              EdgeInsets.only(top: 30, left: 10, right: 15, bottom: 40),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: LandBuilding(
                ID_khan: id_khan.toString(),
                // asking_price: asking_price,
                opt: (opt != null) ? opt! : 0,
                address: '${commune} / ${district}',
                list: (value) {
                  setState(() {
                    requestModelAuto.verbal = value;
                  });
                },
                landId: verbal_id,
                Avt: (value) {
                  a = value;
                  setState(() {});
                },
                opt_type_id: opt_type_id.toString(),
                check_property: 1,
                list_lb: (value) {
                  setState(() {
                    lb.addAll(value!);
                  });
                },
                ID_sangkat: id_Sangkat.toString(),
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
      color: kImageColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle NameProperty() {
    return TextStyle(
      color: kImageColor,
      fontSize: 11,
      fontWeight: FontWeight.bold,
    );
  }

  double? lat;
  double? log;
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

  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = position.latitude;
      log = position.longitude;
      requestModelAuto.lat = lat.toString();
      requestModelAuto.lng = log.toString();
    });
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
      ),
    );

    if (response.statusCode == 200) {
      // Successful response
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
                Load_khan(district.toString());
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                Load_sangkat(commune.toString());
              });
            }
          }
        }
      }
    }
  }
}

// ===========================          List_Auto       =====================
class List_Auto extends StatefulWidget {
  const List_Auto({
    super.key,
    required this.verbal_id,
    required this.id_control_user,
  });
  final String verbal_id;
  final String id_control_user;
  @override
  State<List_Auto> createState() => _List_AutoState();
}

class _List_AutoState extends State<List_Auto> {
  List list1 = [];
  bool check_data1 = false, check_data2 = false;
  void get_by_user_autoverbal() async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=${widget.id_control_user}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list1 = jsonData;
        print("object${list1.length}");
        check_data1 = true;
      });
    }
  }

  bool b1 = true, b2 = false;
  Future OpenDataBase() async {
    await mydb.open_offline();
    slist = await mydb.db.rawQuery('SELECT * FROM verbal_models_offline');
    setState(() {
      slist;
    });
  }

  List<Map>? slist;
  MyDb mydb = new MyDb();
  @override
  void initState() {
    get_by_user_autoverbal();
    OpenDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width * 0.9;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text(
            "Auto Verbal List",
            style: TextStyle(fontSize: 22),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 64, 120, 216),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: CustomPaint(
            size: Size(
              5,
              (5 * 0.5833333333333334).toDouble(),
            ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
            child: ListView(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GFButton(
                        onPressed: () {
                          setState(() {
                            b1 = true;
                            b2 = false;
                          });
                        },
                        color:
                            (b1) ? Color.fromRGBO(13, 71, 161, 1) : Colors.blue,
                        text: "Your Verbal",
                        elevation: (b1) ? 10 : 0,
                        shape: GFButtonShape.pills,
                      ),
                      GFButton(
                        onPressed: () async {
                          setState(() {
                            b1 = false;
                            b2 = true;
                          });
                          await OpenDataBase();
                        },
                        color:
                            (b2) ? Color.fromRGBO(13, 71, 161, 1) : Colors.blue,
                        text: "\t\t\t\t\t\tSaved\t\t\t\t\t\t",
                        elevation: (b2) ? 10 : 0,
                        shape: GFButtonShape.pills,
                      ),
                    ],
                  ),
                ),
                if (b1)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Visibility(
                      visible: check_data1,
                      replacement: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return Container(
                            height: 220,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(217, 255, 255, 255),
                              // border: Border.all(
                              //     width: 1,
                              //     color: Color.fromRGBO(67, 160, 71, 1)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Verbal ID\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "${list1[i]['verbal_id']}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  9,
                                              shadows: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bank\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Text(
                                              "${list1[i]['bank_name']}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bank Branch\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              "${list1[i]['bank_branch_name'] ?? ""}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Property Type\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              "${list1[i]['property_type_name']}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date :\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              "${list1[i]['verbal_date']}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: FadeInImage.assetNetwork(
                                          fit: BoxFit.cover,
                                          placeholderFit: BoxFit.contain,
                                          placeholder: 'assets/earth.gif',
                                          image:
                                              "https://maps.googleapis.com/maps/api/staticmap?center=${list1[i]["latlong_log"]},${list1[i]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list1[i]["latlong_log"]},${list1[i]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI",
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GFButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            save_image_after_add_verbal(
                                                          set_data_verbal:
                                                              list1[i]
                                                                  ["verbal_id"],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  text: "Get Image",
                                                  color: Colors.green,
                                                  icon: Icon(
                                                    Icons
                                                        .photo_library_outlined,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 5,
                                                        offset: Offset(1, 0.5),
                                                      )
                                                    ],
                                                    size: 20,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                GFButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            detail_verbal(
                                                          set_data_verbal:
                                                              list1[i]
                                                                  ["verbal_id"],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  text: " Get PDF ",
                                                  color: Color.fromRGBO(
                                                    229,
                                                    57,
                                                    53,
                                                    1,
                                                  ),
                                                  icon: Icon(
                                                    Icons.picture_as_pdf,
                                                    size: 20,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 5,
                                                        offset: Offset(1, 0.5),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Icon(Icons.share),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      barrierLabel:
                                                          MaterialLocalizations
                                                                  .of(context)
                                                              .modalBarrierDismissLabel,
                                                      barrierColor:
                                                          ui.Color.fromARGB(
                                                        0,
                                                        0,
                                                        0,
                                                        0,
                                                      ),
                                                      builder: (context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                context,
                                                              ).size.height *
                                                              0.6,
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).size.height *
                                                                      0.8,
                                                                  color: ui
                                                                          .Color
                                                                      .fromARGB(
                                                                    97,
                                                                    0,
                                                                    0,
                                                                    0,
                                                                  ),
                                                                  child:
                                                                      convert_data_verbal_to_image(
                                                                    set_data_verbal:
                                                                        list1[i]
                                                                            [
                                                                            "verbal_id"],
                                                                    sh_in_list:
                                                                        true,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            GFButton(
                                              onPressed: () {
                                                // var data = verbalModel(
                                                //   verbalId:
                                                //       '${list1[i]["verbal_id"] ?? ''}',
                                                //   bank_branch_name:
                                                //       '${list1[i]["bank_branch_name"] ?? ''}',
                                                //   bank_name:
                                                //       '${list1[i]["bank_name"] ?? ''}',
                                                //   property_type_name:
                                                //       '${list1[i]["property_type_name"] ?? ''}',
                                                //   tel_num:
                                                //       '${list1[i]["tel_num"] ?? ''}',
                                                //   username:
                                                //       '${list1[i]["username"] ?? ''}',
                                                //   verbal_address:
                                                //       '${list1[i]["verbal_address"] ?? ''}',
                                                //   verbal_contact:
                                                //       '${list1[i]["verbal_contact"] ?? ''}',
                                                //   verbal_date:
                                                //       '${list1[i]["verbal_date"] ?? ''}',
                                                //   verbal_owner:
                                                //       '${list1[i]["verbal_owner"] ?? ''}',
                                                // );

                                                // await PeopleController()
                                                //     .insertverbal(data);
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  barrierLabel:
                                                      MaterialLocalizations.of(
                                                              context)
                                                          .modalBarrierDismissLabel,
                                                  barrierColor:
                                                      ui.Color.fromARGB(
                                                    0,
                                                    0,
                                                    0,
                                                    0,
                                                  ),
                                                  builder: (context) {
                                                    return Container(
                                                      height: MediaQuery.of(
                                                            context,
                                                          ).size.height *
                                                          0.6,
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: MediaQuery
                                                                          .of(
                                                                    context,
                                                                  )
                                                                      .size
                                                                      .height *
                                                                  0.8,
                                                              color: ui.Color
                                                                  .fromARGB(
                                                                97,
                                                                0,
                                                                0,
                                                                0,
                                                              ),
                                                              child:
                                                                  convert_data_verbal_to_image(
                                                                set_data_verbal:
                                                                    list1[i][
                                                                        "verbal_id"],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              text: "\tSave for offline\t",
                                              size: GFSize.MEDIUM,
                                              icon: Icon(
                                                Icons.note_alt_outlined,
                                                color: Colors.white,
                                                size: 20,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 5,
                                                    offset: Offset(1, 0.5),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: list1.length,
                      ),
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: (slist!.isEmpty && slist == null)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            // stuone["roll_no"]
                            child: Column(
                              children: slist!.map((stuone) {
                                return InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                            left: 40,
                                            right: 40,
                                            bottom: 100,
                                            top: 90,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Scaffold(
                                            body: Container(
                                              alignment: Alignment.center,
                                              child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 50,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Image.memory(
                                                            base64Decode(
                                                              stuone[
                                                                  "verbal_image"],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              GFButton(
                                                                onPressed:
                                                                    () async {
                                                                  await mydb
                                                                      .open_offline();
                                                                  int b = await mydb
                                                                      .db
                                                                      .rawDelete(
                                                                          "DELETE FROM verbal_models_offline WHERE verbal_id = ?",
                                                                          [
                                                                        stuone[
                                                                            "verbal_id"]
                                                                      ]);
                                                                  if (b == 1) {
                                                                    const snackBar =
                                                                        SnackBar(
                                                                      content: Text(
                                                                          'Data Deleted!...'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                    );

                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackBar);

                                                                    Navigator
                                                                        .pop(
                                                                      context,
                                                                    );
                                                                    setState(
                                                                        () {
                                                                      b1 = true;
                                                                      b2 =
                                                                          false;
                                                                    });
                                                                  } else {
                                                                    const snackBar =
                                                                        SnackBar(
                                                                      content: Text(
                                                                          'Data Deleted felse!...'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                    );

                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackBar);

                                                                    Navigator
                                                                        .pop(
                                                                      context,
                                                                    );
                                                                  }
                                                                },
                                                                text:
                                                                    "Delete\t\t",
                                                                color: const ui
                                                                    .Color.fromRGBO(
                                                                  255,
                                                                  23,
                                                                  68,
                                                                  1,
                                                                ),
                                                                type: GFButtonType
                                                                    .outline2x,
                                                                icon: Icon(
                                                                  Icons
                                                                      .delete_outline_rounded,
                                                                  color: const ui
                                                                      .Color.fromRGBO(
                                                                    255,
                                                                    23,
                                                                    68,
                                                                    1,
                                                                  ),
                                                                ),
                                                              ),
                                                              GFButton(
                                                                onPressed:
                                                                    () async {
                                                                  final result =
                                                                      await ImageGallerySaver
                                                                          .saveImage(
                                                                    base64Decode(
                                                                        stuone[
                                                                            "verbal_image"]),
                                                                  );
                                                                  const snackBar =
                                                                      SnackBar(
                                                                    content: Text(
                                                                        'Data Saved!'),
                                                                    duration: Duration(
                                                                        seconds:
                                                                            2),
                                                                  );

                                                                  // ignore: use_build_context_synchronously
                                                                  ScaffoldMessenger
                                                                      .of(
                                                                    context,
                                                                  ).showSnackBar(
                                                                    snackBar,
                                                                  );
                                                                  // ignore: use_build_context_synchronously
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                  setState(() {
                                                                    b1 = true;
                                                                    b2 = false;
                                                                  });
                                                                },
                                                                text:
                                                                    "download",
                                                                icon: Icon(
                                                                  Icons
                                                                      .download,
                                                                  color: ui
                                                                          .Color
                                                                      .fromARGB(
                                                                    255,
                                                                    23,
                                                                    65,
                                                                    255,
                                                                  ),
                                                                ),
                                                                type: GFButtonType
                                                                    .outline2x,
                                                                color: ui.Color
                                                                    .fromARGB(
                                                                  255,
                                                                  23,
                                                                  65,
                                                                  255,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.redAccent[400],
                                                      child: Icon(Icons.close),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Image.memory(
                                            base64Decode(
                                              stuone["verbal_image"],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
      Offset(size.width * 0.50, 0),
      Offset(size.width * 0.50, size.height * 1.00),
      [Color(0xff5bf03d), Color(0xff11376e)],
      [0.00, 1.00],
    );

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.5000000, size.height * 0.9985714);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(
      size.width,
      size.height * 0.1564286,
      size.width,
      size.height * 0.2085714,
    );
    path0.cubicTo(
      size.width * 0.8331250,
      size.height * 0.5014286,
      size.width * 0.5835417,
      size.height * 0.4285714,
      size.width * 0.4991667,
      size.height * 0.7857143,
    );
    path0.cubicTo(
      size.width * 0.4160417,
      size.height * 0.4267857,
      size.width * 0.1647917,
      size.height * 0.4975000,
      0,
      size.height * 0.2128571,
    );
    path0.quadraticBezierTo(0, size.height * 0.1596429, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// ===========================          Add_Auto_verbal by comparable       =====================
class Add_with_property extends StatefulWidget {
  const Add_with_property({
    super.key,
    required this.id,
    required this.id_control_user,
  });
  final String id;
  final String id_control_user;
  @override
  State<Add_with_property> createState() => _Add_with_propertyState();
}

class _Add_with_propertyState extends State<Add_with_property>
    with TickerProviderStateMixin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int? opt;
  double? asking_price;
  Uint8List? get_image_byte;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel requestModelAuto;
  var from = [
    'Bank',
    'Private',
    'Other',
  ];
  var gender = [
    'Female',
    'Male',
    'Other',
  ];
  var district;

  late List<dynamic> list_Khan;
  int check_ios_pay = 0;
  int id_khan = 0;
  double? lat1;
  double? log2;
  var a;
  String? filePath;

  var opt_type_id = '0';
  var list;
  List<L_B> lb = [];
  void deleteItemToList(int Id) {
    setState(() {
      lb.removeAt(Id);
    });
  }

  File? file;
  Uint8List? get_bytes;
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;
  var id_verbal;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  int? number;
  var control_user;
  List? list_user;
  MyDb mydb_lb = new MyDb();
  MyDb mydb_vb = new MyDb();
  // Future get_control_user(String id) async {
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body);

  //     setState(() {
  //       // print(jsonData[0]['control_user'].toString() + "\n");
  //       list_user = jsonData[0];
  //     });
  //   }
  // }

  Future<void> get_count() async {
    setState(() {
      control_user = widget.id_control_user;
    });
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_count?id_user_control=${control_user}',
      ),
    );
    var rs_ios = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/ios_pay_option',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      var jsonData_ios = jsonDecode(rs_ios.body);
      setState(() {
        number = jsonData['number_count'];
        list_user = jsonData['user'];
        check_ios_pay = jsonData_ios;
      });
    }
  }

  Future<void> payment_done(BuildContext context) async {
    final Data = {
      "id_user_control": control_user.toString(),
      "count_autoverbal": "-1",
    };
    final response = await http.post(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/0',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(Data),
    );
    if (response.statusCode == 200) {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.question,
        showCloseIcon: false,
        // title: value.message,
        autoHide: Duration(seconds: 10),
        body: Center(
          child: Text("Do you want to save photo"),
        ),
        btnOkOnPress: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => save_image_after_add_verbal(
                set_data_verbal: verbal_id,
              ),
            ),
          );
        },
        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        onDismissCallback: (type) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => List_Auto(
                verbal_id: widget.id,
                id_control_user: widget.id_control_user,
              ),
            ),
          );
        },
      ).show();
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  var verbal_id;
  @override
  void initState() {
    _getCurrentPosition();
    // get_control_user(widget.id.toString());
    verbal_id = widget.id_control_user.toString() + RandomString(9);
    get_count();
    addVerbal(context);
    lat1;
    log2;
    controller =
        AnimationController(duration: Duration(milliseconds: 645), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
    lb;

    super.initState();

    requestModelAuto = AutoVerbalRequestModel(
      property_type_id: "",
      lat: "",
      lng: "",
      address: '',
      approve_id: "",
      agent: "",
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
      user: "",
      verbal_com: '',
      verbal_con: "30",
      verbal: [],
      verbal_id: '0',
      verbal_khan: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (number != null) {
      setState(() {
        number;
      });
    }
    return (number != null)
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(235, 7, 9, 145),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () async {
                    MyDb mydb = new MyDb();

                    List<Map<String, dynamic>> jsonList =
                        lb.map((item) => item.toJson()).toList();
                    setState(() {
                      requestModelAuto.user = widget.id_control_user;
                      requestModelAuto.verbal_id = verbal_id;
                      requestModelAuto.verbal_khan = '${commune}.${district}';
                      requestModelAuto.verbal = jsonList;
                      _image;
                    });
                    await get_count();
                    if (number! >= 1) {
                      if (_image != null) {
                        Uint8List? imagebytes =
                            await FlutterImageCompress.compressWithFile(
                          _image!.absolute.path,
                          minHeight: 1280,
                          minWidth: 720,
                          quality: 80,
                        );
                        String base64string = base64.encode(imagebytes!);
                        requestModelAuto.image = base64string;
                      } else {
                        requestModelAuto.image = "No";
                      }

                      if (asking_price != null) {
                        APIservice apIservice = APIservice();
                        apIservice.saveAutoVerbal(requestModelAuto).then(
                          (value) async {
                            if (requestModelAuto.verbal.isEmpty) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Error',
                                desc: "Please add Land/Building at least 1!",
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.red,
                              ).show();
                            } else {
                              if (value.message == "Save Successfully") {
                                await payment_done(context);
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: 'Error',
                                  desc: value.message,
                                  btnOkOnPress: () {},
                                  btnOkIcon: Icons.cancel,
                                  btnOkColor: Colors.red,
                                ).show();
                              }
                            }
                          },
                        );
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: "Please select your Location",
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      }
                    } else {
                      if (jsonList.length <= 1) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: "Please add Land/Building at least 1!",
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else {
                        await mydb_lb.open_land_verbal();
                        await mydb_vb.open_verbal();

                        for (int i = 1; i < jsonList.length; i++) {
                          await mydb_lb.db.rawInsert(
                              "INSERT INTO comverbal_land_models (verbal_landid, verbal_land_dp, verbal_land_type, verbal_land_des, verbal_land_area, verbal_land_minsqm, verbal_land_maxsqm, verbal_land_minvalue, verbal_land_maxvalue, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);",
                              [
                                verbal_id.toString(),
                                int.parse(jsonList[i]['verbal_land_dp']),
                                (jsonList[i]['verbal_land_type'].toString() ??
                                    "0"),
                                (jsonList[i]['verbal_land_des'].toString() ??
                                    "0"),
                                double.parse(
                                  jsonList[i]['verbal_land_area'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_minsqm'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_maxsqm'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_minvalue']
                                      .toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_maxvalue']
                                      .toString(),
                                ),
                                (jsonList[i]['address'].toString() ?? "0")
                              ]);
                        }
                        if (_image != null) {
                          Uint8List? imagebytes =
                              await FlutterImageCompress.compressWithFile(
                            _image!.absolute.path,
                            minHeight: 1280,
                            minWidth: 720,
                            quality: 80,
                          );
                          String base64string = base64.encode(imagebytes!);
                          await mydb_vb.db.rawInsert(
                              "INSERT INTO verbal_models (verbal_id, verbal_khan, verbal_property_id, verbal_bank_id, verbal_bank_branch_id, verbal_bank_contact, verbal_owner, verbal_contact, verbal_date, verbal_bank_officer,verbal_address,verbal_approve_id,VerifyAgent,verbal_comment,latlong_log,latlong_la,verbal_image,verbal_com,verbal_con,verbal_property_code,verbal_user,verbal_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?);",
                              [
                                verbal_id ?? "No",
                                requestModelAuto.verbal_khan,
                                requestModelAuto.property_type_id,
                                requestModelAuto.bank_id,
                                requestModelAuto.bank_branch_id,
                                requestModelAuto.bank_contact,
                                requestModelAuto.owner,
                                requestModelAuto.contact,
                                requestModelAuto.date,
                                requestModelAuto.bank_officer,
                                requestModelAuto.address,
                                requestModelAuto.approve_id,
                                requestModelAuto.agent,
                                requestModelAuto.comment,
                                requestModelAuto.lat,
                                requestModelAuto.lng,
                                base64string,
                                requestModelAuto.verbal_com,
                                requestModelAuto.verbal_con,
                                "No",
                                widget.id_control_user,
                                requestModelAuto.option
                              ]);
                        } else {
                          await mydb_vb.db.rawInsert(
                              "INSERT INTO verbal_models (verbal_id, verbal_khan, verbal_property_id, verbal_bank_id, verbal_bank_branch_id, verbal_bank_contact, verbal_owner, verbal_contact, verbal_date, verbal_bank_officer,verbal_address,verbal_approve_id,VerifyAgent,verbal_comment,latlong_log,latlong_la,verbal_image ,verbal_com,verbal_con,verbal_property_code,verbal_user,verbal_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?,?,?);",
                              [
                                verbal_id,
                                requestModelAuto.verbal_khan,
                                requestModelAuto.property_type_id,
                                requestModelAuto.bank_id,
                                requestModelAuto.bank_branch_id,
                                requestModelAuto.bank_contact,
                                requestModelAuto.owner,
                                requestModelAuto.contact,
                                requestModelAuto.date,
                                requestModelAuto.bank_officer,
                                requestModelAuto.address,
                                requestModelAuto.approve_id,
                                requestModelAuto.agent,
                                requestModelAuto.comment,
                                requestModelAuto.lat,
                                requestModelAuto.lng,
                                "No",
                                requestModelAuto.verbal_com,
                                requestModelAuto.verbal_con,
                                "No",
                                widget.id_control_user,
                                requestModelAuto.option
                              ]);
                        }
                        List<Map>? vb, lb;
                        lb = await mydb_lb.db.rawQuery(
                          "SELECT * FROM comverbal_land_models WHERE verbal_landid = ? ",
                          [verbal_id.toString()],
                        );
                        vb = await mydb_vb.db.rawQuery(
                          "SELECT * FROM verbal_models  WHERE verbal_id = ?",
                          [verbal_id.toString()],
                        );
                        setState(() {
                          if (vb!.length == 1 && lb!.length == 1) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Success',
                              desc: "Data is saving for waiting your payment",
                              autoHide: Duration(seconds: 3),
                              onDismissCallback: (type) async {
                                // await get_control_user(widget.id);
                                // debugPrint('Dialog Dissmiss from callback $type');
                                setState(() {
                                  print(
                                    "object: ${list_user![0].toString()}\n",
                                  );
                                });

                                if (Platform.isAndroid || check_ios_pay == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TopUp(
                                        set_phone:
                                            "${list_user![0]['tel_num']}",
                                        set_id_user: list_user![0]
                                                ['control_user']
                                            .toString(),
                                        set_email:
                                            list_user![0]['email'].toString(),
                                        id_user: widget.id,
                                        id_verbal: verbal_id.toString(),
                                      ),
                                    ),
                                  );
                                } else if (Platform.isIOS &&
                                    check_ios_pay == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TopUp_ios(
                                        set_phone:
                                            "${list_user![0]['tel_num']}",
                                        id_user: widget.id,
                                        set_id_user: control_user,
                                      ),
                                    ),
                                  );
                                }

                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           ProtectDataCrossCheck(
                                //         id_user: widget.id_control_user,
                                //       ),
                                //     ));
                              },
                            ).show();
                          } else if (lb!.isEmpty && vb.length == 1) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "Please add Land/Building at least 1!",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          } else if (lb.length == 1 && vb.isEmpty) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "Please check find that your input",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          } else {}
                        });
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => TopUp(
                      //       set_phone: list_user['tel_num'].toString(),
                      //       set_id_user: list_user['control_user'].toString(),
                      //       set_email: list_user['email'].toString(),
                      //       id_user: widget.id,
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[700],
                      boxShadow: [
                        BoxShadow(color: Colors.green, blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        bottomLeft: Radius.circular(80),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Submit",
                          style: TextStyle(fontSize: 10),
                        ),
                        Icon(Icons.save_alt_outlined, size: 15),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 10,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 32, 32),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.topRight,
                        )
                      ],
                    ),
                  ),
                ),
              ],
              title: Text(
                'property check',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                ),
              ),
              toolbarHeight: 80,
            ),
            backgroundColor: Color.fromARGB(235, 7, 9, 145),
            body: RefreshIndicator(
              onRefresh: () => get_count(),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: addVerbal(context),
                ),
              ),
            ),
            floatingActionButton: (number! > 0)
                ? FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        number;
                        _controller.dispose();
                      });
                    },
                    backgroundColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${number}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.amber[800],
                          ),
                        ),
                        RotationTransition(
                          turns: _animation,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/v.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    child: Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Please, Top up now for cross check value',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[800],
                        ),
                      ),
                    ),
                  ),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(235, 7, 9, 145),
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
            ),
          );
  }

  Widget addVerbal(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Code(
          code: (value) {
            setState(() {
              // code = value;
            });
          },
          cd: verbal_id,
          check_property: 1,
        ),
        if (lat != null && lat1 == null)
          InkWell(
            onTap: () async {
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 120,
                placeholderCacheWidth: 120,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.contain,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else if (lat1 != null)
          InkWell(
            onTap: () async {
              setState(() {
                asking_price = 0.0;
              });
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 50,
                placeholderCacheWidth: 50,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.fill,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else
          SizedBox(height: 12),
        SizedBox(height: 12),
        CommentAndOption(
          value: (value) {
            setState(() {
              opt = int.parse(value);
            });
          },
          comment1: (opt != null) ? opt.toString() : null,
          id: (value) {
            setState(() {
              requestModelAuto.option = value.toString();
            });
          },
          comment: (newValue) {
            setState(() {
              requestModelAuto.comment = newValue!.toString();
            });
          },
          opt_type_id: (value) {
            setState(() {
              opt_type_id = value.toString();
            });
          },
        ),
        if (id_khan != 0)
          InkWell(
            onTap: () {
              _asyncInputDialog(context);
            },
            child: Container(
              height: 37,
              margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("land~Building"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Horizon',
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('land'),
                          RotateAnimatedText('Building'),
                        ],
                        pause: const Duration(milliseconds: 100),
                        repeatForever: true,
                      ),
                    ),
                  ),
                  GFAnimation(
                    controller: controller,
                    slidePosition: offsetAnimation,
                    type: GFAnimationType.slideTransition,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 30,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),
          ),

        Container(
          width: 500,
          height: (lb.length >= 1) ? 280 : 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < lb.length; i++)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                      width: 290,
                      //height: 210,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: kPrimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${lb[i].verbal_land_type} ',
                                      style: NameProperty(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            deleteItemToList(i);
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: kPrimaryColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${lb[i].address} ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                  SizedBox(height: 3),
                                  Text(
                                    "Floor",
                                    style: Label(),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Area",
                                    style: Label(),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Min Value/Sqm',
                                    style: Label(),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Max Value/Sqm',
                                    style: Label(),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Min Value',
                                    style: Label(),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Man Value',
                                    style: Label(),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text(
                                    ':   ' + lb[i].verbal_land_dp,
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' + lb[i].verbal_land_des,
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        (formatter.format(
                                          lb[i].verbal_land_area.toInt(),
                                        )).toString() +
                                        'm' +
                                        '\u00B2',
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        formatter
                                            .format(lb[i].verbal_land_minsqm) +
                                        '\$',
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        formatter
                                            .format(lb[i].verbal_land_maxsqm) +
                                        '\$',
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        (formatter.format(
                                          lb[i].verbal_land_minvalue,
                                        )).toString() +
                                        '\$',
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        (formatter
                                                .format(
                                                  lb[i].verbal_land_maxvalue,
                                                )
                                                .toString() +
                                            '\$'),
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
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: [
            if (_file != null)
              Container(
                height: 200,
                width: 400,
                // child: Image.file(File(_file!.path)),
                child: Image.file(_image!),
              ),
            // if (_file == null)
            TextButton(
              onPressed: () async {
                await openImage();
                setState(() {
                  _file;
                });
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    // padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.map_sharp,
                            color: kImageColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            (imagepath == "")
                                ? 'Choose Photo'
                                : 'choosed Photo',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        PropertyDropdown(
          name: (value) {
            setState(() {
              propertyType = value;
            });
          },
          id: (value) {
            setState(() {
              requestModelAuto.property_type_id = value;
            });
          },
          // pro: list[0]['property_type_name'],
        ),

        BankDropdown(
          bank: (value) {
            setState(() {
              requestModelAuto.bank_id = value;
            });
          },
          bankbranch: (value) {
            setState(() {
              requestModelAuto.bank_branch_id = value;
            });
          },
        ),
        SizedBox(
          height: 5.0,
        ),
        FormTwinN(
          Label1: 'Owner',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.owner = input!;
          },
          onSaved2: (input) {
            requestModelAuto.contact = input!;
          },
          icon1: Icon(
            Icons.person,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        // DateComponents(
        //   date: (value) {
        //     requestModelAuto.date = value;
        //   },
        // ),

        FormTwinN(
          Label1: 'Bank Officer',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.bank_officer = input!;
          },
          onSaved2: (input) {
            setState(() {
              requestModelAuto.bank_contact = input!;
            });
          },
          icon1: Icon(
            Icons.work,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),

        SizedBox(
          height: 5,
        ),
        // ForceSaleAndValuation(
        //   value: (value) {
        //     requestModelAuto.verbal_con = value;
        //   },
        //   // fsl: list[0]['verbal_con'],
        // ),

        // ApprovebyAndVerifyby(
        //   approve: (value) {
        //     setState(() {
        //       requestModelAuto.approve_id = value.toString();
        //     });
        //   },
        //   verify: (value) {
        //     setState(() {
        //       requestModelAuto.agent = value.toString();
        //     });
        //   },
        //   // appro: list[0]['approve_name'],
        //   // vfy: list[0]['VerifyAgent'],
        // ),

        FormS(
          label: 'Phum optional',
          onSaved: (input) {
            requestModelAuto.address = input!.toString();
          },
          iconname: Icon(
            Icons.location_on_rounded,
            color: kImageColor,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }

  var dropdown;
  String? options;
  String? commune;

  //MAP
  Future<void> SlideUp(BuildContext context) async {
//=============================================================
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => map_cross_verbal(
          get_commune: (value) {
            setState(() {
              commune = value;

              Load_sangkat(value);
            });
          },
          get_district: (value) {
            setState(() {
              district = value;

              Load_khan(district);
            });
          },
          get_lat: (value) {
            setState(() {
              lat1 = double.parse(value.toString());
              requestModelAuto.lat = value;
            });
          },
          get_log: (value) {
            setState(() {
              log2 = double.parse(value.toString());
              requestModelAuto.lng = value;
            });
          },
          get_province: (value) {},
          asking_price: (value) {
            setState(() {
              asking_price = double.parse(value.toString());
            });
          },
        ),
      ),
    );

    if (!mounted) return;
  }

  Future<File> convertImageByteToFile(
    Uint8List imageBytes,
    String fileName,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('$path/$fileName');
    await file.writeAsBytes(imageBytes);
    return file;
  }

  Random random = new Random();
  Future<dynamic> uploadt_image_map() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image_map',
      ),
    );
    request.fields['cid'] = code.toString();
    if (lat1 == null) {
      final response1 = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
        ),
      );
      final byte = response1.bodyBytes;
      Uint8List get_image_byte1 = Uint8List.fromList(byte);
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          get_image_byte1,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
        ),
      );
    } else {
      final response2 = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
        ),
      );
      final byte = response2.bodyBytes;
      Uint8List get_image_byte2 = Uint8List.fromList(byte);
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          get_image_byte2,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
        ),
      );
    }

    var res = await request.send();
  }

//===================== Upload Image to MySql Server
  File? _image;
  final picker = ImagePicker();
  late String base64string;
  XFile? _file;
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  Future openImage() async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        CroppedFile? cropFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
              lockAspectRatio: false,
              backgroundColor: Colors.blue,
              initAspectRatio: CropAspectRatioPreset.original,
            )
          ],
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.square,
          ],
        );

        setState(() {
          _file = XFile(cropFile!.path);
          // imagebytes = _file.path;
          // imagepath = pickedFile.path;
          _image = File(cropFile.path); //convert Path to File
        });
      } else {
        // print("No image is selected.");
      }
    } catch (e) {
      // print("error while picking file.");
    }
  }

  Future<dynamic> uploadt_image() async {
    var request = await http.MultipartRequest(
      "POST",
      Uri.parse(
        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image",
      ),
    );
    Map<String, String> headers = {
      "content-type": "application/json",
      "Connection": "keep-alive",
      "Accept-Encoding": " gzip"
    };
    request.headers.addAll(headers);
    // request.files.add(picture);
    request.fields['cid'] = code.toString();
    request.files.add(
      await http.MultipartFile.fromBytes(
        'image',
        imagebytes!,
        filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
      ),
    );
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    // print(result);
  }

  //get khan
  void Load_khan(String district) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_Khan = jsonData;
        id_khan = int.parse(list_Khan[0]['Khan_ID'].toString());
      });
    }
  }

  var id_Sangkat;
  List<dynamic> list_sangkat = [];
  void Load_sangkat(String id) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${id}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_sangkat = jsonData;
        id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID'].toString());
      });
    }
  }

  // int i = 0;
  double? ak;
  Future _asyncInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding:
              EdgeInsets.only(top: 30, left: 10, right: 15, bottom: 40),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: LandBuilding(
                ID_khan: id_khan.toString(),
                asking_price: (asking_price != 0.0) ? asking_price : ak,
                opt: (opt != null) ? opt! : 0,
                address: '${commune} / ${district}',
                list: (value) {
                  setState(() {
                    requestModelAuto.verbal = value;
                  });
                },
                landId: verbal_id,
                Avt: (value) {
                  a = value;
                  setState(() {});
                },
                opt_type_id: opt_type_id.toString(),
                check_property: 1,
                list_lb: (value) {
                  setState(() {
                    lb.addAll(value!);
                  });
                },
                ID_sangkat: id_Sangkat.toString(),
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
      color: kImageColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle NameProperty() {
    return TextStyle(
      color: kImageColor,
      fontSize: 11,
      fontWeight: FontWeight.bold,
    );
  }

  double? lat;
  double? log;
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

  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = position.latitude;
      log = position.longitude;
      requestModelAuto.lat = lat.toString();
      requestModelAuto.lng = log.toString();
    });
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
      ),
    );

    if (response.statusCode == 200) {
      // Successful response
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
                Load_khan(district.toString());
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                Load_sangkat(commune.toString());
              });
            }
          }
        }
      }
    }
  }
}

//================ add_autoverbal by approval ================================
class Add_with_Approval extends StatefulWidget {
  const Add_with_Approval(
      {super.key, required this.id, required this.id_control_user});
  final String id;
  final String id_control_user;
  @override
  State<Add_with_Approval> createState() => _Add_with_ApprovalState();
}

class _Add_with_ApprovalState extends State<Add_with_Approval>
    with TickerProviderStateMixin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int? opt;
  double? asking_price;
  Uint8List? get_image_byte;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel requestModelAuto;
  var from = [
    'Bank',
    'Private',
    'Other',
  ];
  var gender = [
    'Female',
    'Male',
    'Other',
  ];
  var district;

  late List<dynamic> list_Khan;
  int check_ios_pay = 0;
  int id_khan = 0;
  double? lat1;
  double? log2;
  var a;
  String? filePath;

  var opt_type_id = '0';
  var list;
  List<L_B> lb = [];
  void deleteItemToList(int Id) {
    setState(() {
      lb.removeAt(Id);
    });
  }

  File? file;
  Uint8List? get_bytes;
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;
  var id_verbal;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  int? number;
  var control_user;
  List? list_user;
  MyDb mydb_lb = new MyDb();
  MyDb mydb_vb = new MyDb();
  // Future get_control_user(String id) async {
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body);

  //     setState(() {
  //       // print(jsonData[0]['control_user'].toString() + "\n");
  //       list_user = jsonData[0];
  //     });
  //   }
  // }

  Future<void> get_count() async {
    setState(() {
      control_user = widget.id_control_user;
    });
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_count?id_user_control=${control_user}',
      ),
    );
    var rs_ios = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/ios_pay_option',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      var jsonData_ios = jsonDecode(rs_ios.body);
      setState(() {
        number = jsonData['number_count'];
        list_user = jsonData['user'];
        check_ios_pay = jsonData_ios;
      });
    }
  }

  Future<void> payment_done(BuildContext context) async {
    final Data = {
      "id_user_control": control_user.toString(),
      "count_autoverbal": "0",
    };
    final response = await http.post(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/0',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(Data),
    );
    if (response.statusCode == 200) {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.question,
        showCloseIcon: false,
        // title: value.message,
        autoHide: Duration(seconds: 10),
        body: Center(
          child: Text("Do you want to save photo"),
        ),
        btnOkOnPress: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => save_image_after_add_verbal(
                set_data_verbal: verbal_id,
              ),
            ),
          );
        },
        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        onDismissCallback: (type) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => List_Auto(
                verbal_id: widget.id,
                id_control_user: widget.id_control_user,
              ),
            ),
          );
        },
      ).show();
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  var verbal_id;
  @override
  void initState() {
    _getCurrentPosition();
    // get_control_user(widget.id.toString());
    verbal_id = widget.id_control_user.toString() + RandomString(9);
    get_count();
    addVerbal(context);
    lat1;
    log2;
    controller =
        AnimationController(duration: Duration(milliseconds: 645), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
    lb;

    super.initState();

    requestModelAuto = AutoVerbalRequestModel(
      property_type_id: "",
      lat: "",
      lng: "",
      address: '',
      approve_id: "",
      agent: "",
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
      user: "",
      verbal_com: '',
      verbal_con: "30",
      verbal: [],
      verbal_id: '0',
      verbal_khan: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (number != null) {
      setState(() {
        number;
      });
    }
    return (number != null)
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: ui.Color(0xEB070991),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () async {
                    MyDb mydb = new MyDb();

                    List<Map<String, dynamic>> jsonList =
                        lb.map((item) => item.toJson()).toList();
                    setState(() {
                      requestModelAuto.user = widget.id_control_user;
                      requestModelAuto.verbal_id = verbal_id;
                      requestModelAuto.verbal_khan = '${commune}.${district}';
                      requestModelAuto.verbal = jsonList;
                      _image;
                    });
                    await get_count();
                    if (number! >= 1) {
                      if (_image != null) {
                        Uint8List? imagebytes =
                            await FlutterImageCompress.compressWithFile(
                          _image!.absolute.path,
                          minHeight: 1280,
                          minWidth: 720,
                          quality: 80,
                        );
                        String base64string = base64.encode(imagebytes!);
                        requestModelAuto.image = base64string;
                      } else {
                        requestModelAuto.image = "No";
                      }

                      if (asking_price != null) {
                        APIservice apIservice = APIservice();
                        apIservice.saveAutoVerbal(requestModelAuto).then(
                          (value) async {
                            if (requestModelAuto.verbal.isEmpty) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Error',
                                desc: "Please add Land/Building at least 1!",
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.red,
                              ).show();
                            } else {
                              if (value.message == "Save Successfully") {
                                await payment_done(context);
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: 'Error',
                                  desc: value.message,
                                  btnOkOnPress: () {},
                                  btnOkIcon: Icons.cancel,
                                  btnOkColor: Colors.red,
                                ).show();
                              }
                            }
                          },
                        );
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: "Please select your Location",
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      }
                    } else {
                      if (jsonList.length <= 1) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: "Please add Land/Building at least 1!",
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else {
                        await mydb_lb.open_land_verbal();
                        await mydb_vb.open_verbal();

                        for (int i = 1; i < jsonList.length; i++) {
                          await mydb_lb.db.rawInsert(
                              "INSERT INTO comverbal_land_models (verbal_landid, verbal_land_dp, verbal_land_type, verbal_land_des, verbal_land_area, verbal_land_minsqm, verbal_land_maxsqm, verbal_land_minvalue, verbal_land_maxvalue, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);",
                              [
                                verbal_id.toString(),
                                int.parse(jsonList[i]['verbal_land_dp']),
                                (jsonList[i]['verbal_land_type'].toString() ??
                                    "0"),
                                (jsonList[i]['verbal_land_des'].toString() ??
                                    "0"),
                                double.parse(
                                  jsonList[i]['verbal_land_area'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_minsqm'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_maxsqm'].toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_minvalue']
                                      .toString(),
                                ),
                                double.parse(
                                  jsonList[i]['verbal_land_maxvalue']
                                      .toString(),
                                ),
                                (jsonList[i]['address'].toString() ?? "0")
                              ]);
                        }
                        if (_image != null) {
                          Uint8List? imagebytes =
                              await FlutterImageCompress.compressWithFile(
                            _image!.absolute.path,
                            minHeight: 1280,
                            minWidth: 720,
                            quality: 80,
                          );
                          String base64string = base64.encode(imagebytes!);
                          await mydb_vb.db.rawInsert(
                              "INSERT INTO verbal_models (verbal_id, verbal_khan, verbal_property_id, verbal_bank_id, verbal_bank_branch_id, verbal_bank_contact, verbal_owner, verbal_contact, verbal_date, verbal_bank_officer,verbal_address,verbal_approve_id,VerifyAgent,verbal_comment,latlong_log,latlong_la,verbal_image,verbal_com,verbal_con,verbal_property_code,verbal_user,verbal_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?);",
                              [
                                verbal_id ?? "No",
                                requestModelAuto.verbal_khan,
                                requestModelAuto.property_type_id,
                                requestModelAuto.bank_id,
                                requestModelAuto.bank_branch_id,
                                requestModelAuto.bank_contact,
                                requestModelAuto.owner,
                                requestModelAuto.contact,
                                requestModelAuto.date,
                                requestModelAuto.bank_officer,
                                requestModelAuto.address,
                                requestModelAuto.approve_id,
                                requestModelAuto.agent,
                                requestModelAuto.comment,
                                requestModelAuto.lat,
                                requestModelAuto.lng,
                                base64string,
                                requestModelAuto.verbal_com,
                                requestModelAuto.verbal_con,
                                "No",
                                widget.id_control_user,
                                requestModelAuto.option
                              ]);
                        } else {
                          await mydb_vb.db.rawInsert(
                              "INSERT INTO verbal_models (verbal_id, verbal_khan, verbal_property_id, verbal_bank_id, verbal_bank_branch_id, verbal_bank_contact, verbal_owner, verbal_contact, verbal_date, verbal_bank_officer,verbal_address,verbal_approve_id,VerifyAgent,verbal_comment,latlong_log,latlong_la,verbal_image ,verbal_com,verbal_con,verbal_property_code,verbal_user,verbal_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?,?,?);",
                              [
                                verbal_id,
                                requestModelAuto.verbal_khan,
                                requestModelAuto.property_type_id,
                                requestModelAuto.bank_id,
                                requestModelAuto.bank_branch_id,
                                requestModelAuto.bank_contact,
                                requestModelAuto.owner,
                                requestModelAuto.contact,
                                requestModelAuto.date,
                                requestModelAuto.bank_officer,
                                requestModelAuto.address,
                                requestModelAuto.approve_id,
                                requestModelAuto.agent,
                                requestModelAuto.comment,
                                requestModelAuto.lat,
                                requestModelAuto.lng,
                                "No",
                                requestModelAuto.verbal_com,
                                requestModelAuto.verbal_con,
                                "No",
                                widget.id_control_user,
                                requestModelAuto.option
                              ]);
                        }
                        List<Map>? vb, lb;
                        lb = await mydb_lb.db.rawQuery(
                          "SELECT * FROM comverbal_land_models WHERE verbal_landid = ? ",
                          [verbal_id.toString()],
                        );
                        vb = await mydb_vb.db.rawQuery(
                          "SELECT * FROM verbal_models  WHERE verbal_id = ?",
                          [verbal_id.toString()],
                        );
                        setState(() {
                          if (vb!.length == 1 && lb!.length == 1) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Success',
                              desc: "Data is saving for waiting your payment",
                              autoHide: Duration(seconds: 3),
                              onDismissCallback: (type) async {
                                // await get_control_user(widget.id);
                                // debugPrint('Dialog Dissmiss from callback $type');
                                setState(() {
                                  print(
                                    "object: ${list_user![0].toString()}\n",
                                  );
                                });

                                if (Platform.isAndroid || check_ios_pay == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TopUp(
                                        set_phone:
                                            "${list_user![0]['tel_num']}",
                                        set_id_user: list_user![0]
                                                ['control_user']
                                            .toString(),
                                        set_email:
                                            list_user![0]['email'].toString(),
                                        id_user: widget.id,
                                        id_verbal: verbal_id.toString(),
                                      ),
                                    ),
                                  );
                                } else if (Platform.isIOS &&
                                    check_ios_pay == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TopUp_ios(
                                        set_phone:
                                            "${list_user![0]['tel_num']}",
                                        id_user: widget.id,
                                        set_id_user: control_user,
                                      ),
                                    ),
                                  );
                                }

                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           ProtectDataCrossCheck(
                                //         id_user: widget.id_control_user,
                                //       ),
                                //     ));
                              },
                            ).show();
                          } else if (lb!.isEmpty && vb.length == 1) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "Please add Land/Building at least 1!",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          } else if (lb.length == 1 && vb.isEmpty) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "Please check find that your input",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          } else {}
                        });
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => TopUp(
                      //       set_phone: list_user['tel_num'].toString(),
                      //       set_id_user: list_user['control_user'].toString(),
                      //       set_email: list_user['email'].toString(),
                      //       id_user: widget.id,
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[700],
                      boxShadow: [
                        BoxShadow(color: Colors.green, blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        bottomLeft: Radius.circular(80),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Submit",
                          style: TextStyle(fontSize: 10),
                        ),
                        Icon(Icons.save_alt_outlined, size: 15),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 10,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 32, 32),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.topRight,
                        )
                      ],
                    ),
                  ),
                ),
              ],
              title: Text(
                'property check for approval',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                ),
              ),
              toolbarHeight: 80,
            ),
            backgroundColor: Color.fromARGB(235, 7, 9, 145),
            body: RefreshIndicator(
              onRefresh: () => get_count(),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: addVerbal(context),
                ),
              ),
            ),
            floatingActionButton: (number! > 0)
                ? FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        number;
                        _controller.dispose();
                      });
                    },
                    backgroundColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${number}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.amber[800],
                          ),
                        ),
                        RotationTransition(
                          turns: _animation,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/v.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    child: Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Please, Top up now for cross check value',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[800],
                        ),
                      ),
                    ),
                  ),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(235, 7, 9, 145),
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
            ),
          );
  }

  Widget addVerbal(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Code(
          code: (value) {
            setState(() {
              // code = value;
            });
          },
          cd: verbal_id,
          check_property: 1,
        ),
        if (lat != null && lat1 == null)
          InkWell(
            onTap: () async {
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 120,
                placeholderCacheWidth: 120,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.contain,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else if (lat1 != null)
          InkWell(
            onTap: () async {
              setState(() {
                asking_price = 0.0;
              });
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 50,
                placeholderCacheWidth: 50,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.fill,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else
          SizedBox(height: 12),
        SizedBox(height: 12),
        CommentAndOption(
          value: (value) {
            setState(() {
              opt = int.parse(value);
            });
          },
          comment1: (opt != null) ? opt.toString() : null,
          id: (value) {
            setState(() {
              requestModelAuto.option = value.toString();
            });
          },
          comment: (newValue) {
            setState(() {
              requestModelAuto.comment = newValue!.toString();
            });
          },
          opt_type_id: (value) {
            setState(() {
              opt_type_id = value.toString();
            });
          },
        ),
        if (id_khan != 0)
          InkWell(
            onTap: () {
              _asyncInputDialog(context);
            },
            child: Container(
              height: 37,
              margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("land~Building"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Horizon',
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('land'),
                          RotateAnimatedText('Building'),
                        ],
                        pause: const Duration(milliseconds: 100),
                        repeatForever: true,
                      ),
                    ),
                  ),
                  GFAnimation(
                    controller: controller,
                    slidePosition: offsetAnimation,
                    type: GFAnimationType.slideTransition,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 30,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),
          ),

        Container(
          width: 500,
          height: (lb.length >= 1) ? 200 : 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < lb.length; i++)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                      width: 290,
                      //height: 210,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: kPrimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${lb[i].verbal_land_type} ',
                                      style: NameProperty(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            deleteItemToList(i);
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: kPrimaryColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${lb[i].address} ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                  SizedBox(height: 3),
                                  Text(
                                    "Floor",
                                    style: Label(),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Area",
                                    style: Label(),
                                  ),
                                  SizedBox(height: 3),
                                  // Text(
                                  //   'Min Value/Sqm',
                                  //   style: Label(),
                                  // ),
                                  // SizedBox(height: 3),
                                  // Text(
                                  //   'Max Value/Sqm',
                                  //   style: Label(),
                                  // ),
                                  // SizedBox(height: 3),
                                  // Text(
                                  //   'Min Value',
                                  //   style: Label(),
                                  // ),
                                  // SizedBox(height: 3),
                                  // Text(
                                  //   'Man Value',
                                  //   style: Label(),
                                  // ),
                                ],
                              ),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text(
                                    ':   ' + lb[i].verbal_land_dp,
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' + lb[i].verbal_land_des,
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        (formatter.format(
                                          lb[i].verbal_land_area.toInt(),
                                        )).toString() +
                                        'm' +
                                        '\u00B2',
                                    style: Name(),
                                  ),
                                  SizedBox(height: 2),
                                  // Text(
                                  //   ':   ' +
                                  //       formatter
                                  //           .format(lb[i].verbal_land_minsqm) +
                                  //       '\$',
                                  //   style: Name(),
                                  // ),
                                  // SizedBox(height: 2),
                                  // Text(
                                  //   ':   ' +
                                  //       formatter
                                  //           .format(lb[i].verbal_land_maxsqm) +
                                  //       '\$',
                                  //   style: Name(),
                                  // ),
                                  // SizedBox(height: 2),
                                  // Text(
                                  //   ':   ' +
                                  //       (formatter.format(
                                  //         lb[i].verbal_land_minvalue,
                                  //       )).toString() +
                                  //       '\$',
                                  //   style: Name(),
                                  // ),
                                  // SizedBox(height: 2),
                                  // Text(
                                  //   ':   ' +
                                  //       (formatter
                                  //               .format(
                                  //                 lb[i].verbal_land_maxvalue,
                                  //               )
                                  //               .toString() +
                                  //           '\$'),
                                  //   style: Name(),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: [
            if (_file != null)
              Container(
                height: 200,
                width: 400,
                // child: Image.file(File(_file!.path)),
                child: Image.file(_image!),
              ),
            // if (_file == null)
            TextButton(
              onPressed: () async {
                await openImage();
                setState(() {
                  _file;
                });
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    // padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.map_sharp,
                            color: kImageColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            (imagepath == "")
                                ? 'Choose Photo'
                                : 'choosed Photo',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        dropdown_shape_of_land(),
        PropertyDropdown(
          name: (value) {
            setState(() {
              propertyType = value;
            });
          },
          id: (value) {
            setState(() {
              requestModelAuto.property_type_id = value;
            });
          },
          // pro: list[0]['property_type_name'],
        ),

        BankDropdown(
          bank: (value) {
            setState(() {
              requestModelAuto.bank_id = value;
            });
          },
          bankbranch: (value) {
            setState(() {
              requestModelAuto.bank_branch_id = value;
            });
          },
        ),
        SizedBox(
          height: 5.0,
        ),
        FormTwinN(
          Label1: 'Owner',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.owner = input!;
          },
          onSaved2: (input) {
            requestModelAuto.contact = input!;
          },
          icon1: Icon(
            Icons.person,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        // DateComponents(
        //   date: (value) {
        //     requestModelAuto.date = value;
        //   },
        // ),

        FormTwinN(
          Label1: 'Bank Officer',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.bank_officer = input!;
          },
          onSaved2: (input) {
            setState(() {
              requestModelAuto.bank_contact = input!;
            });
          },
          icon1: Icon(
            Icons.work,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),

        SizedBox(
          height: 5,
        ),
        // ForceSaleAndValuation(
        //   value: (value) {
        //     requestModelAuto.verbal_con = value;
        //   },
        //   // fsl: list[0]['verbal_con'],
        // ),

        // ApprovebyAndVerifyby(
        //   approve: (value) {
        //     setState(() {
        //       requestModelAuto.approve_id = value.toString();
        //     });
        //   },
        //   verify: (value) {
        //     setState(() {
        //       requestModelAuto.agent = value.toString();
        //     });
        //   },
        //   // appro: list[0]['approve_name'],
        //   // vfy: list[0]['VerifyAgent'],
        // ),

        FormS(
          label: 'Phum optional',
          onSaved: (input) {
            requestModelAuto.address = input!.toString();
          },
          iconname: Icon(
            Icons.location_on_rounded,
            color: kImageColor,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }

  var dropdown;
  String? options;
  String? commune;

  //MAP
  Future<void> SlideUp(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Map_verbal_add(
          show_landmarket_price: false,
          get_commune: (value) {
            setState(() {
              commune = value;
              Load_sangkat(value);
            });
          },
          get_district: (value) {
            setState(() {
              district = value;
              Load_khan(district);
            });
          },
          get_lat: (value) {
            setState(() {
              lat1 = double.parse(value);
              requestModelAuto.lat = value;
            });
          },
          get_log: (value) {
            setState(() {
              log2 = double.parse(value);
              requestModelAuto.lng = value;
            });
          },
          get_province: (value) {},
        ),
      ),
    );

    if (!mounted) return;
  }

  Future<File> convertImageByteToFile(
    Uint8List imageBytes,
    String fileName,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('$path/$fileName');
    await file.writeAsBytes(imageBytes);
    return file;
  }

  Random random = new Random();
  Future<dynamic> uploadt_image_map() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image_map',
      ),
    );
    request.fields['cid'] = code.toString();
    if (lat1 == null) {
      final response1 = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
        ),
      );
      final byte = response1.bodyBytes;
      Uint8List get_image_byte1 = Uint8List.fromList(byte);
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          get_image_byte1,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
        ),
      );
    } else {
      final response2 = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
        ),
      );
      final byte = response2.bodyBytes;
      Uint8List get_image_byte2 = Uint8List.fromList(byte);
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          get_image_byte2,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
        ),
      );
    }

    var res = await request.send();
  }

//===================== Upload Image to MySql Server
  File? _image;
  final picker = ImagePicker();
  late String base64string;
  XFile? _file;
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  Future openImage() async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        CroppedFile? cropFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
              lockAspectRatio: false,
              backgroundColor: Colors.blue,
              initAspectRatio: CropAspectRatioPreset.original,
            )
          ],
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.square,
          ],
        );

        setState(() {
          _file = XFile(cropFile!.path);
          // imagebytes = _file.path;
          // imagepath = pickedFile.path;
          _image = File(cropFile.path); //convert Path to File
        });
      } else {
        // print("No image is selected.");
      }
    } catch (e) {
      // print("error while picking file.");
    }
  }

  Future<dynamic> uploadt_image() async {
    var request = await http.MultipartRequest(
      "POST",
      Uri.parse(
        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image",
      ),
    );
    Map<String, String> headers = {
      "content-type": "application/json",
      "Connection": "keep-alive",
      "Accept-Encoding": " gzip"
    };
    request.headers.addAll(headers);
    // request.files.add(picture);
    request.fields['cid'] = code.toString();
    request.files.add(
      await http.MultipartFile.fromBytes(
        'image',
        imagebytes!,
        filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png',
      ),
    );
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    // print(result);
  }

  //get khan
  void Load_khan(String district) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_Khan = jsonData;
        id_khan = int.parse(list_Khan[0]['Khan_ID'].toString());
      });
    }
  }

  var id_Sangkat;
  List<dynamic> list_sangkat = [];
  void Load_sangkat(String id) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${id}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_sangkat = jsonData;
        id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID'].toString());
      });
    }
  }

  // int i = 0;
  double? ak;
  Future _asyncInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding:
              EdgeInsets.only(top: 30, left: 10, right: 15, bottom: 40),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: LandBuilding(
                ID_khan: id_khan.toString(),
                asking_price: (asking_price != 0.0) ? asking_price : ak,
                opt: (opt != null) ? opt! : 0,
                address: '${commune} / ${district}',
                list: (value) {
                  setState(() {
                    requestModelAuto.verbal = value;
                  });
                },
                landId: verbal_id,
                Avt: (value) {
                  a = value;
                  setState(() {});
                },
                opt_type_id: opt_type_id.toString(),
                check_property: 0,
                list_lb: (value) {
                  setState(() {
                    lb.addAll(value!);
                  });
                },
                ID_sangkat: id_Sangkat.toString(),
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
      color: kImageColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle NameProperty() {
    return TextStyle(
      color: kImageColor,
      fontSize: 11,
      fontWeight: FontWeight.bold,
    );
  }

  double? lat;
  double? log;
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

  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = position.latitude;
      log = position.longitude;
      requestModelAuto.lat = lat.toString();
      requestModelAuto.lng = log.toString();
    });
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
      ),
    );

    if (response.statusCode == 200) {
      // Successful response
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
                Load_khan(district.toString());
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                Load_sangkat(commune.toString());
              });
            }
          }
        }
      }
    }
  }
}
