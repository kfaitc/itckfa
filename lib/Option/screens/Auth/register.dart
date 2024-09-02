// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/Option/components/contants.dart';
import 'package:itckfa/Option/customs/formVLD.dart';
import 'package:itckfa/api/api_service.dart';
import 'package:itckfa/models/register_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';

import '../../../screen/Customs/responsive.dart';
import '../../customs/formTwin.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Register();
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  // List of items in our dropdown menu
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
  MyDb mydb = MyDb();
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  File? imagefile;
  Future<void> openImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? media = await picker.pickMedia();
    //you can use ImageCourse.camera for Camera capture
    if (media != null) {
      imagepath = media.path;
      imagefile = File(imagepath); //convert Path to File
      get_bytes = await imagefile!.readAsBytes(); //convert to bytes
    } else {
      // print("No image is selected.");
    }
  }

  Future cut_again() async {
    imagepath = imagefile!.path;
    CroppedFile? cropFile = await ImageCropper().cropImage(
      sourcePath: imagefile!.path,
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
      uiSettings: [
        AndroidUiSettings(
          lockAspectRatio: false,
          backgroundColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
      ],
    );

    get_bytes = await imagefile!.readAsBytes(); //convert to bytes
    setState(() {
      get_bytes;
      imagepath = imagefile!.path;
      imagefile = File(imagepath); //convert Path to File
    });
  }

  // FirebaseAuth auth = FirebaseAuth.instance;
  // PhoneAuthCredential? credential;
  String? smsCode;
  String? set_id_user;
  int? user_last_id;
  Random random = Random();

  Uint8List? get_bytes;
  Uint8List? _byesData;
  void get_user_last_id() async {
    setState(() {});
    // await Firebase.initializeApp();
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_last_user',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        user_last_id = jsonData;
        set_id_user =
            '${user_last_id.toString()}K${random.nextInt(999).toString()}F${user_last_id.toString()}A';
      });
    }
  }

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

  Future<void> uploadImage() async {
    if (get_bytes != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_profile_user',
        ),
      );
      request.fields['id_user'] = set_id_user ?? '';
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          get_bytes!,
          filename: 'User ID :$set_id_user photo ${random.nextInt(999)}.jpg',
        ),
      );
      var res = await request.send();
    }
  }

  var otp, field_otp;
  Future<void> getOTP() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/getotp/user?tel_num=${requestModel.tel_num}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        otp = jsonResponse['otp'].toString();
        print("\nkokokok $otp\n");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  bool _isObscure = true;
  RegisterRequestModel requestModel = RegisterRequestModel(
    email: "",
    password: "",
    first_name: '',
    gender: '',
    known_from: '',
    last_name: '',
    tel_num: '',
    password_confirmation: '',
    control_user: '',
    OTP_Code: '',
  );
  bool isApiCallProcess = false;
  @override
  void initState() {
    get_user_last_id();
    // mydb.open();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSteup(context),
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSteup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/KFA_CRM.png',
          height: 160,
          width: 160,
        ),
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      backgroundColor: kwhite_new,
      body: Container(
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Responsive(
            mobile: register(context),
            tablet: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: register(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            desktop: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: register(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            phone: register(context),
          ),
        ),
      ),
    );
  }

  Padding register(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Register to KFA system',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kwhite_new,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              // Text.rich(
              //   TextSpan(
              //     // ignore: prefer_const_literals_to_create_immutables
              //     children: [
              //       TextSpan(
              //         text: "ONE CLICK ",
              //         style: TextStyle(
              //           fontSize: 20.0,
              //           fontWeight: FontWeight.bold,
              //           color: kImageColor,
              //         ),
              //       ),
              //       TextSpan(
              //         text: "1\$",
              //         style: TextStyle(
              //           fontSize: 30.0,
              //           fontWeight: FontWeight.bold,
              //           color: kerror,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              InkWell(
                onTap: () async {
                  if (get_bytes == null) {
                    await _getStoragePermission();
                    await openImage(ImageSource.gallery);
                  } else {
                    await cut_again();
                    setState(() {
                      imagefile;
                      get_bytes;
                    });
                  }
                  setState(() {
                    get_bytes;
                    imagefile;
                  });
                },
                child: Center(
                  child: (get_bytes == null)
                      ? Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            GFAvatar(
                              size: 100,
                              backgroundImage:
                                  AssetImage('assets/images/user-avatar.png'),
                            ),
                            Container(
                              height: 20,
                              width: 30,
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(96, 102, 102, 102),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            GFAvatar(
                              size: 100,
                              backgroundImage: MemoryImage(get_bytes!),
                            ),
                            Container(
                              height: 20,
                              width: 30,
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(96, 102, 102, 102),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.crop,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              if (user_last_id != null)
                SizedBox(
                  height: 58,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'This\'s your personal id:',
                        //initialValue: '${set_id_user}',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: kwhite_new,
                        ),
                        // decoration: InputDecoration(
                        //   fillColor: kwhite,
                        //   filled: true,
                        //   // prefixIcon: Icon(
                        //   //   Icons.info_outline_rounded,
                        //   //   color: kImageColor,
                        //   // ),
                        //   // focusedBorder: OutlineInputBorder(
                        //   //   borderSide: const BorderSide(
                        //   //       color: kPrimaryColor, width: 2.0),
                        //   //   borderRadius: BorderRadius.circular(10.0),
                        //   // ),
                        //   // enabledBorder: OutlineInputBorder(
                        //   //   borderSide: BorderSide(
                        //   //     width: 1,
                        //   //     color: kPrimaryColor,
                        //   //   ),
                        //   //   borderRadius: BorderRadius.circular(10.0),
                        //   // ),
                        // ),
                      ),
                      Text(
                        '$set_id_user',
                        //initialValue: '${set_id_user}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: kwhite_new,
                        ),
                        // decoration: InputDecoration(
                        //   fillColor: kwhite,
                        //   filled: true,
                        //   // prefixIcon: Icon(
                        //   //   Icons.info_outline_rounded,
                        //   //   color: kImageColor,
                        //   // ),
                        //   // focusedBorder: OutlineInputBorder(
                        //   //   borderSide: const BorderSide(
                        //   //       color: kPrimaryColor, width: 2.0),
                        //   //   borderRadius: BorderRadius.circular(10.0),
                        //   // ),
                        //   // enabledBorder: OutlineInputBorder(
                        //   //   borderSide: BorderSide(
                        //   //     width: 1,
                        //   //     color: kPrimaryColor,
                        //   //   ),
                        //   //   borderRadius: BorderRadius.circular(10.0),
                        //   // ),
                        // ),
                      ),
                    ],
                  ),
                ),
              // SizedBox(
              //   height: 10.0,
              // ),
              FormTwin(
                Label1: 'First Name',
                Label2: 'Last Name',
                onSaved1: (input) {
                  setState(() {
                    requestModel.first_name = input!;
                  });
                },
                onSaved2: (input) {
                  setState(() {
                    requestModel.last_name = input!;
                  });
                },
                icon1: Icon(
                  Icons.person,
                  color: kImageColor,
                ),
                icon2: Icon(
                  Icons.person,
                  color: kImageColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // FormValidate(
              //   //  onSaved: (input) => requestModel.username = input!,
              //     label: 'Username',
              //     iconname: Icon(
              //       Icons.person,
              //       color: kImageColor,
              //     )),
              SizedBox(
                height: 10,
              ),
              //ignore: sized_box_for_whitespace
              Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: DropdownButtonFormField<String>(
                    onChanged: (String? newValue) {
                      setState(() {
                        genderValue = newValue!;
                        requestModel.gender = genderValue.toString();
                        // print(newValue);
                      });
                    },
                    items: gender
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    // add extra sugar..
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: kImageColor,
                    ),
                    decoration: InputDecoration(
                      fillColor: kwhite,
                      filled: true,
                      labelText: 'Gender',
                      hintText: 'Select one',
                      prefixIcon: Icon(
                        Icons.accessibility_new_sharp,
                        color: kImageColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FormValidate(
                onSaved: (input) {
                  setState(() {
                    requestModel.email = input!;
                  });
                },
                label: 'Email',
                type: TextInputType.emailAddress,
                iconname: Icon(
                  Icons.email,
                  color: kImageColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FormValidate(
                onSaved: (input) {
                  setState(() {
                    requestModel.tel_num = input!;
                  });
                },
                label: 'Phone Number',
                type: TextInputType.phone,
                iconname: Icon(
                  Icons.phone,
                  color: kImageColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  obscureText: _isObscure,
                  onChanged: (input) {
                    setState(() {
                      requestModel.password = input;
                    });
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Enter password',
                    prefixIcon: Icon(
                      Icons.key,
                      color: kImageColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: kImageColor,
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'require *';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (input) {
                    setState(() {
                      requestModel.password_confirmation = input;
                    });
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Confirm password',
                    prefixIcon: Icon(
                      Icons.key,
                      color: kImageColor,
                    ),
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     color: kImageColor,
                    //     _isObscure ? Icons.visibility : Icons.visibility_off,
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //       _isObscure = !_isObscure;
                    //     });
                    //   },
                    // ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'require *';
                    }
                    return null;
                  },
                ),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 70,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: DropdownButtonFormField<String>(
                    //value: fromValue,
                    onSaved: (input) => requestModel.known_from = input!,
                    onChanged: (String? newValue) {
                      setState(() {
                        fromValue = newValue!;
                        requestModel.known_from = newValue;
                      });
                    },
                    items: from
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    // add extra sugar..
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: kImageColor,
                    ),

                    decoration: InputDecoration(
                      fillColor: kwhite,
                      filled: true,
                      labelText: 'From',
                      hintText: 'Select one',
                      prefixIcon: Icon(
                        Icons.business_outlined,
                        color: kImageColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //   decoration: InputDecoration(
                      //       labelText: 'From',
                      //       prefixIcon: Icon(Icons.business_outlined)),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 150,
                child: AnimatedButton(
                  text: 'Register',
                  color: kwhite_new,
                  pressEvent: () async {
                    if (validateAndSave()) {
                      if (otp == null || otp != field_otp) {
                        await getOTP();
                        // ignore: use_build_context_synchronously
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.info,
                          keyboardAware: true,
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Enter OTP Code',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Material(
                                //   elevation: 0,
                                //   color: Colors.blueGrey.withAlpha(40),
                                //   child: TextFormField(
                                //     autofocus: true,
                                //     minLines: 1,
                                //     onChanged: (value) {
                                //       setState(() {
                                //         field_otp = value;
                                //         requestModel.OTP_Code = value;
                                //         if (otp == field_otp) {
                                //           Navigator.pop(context);
                                //           ScaffoldMessenger.of(context)
                                //               .showSnackBar(
                                //             SnackBar(
                                //                 content: Text(
                                //               "Correct OTP",
                                //             )),
                                //           );
                                //         }
                                //       });
                                //     },
                                //     decoration: const InputDecoration(
                                //       border: InputBorder.none,
                                //     ),
                                //   ),
                                // ),
                                Pinput(
                                  length: 6,
                                  showCursor: true,
                                  senderPhoneNumber: requestModel.tel_num,
                                  onChanged: (value) {
                                    setState(() {
                                      field_otp = value;
                                      requestModel.OTP_Code = value;
                                      if (otp == field_otp) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                            "Correct OTP",
                                          )),
                                        );
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                AnimatedButton(
                                  isFixedHeight: false,
                                  text: 'Close',
                                  pressEvent: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ).show();
                      } else if (otp == field_otp) {
                        setState(() {
                          isApiCallProcess = true;
                          requestModel.control_user = set_id_user.toString();
                        });
                        if (get_bytes != null || _byesData != null) {
                          await uploadImage();
                        }
                        APIservice apIservice = APIservice();
                        apIservice.register(requestModel).then((value) async {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if (value.message == "User successfully registered") {
                            await mydb.open_user();
                            await mydb.db.rawInsert(
                                "INSERT INTO user (id, first_name, last_name, username, gender, tel_num, known_from, email, password) VALUES (?, ?, ?, ?, ?, ?, ?, ? , ?);",
                                [
                                  value.user['id'],
                                  requestModel.first_name,
                                  requestModel.last_name,
                                  requestModel.control_user,
                                  requestModel.gender ?? "",
                                  requestModel.tel_num,
                                  requestModel.known_from,
                                  requestModel.email,
                                  requestModel.password,
                                ]);
                            // ignore: use_build_context_synchronously
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              headerAnimationLoop: false,
                              dialogType: DialogType.success,
                              showCloseIcon: false,
                              title: value.message,
                              autoHide: Duration(seconds: 3),
                              onDismissCallback: (type) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("New User Added")),
                                );
                                Get.to(() => Login());
                              },
                            ).show();
                          } else if (value.message ==
                              "User unsuccessfully registered") {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: "This Email is already registered",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                            // print(value.message);
                          }
                        });
                      }

                      // await FirebaseAuth.instance.verifyPhoneNumber(
                      //   phoneNumber: '+855${requestModel.tel_num}',
                      //   timeout: const Duration(seconds: 90),
                      //   verificationCompleted:
                      //       (PhoneAuthCredential credential) async {
                      //     await auth.signInWithCredential(credential);
                      //     print("\ngood to\n");
                      //     // ignore: use_build_context_synchronously
                      //     AwesomeDialog(
                      //       context: context,
                      //       dialogType: DialogType.info,
                      //       animType: AnimType.rightSlide,
                      //       headerAnimationLoop: false,
                      //       title: 'Error code sms',
                      //       desc: "good",
                      //       btnOkOnPress: () {},
                      //       btnOkIcon: Icons.cancel,
                      //       btnOkColor: Colors.greenAccent,
                      //     ).show();
                      //   },
                      //   verificationFailed: (FirebaseAuthException e) {
                      //     if (e.code == 'invalid-phone-number') {
                      //       AwesomeDialog(
                      //         context: context,
                      //         dialogType: DialogType.error,
                      //         animType: AnimType.rightSlide,
                      //         headerAnimationLoop: false,
                      //         title: 'Error code sms',
                      //         desc: e.code,
                      //         btnOkOnPress: () {},
                      //         btnOkIcon: Icons.cancel,
                      //         btnOkColor: Colors.red,
                      //       ).show();
                      //     }
                      //   },
                      //   codeSent:
                      //       (String verificationId, int? resendToken) async {
                      //     await Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => MyVerify(
                      //                   code: (value) {
                      //                     setState(() {
                      //                       smsCode = value;
                      //                     });
                      //                   },
                      //                 )));
                      //     // Create a PhoneAuthCredential with the code
                      //     credential = PhoneAuthProvider.credential(
                      //         verificationId: verificationId,
                      //         smsCode: smsCode!);
                      //     final user =
                      //         await auth.signInWithCredential(credential!);

                      //     apIservice.register(requestModel).then((value) {
                      //       setState(() {
                      //         isApiCallProcess = false;
                      //       });
                      //       if (value.message ==
                      //           "User successfully registered") {
                      //         var people = PeopleModel(
                      //           id: 0,
                      //           name: requestModel.email,
                      //           password: requestModel.password,
                      //         );
                      //         PeopleController().insertPeople(people);
                      //         AwesomeDialog(
                      //           context: context,
                      //           animType: AnimType.leftSlide,
                      //           headerAnimationLoop: false,
                      //           dialogType: DialogType.success,
                      //           showCloseIcon: false,
                      //           title: value.message,
                      //           autoHide: Duration(seconds: 3),
                      //           onDismissCallback: (type) {
                      //             Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => Login(),
                      //               ),
                      //             );
                      //           },
                      //         ).show();
                      //       } else {
                      //         AwesomeDialog(
                      //           context: context,
                      //           dialogType: DialogType.error,
                      //           animType: AnimType.rightSlide,
                      //           headerAnimationLoop: false,
                      //           title: 'Error',
                      //           desc: value.message,
                      //           btnOkOnPress: () {},
                      //           btnOkIcon: Icons.cancel,
                      //           btnOkColor: Colors.red,
                      //         ).show();
                      //         print(value.message);
                      //       }
                      //       Navigator.pop(context);
                      //     });
                      //   },
                      //   codeAutoRetrievalTimeout: (String verificationId) {},
                      // );
                    }
                  },
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have account? ",
                      style: TextStyle(fontSize: 16.0, color: kTextLightColor),
                    ),
                    TextSpan(
                      text: 'Log In',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(lat: 0, log: 0, thi: 0),
                            ),
                          );
                        },
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kImageColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
