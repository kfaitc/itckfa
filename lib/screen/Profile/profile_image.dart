// // ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors, import_of_legacy_library_into_null_safe

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Picture_image extends StatefulWidget {
//   const Picture_image({Key? key}) : super(key: key);

//   @override
//   State<Picture_image> createState() => _Picture_imageState();
// }

// class _Picture_imageState extends State<Picture_image> {
//   File? _image;
//   String? _imagepath;

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
//       appBar: AppBar(
//         title: Text('Image'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _imagepath != null
//                 ? CircleAvatar(
//                     radius: 50, backgroundImage: FileImage(File(_imagepath!)))
//                 : CircleAvatar(
//                     radius: 50,
//                     backgroundImage:
//                         _image == null ? null : FileImage(File(_image!.path)),
//                   ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: RaisedButton(
//                 onPressed: () {
//                   PickImage();
//                 },
//                 child: Text('Pick image'),
//               ),
//             ),
//             RaisedButton(
//               onPressed: () {
//                 saveimage(_image!.path);
//                 print('i can save it');
//               },
//               child: Text('Save Image'),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void PickImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _image = image;
//     });
//   }

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
