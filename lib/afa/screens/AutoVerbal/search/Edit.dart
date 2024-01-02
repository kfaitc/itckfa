// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/afa/components/LandBuilding.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/afa/customs/readonly.dart';
import 'package:itckfa/afa/screens/AutoVerbal/Add.dart';
import 'package:itckfa/afa/screens/AutoVerbal/printer/save_image_for_Autoverbal.dart';
import 'package:itckfa/models/model_bl_new.dart';
import 'package:itckfa/screen/components/map_all/map_in_edit_verbal.dart';
import 'package:itckfa/screen/components/payment/Main_Form/in_app_purchase_top_up.dart';
import 'package:itckfa/screen/components/payment/Main_Form/top_up.dart';

import '../../../../api/api_service.dart';
import '../../../../models/autoVerbal.dart';
import '../../../../screen/Customs/formTwinN.dart';
import '../../../../screen/Customs/responsive.dart';
import '../../../../screen/Profile/components/Drop.dart';
import '../../../components/ApprovebyAndVerifyby.dart';
import '../../../components/code.dart';
import '../../../components/comment.dart';
import '../../../components/forceSale.dart';
import '../../../components/property.dart';
import '../../../customs/uplandBuilding.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Edit extends StatefulWidget {
  const Edit({
    super.key,
    required this.verbal_id,
    required this.user_id_controller,
  });
  final String verbal_id;
  final String user_id_controller;
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> with SingleTickerProviderStateMixin {
  MyDb mydb_lb = new MyDb();
  MyDb mydb_vb = new MyDb();
  MyDb mydb_user = new MyDb();
  List<Map> DataAutoVerbal = [];
  List<Map> DataLandAutoVerbal = [];
  List list = [];
  List land = [];
  List user = [];
  Future find() async {
    await mydb_vb.open_verbal();
    await mydb_lb.open_land_verbal();
    await mydb_user.open_user();
    double x = 0, n = 0;
    land = await mydb_lb.db.rawQuery(
        "SELECT * FROM comverbal_land_models WHERE verbal_landid = ? ",
        [widget.verbal_id.toString()]);

    list = await mydb_vb.db.rawQuery(
        "SELECT * FROM verbal_models  WHERE verbal_id = ?",
        [widget.verbal_id.toString()]);
    user = await mydb_user.db.rawQuery(
        'SELECT * FROM user  WHERE username = ? ',
        [widget.user_id_controller.toString()]);
    setState(() {
      print("object\n $user \n");
      land;
      list;
      user;
    });
    get_property();
    get_bank();
    get_bankbranch();
    get_count();

    // get_bankbranch();
  }

  var property_name = "";
  Future get_property() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property?property_type_id=${list[0]['verbal_property_id']}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        print("\nsdfsdf");
        property_name = jsonData['property'][0]["property_type_name"];
      });
    }
  }

  var bank = "";
  Future get_bank() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank?bank_id=${list[0]['verbal_bank_id']}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      // print(jsonData);
      // print(jsonData);

      setState(() {
        bank = jsonData['banks'][0]['bank_acronym'];
      });
    }
  }

  var _branch = "";
  void get_bankbranch() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_id=${list[0]['verbal_bank_branch_id']}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body.toString());
      // print(jsonData);
      setState(() {
        print(jsonData);

        if (jsonData.toString() != '[]') {
          _branch = jsonData[0]['bank_branch_name'];
        } else {
          _branch = "Null";
        }
      });
    }
  }

  int? number;
  Future<void> get_count() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_count?id_user_control=${list[0]["verbal_user"]}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        number = jsonData;
        print("object: $number \n\n");
      });
    }
  }

  @override
  void initState() {
    find();

    if (list.length > 0) {}
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width * 9;
    setState(() {
      bank;
      property_name;
      _branch;
      print("object $bank \n $property_name \n $_branch");
    });
    if (number != null) {
      setState(() {
        number;
      });
    }
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: kwhite_new,
        centerTitle: true,
        title: Text("Check Out"),
      ),
      body: (list.length > 0 &&
              bank != '' &&
              property_name != '' &&
              _branch != '')
          ? SafeArea(
              child: RefreshIndicator(
                onRefresh: () => find(),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        (list[0]["verbal_image"] == "null" ||
                                list[0]["verbal_image"] == "No")
                            ? Container(
                                height: 200,
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_la"]},${list[0]["latlong_log"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_la"]},${list[0]["latlong_log"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 150,
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 150,
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: MemoryImage(base64
                                              .decode(list[0]["verbal_image"])),
                                          //  NetworkImage(
                                          //     'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_la"]},${list[0]["latlong_log"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_la"]},${list[0]["latlong_log"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                        Box(
                          label: "ID Auto Verbal",
                          iconname: const Icon(
                            Icons.code,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_id"] ?? "",
                        ),
                        Box(
                          label: "Property",
                          iconname: const Icon(
                            Icons.business_outlined,
                            color: kImageColor,
                          ),
                          value: property_name ?? "",
                        ),
                        Box(
                          label: "Bank",
                          iconname: const Icon(
                            Icons.home_work,
                            color: kImageColor,
                          ),
                          value: bank ?? "",
                        ),
                        Box(
                          label: "Branch",
                          iconname: const Icon(
                            Icons.account_tree_rounded,
                            color: kImageColor,
                          ),
                          value: _branch ?? "",
                        ),
                        Box(
                          label: "Owner",
                          iconname: const Icon(
                            Icons.person,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_owner"] ?? "",
                        ),
                        Box(
                          label: "Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_contact"] ?? "",
                        ),
                        // Box(
                        //   label: "Date",
                        //   iconname: const Icon(
                        //     Icons.calendar_today,
                        //     color: kImageColor,
                        //   ),
                        //   value: list[0]["verbal_created_date"].split(" ")[0] ??
                        //       "N/A",
                        // ),
                        Box(
                          label: "Bank Officer",
                          iconname: const Icon(
                            Icons.work,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_bank_officer"] ?? "",
                        ),
                        Box(
                          label: "Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_bank_contact"] ?? "",
                        ),
                        // Box(
                        //   label: "Comment",
                        //   iconname: const Icon(
                        //     Icons.comment_sharp,
                        //     color: kImageColor,
                        //   ),
                        //   value: list[0]["verbal_comment"] ?? "",
                        // ),
                        // Box(
                        //   label: "Verify by",
                        //   iconname: const Icon(
                        //     Icons.person_sharp,
                        //     color: kImageColor,
                        //   ),
                        //   value: list[0]["agenttype_name"] ?? "",
                        // ),
                        // Box(
                        //   label: "Approve by",
                        //   iconname: const Icon(
                        //     Icons.person_outlined,
                        //     color: kImageColor,
                        //   ),
                        //   value: list[0]["approve_name"] ?? "",
                        // ),
                        Box(
                          label: "Address",
                          iconname: const Icon(
                            Icons.location_on_rounded,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_address"].toString() +
                                  ' / ' +
                                  list[0]["verbal_khan"] ??
                              "",
                        ),
                        //     SizedBox(
                        //       width: 450,
                        //       height: 270,
                        //       child: SingleChildScrollView(
                        //         scrollDirection: Axis.horizontal,
                        //         child: Row(
                        //           children: [
                        //             for (int i = 0; i < land.length; i++)
                        //               Container(
                        //                 width: 270,
                        //                 // height: 200,
                        //                 padding: const EdgeInsets.all(7),
                        //                 margin: const EdgeInsets.all(11),
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   boxShadow: const [
                        //                     BoxShadow(
                        //                         blurRadius: 2,
                        //                         color: Colors.black45)
                        //                   ],
                        //                   border: Border.all(
                        //                       width: 1, color: kPrimaryColor),
                        //                   borderRadius:
                        //                       BorderRadius.all(Radius.circular(15)),
                        //                 ),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           left: 7, right: 10),
                        //                       child: Text.rich(
                        //                         TextSpan(
                        //                           children: <InlineSpan>[
                        //                             WidgetSpan(
                        //                                 child: Icon(
                        //                               Icons.location_on_sharp,
                        //                               color: kPrimaryColor,
                        //                               size: 14,
                        //                             )),
                        //                             TextSpan(
                        //                                 text:
                        //                                     "${land[i]['address']} "),
                        //                           ],
                        //                         ),
                        //                         textAlign: TextAlign.left,
                        //                         style: const TextStyle(
                        //                             fontSize: 10,
                        //                             overflow:
                        //                                 TextOverflow.ellipsis),
                        //                       ),
                        //                     ),
                        //                     const SizedBox(
                        //                       height: 3.0,
                        //                     ),
                        //                     const Divider(
                        //                       height: 1,
                        //                       thickness: 1,
                        //                       color: kPrimaryColor,
                        //                     ),
                        //                     const SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                     Container(
                        //                       padding:
                        //                           const EdgeInsets.only(left: 10),
                        //                       alignment: Alignment.centerLeft,
                        //                       child: Text(
                        //                         land[i]['verbal_land_type'],
                        //                       ),
                        //                     ),
                        //                     Row(
                        //                       children: [
                        //                         const SizedBox(width: 10),
                        //                         Column(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.start,
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           children: [
                        //                             Text(
                        //                               "Depreciation",
                        //                               style: Label(),
                        //                             ),
                        //                             const SizedBox(height: 3),
                        //                             Text(
                        //                               "Area",
                        //                               style: Label(),
                        //                             ),
                        //                             SizedBox(height: 3),
                        //                             Text(
                        //                               'Min Value/Sqm',
                        //                               style: Label(),
                        //                             ),
                        //                             const SizedBox(height: 3),
                        //                             Text(
                        //                               'Max Value/Sqm',
                        //                               style: Label(),
                        //                             ),
                        //                             const SizedBox(height: 3),
                        //                             Text(
                        //                               'Min Value',
                        //                               style: Label(),
                        //                             ),
                        //                             SizedBox(height: 3),
                        //                             Text(
                        //                               'Min Value',
                        //                               style: Label(),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                         SizedBox(width: 15),
                        //                         Column(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.start,
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           children: [
                        //                             SizedBox(height: 4),
                        //                             Text(
                        //                               ':   ' +
                        //                                   land[i]['verbal_land_dp'],
                        //                               style: Name(),
                        //                             ),
                        //                             SizedBox(height: 2),
                        //                             Text(
                        //                               ':   ${formatter.format(double.parse(land[i]['verbal_land_area'].toString()))} m\u00B2',
                        //                               style: Name(),
                        //                             ),
                        //                             SizedBox(height: 2),
                        //                             Text(
                        //                               ':   ${formatter.format(double.parse(land[i]['verbal_land_minsqm'].toString()))} \$',
                        //                               style: Name(),
                        //                             ),
                        //                             SizedBox(height: 2),
                        //                             Text(
                        //                               ':   ${formatter.format(double.parse(land[i]['verbal_land_maxsqm'].toString()))} \$',
                        //                               style: Name(),
                        //                             ),
                        //                             SizedBox(height: 2),
                        //                             Text(
                        //                               ':   ${formatter.format(double.parse(land[i]['verbal_land_minvalue'].toString()))} \$',
                        //                               style: Name(),
                        //                             ),
                        //                             SizedBox(height: 2),
                        //                             Text(
                        //                               ':   ${formatter.format(double.parse(land[i]['verbal_land_maxvalue'].toString()))} \$',
                        //                               style: Name(),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: InkWell(
        onTap: () {
          setState(() {
            (bnt1) ? (bnt1 = false) : (bnt1 = true);
            // List<L_B> lb;
            // .
            requestModelAuto = AutoVerbalRequestModel(
              property_type_id: list[0]["verbal_property_id"],
              lat: list[0]["latlong_log"],
              lng: list[0]["latlong_la"],
              address: list[0]["verbal_address"],
              approve_id: list[0]["verbal_approve_id"],
              agent: list[0]["VerifyAgent"],
              bank_branch_id: list[0]["verbal_bank_branch_id"],
              bank_contact: list[0]["verbal_bank_contact"],
              bank_id: list[0]["verbal_bank_id"],
              bank_officer: list[0]["verbal_bank_officer"],
              code: list[0]["verbal_property_code"],
              comment: list[0]["verbal_comment"],
              contact: list[0]["verbal_contact"],
              date: list[0]["verbal_date"],
              image: list[0]["verbal_image"],
              option: list[0]["verbal_option"],
              owner: list[0]["verbal_owner"],
              user: list[0]["verbal_user"],
              verbal_com: list[0]["verbal_com"],
              verbal_con: list[0]["verbal_con"],
              verbal: land,
              verbal_id: list[0]["verbal_id"],
              verbal_khan: list[0]["verbal_khan"],
            );
          });
          if (number! >= 1) {
            APIservice apIservice = APIservice();
            apIservice.saveAutoVerbal(requestModelAuto!).then(
              (value) async {
                if (requestModelAuto!.verbal.isEmpty) {
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
                    await mydb_vb.db.rawDelete(
                        "DELETE FROM verbal_models WHERE verbal_id = ?",
                        [list[0]["verbal_id"]]);
                    await mydb_lb.db.rawDelete(
                        "DELETE FROM comverbal_land_models WHERE verbal_landid = ?",
                        [list[0]["verbal_id"]]);

                    await payment_done(context);
                    // ignore: use_build_context_synchronously
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => save_image_after_add_verbal(
                                    set_data_verbal: list[0]["verbal_id"],
                                  )));
                        },
                        btnCancelOnPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => save_image_after_add_verbal(
                                    set_data_verbal: list[0]["verbal_id"],
                                  )));
                        },
                        btnOkIcon: Icons.info_outline,
                        btnOkColor: Colors.blueAccent,
                        onDismissCallback: (type) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => List_Auto(
                                verbal_id: list[0]["verbal_id"],
                                id_control_user: list[0]["verbal_user"],
                              ),
                            ),
                          );
                        }).show();
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
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              headerAnimationLoop: true,
              title: 'Error',
              desc: "You need VPoint to Process\nNow You have $number VPoint",
              autoHide: Duration(seconds: 4),
              btnOkOnPress: () {
                setState(() {
                  (!bnt1) ? (bnt1 = true) : (bnt1 = false);
                });
              },
              onDismissCallback: (type) {
                setState(() {
                  int i = user.length;

                  if (Platform.isIOS) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopUp_ios(
                          set_phone: user[i - 1]['tel_num'].toString(),
                          id_user: user[i - 1]['id'].toString(),
                          set_id_user: user[i - 1]['username'].toString(),
                        ),
                      ),
                    );
                  } else if (Platform.isAndroid) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopUp(
                          set_phone: user[i - 1]['tel_num'].toString(),
                          set_id_user: user[i - 1]['username'].toString(),
                          set_email: user[i - 1]['email'].toString(),
                          id_user: user[i - 1]['id'].toString(),
                          id_verbal: list[0]["verbal_id"],
                        ),
                      ),
                    );
                  }
                });
              },
              // btnOkIcon: Icons.info_outline,
              // btnOkColor: Colors.blueAccent,
            ).show();
          }
        },
        child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.5,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Colors.black87,
                  offset: (bnt1 == false) ? Offset(1, 0.5) : Offset(0, 0),
                  blurStyle: BlurStyle.outer)
            ], color: kwhite_new, borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Payment",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100),
            )),
      ),
    );
  }

  AutoVerbalRequestModel? requestModelAuto;
  bool bnt1 = false;
  List<Map<String, dynamic>> convertList(
      List<Map<dynamic, dynamic>> originalList) {
    List<Map<String, dynamic>> convertedList = [];

    for (var originalMap in originalList) {
      Map<String, dynamic> convertedMap = {};

      // Convert keys to String
      originalMap.forEach((key, value) {
        convertedMap[key.toString()] = value;
      });

      convertedList.add(convertedMap);
    }

    return convertedList;
  }

  Future<void> payment_done(BuildContext context) async {
    final Data = {
      "id_user_control": list[0]["verbal_user"],
      "count_autoverbal": "-1",
    };
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/0'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(Data),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
    }
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 12);
  }

  TextStyle Name() {
    return TextStyle(
      color: Colors.black12,
      fontSize: 13,
      // decoration: TextDecoration.lineThrough,
      // decorationColor: Colors.redAccent,
      fontWeight: FontWeight.bold,
      // shadows: [Shadow(blurRadius: 50)],
    );
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }

  var formatter = NumberFormat("##,###,###,###", "en_US");
}
