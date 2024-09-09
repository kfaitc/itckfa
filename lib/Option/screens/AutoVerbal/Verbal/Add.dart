// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/Option/components/colors.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../contants.dart';
import '../../../../Getx/Auth/Auth.dart';
import '../../../../Getx/Auto_Verbal/autu_verbal.dart';
import '../../../../Getx/Memory/pdf.dart';
import '../../../../Getx/local/mydb.dart';
import '../../../../models/autoverbal_model.dart';
import '../../../../models/model_bl_new.dart';
import '../../../../screen/Customs/formTwinN.dart';
import '../../../components/bank_dropdown.dart';
import '../../../components/code.dart';
import '../../../components/comment.dart';
import '../../../components/property35_search.dart';
import '../../../components/slideUp.dart';

var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

String RandomString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

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
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  Data datamodel = Data();
  TextEditingController dateinput = TextEditingController();
  // late AutoVerbalRequestModel datamodel;

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

  late List<dynamic> list_Khan;

  int id_khan = 0;
  double? lat1;
  double? log2;
  var a;
  String? filePath;
  MyDb mydb_lb = MyDb();
  MyLocalhost myDB = MyLocalhost();
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

  PDFController pdfController = PDFController();
  // Future<void> payment_done(BuildContext context) async {
  //   final Data = {
  //     "id_user_control": control_user.toString(),
  //     "count_autoverbal": "-1",
  //   };
  //   final response = await http.post(
  //     Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/0',
  //     ),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode(Data),
  //   );
  //   if (response.statusCode == 200) {
  //     AwesomeDialog(
  //       context: context,
  //       animType: AnimType.leftSlide,
  //       headerAnimationLoop: false,
  //       dialogType: DialogType.success,
  //       showCloseIcon: false,
  //       // title: value.message,
  //       autoHide: const Duration(seconds: 10),
  //       body: const Center(child: Text("Do you want to save photo")),
  //       btnOkOnPress: () {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => save_image_after_add_verbal(
  //               set_data_verbal: code.toString(),
  //             ),
  //           ),
  //         );
  //       },
  //       btnCancelOnPress: () {
  //         Navigator.pop(context);
  //       },
  //       onDismissCallback: (type) {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => List_Auto(
  //               verbal_id: widget.id,
  //               id_control_user: widget.id_control_user,
  //             ),
  //           ),
  //         );
  //       },
  //     ).show();
  //   }
  // }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  bool checkMap = false;
  TextEditingController addressController = TextEditingController();
  final authService = Authentication();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    pdfController.imagePDF();
    myDB.autoVerbalDB();
    mydb_lb.open_land_verbal();

    controller = AnimationController(
      duration: const Duration(milliseconds: 645),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.reset();
    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack,
      ),
    );

    lb;

    super.initState();

    // datamodel = AutoVerbalRequestModel(
    //   borey: "0",
    //   road: "",
    //   property_type_id: "0",
    //   lat: "0",
    //   lng: "0",
    //   address: '',
    //   approve_id: "0",
    //   agent: "0",
    //   bank_branch_id: "0",
    //   bank_contact: "0",
    //   bank_id: "0",
    //   bank_officer: "0",
    //   code: "0",
    //   comment: "0",
    //   contact: "0",
    //   date: "0",
    //   image: "",
    //   option: "0",
    //   owner: "0",
    //   user: widget.id_control_user,
    //   verbal_com: '0',
    //   verbal_con: "30",
    //   verbal: [],
    datamodel.protectID = int.parse(
      "${widget.id}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}",
    );
    //   verbal_khan: '0',
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AuthVerbal>()) {
      Get.put(AuthVerbal(Iduser: widget.id_control_user));
    }
    final AuthVerbal authVerbal = Get.find<AuthVerbal>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(235, 7, 9, 145),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          SizedBox(
            height: 40,
            width: 90,
            child: Obx(
              () {
                if (authVerbal.isAuthGet.value) {
                  return const SizedBox();
                } else if ((authVerbal.listGetUser.isNotEmpty)) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          authVerbal.countAccount.value.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.amber[800],
                          ),
                        ),
                        const SizedBox(width: 5),
                        RotationTransition(
                          turns: _animation,
                          child: Container(
                            height: 30,
                            width: 30,
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
                  );
                } else {
                  return InkWell(
                    child: Container(
                      color: Colors.blue[900],
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'No VPoint',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[800],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
        title: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          child: Text('Auto Verbal',
              style: TextStyle(
                color: whiteColor,
                fontSize: 17,
              )),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: const Color.fromARGB(235, 7, 9, 145),
      body: Obx(() {
        if (authVerbal.isAuthGet.value) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(235, 7, 9, 145),
              image: DecorationImage(
                image: AssetImage("assets/images/KFA_CRM.png"),
                opacity: 0.5,
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if ((authVerbal.listGetUser.isEmpty)) {
          return const Text("No Data");
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Code(
                          cd: datamodel.protectID.toString(),
                          code: (value) {
                            setState(() {
                              // code = value;
                            });
                          },
                          check_property: 1,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            if (authVerbal.countAccount > 0) {
                              if (listBuilding.isNotEmpty) {
                                setState(() {
                                  checkMap = false;
                                });
                                if (_image != null) {
                                  Uint8List fileBytes =
                                      await _image!.readAsBytes();
                                  base64string = base64.encode(fileBytes);
                                } else {
                                  base64string = "No";
                                }
                                setState(() {
                                  datamodel.verbalAddress =
                                      addressController.text;
                                  datamodel.controlUser =
                                      widget.id_control_user;
                                  datamodel.verbalUser = int.parse(widget.id);
                                });
                                await authVerbal.saveAuto(
                                  datamodel,
                                  context,
                                  pdfController.imagelogo,
                                  base64string,
                                  authVerbal.listGetUser,
                                  listBuilding,
                                  249,
                                );
                              } else {
                                setState(() {
                                  checkMap = true;
                                  Get.snackbar(
                                    "",
                                    "",
                                    titleText: Text(
                                      'GoogleMap',
                                      style: TextStyle(
                                        color: greyColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    messageText: Row(
                                      children: [
                                        Text(
                                          'Requestment ',
                                          style: TextStyle(
                                            color: greyColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          '(Land/Building)',
                                          style: TextStyle(
                                            color: redColors,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    colorText: Colors.black,
                                    padding: const EdgeInsets.only(
                                        right: 50,
                                        left: 50,
                                        top: 20,
                                        bottom: 20),
                                    borderColor:
                                        const Color.fromARGB(255, 48, 47, 47),
                                    borderWidth: 1.0,
                                    borderRadius: 5,
                                    backgroundColor: const Color.fromARGB(
                                        255, 235, 242, 246),
                                    icon: const Icon(Icons.add_alert),
                                  );
                                });
                              }
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'No VPoint',
                                desc: "Please Top up VPoint",
                                btnOkOnPress: () async {
                                  // for (int i = 1; i < listBuilding.length; i++) {
                                  //   await myDB.db.rawInsert(
                                  //       "INSERT INTO verbal_land_models (verbal_landid, verbal_land_dp, verbal_land_type, verbal_land_des, verbal_land_area, verbal_land_minsqm, verbal_land_maxsqm, verbal_land_minvalue, verbal_land_maxvalue, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);",
                                  //       [
                                  //         int.parse(listBuilding[i]['verbal_land_dp']),
                                  //         (listBuilding[i]['verbal_land_type'].toString() ??
                                  //             "0"),
                                  //         (listBuilding[i]['verbal_land_des'].toString() ??
                                  //             "0"),
                                  //         double.parse(
                                  //           listBuilding[i]['verbal_land_area'].toString(),
                                  //         ),
                                  //         double.parse(
                                  //           listBuilding[i]['verbal_land_minsqm'].toString(),
                                  //         ),
                                  //         double.parse(
                                  //           listBuilding[i]['verbal_land_maxsqm'].toString(),
                                  //         ),
                                  //         double.parse(
                                  //           listBuilding[i]['verbal_land_minvalue']
                                  //               .toString(),
                                  //         ),
                                  //         double.parse(
                                  //           listBuilding[i]['verbal_land_maxvalue']
                                  //               .toString(),
                                  //         ),
                                  //         (listBuilding[i]['address'])
                                  //       ]);
                                  // }

                                  // await myDB.db.rawInsert(
                                  //     "INSERT INTO Auto_TB (protectID, title_number, borey, road, verbal_property_id, verbal_bank_id, verbal_bank_branch_id, verbal_bank_contact,verbal_owner,verbal_contact,verbal_bank_officer,verbal_address,verbal_approve_id,latlong_log,latlong_la,verbal_image,verbal_user,verbal_option) VALUES (?, ?, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ?);",
                                  //     [
                                  //       datamodel.protectID,
                                  //       datamodel.titleNumber,
                                  //       datamodel.borey,
                                  //       datamodel.road,
                                  //       datamodel.propertyTypeId,
                                  //       datamodel.verbalBankId,
                                  //       datamodel.verbalBankBranchId,
                                  //       datamodel.verbalBankContact,
                                  //       datamodel.verbalOwner,
                                  //       datamodel.verbalContact,
                                  //       datamodel.verbalBankOfficer,
                                  //       datamodel.verbalAddress,
                                  //       datamodel.approveId,
                                  //       datamodel.latlongLog,
                                  //       datamodel.latlongLa,
                                  //       base64string,
                                  //       datamodel.verbalUser,
                                  //       datamodel.verbalOption,
                                  //     ]);
                                },
                                btnCancelOnPress: () {},
                              ).show();

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => TopUp(
                              //       set_phone: "",
                              //       id_user: widget.id,
                              //       set_id_user: widget.id_control_user,
                              //     ),
                              //   ),
                              // );
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        const Color.fromARGB(255, 4, 41, 189)),
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: const ui.Color.fromARGB(
                                              255, 4, 41, 189)
                                          .withOpacity(0.5),
                                      spreadRadius: 7,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Submit ",
                                  style:
                                      TextStyle(color: greyColor, fontSize: 12),
                                ),
                                Icon(
                                  Icons.save_alt_outlined,
                                  color: greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (datamodel.latlongLa != null)
                    InkWell(
                      onTap: () async {
                        await SlideUp(context);
                      },
                      child: Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width * 1,
                        margin:
                            const EdgeInsets.only(top: 15, right: 13, left: 15),
                        child: FadeInImage.assetNetwork(
                          placeholderCacheHeight: 120,
                          placeholderCacheWidth: 120,
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.contain,
                          placeholder: 'assets/earth.gif',
                          image:
                              'https://maps.googleapis.com/maps/api/staticmap?center=${(datamodel.latlongLa! < datamodel.latlongLog!) ? "${datamodel.latlongLa},${datamodel.latlongLog!}" : "${datamodel.latlongLog},${datamodel.latlongLa!}"}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(datamodel.latlongLa! < datamodel.latlongLog!) ? "${datamodel.latlongLa},${datamodel.latlongLog!}" : "${datamodel.latlongLog},${datamodel.latlongLa!}"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                        ),
                      ),
                    )
                  else
                    InkWell(
                        onTap: () async {
                          await SlideUp(context);
                        },
                        child: Stack(
                          children: [
                            // Container with the GIF
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 180,
                              width: MediaQuery.of(context).size.width * 1,
                              margin: const EdgeInsets.only(
                                  top: 15, right: 30, left: 30),
                              child: Image.asset(
                                'assets/images/realestate.gif',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Google Map *',
                                style: TextStyle(
                                  color: (!checkMap || listBuilding.isNotEmpty)
                                      ? whiteColor
                                      : const ui.Color.fromARGB(
                                          255, 254, 21, 8),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor:
                                      (!checkMap || listBuilding.isNotEmpty)
                                          ? Colors.black.withOpacity(0.5)
                                          : const ui.Color.fromARGB(
                                              255, 205, 202, 202),
                                ),
                              ),
                            ),
                          ],
                        )),
                  const SizedBox(height: 10),
                  CommentAndOption(
                    value: (value) {
                      setState(() {
                        opt = int.parse(value);
                      });
                    },
                    comment1: (opt != null) ? opt.toString() : null,
                    id: (value) {
                      setState(() {
                        // datamodel.verbalOption = int.parse(value.toString());
                      });
                    },
                    comment: (newValue) {
                      setState(() {
                        datamodel.verbalComment = newValue!.toString();
                      });
                    },
                    opt_type_id: (value) {
                      setState(() {
                        datamodel.verbalOption = int.parse(value);
                      });
                    },
                  ),
                  // if (id_khan != 0)
                  //   InkWell(
                  //     onTap: () {
                  //       _asyncInputDialog(context);
                  //       ++i;
                  //     },
                  //     child: Container(
                  //       height: 37,
                  //       margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  //       decoration: BoxDecoration(
                  //         color: Colors.lightBlueAccent[700],
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           // Text("land~Building"),
                  //           SizedBox(
                  //             width: MediaQuery.of(context).size.width * 0.3,
                  //             child: DefaultTextStyle(
                  //               style: const TextStyle(
                  //                 fontSize: 18.0,
                  //                 fontFamily: 'Horizon',
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //               child: AnimatedTextKit(
                  //                 animatedTexts: [
                  //                   RotateAnimatedText('land'),
                  //                   RotateAnimatedText('Building'),
                  //                 ],
                  //                 pause: const Duration(milliseconds: 100),
                  //                 repeatForever: true,
                  //               ),
                  //             ),
                  //           ),
                  //           GFAnimation(
                  //             controller: controller,
                  //             slidePosition: offsetAnimation,
                  //             type: GFAnimationType.slideTransition,
                  //             child: const Icon(
                  //               Icons.add_circle_outline,
                  //               color: Colors.white,
                  //               size: 30,
                  //               shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  const SizedBox(height: 10),
                  if (listBuilding.isNotEmpty)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
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
                              border:
                                  Border.all(width: 1, color: kPrimaryColor),
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
                                                  // check = true;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Depreciation",
                                          style: Label(),
                                        ),
                                        const SizedBox(height: 3),
                                        if (listBuilding[index]
                                                ['verbal_land_des'] !=
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 4),
                                        Text(
                                          ' : ${listBuilding[index]['verbal_land_des'] ?? ""}',
                                          style: Name(),
                                        ),
                                        const SizedBox(height: 2),
                                        if (listBuilding[index]
                                                ['verbal_land_des'] !=
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

                  const SizedBox(height: 10.0),
                  Column(
                    children: [
                      if (_file != null)
                        SizedBox(
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
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              // padding: EdgeInsets.only(left: 30, right: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Icon(Icons.map_sharp,
                                        color: kImageColor),
                                    const SizedBox(width: 10),
                                    Text(
                                      (imagepath == "")
                                          ? 'Choose Photo'
                                          : 'Choosed Photo',
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            // width: double.infinity,
                            child: PropertySearch(
                              // pro: "Land",
                              name: (value) {
                                propertyType = value;
                              },
                              checkOnclick: (value) {
                                setState(() {});
                              },
                              id: (value) {
                                setState(() {
                                  datamodel.verbalPropertyId = int.parse(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  BankDropdownSearch(
                    bankbranchback: (value) {
                      setState(() {
                        // branchName = value;
                        // print('==> $branchName');
                      });
                    },
                    banknameback: (value) {
                      setState(() {
                        // bankName = value;
                      });
                    },
                    bankName: 'Bank',
                    branchName: 'Branch',
                    bank: (value) {
                      setState(() {
                        datamodel.verbalBankId = int.parse(value);
                      });
                    },
                    bankbranch: (value) {
                      setState(() {
                        datamodel.verbalBankBranchId = int.parse(value);
                      });
                    },
                  ),
                  // BankDropdown(
                  //   bank: (value) {
                  //     datamodel.verbalBankId = value;
                  //   },
                  //   bankbranch: (value) {
                  //     datamodel.verbalBankBranchId = value;
                  //   },
                  // ),

                  FormTwinN(
                    Label1: 'Owner',
                    Label2: 'Contact',
                    onSaved1: (input) {
                      datamodel.verbalOwner = input!;
                    },
                    onSaved2: (input) {
                      datamodel.verbalContact = input!;
                    },
                    icon1: const Icon(Icons.person, color: kImageColor),
                    icon2: const Icon(Icons.phone, color: kImageColor),
                  ),
                  const SizedBox(height: 10),
                  // DateComponents(
                  //   date: (value) {
                  //     datamodel.date = value;
                  //   },
                  // ),

                  FormTwinN(
                    Label1: 'Bank Officer',
                    Label2: 'Contact',
                    onSaved1: (input) {
                      datamodel.verbalBankOfficer = input!;
                    },
                    onSaved2: (input) {
                      setState(() {
                        datamodel.verbalBankContact = input!;
                      });
                    },
                    icon1: const Icon(Icons.work, color: kImageColor),
                    icon2: const Icon(Icons.phone, color: kImageColor),
                  ),

                  const SizedBox(height: 10),
                  // ForceSaleAndValuation(
                  //   value: (value) {
                  //     datamodel.verbal_con = value;
                  //   },
                  //   // fsl: list[0]['verbal_con'],
                  // ),

                  // ApprovebyAndVerifyby(
                  //   approve: (value) {
                  //     setState(() {
                  //       datamodel.approve_id = value.toString();
                  //     });
                  //   },
                  //   verify: (value) {
                  //     setState(() {
                  //       datamodel.agent = value.toString();
                  //     });
                  //   },
                  //   // appro: list[0]['approve_name'],
                  //   // vfy: list[0]['VerifyAgent'],
                  // ),
                  SizedBox(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          fillColor: kwhite,
                          filled: true,
                          labelText: 'Phum optional',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 0),
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                          prefixIcon: const Icon(
                            Icons.location_on_rounded,
                            color: kImageColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // FormS(
                  //   label: 'Phum optional',
                  //   onSaved: (input) {
                  //     datamodel.address = input!.toString();
                  //   },
                  //   iconname:
                  //       const Icon(Icons.location_on_rounded, color: kImageColor),
                  // ),
                  const SizedBox(height: 30.0),
                ],
              ),
            )),
          );
        }
      }),
      // floatingActionButton:
    );
  }

  List listBuilding = [];

  String? options;

  //MAP
  Future<void> SlideUp(BuildContext context) async {
//=============================================================
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => map_cross_verbal(
          listBuildings: listBuilding,
          listBuilding: (value) {
            setState(() {
              listBuilding = value;
            });
          },
          verbID: datamodel.protectID.toString(),
          asking_price: (value) {},
          updateNew: 0,
          get_commune: (value) {
            setState(() {});
          },
          get_district: (value) {
            setState(() {});
          },
          get_lat: (value) {
            setState(() {
              // lat1 = double.parse(value.toString());
              datamodel.latlongLa = double.parse(value.toString());
            });
          },
          get_log: (value) {
            setState(() {
              // log2 = double.parse(value.toString());
              datamodel.latlongLog = double.parse(value.toString());
            });
          },
          get_province: (value) {
            setState(() {
              addressController.text = value;
            });
          },
          iduser: widget.id_control_user,
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

  Random random = Random();

  File? _image;
  final picker = ImagePicker();
  String base64string = 'No';
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

  //get khan

  var id_Sangkat;

  int i = 0;

  TextStyle Label() {
    return const TextStyle(color: kPrimaryColor, fontSize: 11);
  }

  TextStyle Name() {
    return const TextStyle(
        color: kImageColor, fontSize: 12, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return const TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }

  double? lat;
  double? log;
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
