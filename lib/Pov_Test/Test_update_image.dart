// // ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_null_comparison, prefer_const_constructors, non_constant_identifier_names, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_print, camel_case_types, sized_box_for_whitespace

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// import 'Property copy/contants.dart';

// class nananna extends StatefulWidget {
//   const nananna({super.key});

//   @override
//   State<nananna> createState() => _nanannaState();
// }

// class _nanannaState extends State<nananna> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: TextButton(
//             onPressed: () {
//               Get.to(ImageFileConverter());
//             },
//             child: Text('Go')),
//       ),
//     );
//   }
// }

// class ImageFileConverter extends StatefulWidget {
//   const ImageFileConverter({Key? key}) : super(key: key);

//   @override
//   _ImageFileConverterState createState() => _ImageFileConverterState();
// }

// class _ImageFileConverterState extends State<ImageFileConverter> {
//   late File _imageFile_noinput;
//   late File _imageFile_wait;

//   bool _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     _initData();
//   }

//   Future<void> _initData() async {
//     await Future.wait([
//       _downloadImage()
//       // Property_Sale_last_id(),
//     ]);
//     await Future.delayed(Duration(seconds: 2));
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   String? image_na =
//       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/propery_sale/2hh2.jpg';
//   Future<void> _downloadImage() async {
//     final response = await http.get(Uri.parse('$image_na'));
//     final bytes = response.bodyBytes;
//     final tempDir = await getTemporaryDirectory();
//     final tempFile = File('${tempDir.path}/image.jpg');
//     await tempFile.writeAsBytes(bytes);
//     setState(() {
//       _imageFile_noinput = tempFile;
//       print('_imageFile$_imageFile_noinput');
//     });
//   }

//   String? id_ptys1 = '20234688';
//   String? image_i;
//   String? property_type_id;
//   Future<File?> _upload_Image_Sale_url(File) async {
//     if (_imageFile_noinput != null && _imageFile_input == null) {
//       _imageFile_wait = _imageFile_noinput;
//       print('No input');
//     } else {
//       _imageFile_wait = _imageFile_input!;
//       print('Input');
//     }
//     final url = Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_post_id_last/${id_ptys1}');

//     final request = http.MultipartRequest('POST', url);

//     request.fields['id_image'] = id_ptys1.toString();
//     request.fields['property_type_id'] = property_type_id!;

//     request.files.add(await http.MultipartFile.fromPath(
//         'image_name_sale', _imageFile_wait.path));

//     final response = await request.send();

//     if (response.statusCode == 200) {
//       print('Image uploaded!');
//     } else {
//       print('Error uploading image: ${response.reasonPhrase}');
//     }
//   }

//   File? _imageFile_input;
//   Future<void> _getImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile_input = File(pickedFile.path);
//         print(_imageFile_input);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: _isLoading
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     (_imageFile_noinput != null && _imageFile_input == null)
//                         ? Padding(
//                             padding: const EdgeInsets.only(left: 10, right: 10),
//                             child: Image.file(
//                               _imageFile_noinput,
//                               height: 200,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.only(left: 10, right: 10),
//                             child: Image.file(
//                               _imageFile_input!,
//                               height: 200,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                     SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10, left: 10),
//                       child: InkWell(
//                         onTap: _getImage,
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 50,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: Color.fromARGB(255, 47, 22, 157)),
//                           child: Text(
//                             'Select Image',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       width: 400,
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         onChanged: (value) {
//                           setState(() {
//                             property_type_id = value;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(
//                             Icons.price_change_outlined,
//                             color: kImageColor,
//                           ),
//                           hintText: 'price',
//                           fillColor: kwhite,
//                           filled: true,
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: kPrimaryColor, width: 2.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: kPrimaryColor,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                         onPressed: () async {
//                           setState(() {
//                             _imageFile_noinput;
//                             print('00000 = ${_imageFile_noinput}');
//                           });
//                           await _downloadImage();
//                           _upload_Image_Sale_url(_imageFile_noinput);
//                         },
//                         child: Text('Save'))
//                   ],
//                 ),
//               ));
//   }
// }
