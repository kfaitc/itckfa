// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/contants.dart';

import '../../models/model_bl_new.dart';
import '../customs/formVLDN.dart';
import '../customs/formnum.dart';

import 'autoVerbalType.dart';

typedef OnChangeCallback = void Function(dynamic value);

class LandBuilding extends StatefulWidget {
  // final double asking_price;
  final String address;
  final int opt;
  final double? asking_price;
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
    this.asking_price,
  });

  @override
  State<LandBuilding> createState() => _LandBuildingState();
}

class _LandBuildingState extends State<LandBuilding> {
  List list = [];
  var formatter = NumberFormat("##,###,###,##0.00", "en_US");
  int? min;
  int? max;
  String? des;
  String dep = "0";
  double area = 0;
  late String autoverbalType;
  late String autoverbalTypeValue = '';
  double? minSqm, maxSqm, totalMin, totalMax, total_Area;
  double h = 0, l = 0;
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

  // ignore: non_constant_identifier_names
  double? Minimum, Maximun;

  // late int asking_price;
  void addItemToList() {
    setState(() {
      list.add({
        "verbal_land_type": autoverbalType,
        "verbal_land_des": des ?? '',
        "verbal_land_dp": dep,
        "verbal_land_area": area,
        "verbal_land_minsqm": minSqm!.toStringAsFixed(0),
        "verbal_land_maxsqm": maxSqm!.toStringAsFixed(0),
        "verbal_land_minvalue": totalMin!.toStringAsFixed(0),
        "verbal_land_maxvalue": totalMax!.toStringAsFixed(0),
        "address": widget.address,
        "verbal_landid": widget.landId
      });
      lb.add(
        L_B(
            autoverbalType,
            des ?? '',
            dep,
            widget.address,
            int.parse(widget.landId),
            area,
            minSqm!,
            maxSqm!,
            totalMin!,
            totalMax ?? 0),
      );
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
          right: 0.0,
          top: 2.0,
          child: InkResponse(
            onTap: () {
              Navigator.pop(context);
              widget.list(list);
              widget.list_lb(lb);
            },
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.save_alt),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
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
                child: Column(
                  children: [
                    SizedBox(
                      width: 400,
                      child: AutoVerbalTypeDropdown(
                        name: (value) {
                          setState(() {
                            autoverbalType = value;
                          });
                        },
                        id: (value) {
                          setState(() {
                            autoverbalTypeValue = value;
                            widget.Avt(autoverbalTypeValue);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormN(
                      label: "Head",
                      iconname: Icon(
                        Icons.h_plus_mobiledata_outlined,
                        color: kImageColor,
                      ),
                      onSaved: (newValue) {
                        setState(() {
                          h = double.parse(newValue!);
                          if (l != 0) {
                            total_Area = h * l;
                            area = total_Area!;
                          } else {
                            total_Area = h;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormN(
                      label: "Length",
                      iconname: Icon(
                        Icons.blur_linear_outlined,
                        color: kImageColor,
                      ),
                      onSaved: (newValue) {
                        setState(() {
                          l = double.parse(newValue!);
                          if (h != 0) {
                            total_Area = h * l;
                            area = total_Area!;
                          } else {
                            total_Area = l;
                          }
                        });
                      },
                    ),
                    if (autoverbalTypeValue != '100')
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 400,
                            child: FormN(
                              label: "Depreciation(Age)",
                              iconname: Icon(
                                Icons.calendar_month_outlined,
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
                            child: FormN(
                              label: "Floors",
                              iconname: Icon(
                                Icons.calendar_month_outlined,
                                color: kImageColor,
                              ),
                              onSaved: (newValue) {
                                setState(() {
                                  des = newValue!;
                                  if (total_Area != null) {
                                    total_Area =
                                        total_Area! * double.parse(des!);
                                  }
                                  total_Area;
                                  area = total_Area!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: FormValidateN(
                        label: (total_Area != 0)
                            ? "Area (m\u00B2): ${formatter.format(total_Area ?? 0)}"
                            : "Area",
                        iconname: Icon(
                          Icons.layers,
                          color: kImageColor,
                        ),
                        onSaved: (newValue) {
                          setState(() {
                            area = double.parse(newValue!);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (autoverbalTypeValue == '100' &&
                        widget.asking_price == null)
                      Column(
                        children: [
                          Container(
                            height: 55,
                            margin: EdgeInsets.only(left: 5, top: 10, right: 5),
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
                        ],
                      ),
                    GFButton(
                      elevation: 5,
                      type: GFButtonType.solid,
                      shape: GFButtonShape.pills,
                      fullWidthButton: true,
                      text: "Calculator price",
                      onPressed: () {
                        if (autoverbalTypeValue == '100') {
                          setState(() {
                            if (widget.asking_price == null) {
                              calLs(area);
                            } else {
                              calLs2(area);
                            }
                          });
                        } else {
                          setState(() {
                            calElse(area, autoverbalTypeValue);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 210,
                            //height: 210,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 5),
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
                                            '${list[index]["verbal_land_type"].toString()} ',
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
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  deleteItemToList(index);
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
                                            style: Label(),
                                            text:
                                                "${list[index]["address"].toString()} "),
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
                                // Container(
                                //   padding: EdgeInsets.only(left: 10),
                                //   alignment: Alignment.centerLeft,
                                //   child: Text(
                                //     list[index]["verbal_land_des"],
                                //   ),
                                // ),
                                Row(
                                  children: [
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
                                          "Floor",
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
                                        Text(
                                          ':  ${formatter.format(double.parse(list[index]["verbal_land_dp"].toString()))} ',
                                          style: Name(),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          ':  ${list[index]["verbal_land_des"].toString()} ',
                                          style: Name(),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          ':   ${formatter.format(double.parse((list[index]["verbal_land_area"].toString())))} m' +
                                              '\u00B2',
                                          style: Name(),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          ':   ' +
                                              (list[index]
                                                      ["verbal_land_minsqm"])
                                                  .toString() +
                                              '\$',
                                          style: Name(),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          ':   ' +
                                              (list[index]
                                                      ["verbal_land_maxsqm"])
                                                  .toString() +
                                              '\$',
                                          style: Name(),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          ':   ' +
                                              formatter
                                                  .format(double.parse((list[
                                                          index][
                                                      "verbal_land_minvalue"])))
                                                  .toString() +
                                              '\$',
                                          style: Name(),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          ':   ' +
                                              // (list[index][
                                              //             "verbal_land_maxvalue"]
                                              //         .toString() +
                                              //     '\$'),
                                              formatter
                                                  .format(double.parse((list[
                                                          index][
                                                      "verbal_land_maxvalue"])))
                                                  .toString() +
                                              '\$',
                                          style: Name(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
            ],
          ),
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
      // ignore: unnecessary_null_comparison
      if (widget.opt_type_id != null) {
        totalMin =
            ((minSqm! * area) * (double.parse(widget.opt_type_id) / 100)) +
                (minSqm! * area);
        totalMax =
            ((maxSqm! * area) * (double.parse(widget.opt_type_id) / 100)) +
                (maxSqm! * area);
        addItemToList();
      } else {
        totalMin = minSqm! * area;
        totalMax = maxSqm! * area;
        addItemToList();
      }

      // print(widget.asking_price);
      // print(minSqm);
      // print(maxSqm);
      // print(totalMin);
      // print(totalMax);
    });
  }

  void calLs2(double area) {
    setState(() {
      maxSqm = (widget.asking_price! - (0.05 * widget.asking_price!)) +
          (widget.asking_price! -
              (widget.asking_price! -
                  (widget.asking_price! *
                      double.parse(widget.opt_type_id) /
                      100)));

      minSqm = (widget.asking_price! - (0.1 * widget.asking_price!)) +
          (widget.asking_price! -
              (widget.asking_price! -
                  (widget.asking_price! *
                      double.parse(widget.opt_type_id) /
                      100)));
      totalMin = (minSqm! * area);
      totalMax = (maxSqm! * area);
      addItemToList();
    });
    print(maxSqm.toString() + "\t" + minSqm.toString());
  }

  Future<void> calElse(double area, String autoverbalTypeValue) async {
    setState(() {
      isApiCallProcess = true;
    });
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/type?autoverbal_id=${autoverbalTypeValue}'));

    setState(() {
      var jsonData = jsonDecode(rs.body);
      isApiCallProcess = false;
      maxSqm = double.parse(jsonData[0]['max'].toString());
      minSqm = double.parse(jsonData[0]['min'].toString());
      // ignore: unnecessary_null_comparison
      if (widget.opt_type_id != null) {
        totalMin = ((minSqm! * area) *
                (double.parse(widget.opt_type_id.toString()) / 100)) +
            (minSqm! * area);
        totalMax = ((maxSqm! * area) *
                (double.parse(widget.opt_type_id.toString()) / 100)) +
            (maxSqm! * area);

        addItemToList();
      } else {
        totalMin = minSqm! * area;
        totalMax = maxSqm! * area;
        addItemToList();
      }
    });
    //  }
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 9);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 9, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 10, fontWeight: FontWeight.bold);
  }
}
