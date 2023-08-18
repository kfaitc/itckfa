// // ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors, unused_field, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:kfa_project/contants.dart';

// class Profile_pic extends StatefulWidget {
//   const Profile_pic({Key? key}) : super(key: key);

//   @override
//   State<Profile_pic> createState() => _Profile_picState();
// }

// class _Profile_picState extends State<Profile_pic> {
//   late bool isProcess = false;
//   PickedFile? _imagefile;
//   final ImagePicker _picker = ImagePicker();
//   final ImageCropper _cropper = ImageCropper();

//   void TakePhoto(ImageSource source) async {
//     setState(() {
//       isProcess = true;
//     });
//     final pickedFile = await _picker.getImage(
//       source: source,
//     );

//     if (pickedFile != null) {
//       final croppedImage = await _cropper.cropImage(
//           sourcePath: pickedFile.path,
//           aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//           compressQuality: 100,
//           maxHeight: 700,
//           maxWidth: 700,
//           compressFormat: ImageCompressFormat.jpg,
//           androidUiSettings: AndroidUiSettings(
//             toolbarColor: Colors.blue,
//             toolbarTitle: "Crop Image",
//             statusBarColor: Colors.green,
//             backgroundColor: Colors.white,
//           ));

//       setState(() {
//         _imagefile = croppedImage as PickedFile?;
//         isProcess = false;
//       });
//     } else {
//       setState(() {
//         isProcess = false;
//       });
//     }

//     setState(() {
//       _imagefile = pickedFile;
//     });
//   }

//   // cropImage(ImageSource source) async {
//   //   File? cropped = await ImageCropper.
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 500,
//       //color: Colors.red,
//       child: SizedBox(
//         height: 120,
//         width: 120,
//         child: Stack(
//           clipBehavior: Clip.none,
//           fit: StackFit.expand,
//           children: <Widget>[
//             CircleAvatar(
//               radius: 71,
//               backgroundColor: kImageColor,
//               child: CircleAvatar(
//                 radius: 55,
//                 //backgroundColor: kPrimaryColor,
//                 backgroundImage: _imagefile == null
//                     ? null
//                     : FileImage(File(_imagefile!.path)),
//               ),
//             ),
//             Positioned(
//               right: 113,
//               bottom: 0,
//               child: SizedBox(
//                 height: 40,
//                 width: 40,
//                 // ignore: deprecated_member_use
//                 child: FlatButton(
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                       side: BorderSide(
//                         color: kImageColor,
//                       )),
//                   color: kImageColor,
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text(
//                               'Choose option',
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             content: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   EditPicture(
//                                     icon: Icons.camera,
//                                     title: 'Camera',
//                                     press: () {
//                                       TakePhoto(ImageSource.camera);
//                                     },
//                                   ),
//                                   EditPicture(
//                                     icon: Icons.image,
//                                     title: 'Gallary',
//                                     press: () {
//                                       TakePhoto(ImageSource.gallery);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   },
//                   child: SvgPicture.asset(
//                     "assets/icons/camera.svg",
//                     color: Colors.black,
//                     height: 24,
//                     width: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EditPicture extends StatelessWidget {
//   final String title;
//   final icon;
//   final press;
//   const EditPicture({
//     Key? key,
//     required this.title,
//     required this.icon,
//     this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListBody(
//       children: [
//         InkWell(
//           onTap: press,
//           splashColor: Colors.lightBlue,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Icon(
//                   icon,
//                   color: kImageColor,
//                 ),
//               ),
//               Text(
//                 title,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
