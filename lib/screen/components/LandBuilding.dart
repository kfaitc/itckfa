// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../afa/Customs/formVLDN.dart';
import '../../afa/Customs/formnum.dart';
import '../../models/model_bl_new.dart';
import '../Customs/Contants.dart';
import '../customs/form.dart';

import 'autoVerbalType.dart';

typedef OnChangeCallback = void Function(dynamic value);

class LandBuilding extends StatefulWidget {
  final String address;
  final int opt;
  final String landId;
  final String ID_khan;
  final String ID_sangkat;
  final OnChangeCallback list;
  final OnChangeCallback list_lb;
  final OnChangeCallback Avt;
  final String opt_type_id;
  final int check_property;
  const LandBuilding({
    super.key,
    // required this.asking_price,
    required this.opt,
    required this.address,
    required this.list,
    required this.landId,
    required this.ID_khan,
    required this.Avt,
    required this.opt_type_id,
    required this.check_property,
    required this.list_lb,
    required this.ID_sangkat,
  });

  @override
  State<LandBuilding> createState() => _LandBuildingState();
}

class _LandBuildingState extends State<LandBuilding> {
  final _formKey = GlobalKey<FormState>();
  List list = [];
  late int min = 0;
  late int max = 0;
  late String des;
  late String dep;
  late double area;
  late String autoverbalType;
  late String autoverbalTypeValue = '';
  late double minSqm, maxSqm, totalMin = 0, totalMax = 0;
  bool isApiCallProcess = false;
  var dropdown;
  List<L_B> lb = [L_B('', '', '', '', 0, 0, 0, 0, 0, 0)];
  String? options;
  var _selectedValue;
  List<String> option = [
    'Residencial',
    'Commercial',
    'Agricultural',
  ];

  double? Minimum, Maximun;

  // late int asking_price;
  void addItemToList() {
    // print(widget.asking_price);
    setState(() {
      list.add({
        "verbal_land_type": autoverbalType,
        "verbal_land_des": des,
        "verbal_land_dp": dep,
        "address": widget.address,
        "verbal_landid": int.parse(widget.landId),
        "verbal_land_area": area,
        "verbal_land_minsqm": minSqm.toStringAsFixed(2),
        "verbal_land_maxsqm": maxSqm.toStringAsFixed(2),
        "verbal_land_minvalue": totalMin.toStringAsFixed(2),
        "verbal_land_maxvalue": totalMax.toStringAsFixed(2),
      });
      lb.add(L_B(autoverbalType, des, dep, widget.address,
          int.parse(widget.landId), area, minSqm, maxSqm, totalMin, totalMax));

      minSqm = 0;
      maxSqm = 0;

      totalMax = 0;
      totalMin = 0;
      area = 0;
    });
    //  print(id);
  }

  void deleteItemToList(int Id) {
    setState(() {
      list.removeAt(Id);
      lb.removeAt(Id);
    });
  }

  int i = 1;
  @override
  void initState() {
    lb = [];
    minSqm = 0;
    maxSqm = 0;
    //  asking_price = 1;
    super.initState();
    // ignore: unnecessary_new
    des = "";
    dep = "";
    area = 0;
    Minimum = 0;
    Maximun = 0;
    autoverbalType = "";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 1.0,
          top: 2.0,
          child: InkResponse(
            onTap: () {
              // Note
              widget.list_lb(lb);
              widget.list(list);
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Land/Building",
                style: TextStyle(color: kImageColor, fontSize: 20),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 400,
                      child: AutoVerbalTypeDropdown(
                        name: (value) {
                          autoverbalType = value;
                        },
                        id: (value) {
                          autoverbalTypeValue = value;
                          setState(() {
                            widget.Avt(autoverbalTypeValue);
                          });
                        },
                      ),
                    ),
                    // if (autoverbalTypeValue == 100)
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: FormS(
                        label: "Desciption",
                        iconname: Icon(
                          Icons.book,
                          color: kImageColor,
                        ),
                        onSaved: (newValue) => des = newValue!,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: FormN(
                        label: "Depreciation",
                        iconname: Icon(
                          Icons.format_list_numbered_rtl,
                          color: kImageColor,
                        ),
                        onSaved: (newValue) {
                          setState(() {
                            dep = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: FormValidateN(
                        label: "Area",
                        iconname: Icon(
                          Icons.layers,
                          color: kImageColor,
                        ),
                        onSaved: (newValue) => area = double.parse(newValue!),
                      ),
                    ),
                    (widget.check_property == 2)
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 400,
                                child: FormValidateN(
                                    label: "Minimum",
                                    iconname: Icon(
                                      Icons.layers,
                                      color: kImageColor,
                                    ),
                                    onSaved: (newValue) {
                                      setState(() {
                                        Minimum = double.parse(newValue!);
                                      });
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 400,
                                child: FormValidateN(
                                  label: "Maximum",
                                  iconname: Icon(
                                    Icons.layers,
                                    color: kImageColor,
                                  ),
                                  onSaved: (newValue) {
                                    setState(() {
                                      Maximun = double.parse(newValue!);
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    (autoverbalTypeValue == '100')
                        ? Column(
                            children: [
                              Container(
                                height: 57,
                                margin: EdgeInsets.only(
                                    left: 30, top: 10, right: 30),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedValue,
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value;
                                      print(_selectedValue);
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _selectedValue = value;
                                    });
                                  },
                                  items: option.map((String val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text(
                                        val,
                                      ),
                                    );
                                  }).toList(),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: kImageColor,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Option',
                                    hintText: 'Select',
                                    prefixIcon: Icon(
                                      Icons.pix_rounded,
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
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: 57,
                              //   margin: EdgeInsets.only(
                              //       left: 30, top: 10, right: 30),
                              //   child: DropdownButtonFormField<String>(
                              //     isExpanded: true,
                              //     onChanged: (newValue) {
                              //       setState(() {
                              //         propertyValue_sangkat =
                              //             newValue as String;
                              //         print(newValue);
                              //       });
                              //     },
                              //     validator: (String? value) {
                              //       if (value?.isEmpty ?? true) {
                              //         return 'Please select sangkat';
                              //       }
                              //       return null;
                              //     },
                              //     items: list_sangkat
                              //         .map<DropdownMenuItem<String>>(
                              //           (value) => DropdownMenuItem<String>(
                              //             value: value["Sangkat_ID"].toString(),
                              //             child: Text(
                              //               value["Sangkat_Name"],
                              //               style: TextStyle(fontSize: 15),
                              //               overflow: TextOverflow.ellipsis,
                              //             ),
                              //             onTap: () {
                              //               setState(() {
                              //                 getname_sangkat =
                              //                     value["Sangkat_Name"];
                              //               });
                              //             },
                              //           ),
                              //         )
                              //         .toList(),
                              //     // add extra sugar..
                              //     icon: Icon(
                              //       Icons.arrow_drop_down,
                              //       color: kImageColor,
                              //     ),

                              //     decoration: InputDecoration(
                              //       fillColor: Colors.white,
                              //       filled: true,
                              //       labelText: 'Sangkat',
                              //       hintText: 'Select',
                              //       prefixIcon: Icon(
                              //         Icons.home_work,
                              //         color: kImageColor,
                              //       ),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderSide: const BorderSide(
                              //             color: kPrimaryColor, width: 2.0),
                              //         borderRadius: BorderRadius.circular(10.0),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           width: 1,
                              //           color: kPrimaryColor,
                              //         ),
                              //         borderRadius: BorderRadius.circular(10.0),
                              //       ),
                              //       errorBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           width: 1,
                              //           color: Colors.black,
                              //         ),
                              //         borderRadius: BorderRadius.circular(10.0),
                              //       ),
                              //       focusedErrorBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           width: 2,
                              //           color: Colors.black,
                              //         ),
                              //         borderRadius: BorderRadius.circular(10.0),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        : SizedBox(),
                    GFButton(
                      elevation: 5,
                      type: GFButtonType.solid,
                      shape: GFButtonShape.pills,
                      fullWidthButton: true,
                      text: "Calculator price",
                      onPressed: () {
                        if (widget.check_property == 1) {
                          if (autoverbalTypeValue == '100') {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              calLs(area);
                            }
                          } else {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              calElse(area, autoverbalTypeValue);
                              // Navigator.of(context).pop();
                            }
                          }
                        } else {
                          setState(() {
                            maxSqm = Maximun!;
                            minSqm = Minimum!;
                            totalMax = area * maxSqm;
                            totalMin = area * minSqm;
                            print(totalMin);
                            addItemToList();
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // (widget.check_property==1)?
                    Container(
                      width: double.infinity,
                      height: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Container(
                              width: 260,
                              //height: 210,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: kPrimaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${list[index]["verbal_land_type"]} ',
                                              style: NameProperty(),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    deleteItemToList(index);
                                                    print(list);
                                                    if (list.length == 0) {
                                                      Navigator.pop(context);
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text.rich(
                                      TextSpan(
                                        children: <InlineSpan>[
                                          WidgetSpan(
                                              child: Icon(
                                            Icons.location_on_sharp,
                                            color: kPrimaryColor,
                                            size: 14,
                                          )),
                                          TextSpan(
                                              text:
                                                  "${list[index]["address"]} "),
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      list[index]["verbal_land_des"],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Depreciation",
                                            style: Label(),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            "Area",
                                            style: Label(),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            'Min Value/Sqm',
                                            style: Label(),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            'Max Value/Sqm',
                                            style: Label(),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            'Min Value',
                                            style: Label(),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            'Min Value',
                                            style: Label(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 15),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4),
                                          Text(
                                            ':   ' +
                                                list[index]["verbal_land_dp"],
                                            style: Name(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            ':   ' +
                                                (list[index]["verbal_land_area"]
                                                        .toInt())
                                                    .toString() +
                                                'm' +
                                                '\u00B2',
                                            style: Name(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            ':   ' +
                                                (list[index]
                                                        ["verbal_land_minsqm"])
                                                    .toString() +
                                                '\$',
                                            style: Name(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            ':   ' +
                                                (list[index]
                                                        ["verbal_land_maxsqm"])
                                                    .toString() +
                                                '\$',
                                            style: Name(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            ':   ' +
                                                (list[index][
                                                        "verbal_land_minvalue"])
                                                    .toString() +
                                                '\$',
                                            style: Name(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            ':   ' +
                                                (list[index][
                                                            "verbal_land_maxvalue"]
                                                        .toString() +
                                                    '\$'),
                                            style: Name(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        // separatorBuilder: (BuildContext context, int index) =>
                        //     const Divider(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void calLs(double area) {
    var khan_id = widget.ID_khan;
    var sangkat_id = widget.ID_sangkat;
    setState(() async {
      if (_selectedValue == 'Commercial') {
        var rs = await http.get(Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commercial?Khan_ID=${khan_id}&Sangkat_ID=${sangkat_id}'));
        var jsonData = jsonDecode(rs.body);
        setState(() {
          maxSqm = double.parse(jsonData[0]['Max_Value']);
          minSqm = double.parse(jsonData[0]['Min_Value']);
        });
      } else if (_selectedValue == 'Residencial') {
        var rs = await http.get(Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/residential?Khan_ID=${khan_id}&Sangkat_ID=${sangkat_id}'));
        var jsonData = jsonDecode(rs.body);
        setState(() {
          maxSqm = double.parse(jsonData[0]['Max_Value']);
          minSqm = double.parse(jsonData[0]['Min_Value']);
        });
      } else if (_selectedValue == 'Agricultural') {
        maxSqm = 1;
        minSqm = 1;
      }
      // maxSqm = ((widget.asking_price * (100 - max) / 100) +
      //     (((widget.asking_price * (100 - max)) / 100) * (widget.opt / 100)));
      // minSqm = ((widget.asking_price * (100 - min) / 100) +
      //     (((widget.asking_price * (100 - min)) / 100) * (widget.opt / 100)));
      if (widget.opt_type_id != '0') {
        totalMin = (minSqm * area) * (double.parse(widget.opt_type_id) / 100);
        totalMax = (maxSqm * area) * (double.parse(widget.opt_type_id) / 100);
      } else {
        totalMin = minSqm * area;
        totalMax = maxSqm * area;
      }

      // print(widget.asking_price);
      // print(minSqm);
      // print(maxSqm);
      // print(totalMin);
      // print(totalMax);
      addItemToList();
    });
  }

  Future<void> calElse(double area, String autoverbalTypeValue) async {
    setState(() {
      isApiCallProcess = true;
    });
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/type?autoverbal_id=$autoverbalTypeValue'));
    //  if (rs.statusCode == 200) {
    var jsonData = jsonDecode(rs.body);
    setState(() {
      isApiCallProcess = false;
      // _list = jsonData['property'];
      maxSqm = double.parse(jsonData[0]['max']);
      minSqm = double.parse(jsonData[0]['min']);
      if (widget.opt_type_id != '0') {
        totalMin = (minSqm * area) * (double.parse(widget.opt_type_id) / 100);
        totalMax = (maxSqm * area) * (double.parse(widget.opt_type_id) / 100);
      } else {
        totalMin = minSqm * area;
        totalMax = maxSqm * area;
      }
      addItemToList();
    });
    //  }
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 14, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }
}
