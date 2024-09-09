import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../screen/Profile/components/Drop.dart';
import 'colors.dart';
import 'contants.dart';

class BankDropdownSearch extends StatefulWidget {
  const BankDropdownSearch(
      {Key? key,
      required this.bank,
      required this.banknameback,
      required this.bankbranch,
      this.bn,
      this.brn,
      required this.branchName,
      required this.bankName,
      required this.bankbranchback})
      : super(key: key);
  final OnChangeCallback bank;
  final OnChangeCallback banknameback;
  final OnChangeCallback bankbranch;
  final OnChangeCallback bankbranchback;
  final String? bn;
  final String? brn;
  final String bankName;
  final String branchName;
  @override
  State<BankDropdownSearch> createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdownSearch> {
  late String bankvalue;
  late String branchvalue;
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];
  @override
  void initState() {
    super.initState();
    bankvalue = "";
    branchvalue = "";

    bankModel();
  }

  bool districtw = false;
  Future<void> district(bankID) async {
    districtw = true;
    await Future.wait([branchModel(bankID)]);

    setState(() {
      districtw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.bankName != "null")
                    ? Text(
                        widget.bankName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: greyColorNolot,
                          fontSize: 12,
                        ),
                      )
                    : Text(
                        'Bank',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: greyColorNolot,
                          fontSize: 12,
                        ),
                      ),
                const SizedBox(height: 5),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownSearch<Map<dynamic, dynamic>>(
                    items: listbankModel,
                    compareFn: (item1, item2) {
                      return item1['bank_name'] == item2['bank_name'];
                    },
                    popupProps: PopupProps.menu(
                      isFilterOnline: true,
                      showSearchBox: true,
                      showSelectedItems: true,
                      itemBuilder: (context, item, isSelected) {
                        return ListTile(
                          title: Text(
                            item['bank_name'] ?? '',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 39, 39, 39),
                            ),
                          ),
                          selected: isSelected,
                          style: ListTileStyle.drawer,
                        );
                      },
                      searchFieldProps: const TextFieldProps(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search a Bank',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        district(value?['bank_id'].toString());
                        widget.bank(value?['bank_id'].toString());
                        widget.banknameback(value?['bank_name'].toString());

                        // print(value?['bank_id'].toString());
                      });
                    },
                    selectedItem: const {"title": "A"},
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    filterFn: (item, filter) {
                      return item['bank_name']
                              ?.toLowerCase()
                              .contains(filter.toLowerCase()) ??
                          false;
                    },
                    itemAsString: (item) => item['bank_name'] ?? '',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          districtw
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (widget.branchName != "null")
                          ? Text(
                              widget.branchName.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: greyColorNolot,
                                fontSize: 12,
                              ),
                            )
                          : Text(
                              'Branch',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: greyColorNolot,
                                fontSize: 12,
                              ),
                            ),
                      const SizedBox(height: 5),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownSearch<Map<dynamic, dynamic>>(
                          items: listbranchModel,
                          compareFn: (item1, item2) {
                            return item1['bank_branch_name'] ==
                                item2['bank_branch_name'];
                          },
                          popupProps: PopupProps.menu(
                            isFilterOnline: true,
                            showSearchBox: true,
                            showSelectedItems: true,
                            itemBuilder: (context, item, isSelected) {
                              return ListTile(
                                title: Text(
                                  item['bank_branch_name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 39, 39, 39),
                                  ),
                                ),
                                selected: isSelected,
                                style: ListTileStyle.drawer,
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Search a Branch',
                                  hintStyle: TextStyle(fontSize: 12)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              widget.bankbranch(
                                  value?['bank_branch_id'].toString());
                              widget.bankbranchback(
                                  value?['bank_branch_name'].toString());
                            });
                          },
                          selectedItem: const {"title": "A"},
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                          filterFn: (item, filter) {
                            return item['bank_branch_name']
                                    ?.toLowerCase()
                                    .contains(filter.toLowerCase()) ??
                                false;
                          },
                          itemAsString: (item) =>
                              item['bank_branch_name'] ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  List<Map<dynamic, dynamic>> listbankModel = [];
  List listTitles = [];
  Future<void> bankModel() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listTitles = jsonDecode(json.encode(response.data))['banks'];
        for (int i = 0; i < listTitles.length; i++) {
          listbankModel.add(listTitles[i]);
        }
      });
    } else {
      print(response.statusMessage);
    }
  }

  List<Map<dynamic, dynamic>> listbranchModel = [];
  List listbranch = [];
  Future<void> branchModel(bankID) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_details_id=$bankID',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listbranch = jsonDecode(json.encode(response.data))['bank_branches'];
        for (int i = 0; i < listbranch.length; i++) {
          listbranchModel.add(listbranch[i]);
        }
      });
    } else {
      print(response.statusMessage);
    }
  }

  // Future<void> branch(String value) async {
  //   setState(() {});
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_details_id=' +
  //           value));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body.toString());
  //     // print(jsonData);
  //     setState(() {
  //       _branch = jsonData['bank_branches'];
  //       // print(_branch.toString());
  //     });
  //   }
  // }
}
