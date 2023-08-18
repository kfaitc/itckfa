// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itckfa/Memory_local/Local_data.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/afa/customs/formVLD.dart';
import 'package:itckfa/api/api_service.dart';
import 'package:itckfa/models/register_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';

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
  XFile? _file;
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  dynamic openImage(ImageSource source) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);
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
              backgroundColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original)
        ]);
        _file = XFile(cropFile!.path);
        imagepath = pickedFile.path;
        // _file = imagefile;
        // XFile? imagefile;

        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg
        File? imagefile = File(imagepath); //convert Path to File
        // saveAutoVerbal(imagefile);
        get_bytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string =
            base64.encode(get_bytes!); //convert bytes to base64 string
        // ignore: unused_local_variable
        Uint8List decodedbytes = base64.decode(base64string);
        //decode base64 stirng to bytes
        setState(() async {
          _file = imagefile as XFile;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  Future cut_again(XFile pickedFile) async {
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
          backgroundColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original)
    ]);

    _file = XFile(cropFile!.path);
    imagepath = pickedFile.path;
    // _file = imagefile;
    // XFile? imagefile;

    //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg
    File? imagefile = File(imagepath); //convert Path to File
    // saveAutoVerbal(imagefile);
    get_bytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string =
        base64.encode(get_bytes!); //convert bytes to base64 string
    // ignore: unused_local_variable
    Uint8List decodedbytes = base64.decode(base64string);
    //decode base64 stirng to bytes
    setState(() {
      _file = imagefile as XFile;
    });
  }

  String? set_id_user;
  int? user_last_id;
  Random random = new Random();

  Uint8List? get_bytes;
  Uint8List? _byesData;
  void get_user_last_id() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_last_user'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        user_last_id = jsonData;
        set_id_user =
            '${user_last_id.toString()}K${random.nextInt(999).toString()}F${user_last_id.toString()}A';
      });
    }
  }

  Future<void> uploadImage() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_profile_user'));
    request.fields['id_user'] = set_id_user ?? '';
    if (get_bytes != null) {
      request.files.add(await http.MultipartFile.fromBytes('image', get_bytes!,
          filename:
              'User ID :${set_id_user} photo ${random.nextInt(999)}.jpg'));
    } else {
      request.files.add(await http.MultipartFile.fromBytes('image', _byesData!,
          filename:
              'User ID :${set_id_user} Photo ${random.nextInt(999)}.jpg'));
    }

    // ignore: unused_local_variable
    var res = await request.send();
  }

  bool _isObscure = true;
  RegisterRequestModel requestModel = new RegisterRequestModel(
    email: "",
    password: "",
    first_name: '',
    gender: '',
    known_from: '',
    last_name: '',
    tel_num: '',
    password_confirmation: '',
    control_user: '',
  );
  bool isApiCallProcess = false;
  @override
  void initState() {
    get_user_last_id();

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
          'assets/images/KFA-Logo.png',
          height: 120,
          width: 150,
        ),
        toolbarHeight: 100,
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
                        width: 500,
                        child: register(context),
                      ),
                    ],
                  ),
                )
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
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text.rich(
                TextSpan(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TextSpan(
                      text: "ONE CLICK ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kImageColor,
                      ),
                    ),
                    TextSpan(
                      text: "1\$",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: kerror,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  if (_file == null) {
                    await openImage(ImageSource.gallery);
                  } else {
                    await cut_again(_file!);
                    setState(() {
                      _file;
                    });
                  }
                  setState(() {
                    _file;
                  });
                },
                child: Center(
                    child: (_file == null)
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
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        : Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              GFAvatar(
                                  size: 100,
                                  backgroundImage:
                                      FileImage(File(_file!.path))),
                              Container(
                                height: 20,
                                width: 30,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(96, 102, 102, 102),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  Icons.crop,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
              ),
              SizedBox(
                height: 30.0,
              ),
              if (user_last_id != null)
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: 'Identity ${set_id_user}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.info_outline_rounded,
                          color: kImageColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
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
                height: 10.0,
              ),
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
                  )),
              SizedBox(
                height: 10,
              ),
              // FormValidate(
              //     onSaved: (input) => requestModel.username = input!,
              //     label: 'Username',
              //     iconname: Icon(
              //       Icons.person,
              //       color: kImageColor,
              //     )),
              SizedBox(
                height: 10,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: DropdownButtonFormField<String>(
                    onChanged: (String? newValue) {
                      setState(() {
                        genderValue = newValue!;
                        requestModel.gender = genderValue.toString();
                        print(newValue);
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
                        _isObscure ? Icons.visibility : Icons.visibility_off,
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
                  obscureText: _isObscure,
                  onChanged: (input) {
                    setState(() {
                      requestModel.password_confirmation = input;
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Confirm password',
                    prefixIcon: Icon(
                      Icons.key,
                      color: kImageColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: kImageColor,
                        _isObscure ? Icons.visibility : Icons.visibility_off,
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
                  color: kPrimaryColor,
                  pressEvent: () async {
                    if (validateAndSave()) {
                      setState(() {
                        isApiCallProcess = true;
                        requestModel.control_user = set_id_user.toString();
                      });
                      if (get_bytes != null || _byesData != null) {
                        await uploadImage();
                      }

                      APIservice apIservice = APIservice();

                      apIservice.register(requestModel).then((value) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.message == "User successfully registered") {
                          var people = PeopleModel(
                            id: 0,
                            name: requestModel.email,
                            password: requestModel.password,
                          );
                          PeopleController().insertPeople(people);
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.success,
                            showCloseIcon: false,
                            title: value.message,
                            autoHide: Duration(seconds: 3),
                            onDismissCallback: (type) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                          ).show();
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
                      });
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
                                      LoginPage(lat: 0, log: 0, thi: 0)));
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
