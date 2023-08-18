// // ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, avoid_print, deprecated_member_use, duplicate_ignore, unused_import, non_constant_identifier_names

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:kfa_project/screen/Profile/components/FieldBox.dart';
// import 'package:kfa_project/screen/Profile/components/TwinBox.dart';
// import 'package:kfa_project/screen/Profile/components/genderBox.dart';
// import 'package:kfa_project/screen/Profile/components/profile_pic.dart';
// import 'package:kfa_project/screen/Profile/components/singleBox.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kfa_project/contants.dart';

// class Picture extends StatefulWidget {
//   const Picture({Key? key}) : super(key: key);

//   @override
//   State<Picture> createState() => _PictureState();
// }

// class _PictureState extends State<Picture> {
//   //-- pick, cropped and save to local--//
//   String? _imagepath;
//   PickedFile? _imagefile;
//   final ImagePicker _picker = ImagePicker();
//   final ImageCropper _cropper = ImageCropper();

//   getImage(ImageSource source) async {
//     _imagefile = await _picker.getImage(source: source);
//     if (_imagefile != null) {
//       CroppedFile? cropped = await _cropper.cropImage(
//         sourcePath: _imagefile!.path,
//         //aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//         compressQuality: 90,
//         maxHeight: 100,
//         maxWidth: 100,
//         compressFormat: ImageCompressFormat.jpg,
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: 'Cropper',
//               toolbarColor: Colors.blue,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(
//             title: 'Cropper',
//           ),
//           WebUiSettings(
//             context: context,
//           ),
//         ],
//       );
//       setState(() {
//         _imagefile = cropped as PickedFile?;
//       });
//     } else {
//       throw "Could not cropped Image";
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     LoadImage();
//     // _image = _imagepath as File?;
//     // _imagepath = _image as String;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           'Profile',
//           style: TextStyle(
//             //color: Color.fromRGBO(169, 203, 56, 1),
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         toolbarHeight: 70,
//       ),
//       body: Container(
//         padding: EdgeInsets.only(top: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Container(
//             constraints: BoxConstraints(
//               maxWidth: double.infinity,
//               maxHeight: 700,
//             ),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               // borderRadius: BorderRadius.only(
//               //   // topLeft: Radius.circular(20),
//               //   // topRight: Radius.circular(20),
//               // ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               //---Profile---//
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   //width: MediaQuery.of(context).size.width /2,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         //color: Colors.red,
//                         child: SizedBox(
//                           height: 120,
//                           width: 120,
//                           child: Stack(
//                             clipBehavior: Clip.none,
//                             fit: StackFit.expand,
//                             children: <Widget>[
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 71,
//                                     backgroundColor: Colors.black38,
//                                     child: _imagepath != null
//                                         ? CircleAvatar(
//                                             radius: 58,
//                                             backgroundColor: Colors.grey,
//                                             backgroundImage:
//                                                 FileImage(File(_imagepath!)))
//                                         : CircleAvatar(
//                                             radius: 58,
//                                             backgroundColor: Colors.grey,
//                                             //foregroundImage: AssetImage('assets/images/KFA-Logo.png'),
//                                             backgroundImage: _imagefile == null
//                                                 ? null
//                                                 : FileImage(
//                                                     File(_imagefile!.path))),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 //crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 160),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Meng Chanrithty',
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           '123456789',
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Positioned(
//                                 //right: 230,
//                                 left: 0,
//                                 bottom: 0,
//                                 child: SizedBox(
//                                   height: 40,
//                                   width: 40,
//                                   // child: FlatButton(
//                                   //   padding: EdgeInsets.zero,
//                                   //   shape: RoundedRectangleBorder(
//                                   //       borderRadius: BorderRadius.circular(50),
//                                   //       side: BorderSide(
//                                   //         color: kImageColor,
//                                   //       )),
//                                   //   color: kImageColor,
//                                   //   onPressed: () {
//                                   //     showDialog(
//                                   //         context: context,
//                                   //         builder: (BuildContext context) {
//                                   //           return AlertDialog(
//                                   //             title: Text(
//                                   //               'Choose option',
//                                   //               style: TextStyle(
//                                   //                 color: Colors.blue,
//                                   //                 fontWeight: FontWeight.w600,
//                                   //               ),
//                                   //             ),
//                                   //             content: SingleChildScrollView(
//                                   //               child: Column(
//                                   //                 children: [
//                                   //                   EditPicture(
//                                   //                     icon: Icons.camera,
//                                   //                     title: 'Camera',
//                                   //                     press: () {
//                                   //                       getImage(
//                                   //                           ImageSource.camera);
//                                   //                     },
//                                   //                   ),
//                                   //                   EditPicture(
//                                   //                     icon: Icons.image,
//                                   //                     title: 'Gallary',
//                                   //                     press: () {
//                                   //                       getImage(ImageSource
//                                   //                           .gallery);
//                                   //                     },
//                                   //                   ),
//                                   //                 ],
//                                   //               ),
//                                   //             ),
//                                   //           );
//                                   //         });
//                                   //   },
//                                   //   child: SvgPicture.asset(
//                                   //     "assets/icons/camera.svg",
//                                   //     color: Colors.black,
//                                   //     height: 24,
//                                   //     width: 24,
//                                   //   ),
//                                   // ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Divider(
//                         color: Colors.blueAccent,
//                         thickness: 1,
//                       ),
//                       Column(
//                         children: [
//                           TwinBox(
//                             labelText1: 'First Name',
//                             labelText2: 'Last Name',
//                             fname: '',
//                             lname: '',
//                           ),
//                           SizedBox(
//                             height: 2,
//                           ),
//                           GenderBox(
//                             gender: 'widget.gender',
//                             from: 'widget.from',
//                           ),
//                           SizedBox(
//                             height: 2,
//                           ),
//                           SingleBox(
//                             phone: '',
//                           ),
//                           SizedBox(
//                             height: 2,
//                           ),
//                           Field_box(
//                             name: 'Email',
//                             email: '',
//                           ),
//                           SizedBox(
//                             height: 2,
//                           ),
//                           Field_box(
//                             name: 'Address',
//                             email: '',
//                           ),
//                           SizedBox(
//                             height: 2,
//                           ),
//                         ],
//                       ),

//                       Container(
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.all(40.0),
//                         child: ElevatedButton(
//                           child: Text('Save Change'),
//                           onPressed: () {
//                             saveimage(_imagefile);
//                             print('can save it');
//                           },
//                         ),
//                       ),
//                       // Column(
//                       //   children: [

//                       //   ],
//                       // ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// //--function save and load image--//
//   void saveimage(path) async {
//     SharedPreferences saveimage = await SharedPreferences.getInstance();
//     saveimage.setString('imagepath', path);
//   }

//   void LoadImage() async {
//     SharedPreferences saveimage = await SharedPreferences.getInstance();
//     setState(() {
//       _imagepath = saveimage.getString("imagepath");
//     });
//   }
// }
