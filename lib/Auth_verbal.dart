// // ignore_for_file: constant_identifier_names, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_field, prefer_final_fields, avoid_print, no_leading_underscores_for_local_identifiers, await_only_futures, unused_local_variable

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:getwidget/components/animation/gf_animation.dart';
// import 'package:getwidget/types/gf_animation_type.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// // import 'afa/screens/AutoVerbal/search/Model_List.dart';
// import 'api/api_service.dart';
// import 'models/autoVerbal.dart';
// import 'screen/components/test google map/Slliderup_Google_Map.dart';

// typedef OnChangeCallback = void Function(dynamic value);

// class Autoverbal extends StatefulWidget {
//   const Autoverbal({super.key, required this.id});
//   final String id;

//   @override
//   State<Autoverbal> createState() => _AutoverbalState();
// }

// class _AutoverbalState extends State<Autoverbal> {
//   late AnimationController controller;
//   late Animation<Offset> offsetAnimation;
//   late Animation<double> animation;
//   int opt = 0;

//   double asking_price = 1;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String Value = '30';
//   var forceSale = ['10', '20', '30', '40', '50', '0'];
//   late AutoVerbalRequestModel requestModelAuto;
//   // late List code;
//   String valueapp = '';
//   String valueagent = '';
//   bool loading = false;
//   late int codedisplay;
//   late String propertyValue;
//   late String getname;
//   late List name;
//   var district;
//   // bank and branch
//   late List _listbank = [];
//   late List _branch = [];
//   late List _option = [];
//   int id_khan = 0;
//   var code1 = 0;
//   late String bankvalue;
//   late String branchvalue;
//   late List<dynamic> listApprove = [];
//   late List<dynamic> listVerify = [];
//   late List<dynamic> list_Khan;

//   var bank = [
//     'Bank',
//     'Private',
//     'Other',
//   ];
//   late List<dynamic> _list = [];
//   @override
//   void initState() {
//     listApprove;
//     listVerify;
//     Code();
//     // property
//     propertyValue = "";
//     getname = "";
//     name = [];
//     LoadVerify();
//     LoadApprove();
//     Property();
//     // Bank
//     Bank();
//     option();
//     // branch(branchvalue);
//     // branch(branchvalue);
//     bankvalue = "";
//     branchvalue = "";
//     super.initState();
//     requestModelAuto = AutoVerbalRequestModel(
//       property_type_id: "",
//       lat: "",
//       lng: "",
//       address: '',
//       approve_id: "", agent: "",
//       bank_branch_id: "",
//       bank_contact: "",
//       bank_id: "",
//       bank_officer: "",
//       code: "",
//       comment: "",
//       contact: "",
//       date: "",
//       image: "",
//       option: "",
//       owner: "",
//       user: "10",
//       verbal_com: '',
//       verbal_con: "",
//       verbal: [],
//       verbal_id: 0,
//       // autoVerbal: [requestModelVerbal],
//       // data: requestModelVerbal,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kwhite_new,
//       appBar: AppBar(
//         backgroundColor: kwhite_new,
//         centerTitle: true,
//         title: Text(
//           'Autoverbal List',
//           style: TextStyle(fontSize: 22),
//         ),
//         actions: <Widget>[
//           InkWell(
//             onTap: () {
//               setState(() {
//                 uploadt_image(_file!);
//               });
//               requestModelAuto.user = widget.id;
//               requestModelAuto.verbal_id = code1;
//               // requestModelAuto.verbal = lb;
//               if (validateAndSave()) {
//                 APIservice apIservice = APIservice();
//                 apIservice.saveAutoVerbal(requestModelAuto).then(
//                   (value) async {
//                     print('Error');
//                     print(json.encode(requestModelAuto.toJson()));
//                     if (requestModelAuto.verbal.isEmpty) {
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.error,
//                         animType: AnimType.rightSlide,
//                         headerAnimationLoop: false,
//                         title: 'Error',
//                         desc: "Please add Land/Building at least 1!",
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
//               }
//             },
//             child: Container(
//               margin: EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 4),
//               decoration: BoxDecoration(
//                 color: Colors.lightGreen[700],
//                 boxShadow: [BoxShadow(color: Colors.green, blurRadius: 5)],
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(80),
//                   bottomLeft: Radius.circular(80),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("Submit"),
//                   Icon(Icons.save_alt_outlined),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Container(
//                     width: 10,
//                     height: 20,
//                     alignment: Alignment.topRight,
//                     color: Colors.red[700],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: SingleChildScrollView(
//             child: Form(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, top: 30),
//                 child: Container(
//                   alignment: Alignment.topLeft,
//                   child: loading
//                       ? Center(child: CircularProgressIndicator())
//                       : //if loading == true, show progress indicator
//                       Row(
//                           children: [
//                             SizedBox(width: 30),
//                             Icon(
//                               Icons.qr_code,
//                               color: IconColor,
//                               size: 30,
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               codedisplay.toString(),
//                               style: TextStyle(
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.bold,
//                                   color: TextInBorder),
//                             ),
//                           ],
//                         ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ///////// Property
//               Container(
//                 height: 55,
//                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: DropdownButtonFormField<String>(
//                   isExpanded: true,
//                   //value: genderValue,
//                   onChanged: (newValue) {
//                     setState(() {
//                       propertyValue = newValue as String;
//                       // widget.name(newValue.split(" ")[1]);
//                       // widget.id(newValue.split(" ")[0]);
//                       // ignore: avoid_print
//                       // print(newValue.split(" ")[0]);
//                       // print(newValue.split(" ")[1]);
//                     });
//                   },

//                   items: _list
//                       .map<DropdownMenuItem<String>>(
//                         (value) => DropdownMenuItem<String>(
//                           value: value["property_type_id"].toString() +
//                               " " +
//                               value["property_type_name"],
//                           child: Text(
//                             value["property_type_name"],
//                             style: TextStyle(
//                                 fontSize:
//                                     MediaQuery.of(context).textScaleFactor *
//                                         12),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                   icon: Icon(
//                     Icons.arrow_drop_down,
//                     color: IconColor,
//                     size: 20,
//                   ),

//                   decoration: InputDecoration(
//                     fillColor: InputText,
//                     filled: true,
//                     labelText: 'Property',
//                     hintText: 'Select one',
//                     prefixIcon: Icon(
//                       Icons.business_outlined,
//                       color: IconColor,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: kwhite_new, width: 2.0),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: borderColor,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//               ),

//               // bank
//               SizedBox(
//                 height: 10,
//               ),
//               // Bank
//               Container(
//                 height: 55,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: DropdownButtonFormField<String>(
//                   isExpanded: true,
//                   onChanged: (newValue) {
//                     setState(() {
//                       bankvalue = newValue as String;
//                       // widget.bank(bankvalue);
//                       branch(newValue.toString());
//                       // branch(newValue.toString());
//                       // print(newValue);
//                     });
//                   },
//                   validator: (String? value) {
//                     if (value?.isEmpty ?? true) {
//                       return 'Please select bank';
//                     }
//                     return null;
//                   },

//                   items: _listbank
//                       .map<DropdownMenuItem<String>>(
//                         (value) => DropdownMenuItem<String>(
//                           value: value["bank_id"].toString(),
//                           child: Text(
//                             value["bank_name"],
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize:
//                                     MediaQuery.of(context).textScaleFactor *
//                                         12),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                   // add extra sugar..
//                   icon: Icon(
//                     Icons.arrow_drop_down,
//                     color: IconColor,
//                   ),

//                   decoration: InputDecoration(
//                     fillColor: InputText,
//                     filled: true,

//                     labelText: 'Bank',
//                     hintText: 'Select',

//                     prefixIcon: Icon(
//                       Icons.home_work,
//                       color: IconColor,
//                       size: 20,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: kwhite_new, width: 2.0),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: borderColor,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: Error,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: Error,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     //   decoration: InputDecoration(
//                     //       labelText: 'From',
//                     //       prefixIcon: Icon(Icons.business_outlined)),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               // Branch
//               Container(
//                 height: 55,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: DropdownButtonFormField<String>(
//                   isExpanded: true,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       branchvalue = newValue!;

//                       // branch(newValue.toString());
//                     });
//                   },
//                   items: _branch
//                       .map<DropdownMenuItem<String>>(
//                         (value) => DropdownMenuItem<String>(
//                           value: value["bank_branch_id"].toString(),
//                           child: Text(
//                             value["bank_branch_name"],
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize:
//                                     MediaQuery.of(context).textScaleFactor *
//                                         12),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                   // add extra sugar..
//                   icon: Icon(
//                     Icons.arrow_drop_down,
//                     color: IconColor,
//                   ),
//                   decoration: InputDecoration(
//                     fillColor: InputText,
//                     filled: true,
//                     labelText: 'Branch',
//                     hintText: 'Select',

//                     prefixIcon: Icon(
//                       Icons.account_tree_rounded,
//                       size: 20,
//                       color: IconColor,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: kwhite_new, width: 2.0),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 1,
//                         color: borderColor,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     //   decoration: InputDecoration(
//                     //       labelText: 'From',
//                     //       prefixIcon: Icon(Icons.business_outlined)),
//                   ),
//                   // Bank Officer
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               // bank office and contact
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 55,
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         child: TextFormField(
//                           style: TextStyle(
//                               fontSize:
//                                   MediaQuery.of(context).textScaleFactor * 12),
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [],
//                           onChanged: (newValue) {
//                             requestModelAuto.bank_officer = newValue;
//                           },
//                           decoration: InputDecoration(
//                             fillColor: InputText,
//                             filled: true,
//                             labelText: 'Bank Officer',
//                             prefixIcon: Icon(
//                               Icons.work,
//                               color: IconColor,
//                               size: 20,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kwhite_new, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: borderColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         child: TextFormField(
//                           style: TextStyle(
//                               fontSize:
//                                   MediaQuery.of(context).textScaleFactor * 12),
//                           //controller: email,
//                           onSaved: (newValue) {
//                             // requestModelAuto.bank_contact = newValue!;
//                           },
//                           decoration: InputDecoration(
//                             fillColor: InputText,
//                             filled: true,
//                             labelText: 'Contact',
//                             prefixIcon: Icon(
//                               Icons.people,
//                               color: IconColor,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kwhite_new, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: borderColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5.0,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               // valuetion fee and  Force Sale
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: SizedBox(
//                         height: 55,
//                         child: TextFormField(
//                           style: TextStyle(
//                               fontSize:
//                                   MediaQuery.of(context).textScaleFactor * 12),
//                           // controller: controller,
//                           onSaved: (newValue) {},
//                           decoration: InputDecoration(
//                             fillColor: InputText,
//                             filled: true,
//                             labelText: 'Valuation Fee',
//                             prefixIcon: Icon(
//                               Icons.monetization_on,
//                               size: 20,
//                               color: IconColor,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kwhite_new, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: borderColor,
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5.0,
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: 55,
//                       padding: EdgeInsets.only(right: 10),
//                       child: DropdownButtonFormField<String>(
//                         style: TextStyle(
//                             fontSize:
//                                 MediaQuery.of(context).textScaleFactor * 12),
//                         //value: genderValue,
//                         value: Value,
//                         isExpanded: true,

//                         onChanged: (String? newValue) {
//                           setState(() {
//                             Value = newValue!;

//                             // requestModelAuto.verbal_con = newValue;

//                             print('Force = $Value');
//                           });
//                         },
//                         items: forceSale
//                             .map<DropdownMenuItem<String>>(
//                               (String value) => DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(
//                                   value,
//                                   style: TextStyle(
//                                       fontSize: MediaQuery.of(context)
//                                               .textScaleFactor *
//                                           12,
//                                       color: TextInBorder),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                         // add extra sugar..
//                         icon: Icon(
//                           Icons.arrow_drop_down,
//                           color: IconColor,
//                         ),

//                         decoration: InputDecoration(
//                           fillColor: InputText,
//                           filled: true,
//                           labelText: 'Force Sale',
//                           hintText: 'Select one',
//                           prefixIcon: Icon(
//                             Icons.attach_money_rounded,
//                             color: IconColor,
//                             size: 20,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: kwhite_new, width: 2.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: borderColor,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
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
//               // Option Type and Comment
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 55,
//                       padding: EdgeInsets.only(left: 10),
//                       child: DropdownButtonFormField<String>(
//                         style: TextStyle(
//                             fontSize:
//                                 MediaQuery.of(context).textScaleFactor * 12),
//                         //value: genderValue,
//                         isExpanded: true,
//                         onChanged: (String? newValue) {
//                           // Value = newValue!;
//                         },

//                         items: _option
//                             .map<DropdownMenuItem<String>>(
//                               (value) => DropdownMenuItem<String>(
//                                 value:
//                                     value["opt_value"] + " " + value["opt_id"],
//                                 child: Text(
//                                   value["opt_des"],
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                                 onTap: () {
//                                   // widget.opt_type_id(value["opt_value"]);
//                                 },
//                               ),
//                             )
//                             .toList(),
//                         // add extra sugar..
//                         icon: Icon(
//                           Icons.arrow_drop_down,
//                           color: IconColor,
//                         ),

//                         decoration: InputDecoration(
//                           fillColor: InputText,
//                           filled: true,
//                           labelText: 'OptionType',
//                           hintText: 'Select one',
//                           prefixIcon: Icon(
//                             Icons.my_library_books_rounded,
//                             color: IconColor,
//                             size: 20,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: kwhite_new, width: 2.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: borderColor,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.0,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: SizedBox(
//                         height: 55,
//                         child: TextFormField(
//                           // controller: controller,
//                           onSaved: (newValue) {},
//                           decoration: InputDecoration(
//                             fillColor: InputText,
//                             filled: true,
//                             labelText: 'Comment',
//                             prefixIcon: Icon(
//                               Icons.comment,
//                               color: IconColor,
//                               size: 20,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: kwhite_new, width: 2.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 1,
//                                 color: borderColor,
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
//               // Verify and Approve by
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 55,
//                       padding: EdgeInsets.only(left: 10),
//                       child: DropdownButtonFormField<String>(
//                         style: TextStyle(
//                             fontSize:
//                                 MediaQuery.of(context).textScaleFactor * 12),
//                         //value: genderValue,
//                         isExpanded: true,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             valueagent = newValue!;

//                             print(newValue);
//                           });
//                         },

//                         items: listVerify
//                             .map<DropdownMenuItem<String>>(
//                               (value) => DropdownMenuItem<String>(
//                                 value: value["agenttype_id"],
//                                 child: Text(
//                                   value["agenttype_name"],
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                         // add extra sugar..
//                         icon: Icon(
//                           Icons.arrow_drop_down,
//                           size: 20,
//                           color: IconColor,
//                         ),

//                         decoration: InputDecoration(
//                           fillColor: InputText,
//                           filled: true,
//                           labelText: 'Verify by',
//                           hintText: 'Select one',
//                           prefixIcon: Icon(
//                             Icons.my_library_books_rounded,
//                             color: IconColor,
//                             size: 20,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: kwhite_new, width: 2.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: borderColor,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.0,
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: 55,
//                       padding: EdgeInsets.only(right: 10),
//                       child: DropdownButtonFormField<String>(
//                         style: TextStyle(
//                             fontSize:
//                                 MediaQuery.of(context).textScaleFactor * 12),
//                         //value: genderValue,
//                         isExpanded: true,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             valueapp = newValue!;

//                             print(newValue);
//                           });
//                         },

//                         items: listApprove
//                             .map<DropdownMenuItem<String>>(
//                               (value) => DropdownMenuItem<String>(
//                                 value: value["approve_id"],
//                                 child: Text(
//                                   value["approve_name"],
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                         // add extra sugar..
//                         icon: Icon(
//                           Icons.arrow_drop_down,
//                           color: IconColor,
//                         ),

//                         decoration: InputDecoration(
//                           fillColor: InputText,
//                           filled: true,
//                           labelText: 'Approve by',
//                           hintText: 'Select one',
//                           prefixIcon: Icon(
//                             Icons.my_library_books_rounded,
//                             color: IconColor,
//                             size: 20,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: kwhite_new, width: 2.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: borderColor,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
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
//               // address
//               Padding(
//                 padding: const EdgeInsets.only(right: 10, left: 10),
//                 child: SizedBox(
//                   height: 55,
//                   child: TextFormField(
//                     // controller: controller,
//                     onSaved: (newValue) {},
//                     decoration: InputDecoration(
//                       fillColor: InputText,
//                       filled: true,
//                       labelText: 'address',
//                       prefixIcon: Icon(
//                         Icons.location_on_rounded,
//                         color: IconColor,
//                         size: 25,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(color: kwhite_new, width: 2.0),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: borderColor,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               // location map
//               TextButton(
//                 onPressed: () {
//                   SlideUp(context);
//                 },
//                 child: FractionallySizedBox(
//                   widthFactor: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 2, right: 2),
//                     child: Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           width: 1,
//                           color: borderColor,
//                         ),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       // padding: EdgeInsets.only(left: 30, right: 30),
//                       child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Row(
//                             children: [
//                               SizedBox(width: 10),
//                               Icon(
//                                 Icons.map_sharp,
//                                 color: IconColor,
//                               ),
//                               SizedBox(width: 10),
//                               Text(
//                                 (asking_price == 1)
//                                     ? 'Choose Location'
//                                     : 'Choosed Location',
//                                 style: TextStyle(color: TextInBorder),
//                               ),
//                             ],
//                           )),
//                     ),
//                   ),
//                 ),
//               ),
//               SingleChildScrollView(
//                 child: Column(children: [
//                   imagepath != "" ? Image.file(File(imagepath)) : SizedBox(),
//                   imagepath == ""
//                       ? TextButton(
//                           onPressed: () {
//                             openImage();
//                           },
//                           child: FractionallySizedBox(
//                             widthFactor: 1,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 2, right: 2),
//                               child: Container(
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     width: 1,
//                                     color: borderColor,
//                                   ),
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(10),
//                                   ),
//                                 ),
//                                 // padding: EdgeInsets.only(left: 30, right: 30),
//                                 child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Row(
//                                       // ignore: prefer_const_literals_to_create_immutables
//                                       children: [
//                                         SizedBox(width: 10),
//                                         Icon(
//                                           Icons.map_sharp,
//                                           color: IconColor,
//                                         ),
//                                         SizedBox(width: 10),
//                                         // ignore: unnecessary_null_comparison
//                                         Text(
//                                           (imagepath == "")
//                                               ? 'Choose Photo'
//                                               : 'choosed Photo',
//                                           style: TextStyle(color: TextInBorder),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ),
//                         )
//                       : SizedBox(),
//                 ]),
//               ),

//               if (id_khan != 0)
//                 InkWell(
//                   onTap: () {
//                     // _asyncInputDialog(context);
//                     // ++i;
//                   },
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.6,
//                     height: 40,
//                     decoration: BoxDecoration(
//                         border: Border(),
//                         boxShadow: [
//                           BoxShadow(
//                               blurRadius: 2,
//                               color: Color.fromARGB(160, 0, 0, 0),
//                               offset: Offset(0, 1.5))
//                         ],
//                         color: Colors.lightBlueAccent[700],
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Text("land~Building"),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.3,
//                           child: DefaultTextStyle(
//                             style: const TextStyle(
//                               fontSize: 18.0,
//                               fontFamily: 'Horizon',
//                               fontWeight: FontWeight.bold,
//                             ),
//                             child: AnimatedTextKit(
//                               animatedTexts: [
//                                 RotateAnimatedText('land'),
//                                 RotateAnimatedText('Building'),
//                               ],
//                               pause: const Duration(milliseconds: 100),
//                               repeatForever: true,
//                             ),
//                           ),
//                         ),
//                         GFAnimation(
//                           controller: controller,
//                           slidePosition: offsetAnimation,
//                           type: GFAnimationType.slideTransition,
//                           child: Icon(
//                             Icons.add_circle_outline,
//                             color: Colors.white,
//                             size: 30,
//                             shadows: [
//                               Shadow(blurRadius: 5, color: Colors.black)
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // icon: Icon(
//                   //   Icons.add_circle_outline,
//                   //   color: Colors.white,
//                   // ),
//                 ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }

//   XFile? _file;
//   late List code;
//   void Code() async {
//     setState(() {
//       loading = true; //make loading true to show progressindicator
//     });
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal?verbal_published=0'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         loading = false;
//         code = jsonData;
//         codedisplay = int.parse(code[0]['verbal_id']) + 1;
//         // ignore: avoid_print
//         print(code[0]['verbal_id']);
//         // widget.code(codedisplay);
//         // ignore: avoid_print
//         print(codedisplay);

//         // print(_list);
//       });
//       // print(list.length);
//     }
//   }

//   void Property() async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         _list = jsonData['property'];

//         //print(_list);
//       });
//     }
//   }

//   void Bank() async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       // print(jsonData);
//       // print(jsonData);

//       setState(() {
//         _listbank = jsonData['banks'];
//         print('');
//       });
//     }
//   }

//   void branch(String value) async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_details_id=' +
//             value));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body.toString());
//       // print(jsonData);
//       setState(() {
//         _branch = jsonData['bank_branches'];
//       });
//     }
//   }

//   void option() async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         _option = jsonData;

//         // print(_list);
//       });
//     }
//   }

//   void LoadVerify() async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verify_by?agenttype_published=0'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         listVerify = jsonData;
//         //print(_list);
//       });
//     }
//   }

//   void LoadApprove() async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/approve?approve_published=0'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         listApprove = jsonData;
//         // print(_list);
//       });
//     }
//   }

//   var dropdown;
//   String? options;
//   String? commune;
//   Future<void> SlideUp(BuildContext context) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Google_map_verbal(latitude: double.parse(widget.), longitude: longitude),
//         // builder: (context) => HomePage(
//         //   c_id: code.toString(),
//         //   district: (value) {
//         //     setState(() {
//         //       district = value;
//         //       Load_khan(district);
//         //     });
//         //   },
//         //   commune: (value) {
//         //     setState(() {
//         //       commune = value;
//         //       Load_sangkat(value);
//         //     });
//         //   },
//         //   lat: (value) {
//         //     setState(() {
//         //       print("Value of lat = ${value}");
//         //       requestModelAuto.lat = value;
//         //     });
//         //   },
//         //   log: (value) {
//         //     setState(() {
//         //       requestModelAuto.lng = value;
//         //     });
//         //   },
//         //   province: (value) {},
//         // ),
//       ),
//     );
//     setState(() {
//       requestModelAuto.image = code.toString();
//     });
//     if (!mounted) return;
//     // asking_price = result[0]['adding_price'];
//     // address = result[0]['address'];
//     // requestModelAuto.lat = result[0]['lat'];
//     // requestModelAuto.lng = result[0]['lng'];
//   }

//   void Load_khan(String district) async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         list_Khan = jsonData;
//         id_khan = int.parse(list_Khan[0]['Khan_ID']);
//       });
//     }
//   }

//   var id_Sangkat;
//   List<dynamic> list_sangkat = [];
//   void Load_sangkat(String id) async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${id}'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         list_sangkat = jsonData;
//         id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID']);
//       });
//     }
//   }

//   //===================== Upload Image to MySql Server
//   late File _image;
//   final picker = ImagePicker();
//   late String base64string;
//   // late File _file;
//   final ImagePicker imgpicker = ImagePicker();
//   String imagepath = "";
//   openImage() async {
//     try {
//       var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
//       //you can use ImageCourse.camera for Camera capture
//       if (pickedFile != null) {
//         imagepath = pickedFile.path;
//         print(imagepath);
//         //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg
//         File imagefile = File(imagepath); //convert Path to File
//         // saveAutoVerbal(imagefile);
//         Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
//         String base64string =
//             base64.encode(imagebytes); //convert bytes to base64 string
//         Uint8List decodedbytes = base64.decode(base64string);
//         //decode base64 stirng to bytes
//         setState(() {
//           _file = imagefile as XFile?;
//         });
//       } else {
//         print("No image is selected.");
//       }
//     } catch (e) {
//       print("error while picking file.");
//     }
//   }

//   Future<dynamic> uploadt_image(XFile _image) async {
//     var request = await http.MultipartRequest(
//         "POST",
//         Uri.parse(
//             "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image"));
//     Map<String, String> headers = {
//       "content-type": "application/json",
//       "Connection": "keep-alive",
//       "Accept-Encoding": " gzip"
//     };
//     request.headers.addAll(headers);
//     // request.files.add(picture);
//     request.fields['cid'] = code.toString();
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         "image",
//         _image.path,
//       ),
//     );
//     var response = await request.send();
//     var responseData = await response.stream.toBytes();
//     var result = String.fromCharCodes(responseData);
//     print(result);
//   }

//   bool validateAndSave() {
//     final form = _formKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   int i = 0;
//   // Future _asyncInputDialog(BuildContext context) async {
//   //   return showDialog(
//   //     context: context,
//   //     useSafeArea: false,
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         scrollable: true,
//   //         insetPadding:
//   //             EdgeInsets.only(top: 30, left: 10, right: 1, bottom: 20),
//   //         content: SingleChildScrollView(
//   //           child: Container(
//   //             width: MediaQuery.of(context).size.width * 1,
//   //             child: LandBuilding(
//   //               ID_khan: id_khan.toString(),
//   //               // asking_price: asking_price,
//   //               opt: opt,
//   //               address: '${commune} / ${district}',
//   //               list: (value) {
//   //                 setState(() {
//   //                   requestModelAuto.verbal = value;
//   //                 });
//   //               },
//   //               landId: code.toString(),
//   //               Avt: (value) {
//   //                 a = value;
//   //                 setState(() {});
//   //               },
//   //               // opt_type_id: opt_type_id,
//   //               check_property: 1,
//   //               list_lb: (value) {
//   //                 setState(() {
//   //                   // lb.addAll(value!);
//   //                 });
//   //               },
//   //               ID_sangkat: id_Sangkat.toString(),
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
// }

// const TextInBorder = Color.fromARGB(235, 25, 26, 25);
// const InputText = Color.fromARGB(235, 249, 253, 253);
// const borderColor = Color.fromARGB(235, 21, 165, 231);
// const kwhite_new = Color.fromARGB(235, 8, 11, 161);
// const Stylefont = TextStyle(fontSize: 16);
// const IconColor = Color.fromARGB(235, 88, 182, 11);
// const Error = Color.fromARGB(235, 218, 24, 17);
