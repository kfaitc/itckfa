// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, avoid_print, unused_field, prefer_final_fields, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, equal_keys_in_map, unrelated_type_equality_checks, body_might_complete_normally_nullable, unused_element, await_only_futures, unnecessary_string_interpolations, unnecessary_cast, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_is_empty, unnecessary_null_comparison, unused_local_variable, unused_catch_clause, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:itckfa/Pov_Test/map_in_add_verbal.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../contants.dart';
import '../Getx_api/vetbal_controller.dart';
import '../propertys/api_property/api.dart';
import '../Model/Autho_verbal.dart';

typedef OnChangeCallback = void Function(dynamic value);

// ignore: must_be_immutable
class Add_verbal_property extends StatefulWidget {
  Add_verbal_property({super.key, required this.refresh_homeScreen});
  OnChangeCallback? refresh_homeScreen;

  @override
  State<Add_verbal_property> createState() => _Add_verbal_saleState();
}

class _Add_verbal_saleState extends State<Add_verbal_property> {
  String? provice;
  late AutoVerbal_property_a requestAutoVerbal_property;
  final List<String> _items_2 = [
    'For Sale',
    'For Rent',
  ];

  int? index_Sale;
  int? index_Rent;
  late String branchvalue;
  bool _isLoading = true;
  var _items = [];
  var last_verbal_id;
  @override
  void initState() {
    _initData();
    super.initState();
    requestAutoVerbal_property = AutoVerbal_property_a(
      id_ptys: "",
      hometype: '',
      property_type_id: "",
      price: "",
      land: "",
      sqm: "",
      bath: "",
      address: "",
      type: "",
      bed: '',
      description: '',
      title: '',
    );
  }

  int? hometype_api_index;
  String? hometype11;
  bool? index12 = true;

  var khan;
  var songkat;
  var provice_map;
  Future<void> _initData() async {
    await Future.wait([
      controller_verbal.verbal_last_ID(),
      controller_verbal.verbal_Hometype(),
      controller_verbal.verbal_Commune_25_all(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  var controller_verbal = Controller_verbal();
  bool switchValue = false;
  String _switchValue = 'Switch';
  bool way = false;
  TextEditingController address1 = TextEditingController();
  String? price;
  String? sqm;
  var bed;
  var bath;
  String? type;
  String? land;
  var address;
  var id_ptys;
  String urgent = 'N/A';
  String? get_re = '202301';
  String? await_functino;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Verbal Property'),
          backgroundColor: Color.fromARGB(255, 20, 20, 163),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              onTap: () async {
                setState(() {
                  address = '${khan} / ${provice_map}';
                  type;

                  // print('type =$type');
                  urgent;
                  // print('urgent : $urgent');
                });
                requestAutoVerbal_property.id_ptys =
                    controller_verbal.id_last.toString();
                requestAutoVerbal_property.address = address.toString();
                requestAutoVerbal_property.type = type.toString();
                if (type == 'For Sale' &&
                    _imageFile != null &&
                    _images.length == 2 &&
                    lat != null) {
                  APi_property apIservice = APi_property();
                  apIservice
                      .saveAuto_property_Sale(requestAutoVerbal_property)
                      .then(
                    (value) async {
                      setState(() {
                        await_functino = '1';
                      });
                      await _uploadImageSaleMultiple();
                      await _upload_Image_Sale();
                      setState(() {
                        latlog_Sale();
                        Post_verbalid();
                        urgent_Sale();
                      });

                      // print(
                      //     'value Post = ${json.encode(requestAutoVerbal_property.toJson())}');
                      if (requestAutoVerbal_property.id_ptys.isEmpty) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: "Please check ",
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
                                setState(() {
                                  get_re;
                                  widget.refresh_homeScreen!(get_re);
                                });
                                Navigator.pop(context);
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
                } else if (type == 'For Rent' &&
                    _imageFile != null &&
                    _images.length == 2 &&
                    lat != null) {
                  APi_property apIservice = APi_property();
                  apIservice
                      .saveAuto_property_Rent(requestAutoVerbal_property)
                      .then(
                    (value) async {
                      setState(() {
                        await_functino = '1';
                      });
                      await _uploadImageRentMultiple();
                      await _uploadImage_Rent();
                      setState(() {
                        latlog_Rent();
                        Post_verbalid();
                        urgent_Rent();
                      });
                      // print(
                      //     'value Post = ${json.encode(requestAutoVerbal_property.toJson())}');
                      if (requestAutoVerbal_property.id_ptys.isEmpty) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: "Please Check more for Input",
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
                                setState(() {
                                  get_re;
                                  widget.refresh_homeScreen!(get_re);
                                });
                                Navigator.pop(context);
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
                } else {
                  setState(() {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: false,
                      title: 'Please Check Your Information',
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.cancel,
                      btnOkColor: Colors.red,
                    ).show();
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 80,
                decoration: BoxDecoration(
                    color: kImageColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        // body: Column(
        //   children: [
        //     Text(
        //         '${controller_verbal.list_last_verbalID[0]['id_ptys'].toString()}'),
        //   ],
        // ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (await_functino != '1')
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     TextButton(
                          //         onPressed: () async {
                          //           _uploadImage_Rent();
                          //           // _upload_Image_Sale();
                          //           // _uploadImageSaleMultiple();
                          //         },
                          //         child: Text('Post')),
                          //     // TextButton(
                          //     //     onPressed: () {
                          //     //       controller_verbal.verbal_last_ID();
                          //     //     },
                          //     //     child: Text('Get')),
                          //   ],
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 67, 20, 175),
                                    // border: Border.all(width: 2),
                                  ),
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    'Code : ${controller_verbal.id_last.toString()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 43, 131, 11),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Switch(
                                        autofocus: false,
                                        activeColor:
                                            Color.fromARGB(255, 253, 253, 253),
                                        value: switchValue,
                                        onChanged: (value) {
                                          setState(() {
                                            switchValue = value;
                                            if (value == true) {
                                              urgent = 'Urgent';
                                            } else {
                                              urgent = 'N/A';
                                            }
                                            print(switchValue);
                                          });
                                        },
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 60,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 67, 20, 175),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          '$urgent',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_imageFile != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Image.file(
                                _imageFile!,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: InkWell(
                              onTap: _getImage,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color.fromARGB(255, 47, 22, 157)),
                                child: Text(
                                  'Select Image',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (_images.length != 0)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: double.infinity,
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      children: List.generate(_images.length,
                                          (index) {
                                        return Image.file(
                                          _images[index],
                                          fit: BoxFit.cover,
                                        );
                                      }),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: InkWell(
                              onTap: pickImages,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color.fromARGB(255, 47, 22, 157)),
                                child: Text(
                                  'Mutiple Image',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                newValue!;
                                requestAutoVerbal_property.hometype = newValue;
                                hometype11 = newValue;
                                setState(() {
                                  // print('newValue = $type_select');
                                  // provice = newValue as String;
                                  // print('provice id = $provice');
                                });
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select bank';
                                }
                                return null;
                              },
                              items: controller_verbal.list_hometype
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["hometype"],
                                      child: Text(
                                        value['hometype'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    13,
                                            height: 1),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              // add extra sugar..
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),
                              //property_type_id
                              decoration: InputDecoration(
                                fillColor: kwhite,
                                filled: true,
                                labelText: 'HomeType',
                                hintText: 'Select',
                                prefixIcon: Icon(
                                  Icons.home_outlined,
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
                          SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                requestAutoVerbal_property.property_type_id =
                                    newValue!;

                                setState(() {
                                  provice = newValue as String;
                                  // print('provice id = $provice');
                                });
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select bank';
                                }
                                return null;
                              },
                              items: controller_verbal.list_cummone
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value:
                                          value["property_type_id"].toString(),
                                      child: Text(
                                        value["Name_cummune"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    13,
                                            height: 1),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              // add extra sugar..
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),
                              //property_type_id
                              decoration: InputDecoration(
                                fillColor: kwhite,
                                filled: true,
                                labelText: 'Province',
                                hintText: 'Select',
                                prefixIcon: Icon(
                                  Icons.home_work,
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
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        requestAutoVerbal_property.price =
                                            value;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.price_change_outlined,
                                          color: kImageColor,
                                        ),
                                        hintText: 'price',
                                        fillColor: kwhite,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        requestAutoVerbal_property.sqm =
                                            double.parse(value)
                                                .toStringAsFixed(5);

                                        // setState(() {
                                        //   sqm =
                                        //       double.parse(value).toStringAsFixed(5);
                                        // });
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.square_foot_outlined,
                                          color: kImageColor,
                                        ),
                                        fillColor: kwhite,
                                        hintText: 'sqm',
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        requestAutoVerbal_property.bed = value;
                                        // setState(() {
                                        //   bed = int.parse(value);
                                        // });
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.bed_outlined,
                                          color: kImageColor,
                                        ),
                                        hintText: 'bed',
                                        fillColor: kwhite,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        requestAutoVerbal_property.bath = value;
                                        // setState(() {
                                        //   bath = int.parse(value);
                                        // });
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.bathtub_outlined,
                                          color: kImageColor,
                                        ),
                                        fillColor: kwhite,
                                        hintText: 'bath',
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      onChanged: (newValue) {
                                        requestAutoVerbal_property.type =
                                            newValue!;
                                        setState(() {
                                          type = newValue;
                                          type;
                                          // print(type);
                                        });
                                        if (type == 'For Sale') {
                                          // print('$index_Sale');
                                          // print('$type');
                                          index_Sale =
                                              _items_2.indexOf('For Sale');
                                        } else if (type == 'For Rent') {
                                          index_Rent =
                                              _items_2.indexOf('For Rent');
                                          // print('$type');
                                          // print('$index_Rent');
                                        }
                                      },
                                      validator: (String? value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please select bank';
                                        }
                                        return null;
                                      },
                                      items: _items_2
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        13,
                                                    height: 1),
                                              ),
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
                                        labelText: 'Type',
                                        hintText: 'Select',

                                        prefixIcon: Icon(
                                          Icons.home_work,
                                          color: kImageColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kerror,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: kerror,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        //   decoration: InputDecoration(
                                        //       labelText: 'From',
                                        //       prefixIcon: Icon(Icons.business_outlined)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        requestAutoVerbal_property.land = value;
                                        // setState(() {
                                        //   land =
                                        //       double.parse(value).toStringAsFixed(5);
                                        // });
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.landscape_outlined,
                                          color: kImageColor,
                                        ),
                                        fillColor: kwhite,
                                        hintText: 'land',
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(Map_verbal_address_Sale(
                                  get_province: (value) {
                                    setState(() {
                                      songkat = value.toString();
                                    });
                                  },
                                  get_district: (value) {
                                    setState(() {
                                      provice_map = value.toString();
                                    });
                                  },
                                  get_commune: (value) {
                                    setState(() {
                                      khan = value.toString();
                                    });
                                  },
                                  get_log: (value) {
                                    setState(() {
                                      log = value.toString();
                                    });
                                  },
                                  get_lat: (value) {
                                    lat = value.toString();
                                  },
                                ));
                              },
                              child: (khan != null || songkat != null)
                                  ? Container(
                                      height: 65,
                                      margin:
                                          EdgeInsets.only(right: 10, left: 10),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_city_outlined,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 40, 164, 45),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Text(
                                          //   '${songkat} ',
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 12),
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${khan}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '/ ${provice_map}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 65,
                                      margin:
                                          EdgeInsets.only(right: 10, left: 10),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_city_outlined,
                                            size: 30,
                                            color: kImageColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'address',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                requestAutoVerbal_property.title = value;
                              },
                              maxLines: 3,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Title',
                              ),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                requestAutoVerbal_property.description = value;
                              },
                              maxLines: 3,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Description',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox());
  }

  Future<void> Post_verbalid() async {
    Map<String, int> payload = {
      'id_ptys': int.parse(controller_verbal.id_last.toString()),
      'property': 0,
    };

    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/post_id_sale_last');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('success');
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  File? _imageFile;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
      });
    }
  }

// For Sale***************************************************************
  Future<File?> _upload_Image_Sale() async {
    if (_imageFile == null) {
      return _imageFile;
    }

    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_post');

    final request = http.MultipartRequest('POST', url);
    request.fields['id_image'] = controller_verbal.id_last.toString();
    request.fields['hometype'] = hometype11.toString();
    request.fields['property_type_id'] = provice.toString();
    if (_imageFile != null) {
      String targetPath = '${_imageFile!.path}_compressed.jpg';

      try {
        File? compressedFile =
            await testCompressAndGetFile(_imageFile!, targetPath);

        setState(() {
          _compressedImage_only = compressedFile;
        });
      } catch (e) {
        print('Error compressing image: $e');
      }
    }
    request.files.add(await http.MultipartFile.fromPath(
        'image_name_sale', _compressedImage_only!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded!');
    } else {
      print('Error uploading image: ${response.reasonPhrase}');
    }
  }

  List<File> _images = [];
  Future<void> pickImages() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
      );
    } on Exception catch (e) {
      // Handle exception
    }
    // setState(() {
    //   _images;
    // });

    List<File> files = [];
    for (var asset in resultList) {
      ByteData byteData = await asset.getByteData();
      final tempDir = await getTemporaryDirectory();

      final file = File('${tempDir.path}/${asset.name}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      files.add(file);
    }

    setState(() {
      _images = files;
    });
  }

  Future<File?> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 88,
      rotate: 180,
      autoCorrectionAngle: false,
      keepExif: true,
    );

    // Reverse the image horizontally
    if (result != null) {
      var image = img.decodeImage(result.readAsBytesSync());
      // var reversedImage = img.flipHorizontal(image!);
      var reversedImage = img.flipHorizontalVertical(image!);
      result.writeAsBytesSync(img.encodeJpg(reversedImage));
    }
    return result;
  }

  String? lat, log;
  void latlog_Sale() async {
    Map<String, dynamic> payload = await {
      'id_ptys': controller_verbal.id_last.toString(),
      'property_type_id': int.parse(provice.toString()),
      'lat': lat.toString(),
      'log': log.toString(),
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/lat_log_post');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success latlog');
    } else {
      print('Error Latlog: ${response.reasonPhrase}');
    }
  }

  // Tomorrow make compress image in _uploadImageSaleMultiple
  File? _compressedImage;
  File? _compressedImages;
  File? _compressedImage_only;
  File? result;
  Future<void> _uploadImageSaleMultiple() async {
    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mutiple_image_post');

    final request = http.MultipartRequest('POST', url);
    request.fields['id_ptys'] = controller_verbal.id_last.toString();
    request.fields['property_type_id'] = provice.toString();
    if (_images != null) {
      String targetPath = '${_images[0].path}_compressed.jpg';
      String targetPaths = '${_images[1].path}_compressed.jpg';

      try {
        File? compressedFile =
            await testCompressAndGetFile(_images[0], targetPath);
        File? compressedFiles =
            await testCompressAndGetFile(_images[1], targetPaths);

        setState(() {
          _compressedImage = compressedFile;
          _compressedImages = compressedFiles;
        });
      } catch (e) {
        print('Error compressing image: $e');
      }
    }

    request.files.add(
        await http.MultipartFile.fromPath('image', _compressedImage!.path));
    request.files.add(
        await http.MultipartFile.fromPath('images', _compressedImages!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded! ');
    } else {
      print('Error uploading image: ${response.reasonPhrase} ');
    }
  }

  void urgent_Sale() async {
    print('Post_Sale');

    Map<String, dynamic> payload = await {
      'id_ptys': controller_verbal.id_last.toString(),
      'property_type_id': int.parse(provice.toString()),
      'hometype': hometype11.toString(),
      'urgent': urgent.toString(),
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgent_Post');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success urgent_Sale');
    } else {
      print('Error Rent: ${response.reasonPhrase}');
    }
  }

  //For Rent**************************************************************
  Future<void> _uploadImageRentMultiple() async {
    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mutiple_imageR_post');

    final request = http.MultipartRequest('POST', url);
    request.fields['id_ptys'] = controller_verbal.id_last.toString();
    request.fields['property_type_id'] = provice.toString();
    if (_images != null) {
      String targetPath = '${_images[0].path}_compressed.jpg';
      String targetPaths = '${_images[1].path}_compressed.jpg';

      try {
        File? compressedFile =
            await testCompressAndGetFile(_images[0], targetPath);
        File? compressedFiles =
            await testCompressAndGetFile(_images[1], targetPaths);

        setState(() {
          _compressedImage = compressedFile;
          _compressedImages = compressedFiles;
        });
      } catch (e) {
        print('Error compressing image: $e');
      }
    }

    request.files.add(
        await http.MultipartFile.fromPath('image', _compressedImage!.path));
    request.files.add(
        await http.MultipartFile.fromPath('images', _compressedImages!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded! ');
    } else {
      print('Error uploading image: ${response.reasonPhrase} ');
    }
  }

  void urgent_Rent() async {
    print('Post_Rent');

    Map<String, dynamic> payload = await {
      'id_ptys': controller_verbal.id_last.toString(),
      'property_type_id': int.parse(provice.toString()),
      'hometype': hometype11.toString(),
      'urgent': urgent.toString(),
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgen_rent');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success urgent_Rent');
    } else {
      print('Error Rent: ${response.reasonPhrase}');
    }
  }

  Future<File?> _uploadImage_Rent() async {
    if (_imageFile == null) {
      return _imageFile;
    }

    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/rent_post_image');

    final request = http.MultipartRequest('POST', url);
    request.fields['id_image'] = controller_verbal.id_last.toString();
    request.fields['hometype'] = hometype11.toString();
    request.fields['property_type_id'] = provice.toString();
    if (_imageFile != null) {
      String targetPath = '${_imageFile!.path}_compressed.jpg';

      try {
        File? compressedFile =
            await testCompressAndGetFile(_imageFile!, targetPath);

        setState(() {
          _compressedImage_only = compressedFile;
        });
      } catch (e) {
        print('Error compressing image: $e');
      }
    }
    request.files.add(await http.MultipartFile.fromPath(
        'image_name_rent', _compressedImage_only!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded!');
    } else {
      print('Error uploading image: ${response.reasonPhrase}');
    }
  }

  void latlog_Rent() async {
    Map<String, dynamic> payload = await {
      'id_ptys': controller_verbal.id_last.toString(),
      'property_type_id': int.parse(provice.toString()),
      'lat': lat.toString(),
      'log': log.toString(),
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/lat_log_post_rent');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success latlog');
    } else {
      print('Error Latlog: ${response.reasonPhrase}');
    }
  }
}
