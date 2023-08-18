// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/models/model_bl_new.dart';
import 'package:itckfa/screen/components/map_all/map_in_edit_verbal.dart';

import '../../../../api/api_service.dart';
import '../../../../models/autoVerbal.dart';
import '../../../../screen/Customs/formTwinN.dart';
import '../../../../screen/Customs/responsive.dart';
import '../../../../screen/Profile/components/Drop.dart';
import '../../../../screen/components/ApprovebyAndVerifyby.dart';
import '../../../../screen/components/LandBuilding.dart';
import '../../../../screen/components/code.dart';
import '../../../../screen/components/comment.dart';
import '../../../../screen/components/forceSale.dart';
import '../../../../screen/components/property.dart';
import '../../../../screen/components/test google map/Slliderup_Google_Map.dart';
import '../../../customs/uplandBuilding.dart';

class Edit extends StatefulWidget {
  const Edit(
      {super.key,
      required this.image,
      required this.user,
      required this.property_type_id,
      required this.verbal_id,
      required this.bank_id,
      required this.bank_branch_id,
      required this.bank_contact,
      required this.owner,
      required this.contact,
      required this.bank_officer,
      required this.address,
      required this.approve_id,
      required this.agent,
      required this.comment,
      required this.lat,
      required this.lng,
      required this.verbal_con,
      required this.verbal_com,
      required this.option,
      required this.verbal,
      required this.n_pro,
      required this.n_bank,
      required this.n_appro,
      required this.n_agent,
      this.image_map,
      this.image_photo,
      this.cell_land,
      this.land_list});
  final int verbal_id;
  final String property_type_id;
  final String bank_id;
  final String bank_branch_id;
  final String bank_contact;
  final String owner;
  final String contact;
  final String bank_officer;
  final String address;
  final String approve_id;
  final String agent;
  final String comment;
  final String lat;
  final String lng;
  final String image;
  final String verbal_con;
  final String verbal_com;
  final String user;
  final String option;
  final List verbal;
  final List? land_list;
  final List<L_B>? cell_land;
  final String? image_map;
  final String? image_photo;
  final String n_pro;
  final String n_bank;
  final String n_appro;
  final String n_agent;
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> with SingleTickerProviderStateMixin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int opt = 0;
  double asking_price = 1;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel_update requestModelAuto;
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
  List data_of_land = [];

  bool isApiCallProcess = false;
  var opt_type_id = '0';
  List list = [];
  List<L_B> lb = [L_B('', '', '', '', 0, 0, 0, 0, 0, 0)];
  late List<dynamic> list_Khan;
  var id_khan;
  var district;
  var commune;
  //get khan
  void Load_khan(String district) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}'));
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
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_sangkat = jsonData;
        id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID'].toString());
      });
    }
  }

  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];

      List ls = jsonResponse['results'];
      List ac;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_3") {
            setState(() {
              commune = jsonResponse['results'][j]['address_components'][i]
                  ['short_name'];
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              district = jsonResponse['results'][j]['address_components'][i]
                  ['short_name'];
            });
          }
        }
      }
      Load_sangkat(commune);
      Load_khan(district);
    } else {
      // Error or invalid response
      print(response.statusCode);
    }
  }

  void deleteItemToList(int Id) {
    setState(() {
      list.removeAt(Id);
      lb.removeAt(Id);
    });
  }

  var image_photo;
  var image_map;
  bool ch = false, map = false, img = false;
  var a;
  var dropdown;
  String? options;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;
  @override
  void initState() {
    Find_by_piont(double.parse(widget.lng), double.parse(widget.lat));
    controller = AnimationController(
        duration: const Duration(milliseconds: 645), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
    image_photo = widget.image_photo;
    image_map = widget.image_map;
    lb = widget.cell_land!;
    list = widget.land_list!;
    Load2(widget.option);
    requestModelAuto = AutoVerbalRequestModel_update(
      property_type_id: int.parse(widget.property_type_id.toString()),
      lat: double.parse(widget.lng),
      lng: double.parse(widget.lat),
      address: widget.address,
      approve_id: int.parse(widget.approve_id),
      agent: int.parse(widget.agent),
      bank_branch_id: int.parse(widget.bank_branch_id),
      bank_contact: widget.bank_contact,
      bank_id: int.parse(widget.bank_id),
      bank_officer: widget.bank_officer,
      comment: widget.comment,
      contact: widget.contact,
      image: widget.image,
      option: int.parse(widget.option),
      owner: widget.owner,
      user: int.parse(widget.user),
      verbal_com: widget.verbal_com,
      verbal_con: widget.verbal_con,
      verbal: widget.verbal,
      verbal_id: widget.verbal_id,
      verbal_khan: '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                if (_file != null) {
                  uploadt_image(_file!);
                }
                APIservice apIservice = APIservice();
                apIservice
                    .saveAutoVerbal_Update(requestModelAuto, widget.verbal_id)
                    .then(
                  (value) async {
                    print(json.encode(requestModelAuto.toJson()));
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
                        AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.success,
                            showCloseIcon: false,
                            title: value.message,
                            autoHide: Duration(seconds: 3),
                            onDismissCallback: (type) {
                              Get.back();
                              Get.back();
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
                        print(value.message);
                      }
                    }
                  },
                );
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 4),
              decoration: BoxDecoration(
                color: Colors.lightGreen[700],
                boxShadow: [BoxShadow(color: Colors.green, blurRadius: 5)],
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
                    height: 20,
                    alignment: Alignment.topRight,
                    color: Colors.red[700],
                  )
                ],
              ),
            ),
          ),
        ],
        title: Text.rich(
          TextSpan(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextSpan(
                text: "ADD ONE CLICK ",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kwhite,
                ),
              ),
              TextSpan(
                text: "1\$",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: kerror,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Responsive(
              mobile: addVerbal(context),
              tablet: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: addVerbal(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: addVerbal(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              phone: addVerbal(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget addVerbal(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              Code(
                cd: widget.verbal_id.toString(),
                code: (value) {
                  setState(() {
                    // code = value;
                  });
                },
                check_property: 1,
              ),
              PropertyDropdown(
                pro: widget.n_pro,
                name: (value) {
                  propertyType = value;
                },
                id: (value) {
                  setState(() {
                    requestModelAuto.property_type_id = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              BankDropdown(
                brn: widget.bank_branch_id,
                bn: widget.n_bank,
                bank: (value) {
                  setState(() {
                    requestModelAuto.bank_id = int.parse(value);
                  });
                },
                bankbranch: (value) {
                  setState(() {
                    requestModelAuto.bank_branch_id = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              FormTwinN(
                Label1: 'Owner',
                Label2: 'Contact',
                Label1_e: widget.owner,
                Label2_e: widget.contact,
                onSaved1: (input) {
                  setState(() {
                    requestModelAuto.owner = input.toString();
                  });
                },
                onSaved2: (input) {
                  setState(() {
                    requestModelAuto.contact = input.toString();
                  });
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
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              FormTwinN(
                Label1: 'Bank Officer',
                Label2: 'Contact',
                Label1_e: widget.bank_officer,
                Label2_e: widget.bank_contact,
                onSaved1: (input) {
                  setState(() {
                    requestModelAuto.bank_officer = input.toString();
                  });
                },
                onSaved2: (input) {
                  setState(() {
                    requestModelAuto.bank_contact = input.toString();
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
                height: 10,
              ),
              ForceSaleAndValuation(
                fsl: widget.verbal_con,
                value: (value) {
                  requestModelAuto.verbal_con = value.toString();
                },
              ),
              SizedBox(
                height: 10,
              ),
              CommentAndOption(
                option: option,
                value: (value) {
                  opt = int.parse(value);
                },
                id: (value) {
                  setState(() {
                    requestModelAuto.option = int.parse(value);
                  });
                },
                comment: (String? newValue) {
                  setState(() {
                    requestModelAuto.comment = newValue!.toString();
                  });
                },
                opt_type_id: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              ApprovebyAndVerifyby(
                appro: widget.n_appro,
                vfy: widget.n_agent,
                approve: (value) {
                  requestModelAuto.approve_id = int.parse(value);
                },
                verify: (value) {
                  requestModelAuto.agent = int.parse(value);
                },
              ),
              (map == false)
                  ? Container(
                      margin: EdgeInsets.all(10),
                      width: 300,
                      height: 300,
                      child: Image.network(
                        image_map!,
                        fit: BoxFit.fill,
                      ))
                  : SizedBox(),
              TextButton(
                onPressed: () {
                  setState(() {
                    map = true;
                    SlideUp(context);
                  });
                },
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22, right: 22),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.map_sharp,
                                color: kImageColor,
                              ),
                              SizedBox(width: 10),
                              Text((map == true)
                                  ? 'Location Changed'
                                  : 'Change Location'),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              if (_file == null)
                Container(
                  height: 200,
                  width: 400,
                  child: Image.network(image_photo),
                ),
              Column(
                children: [
                  if (_file != null)
                    Container(
                      height: 200,
                      width: 400,
                      // child: Image.file(File(_file!.path)),
                      child: Image.memory(imagebytes!),
                    ),
                  if (_file == null)
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
                            height: 60,
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
                                    Text((imagepath == "")
                                        ? 'Choose Photo'
                                        : 'choosed Photo'),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // SingleChildScrollView(
              //   child: Column(children: [
              //     imagepath != ""
              //         ? Container(
              //             margin: EdgeInsets.all(10),
              //             width: 300,
              //             height: 300,
              //             child: Image.file(
              //               File(imagepath),
              //               fit: BoxFit.fitWidth,
              //             ))
              //         : SizedBox(),
              //     imagepath == ""
              //         ? TextButton(
              //             onPressed: () {
              //               setState(() {
              //                 openImage();
              //                 img = true;
              //               });
              //             },
              //             child: FractionallySizedBox(
              //               widthFactor: 1,
              //               child: Padding(
              //                 padding:
              //                     const EdgeInsets.only(left: 22, right: 22),
              //                 child: Container(
              //                   height: 60,
              //                   decoration: BoxDecoration(
              //                     border: Border.all(
              //                       width: 1,
              //                       color: kPrimaryColor,
              //                     ),
              //                     borderRadius: BorderRadius.all(
              //                       Radius.circular(10),
              //                     ),
              //                   ),
              //                   // padding: EdgeInsets.only(left: 30, right: 30),
              //                   child: Align(
              //                       alignment: Alignment.centerLeft,
              //                       child: Row(
              //                         // ignore: prefer_const_literals_to_create_immutables
              //                         children: [
              //                           SizedBox(width: 10),
              //                           Icon(
              //                             Icons.photo_album_outlined,
              //                             color: kImageColor,
              //                           ),
              //                           SizedBox(width: 10),
              //                           // ignore: unnecessary_null_comparison
              //                           Text('Change Image'),
              //                         ],
              //                       )),
              //                 ),
              //               ),
              //             ),
              //           )
              //         : SizedBox(),
              //   ]),
              // ),
              SizedBox(
                height: 390,
                child: up_LandBuilding(
                  land_list: widget.land_list,
                  ID_khan: id_khan.toString(),
                  opt: opt,
                  address: '${commune} / ${district}',
                  list: (value) {
                    setState(() {
                      requestModelAuto.verbal = value;
                    });
                  },
                  landId: widget.verbal_id.toString(),
                  Avt: (value) {
                    a = value;
                    setState(() {});
                  },
                  opt_type_id: opt_type_id,
                  check_property: 1,
                  list_lb: (value) {
                    setState(() {
                      lb.addAll(value!);
                    });
                  },
                  ID_sangkat: id_Sangkat.toString(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double? lat1;
  double? log1;
  double? lat;
  double? log;

  Future<void> SlideUp(BuildContext context) async {
    //=============================================================
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Map_verbal_edit(
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
                requestModelAuto.lat = value;
              },
              get_log: (value) {
                requestModelAuto.lng = value;
              },
              get_province: (value) {},
            )));
    // final result = await Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => HomePage(
    //           c_id: code.toString(),
    //           district: (value) {
    //             setState(() {
    //               district = value;
    //               Load_khan(district);
    //             });
    //           },
    //           commune: (value) {
    //             setState(() {
    //               commune = value;
    //               Load_sangkat(value);
    //             });
    //           },
    //           lat: (value) {
    //             setState(() {
    //               lat1 = double.parse(value);

    //               requestModelAuto.lat = value;
    //             });
    //           },
    //           log: (value) {
    //             setState(() {
    //               log2 = double.parse(value);
    //               requestModelAuto.lng = value;
    //             });
    //           },
    //           province: (value) {},
    //         )));
//=============================================================
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Google_map_verbal(
    //       lat: (value) {
    //        lat1 = value ;
    //       },
    //       log: (value) {
    //         log2 = value;
    //       },
    //       latitude: lat!,
    //       longitude: log!,
    //     ),

    // builder: (context) => HomePage(
    //   c_id: code.toString(),
    //   district: (value) {
    //     setState(() {
    //       district = value;
    //       Load_khan(district);
    //     });
    //   },
    //   commune: (value) {
    //     setState(() {
    //       commune = value;
    //       Load_sangkat(value);
    //     });
    //   },
    //   lat: (value) {
    //     setState(() {
    //       print("Value of lat = ${value}");
    //       requestModelAuto.lat = value;
    //     });
    //   },
    //   log: (value) {
    //     setState(() {
    //       requestModelAuto.lng = value;
    //     });
    //   },
    //   province: (value) {},
    // ),
    //   ),
    // );
    setState(() {
      requestModelAuto.image = code.toString();
    });
    if (!mounted) return;
    // asking_price = result[0]['adding_price'];
    // address = result[0]['address'];
    // requestModelAuto.lat = result[0]['lat'];
    // requestModelAuto.lng = result[0]['lng'];
  }

  late File _image;
  final picker = ImagePicker();
  late String base64string;
  // File? _file;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  // openImage() async {
  //   try {
  //     var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       imagepath = pickedFile.path;
  //       print(imagepath);
  //       File imagefile = File(imagepath);
  //       Uint8List imagebytes = await imagefile.readAsBytes();
  //       String base64string = base64.encode(imagebytes);
  //       Uint8List decodedbytes = base64.decode(base64string);
  //       setState(() {
  //         _file = imagefile;
  //       });
  //     } else {
  //       print("No image is selected.");
  //     }
  //   } catch (e) {
  //     print("error while picking file.");
  //   }
  // }
  XFile? _file;
  Uint8List? imagebytes;
  dynamic openImage() async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        CroppedFile? cropFile = await ImageCropper()
            .cropImage(sourcePath: pickedFile.path, aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.square,
        ], uiSettings: [
          AndroidUiSettings(
              lockAspectRatio: false,
              backgroundColor: Colors.blue,
              initAspectRatio: CropAspectRatioPreset.original)
        ]);
        _file = XFile(cropFile!.path);
        // imagebytes = _file.path;
        // imagepath = pickedFile.path;
        File? imagefile = File(cropFile.path); //convert Path to File
        imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string =
            base64.encode(imagebytes!); //convert bytes to base64 string
        Uint8List decodedbytes = base64.decode(base64string);
        //decode base64 stirng to bytes
        setState(() {
          _file = imagefile as XFile;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  Future<dynamic> uploadt_image(XFile _image) async {
    var request = await http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image"));
    Map<String, String> headers = {
      "content-type": "application/json",
      "Connection": "keep-alive",
      "Accept-Encoding": " gzip"
    };
    request.headers.addAll(headers);
    // request.files.add(picture);
    request.fields['cid'] = widget.verbal_id.toString();
    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        _image.path,
      ),
    );
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
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
              EdgeInsets.only(top: 30, left: 10, right: 1, bottom: 20),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: LandBuilding(
                ID_khan: id_khan.toString(),
                // asking_price: asking_price,
                opt: opt,
                address: '${commune} / ${district}',
                list: (value) {
                  setState(() {
                    // print(value);
                    list = value;
                    // requestModelAuto.verbal = value;
                  });
                },
                landId: code.toString(),
                Avt: (value) {
                  a = value;
                },
                opt_type_id: opt_type_id,
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

  String? option;
  late List<dynamic> _list2;
  void Load2(id) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options?opt_id=${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list2 = jsonData;
        option = _list2[0]['opt_des'];
        // print(_list);
      });
    }
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 14, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }
}
