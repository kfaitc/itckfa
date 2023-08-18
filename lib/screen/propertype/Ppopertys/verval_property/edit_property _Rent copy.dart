// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, avoid_print, unused_field, prefer_final_fields, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, equal_keys_in_map, unrelated_type_equality_checks, body_might_complete_normally_nullable, unused_element, await_only_futures, unnecessary_string_interpolations, unnecessary_cast, must_be_immutable, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_null_comparison, avoid_types_as_parameter_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

// import 'dart:convert';
// import 'dart:io';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../Pov_Test/map_in_add_verbal.dart';
// import '../../afa/components/contants.dart';
// import '../propertys/api_property/api.dart';
// import '../Model/update_property.dart';

// class Edit_verbal_property_Rent extends StatefulWidget {
//   Edit_verbal_property_Rent({
//     super.key,
//     // required this.property_type_id1,
//     // required this.Title1,
//     // required this.bed1,
//     // required this.sqm1,
//     // required this.address1,
//     // required this.bath1,
//     // required this.description1,
//     // required this.id_ptys1,
//     // required this.land1,
//     // required this.price1,
//     // required this.type1,
//     // required this.hometype,
//     // required this.urgent,
//     required this.get_all_homeytpe,
//     required this.indexv,
//   });
//   List? get_all_homeytpe;

//   String? indexv;
//   // String? id_ptys1;
//   // String? property_type_id1;
//   // String? price1;
//   // String? sqm1;
//   // String? bed1;
//   // String? bath1;
//   // String? type1;
//   // String? land1;
//   // String? address1;
//   // String? Title1;
//   // String? description1;
//   // String? urgent;
//   // String? hometype;

//   @override
//   State<Edit_verbal_property_Rent> createState() => _Add_verbal_saleState();
// }

// class _Add_verbal_saleState extends State<Edit_verbal_property_Rent> {
//   String? provice;
//   late AutoVerbal_property_update_Rent_k requestAutoVerbal_property;
//   final List<String> _items_2 = [
//     'For Sale',
//   ];
//   int? indexN;
//   bool? ug;
//   int? index_Sale;
//   int? index_Rent;
//   late String branchvalue;
//   bool _isLoading = true;
//   var _items = [];
//   String? Urgent_wiget;
//   String? Urgent_wiget_lok;
//   @override
//   void initState() {
//     type;

//     indexN = int.parse(widget.indexv.toString());
//     Urgent_wiget =
//         Urgent_wiget = widget.get_all_homeytpe![indexN!]['urgent'].toString();
//     if (Urgent_wiget == 'Urgent') {
//       ug = true;
//     } else {
//       ug = false;
//     }

//     // _initData();
//     type = 'For Sale';
//     super.initState();
//     requestAutoVerbal_property = AutoVerbal_property_update_Rent_k(
//       hometype: widget.get_all_homeytpe![indexN!]['hometype'].toString(),
//       id_ptys: widget.get_all_homeytpe![indexN!]['id_ptys'].toString(),
//       property_type_id:
//           widget.get_all_homeytpe![indexN!]['property_type_id'].toString(),
//       price: widget.get_all_homeytpe![indexN!]['price'].toString(),
//       land: widget.get_all_homeytpe![indexN!]['land'].toString(),
//       sqm: widget.get_all_homeytpe![indexN!]['sqm'].toString(),
//       bath: widget.get_all_homeytpe![indexN!]['bath'].toString(),
//       address: widget.get_all_homeytpe![indexN!]['address'].toString(),
//       type: widget.get_all_homeytpe![indexN!]['type'].toString(),
//       bed: widget.get_all_homeytpe![indexN!]['bed'].toString(),
//       description: widget.get_all_homeytpe![indexN!]['description'].toString(),
//       title: widget.get_all_homeytpe![indexN!]['Title'].toString(),
//     );
//     Urgent_wiget_lok = widget.get_all_homeytpe![indexN!]['url'].toString();
//   }

//   var s;
//   bool? index12 = true;

//   var khan;
//   var songkat;
//   var provice_map;
//   // Future<void> _initData() async {
//   //   await Future.wait([
//   //     Property_Sale_id(),
//   //     getimage(),
//   //     _downloadImage(),
//   //     Hometype(),
//   //   ]);
//   //   await Future.delayed(Duration(seconds: 2));
//   //   setState(() {
//   //     _isLoading = false;
//   //   });
//   // }

//   bool switchValue = false;
//   String _switchValue = 'Switch';
//   bool way = false;
//   TextEditingController address1 = TextEditingController();
//   String? price;
//   String? sqm;
//   var bed;
//   var bath;
//   String? type;
//   String? land;
//   var address;
//   var id_ptys;
//   String urgent = 'N/A';
//   String? property_id_p;
//   String? property_id_1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 20, 20, 163),
//         centerTitle: true,
//         title: Text('Edit Property Rent'),
//         actions: <Widget>[
//           InkWell(
//             onTap: () async {
//               setState(() {
//                 address = '${khan} / ${provice_map}';
//                 type;

//                 // print('ssssssssssssssssssssssss = $type');
//                 // print('type =$type');
//                 urgent;
//                 // print('urgent : $urgent');
//               });
//               //  _imageFile_noinput;
//               //         // print('00000 = ${_imageFile_noinput}');
//               //       });
//               //       await _downloadImage();

//               requestAutoVerbal_property.id_ptys =
//                   widget.get_all_homeytpe![indexN!]['id_ptys'].toString();
//               requestAutoVerbal_property.address =
//                   widget.get_all_homeytpe![indexN!]['address'].toString();
//               requestAutoVerbal_property.type =
//                   widget.get_all_homeytpe![indexN!]['type'].toString();
//               if (type != null) {
//                 APi_property apIservice = APi_property();
//                 apIservice
//                     .saveAutoVerbal_Update_property_Rent(
//                         requestAutoVerbal_property,
//                         int.parse(widget.get_all_homeytpe![indexN!]['id_ptys']
//                             .toString()))
//                     .then(
//                   (value) async {
//                     setState(() {
//                       _upload_Image_Sale_url_rent();
//                       urgent_Rent();
//                     });

//                     if (requestAutoVerbal_property.id_ptys.isEmpty) {
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.error,
//                         animType: AnimType.rightSlide,
//                         headerAnimationLoop: false,
//                         title: 'Error',
//                         desc: "Please check ",
//                         btnOkOnPress: () {},
//                         btnOkIcon: Icons.cancel,
//                         btnOkColor: Colors.red,
//                       ).show();
//                     } else {
//                       if (value.message == "Save Successfully") {
//                         AwesomeDialog(
//                             context: context,
//                             animType: AnimType.leftSlide,
//                             headerAnimationLoop: false,
//                             dialogType: DialogType.success,
//                             showCloseIcon: false,
//                             title: value.message,
//                             autoHide: Duration(seconds: 3),
//                             onDismissCallback: (type) {
//                               Navigator.pop(context);
//                             }).show();
//                       } else {
//                         AwesomeDialog(
//                           context: context,
//                           dialogType: DialogType.error,
//                           animType: AnimType.rightSlide,
//                           headerAnimationLoop: false,
//                           title: 'Error',
//                           desc: value.message,
//                           btnOkOnPress: () {},
//                           btnOkIcon: Icons.cancel,
//                           btnOkColor: Colors.red,
//                         ).show();
//                         print(value.message);
//                       }
//                     }
//                   },
//                 );
//               } else {
//                 setState(() {
//                   AwesomeDialog(
//                     context: context,
//                     dialogType: DialogType.error,
//                     animType: AnimType.rightSlide,
//                     headerAnimationLoop: false,
//                     title: 'Please Check Your Information',
//                     btnOkOnPress: () {},
//                     btnOkIcon: Icons.cancel,
//                     btnOkColor: Colors.red,
//                   ).show();
//                 });
//               }
//             },
//             child: Container(
//               alignment: Alignment.center,
//               width: 80,
//               decoration: BoxDecoration(
//                   color: kImageColor, borderRadius: BorderRadius.circular(15)),
//               child: Text(
//                 'Save',
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//       // body: Column(
//       //   children: [
//       //     Text(
//       //         'Edit Property : ${widget.list2_Sale_id![indexN!]['id_ptys'].toString()}'),
//       //   ],
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),

//               // TextButton(
//               //     onPressed: () async {
//               //       setState(() {

//               //         _upload_Image_Sale_url_rent();
//               //       });
//               //       // urgent_Rent();
//               //     },
//               //     child: Text('Go')),
//               Padding(
//                 padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Color.fromARGB(255, 67, 20, 175),
//                         // border: Border.all(width: 2),
//                       ),
//                       height: 55,
//                       width: MediaQuery.of(context).size.width * 0.45,
//                       child: Text(
//                         'Code : ${widget.get_all_homeytpe![indexN!]['id_ptys'].toString()}',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 13),
//                       ),
//                     ),
//                     Container(
//                       height: 55,
//                       width: MediaQuery.of(context).size.width * 0.4,
//                       decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 43, 131, 11),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Switch(
//                             autofocus: false,
//                             activeColor: Color.fromARGB(255, 253, 253, 253),
//                             value: ug!,
//                             onChanged: (value) {
//                               setState(() {
//                                 ug = value;
//                                 if (value == true) {
//                                   urgent = 'Urgent';
//                                 } else {
//                                   urgent = 'N/A';
//                                 }
//                                 print('Urgent : $urgent');
//                               });
//                             },
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: 60,
//                             width: 80,
//                             decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 67, 20, 175),
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Text(
//                               (ug == true) ? 'Urgent' : 'N/A',
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 255, 255, 255),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Column(
//               //   children: [
//               //     Text(
//               //         'propertyy id = ${requestAutoVerbal_property.property_type_id}'),
//               //     Text('image = $image_i'),
//               //     // Text(
//               //     //     'requestAutoVerbal_property.property_type_id ${widget.property_type_id1}'),
//               //   ],
//               // ),
//               // TextButton(
//               //     onPressed: () async {
//               //       setState(() {
//               //         _imageFile_noinput;
//               //         // print('00000 = ${_imageFile_noinput}');
//               //       });
//               //       await _downloadImage();
//               //       _upload_Image_Sale_url(_imageFile_noinput);
//               //     },
//               //     child: Text('Go')),
//               // Text('Id = ${requestAutoVerbal_property.description}'),
//               SizedBox(
//                 height: 20,
//               ),
//               (widget.get_all_homeytpe![indexN!]['url'] != null &&
//                       _imageFile_input == null)
//                   ? Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: CachedNetworkImage(
//                         imageUrl:
//                             widget.get_all_homeytpe![indexN!]['url'].toString(),
//                         fit: BoxFit.cover,
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) => Center(
//                           child: CircularProgressIndicator(
//                               value: downloadProgress.progress),
//                         ),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       ),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Image.file(
//                         _imageFile_input!,
//                         height: 200,
//                         fit: BoxFit.cover,
//                       ),
//                     ),

//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(right: 10, left: 10),
//                 child: InkWell(
//                   onTap: _getImage,
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 50,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         color: Color.fromARGB(255, 47, 22, 157)),
//                     child: Text(
//                       'Select Image',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // Text(widget.get_all_homeytpe![indexN!]['hometype'].toString()),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: DropdownButtonFormField<String>(
//                   isExpanded: true,
//                   onChanged: (newValue) {
//                     newValue!;
//                     print('newValue = $newValue');
//                     requestAutoVerbal_property.hometype = newValue;
//                     // hometype11 = newValue;
//                     setState(() {
//                       // print('newValue = $type_select');
//                       // provice = newValue as String;
//                       // print('provice id = $provice');
//                     });
//                   },
//                   validator: (String? value) {
//                     if (value?.isEmpty ?? true) {
//                       return 'Please select bank';
//                     }
//                     return null;
//                   },
//                   items: widget.get_all_homeytpe!
//                       .map<DropdownMenuItem<String>>(
//                         (value) => DropdownMenuItem<String>(
//                           value: value["hometype"].toString(),
//                           child: Text(
//                             value["hometype"],
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize:
//                                     MediaQuery.textScaleFactorOf(context) * 13,
//                                 height: 1),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                   // add extra sugar..
//                   icon: Icon(
//                     Icons.arrow_drop_down,
//                     color: kImageColor,
//                   ),
//                   //property_type_id
//                   decoration: InputDecoration(
//                     fillColor: kwhite,
//                     filled: true,
//                     labelText: widget.get_all_homeytpe![indexN!]['hometype']
//                         .toString(),
//                     hintText: 'Select',
//                     prefixIcon: Icon(
//                       Icons.home_outlined,
//                       color: kImageColor,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: kPrimaryColor, width: 2.0),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: kPrimaryColor,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: kerror,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: kerror,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     //   decoration: InputDecoration(
//                     //       labelText: 'From',
//                     //       prefixIcon: Icon(Icons.business_outlined)),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Center(
//               //   child: _imageFile == null
//               //       ? CircularProgressIndicator()
//               //       : Image.file(_imageFile1),
//               // ),
//               // Container(
//               //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//               //   child: DropdownButtonFormField<String>(
//               //     isExpanded: true,
//               //     onChanged: (newValue) {
//               //       requestAutoVerbal_property.property_type_id = newValue!;

//               //       setState(() {
//               //         provice = newValue as String;
//               //         // print('provice id = $provice');
//               //       });
//               //     },
//               //     validator: (String? value) {
//               //       if (value?.isEmpty ?? true) {
//               //         return 'Please select bank';
//               //       }
//               //       return null;
//               //     },
//               //     items: _items
//               //         .map<DropdownMenuItem<String>>(
//               //           (value) => DropdownMenuItem<String>(
//               //             value: value["property_type_id"].toString(),
//               //             child: Text(
//               //               value["Name_cummune"],
//               //               overflow: TextOverflow.ellipsis,
//               //               style: TextStyle(
//               //                   fontSize:
//               //                       MediaQuery.textScaleFactorOf(context) * 13,
//               //                   height: 1),
//               //             ),
//               //           ),
//               //         )
//               //         .toList(),
//               //     // add extra sugar..
//               //     icon: Icon(
//               //       Icons.arrow_drop_down,
//               //       color: kImageColor,
//               //     ),
//               //     //property_type_id
//               //     decoration: InputDecoration(
//               //       fillColor: kwhite,
//               //       filled: true,
//               //       labelText: widget.list2_Sale_id![indexN!]
//               //               ['property_type_id']
//               //           .toString(),
//               //       hintText: 'Select',
//               //       prefixIcon: Icon(
//               //         Icons.home_work,
//               //         color: kImageColor,
//               //       ),
//               //       focusedBorder: OutlineInputBorder(
//               //         borderSide:
//               //             const BorderSide(color: kPrimaryColor, width: 2.0),
//               //         borderRadius: BorderRadius.circular(10.0),
//               //       ),
//               //       enabledBorder: OutlineInputBorder(
//               //         borderSide: BorderSide(
//               //           width: 1,
//               //           color: kPrimaryColor,
//               //         ),
//               //         borderRadius: BorderRadius.circular(10.0),
//               //       ),
//               //       errorBorder: OutlineInputBorder(
//               //         borderSide: BorderSide(
//               //           width: 1,
//               //           color: kerror,
//               //         ),
//               //         borderRadius: BorderRadius.circular(10.0),
//               //       ),
//               //       focusedErrorBorder: OutlineInputBorder(
//               //         borderSide: BorderSide(
//               //           width: 2,
//               //           color: kerror,
//               //         ),
//               //         borderRadius: BorderRadius.circular(10.0),
//               //       ),
//               //       //   decoration: InputDecoration(
//               //       //       labelText: 'From',
//               //       //       prefixIcon: Icon(Icons.business_outlined)),
//               //     ),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           onChanged: (value) {
//                             requestAutoVerbal_property.price = value;
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.price_change_outlined,
//                               color: kImageColor,
//                             ),
//                             hintText: widget.get_all_homeytpe![indexN!]['price']
//                                 .toString(),
//                             fillColor: kwhite,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kPrimaryColor, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: kPrimaryColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           onChanged: (value) {
//                             requestAutoVerbal_property.sqm =
//                                 double.parse(value).toStringAsFixed(5);

//                             // setState(() {
//                             //   sqm =
//                             //       double.parse(value).toStringAsFixed(5);
//                             // });
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.square_foot_outlined,
//                               color: kImageColor,
//                             ),
//                             fillColor: kwhite,
//                             hintText: widget.get_all_homeytpe![indexN!]['sqm']
//                                 .toString(),
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kPrimaryColor, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: kPrimaryColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           onChanged: (value) {
//                             requestAutoVerbal_property.bed = value;
//                             // setState(() {
//                             //   bed = int.parse(value);
//                             // });
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.bed_outlined,
//                               color: kImageColor,
//                             ),
//                             hintText: widget.get_all_homeytpe![indexN!]['bed']
//                                 .toString(),
//                             fillColor: kwhite,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kPrimaryColor, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: kPrimaryColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           onChanged: (value) {
//                             requestAutoVerbal_property.bath = value;
//                             // setState(() {
//                             //   bath = int.parse(value);
//                             // });
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.bathtub_outlined,
//                               color: kImageColor,
//                             ),
//                             fillColor: kwhite,
//                             hintText: widget.get_all_homeytpe![indexN!]['bed']
//                                 .toString(),
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kPrimaryColor, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: kPrimaryColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   // Expanded(
//                   //   child: SizedBox(
//                   //     child: Padding(
//                   //       padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   //       child: TextFormField(
//                   //         onChanged: (value) {
//                   //           requestAutoVerbal_property.type = value;
//                   //           // setState(() {
//                   //           //   bath = int.parse(value);
//                   //           // });
//                   //         },
//                   //         decoration: InputDecoration(
//                   //           prefixIcon: Icon(
//                   //             Icons.sell,
//                   //             color: kImageColor,
//                   //           ),
//                   //           fillColor: kwhite,
//                   //           hintText: 'For Sale',
//                   //           filled: true,
//                   //           focusedBorder: OutlineInputBorder(
//                   //             borderSide: const BorderSide(
//                   //                 color: kPrimaryColor, width: 2.0),
//                   //             borderRadius: BorderRadius.circular(10.0),
//                   //           ),
//                   //           enabledBorder: OutlineInputBorder(
//                   //             borderSide: BorderSide(
//                   //               width: 1,
//                   //               color: kPrimaryColor,
//                   //             ),
//                   //             borderRadius: BorderRadius.circular(10.0),
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   // Expanded(
//                   //   child: SizedBox(
//                   //     child: Padding(
//                   //       padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   //       child: DropdownButtonFormField<String>(
//                   //         isExpanded: true,
//                   //         onChanged: (newValue) {
//                   //           requestAutoVerbal_property.type = newValue!;
//                   //           setState(() {
//                   //             type;
//                   //             index_Sale = _items_2.indexOf('For Sale');
//                   //             // print(type);
//                   //           });
//                   //           // if (type == 'For Sale') {
//                   //           //   // print('$index_Sale');
//                   //           //   // print('$type');
//                   //           //   index_Sale = _items_2.indexOf('For Sale');
//                   //           // } else if (type == 'For Rent') {
//                   //           //   index_Rent = _items_2.indexOf('For Rent');
//                   //           //   // print('$type');
//                   //           //   // print('$index_Rent');
//                   //           // }
//                   //         },
//                   //         validator: (String? value) {
//                   //           if (value?.isEmpty ?? true) {
//                   //             return 'Please select bank';
//                   //           }
//                   //           return null;
//                   //         },
//                   //         items: _items_2
//                   //             .map<DropdownMenuItem<String>>(
//                   //               (value) => DropdownMenuItem<String>(
//                   //                 value: value,
//                   //                 child: Text(
//                   //                   value,
//                   //                   overflow: TextOverflow.ellipsis,
//                   //                   style: TextStyle(
//                   //                       fontSize:
//                   //                           MediaQuery.textScaleFactorOf(
//                   //                                   context) *
//                   //                               13,
//                   //                       height: 1),
//                   //                 ),
//                   //               ),
//                   //             )
//                   //             .toList(),
//                   //         // add extra sugar..
//                   //         icon: Icon(
//                   //           Icons.arrow_drop_down,
//                   //           color: kImageColor,
//                   //         ),

//                   //         decoration: InputDecoration(
//                   //           fillColor: kwhite,
//                   //           filled: true,
//                   //           labelText: 'Type',
//                   //           hintText: 'Select',

//                   //           prefixIcon: Icon(
//                   //             Icons.home_work,
//                   //             color: kImageColor,
//                   //           ),
//                   //           focusedBorder: OutlineInputBorder(
//                   //             borderSide: const BorderSide(
//                   //                 color: kPrimaryColor, width: 2.0),
//                   //             borderRadius: BorderRadius.circular(10.0),
//                   //           ),
//                   //           enabledBorder: OutlineInputBorder(
//                   //             borderSide: BorderSide(
//                   //               width: 1,
//                   //               color: kPrimaryColor,
//                   //             ),
//                   //             borderRadius: BorderRadius.circular(10.0),
//                   //           ),
//                   //           errorBorder: OutlineInputBorder(
//                   //             borderSide: BorderSide(
//                   //               width: 1,
//                   //               color: kerror,
//                   //             ),
//                   //             borderRadius: BorderRadius.circular(10.0),
//                   //           ),
//                   //           focusedErrorBorder: OutlineInputBorder(
//                   //             borderSide: BorderSide(
//                   //               width: 2,
//                   //               color: kerror,
//                   //             ),
//                   //             borderRadius: BorderRadius.circular(10.0),
//                   //           ),
//                   //           //   decoration: InputDecoration(
//                   //           //       labelText: 'From',
//                   //           //       prefixIcon: Icon(Icons.business_outlined)),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   Expanded(
//                     child: SizedBox(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         child: TextFormField(
//                           readOnly: true,
//                           onChanged: (value) {
//                             requestAutoVerbal_property.type = value;
//                             // setState(() {
//                             //   land =
//                             //       double.parse(value).toStringAsFixed(5);
//                             // });
//                           },
//                           decoration: InputDecoration(
//                             labelText: widget.get_all_homeytpe![indexN!]['type']
//                                 .toString(),
//                             prefixIcon: Icon(
//                               Icons.landscape_outlined,
//                               color: kImageColor,
//                             ),
//                             fillColor: kwhite,
//                             hintText: widget.get_all_homeytpe![indexN!]['type']
//                                 .toString(),
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kPrimaryColor, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: kPrimaryColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           onChanged: (value) {
//                             requestAutoVerbal_property.land = value;
//                             // setState(() {
//                             //   land =
//                             //       double.parse(value).toStringAsFixed(5);
//                             // });
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.landscape_outlined,
//                               color: kImageColor,
//                             ),
//                             fillColor: kwhite,
//                             hintText: widget.get_all_homeytpe![indexN!]['land']
//                                 .toString(),
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kPrimaryColor, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: kPrimaryColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               InkWell(
//                   onTap: () {
//                     Get.to(Map_verbal_address_Sale(
//                       get_province: (value) {
//                         setState(() {
//                           songkat = value.toString();
//                         });
//                       },
//                       get_district: (value) {
//                         setState(() {
//                           provice_map = value.toString();
//                         });
//                       },
//                       get_commune: (value) {
//                         setState(() {
//                           khan = value.toString();
//                         });
//                       },
//                       get_log: (value) {},
//                       get_lat: (value) {},
//                     ));
//                   },
//                   child: (khan != null || songkat != null)
//                       ? Container(
//                           height: 65,
//                           margin: EdgeInsets.only(right: 10, left: 10),
//                           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               border: Border.all(width: 1),
//                               borderRadius: BorderRadius.circular(10),
//                               color: Color.fromARGB(255, 255, 255, 255)),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.location_city_outlined,
//                                 size: 30,
//                                 color: Color.fromARGB(255, 40, 164, 45),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               // Text(
//                               //   '${songkat} ',
//                               //   style: TextStyle(
//                               //       fontWeight: FontWeight.bold,
//                               //       fontSize: 12),
//                               // ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 '${khan}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 12),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 '/ ${provice_map}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         )
//                       : Container(
//                           height: 65,
//                           margin: EdgeInsets.only(right: 10, left: 10),
//                           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               border: Border.all(width: 1),
//                               borderRadius: BorderRadius.circular(10),
//                               color: Color.fromARGB(255, 255, 255, 255)),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.location_city_outlined,
//                                 size: 30,
//                                 color: kImageColor,
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 '${widget.get_all_homeytpe![indexN!]['address'].toString()}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 14),
//                               )
//                             ],
//                           ),
//                         )),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 50,
//                 width: double.infinity,
//                 margin: EdgeInsets.all(10),
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1,
//                   ),
//                 ),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     requestAutoVerbal_property.title = value;
//                   },
//                   maxLines: 3,
//                   decoration: InputDecoration.collapsed(
//                     hintText:
//                         widget.get_all_homeytpe![indexN!]['Title'].toString(),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 150,
//                 width: double.infinity,
//                 margin: EdgeInsets.all(10),
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1,
//                   ),
//                 ),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     requestAutoVerbal_property.description = value;
//                   },
//                   maxLines: 3,
//                   decoration: InputDecoration.collapsed(
//                     hintText: widget.get_all_homeytpe![indexN!]['description']
//                         .toString(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List? last_id2 = [];
//   var last_cid;
//   List? last_id = [];

//   List? _items1;
//   String? provice_pd;
//   // Future<void> Commune_25_all() async {
//   //   var jsonData;
//   //   final response = await http.get(Uri.parse(
//   //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Commune_25/${widget.property_type_id1}'));

//   //   if (response.statusCode == 200) {
//   //     jsonData = jsonDecode(response.body);
//   //     _items = jsonData;
//   //     setState(() {
//   //       _items1;
//   //       // provice_pd = _items1![index]['Name_cummune'];
//   //       print('provice_pd : $_items1');

//   //       // list1 =list2_Sale_id;
//   //       // print('Commune_25_all = ${_items.toString()}');
//   //     });
//   //   }
//   // }

//   void urgent_Rent() async {
//     print('Post_Sale');

//     Map<String, dynamic> payload = await {
//       'id_ptys': widget.get_all_homeytpe![indexN!]['id_ptys'].toString(),
//       'hometype': requestAutoVerbal_property.hometype,
//       'property_type_id': requestAutoVerbal_property.property_type_id,
//       'urgent': urgent.toString(),
//     };

//     final url = await Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgent_update_rent/${widget.get_all_homeytpe![indexN!]['id_ptys'].toString()}');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(payload),
//     );

//     if (response.statusCode == 200) {
//       print('Success urgent_Sale');
//     } else {
//       print('Error Rent: ${response.reasonPhrase}');
//     }
//   }

//   File? _imageFile;
//   File? _imageFile_url;

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

//   // Future<File?> _upload_Image_Sale() async {
//   //   if (_imageFile == null) {
//   //     return _imageFile;
//   //   }
//   //   final url = Uri.parse(
//   //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_post_id_last/${widget.list2_Sale_id![indexN!]['id_ptys'].toString()}');

//   //   final request = http.MultipartRequest('POST', url);

//   //   request.fields['id_image'] =
//   //       widget.list2_Sale_id![indexN!]['id_ptys'].toString();
//   //   request.fields['hometype'] = requestAutoVerbal_property.hometype;
//   //   request.fields['property_type_id'] =
//   //       requestAutoVerbal_property.property_type_id;
//   //   // setState(() {
//   //   //   if (requestAutoVerbal_property.property_type_id ==
//   //   //       widget.property_type_id1) {
//   //   //     print('No Input');
//   //   //     request.fields['property_type_id'] = '22';
//   //   //   } else {
//   //   //     print('Input');
//   //   //     request.fields['property_type_id'] = '23';
//   //   //   }
//   //   // });

//   //   request.files.add(await http.MultipartFile.fromPath(
//   //       'image_name_sale', _imageFile_wait.path));

//   //   final response = await request.send();

//   //   if (response.statusCode == 200) {
//   //     print('Image uploaded!');
//   //   } else {
//   //     print('Error uploading image: ${response.reasonPhrase}');
//   //   }
//   // }
//   File? one;
//   Future<void> _upload_Image_Sale_url_rent() async {
//     // Convert the image URL to a file

//     final response = await http
//         .get(Uri.parse('${widget.get_all_homeytpe![indexN!]['url']}'));

//     // Get the bytes of the response's body
//     final bytes = response.bodyBytes;

//     // Create a temporary file with a unique name
//     final tempDir = await Directory.systemTemp.createTemp();
//     final tempFile = File(
//         '${tempDir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg');

//     // Write the bytes to the file
//     await tempFile.writeAsBytes(bytes);
//     // print('File Post = ${tempFile.toString()}');
//     // Return the file
//     if (tempFile != null && _imageFile_input == null) {
//       one = tempFile;
//     } else {
//       one = _imageFile_input;
//     }
//     final url = Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_post_rent_last/${widget.get_all_homeytpe![indexN!]['id_ptys'].toString()}');

//     final request = http.MultipartRequest('POST', url);
//     // request.fields['id_image'] = '202347267';
//     // request.fields['hometype'] = 'sdfjkjhhsd';
//     // request.fields['property_type_id'] = '12';

//     // request.files.add(
//     //     await http.MultipartFile.fromPath('image_name_sale', tempFile.path));
//     request.fields['id_image'] =
//         widget.get_all_homeytpe![indexN!]['id_ptys'].toString();
//     request.fields['hometype'] = requestAutoVerbal_property.hometype.toString();
//     request.fields['property_type_id'] =
//         requestAutoVerbal_property.property_type_id;

//     request.files
//         .add(await http.MultipartFile.fromPath('image_name_sale', one!.path));
//     final response1 = await request.send();

//     if (response.statusCode == 200) {
//       print('Image uploaded!');
//     } else {
//       print('Error uploading image: ${response.reasonPhrase}');
//     }

//     // Delete the temporary file
//     await tempFile.delete();
//   }

//   ///////////////Update
//   File? _imageFile_input;
//   late File _imageFile_noinput;
//   late File _imageFile_wait;
//   String? image_na =
//       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/propery_sale/2hh2.jpg';
//   // Future<void> _downloadImage_rent() async {
//   //   final response =
//   //       await http.get(Uri.parse('${widget.list2_Sale12![indexN!]['url']}'));
//   //   final bytes = response.bodyBytes;
//   //   final tempDir = await getTemporaryDirectory();
//   //   final tempFile = File('${tempDir.path}/image.jpg');
//   //   await tempFile.writeAsBytes(bytes);
//   //   setState(() {
//   //     _imageFile_noinput = tempFile;
//   //     print('_imageFile$_imageFile_noinput');
//   //   });
//   // }

//   // Future<File?> _upload_Image_Sale_url_rent(_imageFile_noinput) async {
//   //   if (_imageFile_input == null) {
//   //     _imageFile_wait = _imageFile_noinput;
//   //     // print('No input');
//   //   } else {
//   //     _imageFile_wait = _imageFile_input!;
//   //     // print('Input');
//   //   }
//   //   final url = Uri.parse(
//   //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_post_rent_last/${widget.list2_Sale_id![indexN!]['id_ptys'].toString()}');

//   //   final request = http.MultipartRequest('POST', url);

//   //   request.fields['id_image'] =
//   //       widget.list2_Sale_id![indexN!]['id_ptys'].toString();
//   //   request.fields['hometype'] = requestAutoVerbal_property.hometype.toString();
//   //   request.fields['property_type_id'] =
//   //       requestAutoVerbal_property.property_type_id;

//   //   request.files.add(await http.MultipartFile.fromPath(
//   //       'image_name_rent', _imageFile_wait.path));

//   //   final response = await request.send();

//   //   if (response.statusCode == 200) {
//   //     print('Image uploaded!');
//   //   } else {
//   //     print('Error uploading image: ${response.reasonPhrase}');
//   //   }
//   // }
//   //For Rent**************************************************************

//   // int? dd;
// //https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/images/k800f85a.png
//   // String? image_i;
//   // var get_image = [];
//   // Future<void> getimage() async {
//   //   // var id;

//   //   var rs = await http.get(Uri.parse(
//   //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_image_Sale_last/${widget.list2_Sale_id![indexN!]['id_ptys'].toString()}'));
//   //   if (rs.statusCode == 200) {
//   //     var jsonData = jsonDecode(rs.body);

//   //     setState(() {
//   //       get_image = jsonData;

//   //       dd = get_image.length;
//   //       image_i = get_image[0]['url'];
//   //       print('Image = $image_i');
//   //     });
//   //   }
//   // }
// }
