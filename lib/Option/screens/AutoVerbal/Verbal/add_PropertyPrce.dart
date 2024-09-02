// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../Memory_local/database.dart';
import '../../../../api/api_service.dart';
import '../../../../contants.dart';
import '../../../../models/autoVerbal.dart';
import '../../../../models/model_bl_new.dart';
import '../../../../screen/Customs/form.dart';
import '../../../../screen/components/payment/Main_Form/in_app_purchase_top_up.dart';
import '../../../../screen/components/payment/Main_Form/top_up.dart';
import '../../../components/LandBuilding.dart';
import '../../../components/bank.dart';
import '../../../components/code.dart';
import '../../../components/comment.dart';
import '../../../components/property.dart';
import '../../../components/slideUp.dart';
import '../../../customs/formTwinN.dart';
import '../printer/save_image_for_Autoverbal.dart';
import 'Add.dart';
import 'listview.dart';

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
  MyDb mydb_lb = MyDb();
  MyDb mydb_vb = MyDb();
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
      "created_verbals": "1"
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
        autoHide: const Duration(seconds: 10),
        body: const Center(
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
    controller = AnimationController(
        duration: const Duration(milliseconds: 645), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
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
              backgroundColor: const Color.fromARGB(235, 7, 9, 145),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () async {
                    print("verbalID => $verbal_id");
                    // MyDb mydb = new MyDb();
                    List<Map<String, dynamic>> jsonList =
                        lb.map((item) => item.toJson()).toList();
                    setState(() {
                      requestModelAuto.user = widget.id_control_user;
                      requestModelAuto.verbal_id = verbal_id;
                      requestModelAuto.verbal_khan = '$commune.$district';
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
                              autoHide: const Duration(seconds: 3),
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
                    margin: const EdgeInsets.only(
                        left: 5, top: 15, bottom: 15, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[700],
                      boxShadow: const [
                        BoxShadow(color: Colors.green, blurRadius: 5)
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(80),
                        bottomLeft: Radius.circular(80),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Text("Submit", style: TextStyle(fontSize: 10)),
                        const Icon(Icons.save_alt_outlined, size: 15),
                        const SizedBox(width: 20),
                        Container(
                          width: 10,
                          height: 25,
                          decoration: const BoxDecoration(
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
              title: const Text(
                'property check',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                ),
              ),
              toolbarHeight: 80,
            ),
            backgroundColor: const Color.fromARGB(235, 7, 9, 145),
            body: RefreshIndicator(
              onRefresh: () => get_count(),
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
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
                          number.toString(),
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
                      padding: const EdgeInsets.all(5),
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
              decoration: const BoxDecoration(
                color: Color.fromARGB(235, 7, 9, 145),
                image: DecorationImage(
                  image: AssetImage("assets/images/KFA_CRM.png"),
                  opacity: 0.5,
                ),
              ),
              child: const Center(
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
        const SizedBox(height: 10),
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
              margin: const EdgeInsets.only(top: 15, right: 13, left: 15),
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
              margin: const EdgeInsets.only(top: 15, right: 13, left: 15),
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
          const SizedBox(),
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
              margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
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
                    child: const Icon(
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

        SizedBox(
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
                      width: 250,
                      //height: 210,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: kPrimaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 10),
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
                                        icon: const Icon(
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
                          const SizedBox(height: 3.0),
                          const Divider(
                              height: 1, thickness: 1, color: kPrimaryColor),
                          const SizedBox(height: 5),
                          Text(
                            '${lb[i].address} ',
                            style: const TextStyle(
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
                                  const SizedBox(height: 3),
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
                                    'Min Value/Sqm',
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Max Value/Sqm',
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Min Value',
                                    style: Label(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Man Value',
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
                                    ':   ' + lb[i].verbal_land_dp,
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ':   ' + lb[i].verbal_land_des,
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        (formatter.format(
                                          lb[i].verbal_land_area.toInt(),
                                        )).toString() +
                                        'm' +
                                        '\u00B2',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        formatter
                                            .format(lb[i].verbal_land_minsqm) +
                                        '\$',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        formatter
                                            .format(lb[i].verbal_land_maxsqm) +
                                        '\$',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ':   ' +
                                        (formatter.format(
                                          lb[i].verbal_land_minvalue,
                                        )).toString() +
                                        '\$',
                                    style: Name(),
                                  ),
                                  const SizedBox(height: 2),
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
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    // padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.map_sharp,
                            color: kImageColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            (imagepath == "")
                                ? 'Choose Photo'
                                : 'choosed Photo',
                            style: const TextStyle(
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
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        FormTwinN(
          Label1: 'Owner',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.owner = input!;
          },
          onSaved2: (input) {
            requestModelAuto.contact = input!;
          },
          icon1: const Icon(
            Icons.person,
            color: kImageColor,
          ),
          icon2: const Icon(Icons.phone, color: kImageColor),
        ),
        const SizedBox(height: 10),
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
          icon1: const Icon(Icons.work, color: kImageColor),
          icon2: const Icon(Icons.phone, color: kImageColor),
        ),
        const SizedBox(height: 10),
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
          iconname: const Icon(Icons.location_on_rounded, color: kImageColor),
        ),
        const SizedBox(height: 40.0),
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

  Random random = Random();
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
              const EdgeInsets.only(top: 30, left: 10, right: 15, bottom: 40),
          content: SingleChildScrollView(
            child: SizedBox(
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
    return const TextStyle(color: kPrimaryColor, fontSize: 12);
  }

  TextStyle Name() {
    return const TextStyle(
      color: kImageColor,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle NameProperty() {
    return const TextStyle(
      color: kImageColor,
      fontSize: 11,
      fontWeight: FontWeight.bold,
    );
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
