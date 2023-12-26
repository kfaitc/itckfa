// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, deprecated_member_use, must_be_immutable, use_build_context_synchronously, non_constant_identifier_names, unused_field, unused_local_variable, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unused_import, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/afa/screens/Auth/login.dart';
import 'package:itckfa/api/api_service.dart';
import 'package:itckfa/contants.dart';
import 'package:itckfa/models/register_model.dart';
import 'package:itckfa/screen/Profile/components/Drop.dart';
import 'package:itckfa/screen/Profile/components/Drop_down.dart';
import 'package:itckfa/screen/Profile/components/FieldBox.dart';
import 'package:itckfa/screen/Profile/components/TwinBox.dart';
import 'package:itckfa/screen/Profile/components/singleBox.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
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
  const Account({
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
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
//update data from api
  String url =
      "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/users";

//get image and crop
  String? _imagepath;
  File? _imagefile;
  bool _isObscure = true;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];
  Random random = new Random();
  Future<void> uploadImage() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_profile_user'));
    request.fields['id_user'] = set_id_user ?? '';
    request.files.add(await http.MultipartFile.fromBytes('image', imagebytes!,
        filename: 'User ID :${set_id_user} photo ${random.nextInt(999)}.jpg'));

    var res = await request.send();
  }

  late File _image;
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
                initAspectRatio: CropAspectRatioPreset.original)
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
        // print("No image is selected.");
      }
    } catch (e) {
      // print("error while picking file.");
    }
  }

  List list_User_by_id = [];
  var set_id_user;

  void get_image(String id) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user_profile/${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        url = jsonData[0]['url'];
      });
    }
  }

//function LogOut
  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Fluttertoast.showToast(
      msg: 'Log Out',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.blue,
      fontSize: 20,
    );
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  RegisterRequestModel_update? requestModel;
  late TextEditingController Password;

  @override
  void initState() {
    setState(() {
      Password = TextEditingController(text: widget.password);
      requestModel = RegisterRequestModel_update(
        email: widget.email,
        password: widget.password,
        first_name: widget.first_name,
        gender: widget.gender,
        known_from: widget.from,
        last_name: widget.last_name,
        tel_num: widget.tel,
      );
    });
    url;
    set_id_user = widget.control_user;
    get_image(widget.control_user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //controller to update dataInfo
    final controller = TextEditingController(text: widget.username);
    //Get.lazyPut(() => ImageController());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 250, 246),
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              size: 35,
            )),
        title: Text(
          'Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                buttonSelect(context);
              },
              icon: Icon(Icons.settings)),
        ],
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: 750,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: kwhite_new,
                        borderRadius: kBottomBorderRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () async {
                                  await openImage();
                                  setState(() {
                                    _file;
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    if (url != null && _file == null)
                                      GFAvatar(
                                        size: 65,
                                        backgroundImage: NetworkImage('${url}'),
                                      ),
                                    if (_file != null)
                                      GFAvatar(
                                        size: 65,
                                        backgroundImage:
                                            MemoryImage(imagebytes!),
                                      ),
                                    Container(
                                      height: 20,
                                      width: 50,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(95, 67, 67, 67),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Icon(
                                        (url != null) ? Icons.edit : Icons.crop,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    // controller: controller,
                                    'Name : ${widget.username}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'ID : ${widget.control_user}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        TwinBox(
                          labelText1: 'Firstname',
                          labelText2: 'Lastname',
                          fname: widget.first_name,
                          lname: widget.last_name,
                          get_fname: (value) {
                            setState(() {
                              requestModel!.first_name = value;
                            });
                          },
                          get_lname: (value) {
                            setState(() {
                              requestModel!.last_name = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Dropdown(
                              gender: widget.gender,
                              get_gender: (value) {
                                setState(() {
                                  requestModel!.gender = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            // បិទសឹនបើមានការUpdate ដោយអនុញ្ញាតិអោយគេអាចធ្វើការកែប្រែបានចាំបើក​ SizedBoxខាងក្រោម ។
                            SizedBox(
                              height: 59,
                              width: 140,
                              child: DropdownButtonFormField<String>(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    requestModel!.known_from = newValue!;
                                  });
                                },
                                // validator: (String? value) {
                                //   if (value?.isEmpty ?? true) {
                                //     return 'Please select bank';
                                //   }
                                //   return null;
                                // },
                                value: widget.from,
                                items: bank
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                                // add extra sugar..
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: kwhite_new,
                                ),

                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Bank',
                                  hintText: 'Select',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        SingleBox(
                          phone: widget.tel,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Field_box(
                          name: 'email',
                          email: widget.email,
                          get_email: (value) {
                            setState(() {
                              requestModel!.email = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        if (Password != null)
                          Container(
                            height: 60,
                            width: 280,
                            child: TextFormField(
                              controller: Password,
                              // initialValue: "list[0].password",
                              onChanged: (input) {
                                setState(() {
                                  requestModel!.password = input;
                                });
                              },
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                filled: true,
                                labelText: 'Your Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    color: Color.fromRGBO(169, 203, 56, 1),
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return 'require *';
                                }
                                return null;
                              },
                            ),
                          ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                kwhite_new,
                              ),
                            ),
                            child: Text('Save Change'),
                            onPressed: () async {
                              if (_file != null) {
                                await uploadImage();
                              }
                              APIservice apIservice = APIservice();
                              await apIservice.update_user(
                                  requestModel!, int.parse(widget.id));
                              logOut();
                            },
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ],
                ),

                // Column(
                //   children: [

                //   ],
                // ),
              ],
            )),
      ),
    );
  }

  Future buttonSelect(BuildContext context) {
    var check_password;
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          color: Colors.black26,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    kwhite_new,
                  ),
                ),
                child: Text('Delete Account'),
                onPressed: () async {
                  MyDb mydb = new MyDb();
                  await mydb.open_user();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    headerAnimationLoop: false,
                    title: 'Error',
                    desc: "Are you sure you want to delete",
                    body: Column(
                      children: [
                        Text(
                            "Are you sure you want to delete\nPlease enter your password"),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              check_password = value;
                            });
                          },
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Enter your password here....",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ],
                    ),
                    btnCancel: TextButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        if (check_password == widget.password) {
                          await mydb.db.rawDelete("DELETE FROM user WHERE 1");
                          await update();
                          // print("Data Deleted");
                          Get.to(() => Login());
                        }
                      },
                    ),
                    btnOk: TextButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ).show();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    kwhite_new,
                  ),
                ),
                child: Text('Log Out'),
                onPressed: () {
                  logOut();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future update() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${widget.control_user}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      // print(response.reasonPhrase);
    }
  }
}

class EditPicture extends StatelessWidget {
  final String title;
  final icon;
  final press;
  const EditPicture({
    Key? key,
    required this.title,
    required this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        InkWell(
          onTap: press,
          splashColor: Colors.lightBlue,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  icon,
                  color: kwhite_new,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// UpdateUserInfo()async{
//   var username =
// }
