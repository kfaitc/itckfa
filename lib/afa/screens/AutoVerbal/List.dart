// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_local_variable, avoid_print, must_be_immutable, prefer_is_empty, unnecessary_brace_in_string_interps, prefer_adjacent_string_concatenation, prefer_typing_uninitialized_variables, unused_field, use_build_context_synchronously, curly_braces_in_flow_control_structures, empty_statements

import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:itckfa/afa/components/ToFromDate.dart';
import 'package:itckfa/screen/components/map_all/detail_verbal_by_id.dart';
import 'package:itckfa/screen/components/map_all/map_in_list_search.dart';
import '../../components/contants.dart';
import 'package:http/http.dart' as http;

class Menu_of_Autoverval extends StatefulWidget {
  const Menu_of_Autoverval({super.key, required this.id});
  final String id;
  @override
  State<Menu_of_Autoverval> createState() => _Menu_of_AutovervalState();
}

class _Menu_of_AutovervalState extends State<Menu_of_Autoverval>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Verbal",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kwhite,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: kwhite_new,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 70),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Map_List_search(
                            get_commune: (value) {},
                            get_district: (value) {},
                            get_lat: (value) {},
                            get_log: (value) {},
                            get_max1: (value) {},
                            get_max2: (value) {},
                            get_min1: (value) {},
                            get_min2: (value) {},
                            get_province: (value) {},
                          )));
                },
                child: Container(
                  height: 200,
                  width: wth / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black54,
                          blurStyle: BlurStyle.outer)
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color.fromARGB(255, 37, 42, 172),
                        Color.fromARGB(255, 72, 72, 202),
                        Color.fromARGB(255, 71, 69, 195),
                        Color.fromARGB(255, 111, 96, 243),
                        Color.fromARGB(255, 107, 107, 255),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  child: Text(
                    'Search Map',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Image.asset(
                'assets/images/New_KFA_Logo_pdf.png',
                height: 125,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => list_verbal(
                            verbal_id: widget.id,
                          )));
                },
                child: Container(
                  height: 200,
                  width: wth / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color.fromARGB(255, 20, 148, 203),
                        Color.fromARGB(255, 12, 80, 158),
                        Color.fromARGB(255, 46, 57, 206),
                        Color.fromARGB(255, 59, 71, 205),
                        Color.fromARGB(255, 20, 6, 168),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black54,
                          blurStyle: BlurStyle.outer)
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(blurRadius: 2, color: Colors.blue)
                            ]),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 300),
                          animatedTexts: [
                            RotateAnimatedText('List\t\t'),
                          ],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => list_verbal(
                                      verbal_id: widget.id,
                                    )));
                          },
                        ),
                      ),
                      const Text(
                        'Verbal',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class list_verbal extends StatefulWidget {
  const list_verbal({super.key, required this.verbal_id});
  final String verbal_id;
  @override
  State<list_verbal> createState() => _Menu_list_verbalState();
}

class _Menu_list_verbalState extends State<list_verbal> {
  String? start, end;
  int? number_for_count_verbal;
  List data_of_verbal = [];
  List data_of_price = [];
  final String apiUrl =
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbals/by_page'; // Replace with your API URL
  List<dynamic> data = [];
  int currentPage = 1;
  int? perPage;
  int Total_page = 0;
  int on_row = 20;
  Future<List> fetchData() async {
    setState(() {
      check_data = false;
    });
    final response =
        await http.get(Uri.parse('$apiUrl?start=${start}&end=${end}'));
    final jsonData = json.decode(response.body);
    setState(() {
      data = jsonData;
      Total_page = data.length;
      check_data = true;
      print(data.length);
    });
    return data;
  }

  List _data = [];
  List _data_type = [];
  bool? check_data;
  Future<void> _fetchData() async {
    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal/id_verbal');
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    List d1 = [];
    List d2 = [];
    setState(() {
      _data = jsonData['id_verbal'];
      _data_type = jsonData['type'];
      // for (int i = 0; i < d1.length; i++) {
      //   _data.add(d1[i].toString());
      //   _data_type.add(d2[i].toString());
      // }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        // title: Text(
        //   (start == null) ? '' : '${start} to ${end}',
        //   style: TextStyle(fontSize: 15),
        //   overflow: TextOverflow.ellipsis,
        // ),
        title: Text(
          "Search By Date",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 7, 9, 145),
      ),
      backgroundColor: Color.fromARGB(255, 7, 9, 145),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (check_data == false)
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.25,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 5, color: Colors.black45)
                        ]
                        // image: DecorationImage(
                        //     opacity: 1.0,
                        //     image: AssetImage('assets/images/New_KFA_Logo_pdf.png'),
                        //     fit: BoxFit.cover),
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 90,
                          child:
                              Image.asset('assets/images/New_KFA_Logo_pdf.png'),
                        ),
                        ToFromDate(
                          fromDate: (value) {
                            setState(() {
                              start = value.toString();
                            });
                          },
                          toDate: (value) {
                            setState(() {
                              end = value.toString();
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: GFButtonBadge(
                            onPressed: () {
                              check_data = true;
                              fetchData();
                            },
                            text: "Show",
                            color: Color.fromARGB(255, 7, 9, 145),
                            shape: GFButtonShape.standard,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        16),
                            fullWidthButton: true,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // if (_data.isNotEmpty)
            //   InkWell(
            //     onTap: () async {
            //       await _fetchData();
            //       if (_data.isNotEmpty) {
            //         showSearch(
            //             context: context,
            //             delegate: verbal_Search(
            //               name: _data,
            //               type: _data_type,
            //             ));
            //       }
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       margin: EdgeInsets.only(top: 30),
            //       height: MediaQuery.of(context).size.height * 0.2,
            //       decoration: BoxDecoration(
            //         color: Color.fromARGB(255, 50, 117, 225),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Box(
            //         label: "",
            //         iconname: const Icon(
            //           Icons.vpn_key,
            //           color: kImageColor,
            //         ),
            //         value: "Search By ID",
            //       ),
            //     ),
            //   ),
            if (check_data == true && data.length > 1)
              SingleChildScrollView(
                child: PaginatedDataTable(
                  horizontalMargin: 10.0,
                  arrowHeadColor: Colors.blueAccent[300],
                  columns: [
                    DataColumn(
                        label: Text(
                      'Verbal ID',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Address',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Bank',
                      style: TextStyle(color: Colors.green),
                    )),
                  ],
                  dataRowHeight: 50,
                  rowsPerPage: on_row,
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      on_row = value!;
                    });
                  },
                  source: _DataSource(data, Total_page, context),
                ),
              ),
            if (check_data == false && data.length > 1)
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            if (check_data == false && data.length == 0)
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List data;
  final int count_row;
  final BuildContext context;
  _DataSource(this.data, this.count_row, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0 ? Colors.grey[300] : Colors.white;
            }
            return index % 2 == 0
                ? Color.fromARGB(255, 255, 162, 162)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item['verbal_id'].toString(),
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  item['property_type_name'].toString(),
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => detail_verbal_by_id(
                    id_verbal: item['verbal_id'].toString(),
                  ),
                ),
              );
            },
          ),
          DataCell(
            Text(
              "${item['district_name'].toString()} ${(item['verbal_address'] != '') ? "(${item['verbal_address']})" : ''}",
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => detail_verbal_by_id(
                    id_verbal: item['verbal_id'].toString(),
                  ),
                ),
              );
            },
          ),
          DataCell(
            Text(
              item['bank_name'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => detail_verbal_by_id(
                    id_verbal: item['verbal_id'].toString(),
                  ),
                ),
              );
            },
          ),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
// ==========================================================> Old List of verbal <=====================================================
// class ListVerbal extends StatefulWidget {
//   ListVerbal({Key? key, required this.id}) : super(key: key);
//   String id;

//   @override
//   State<ListVerbal> createState() => _ListVerbalState();
// }

// class _ListVerbalState extends State<ListVerbal> {
//   List<L_B> lb = [];
//   List list = [];
//   // var index = int.parse('verbal_id');
//   Future<void> deleteItemToList(int Id, String ID) async {
//     print(Id);
//     setState(() {
//       list.removeAt(Id);
//     });
//     var rs = await http.delete(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/delete/$ID'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//     }
//   }

//   var image_i, get_image = [];
//   Future<void> getimage(id) async {
//     // var id;

//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_image/${id}'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         get_image = jsonData;
//         image_i = get_image[0]['url'];
//       });
//     }
//   }

//   var image_m, get_image_m = [];
//   Future<void> getimage_m(id) async {
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_image_map/${id}'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         get_image_m = jsonData;
//         image_m = get_image_m[0]['url'];

//         isApiCallProcess = true;
//       });
//     }
//   }

//   var list1 = [];

//   bool isApiCallProcess = false;
//   void Load1() async {
//     setState(() {});
//     var code = list[0]['verbal_id'].toString();

//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list?verbal_id=$code'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         list1 = jsonData;

//         getUser();
//       });
//     }
//   }

//   int i = 0;
//   int? total_MIN = 0;
//   int? total_MAX = 0;
//   List<AutoVerbal_List> data_pdf = [];
//   List land = [];
//   late double fsvM, fsvN, fx, fn;
//   static String address = "";
//   String? image_map;
//   String? image;
//   bool? show = true;
//   @override
//   void initState() {
//     Load();
//     land;
//     total_MIN = 0;
//     total_MAX = 0;
//     data_pdf;
//     fsvM = 0;
//     fsvN = 0;
//     fx = 0;
//     fn = 0;
//     image_map;
//     image_i;
//     image_m;
//     // Load2();
//     Load1();
//     // getUser();

//     super.initState();
//   }

//   Future<void> detailItem(int Id, String ID) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Detail(
//           id: Id,
//           code: ID.toString(),
//         ),
//       ),
//     );
//   }

//   void generatePdf(int i, String fsv) {
//     setState(() {
//       Land1(list[0]['verbal_id'].toString(), list[0]['verbal_con'].toString());
//       Future.delayed(const Duration(seconds: 2), () {
//         Printing.layoutPdf(onLayout: (format) => _generatePdf(format, fsv));
//       });
//     });
//   }

//   void Land1(String i, String fsv) async {
//     double x = 0, n = 0;
//     var jsonData;
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=$i'));
//     if (rs.statusCode == 200) {
//       jsonData = jsonDecode(rs.body);
//       land = jsonData;
//       setState(() {
//         // print("Land === ${land.length}");

//         for (int i = 0; i < land.length; i++) {
//           total_MIN = total_MIN! +
//               int.parse(land[i]["verbal_land_minvalue"].toString());
//           total_MAX = total_MAX! +
//               int.parse(land[i]["verbal_land_maxvalue"].toString());
//           // address = land[i]["address"];
//           x = x + double.parse(land[i]["verbal_land_maxsqm"].toString());
//           n = n + double.parse(land[i]["verbal_land_minsqm"].toString());
//         }
//         fsvM = (total_MAX! * double.parse(fsv)) / 100;
//         fsvN = (total_MIN! * double.parse(fsv)) / 100;

//         if (land.length < 1) {
//           total_MIN = 0;
//           total_MAX = 0;
//         } else {
//           fx = x * (double.parse(fsv) / 100);
//           fn = n * (double.parse(fsv) / 100);
//         }

//         print("Total mix ${total_MAX}");
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kwhite_new,
//         elevation: 0,
//         centerTitle: true,
//         title: Text.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                 text: "LIST",
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   color: kwhite,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         toolbarHeight: 80,
//       ),
//       backgroundColor: kwhite_new,
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(5.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: list.length > 0
//               ? ListView.builder(
//                   itemCount: list.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                         padding: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(15),
//                           ),
//                           border: Border.all(width: 1, color: kPrimaryColor),
//                         ),
//                         child: Column(
//                           children: [
//                             Stack(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         list[index]["verbal_id"],
//                                         style: NameProperty(),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             flex: 1,
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 Icons.edit_calendar_outlined,
//                                                 color: Color.fromARGB(
//                                                     255, 166, 229, 168),
//                                                 size: 35,
//                                               ),
//                                               onPressed: () async {
//                                                 await getimage(
//                                                     list[index]['verbal_id']);
//                                                 await getimage_m(
//                                                     list[index]['verbal_id']);
//                                                 await Get_land(
//                                                     list[index]['verbal_id']);

//                                                 setState(() {
//                                                   Navigator.of(context)
//                                                       .push(MaterialPageRoute(
//                                                     builder: (context) => Edit(
//                                                       land_list: data_of_land,
//                                                       cell_land: lb,
//                                                       image_photo: image_i,
//                                                       image_map: image_m,
//                                                       property_type_id: list[
//                                                                   index][
//                                                               'verbal_property_id']
//                                                           .toString(),
//                                                       lat: list[index]
//                                                               ['latlong_la']
//                                                           .toString(),
//                                                       lng: list[index]
//                                                               ['latlong_log']
//                                                           .toString(),
//                                                       address: list[index]
//                                                               ['verbal_address']
//                                                           .toString(),
//                                                       approve_id: list[index]
//                                                               ['approve_id']
//                                                           .toString(),
//                                                       agent: list[index]
//                                                               ['agenttype_id']
//                                                           .toString(),
//                                                       bank_branch_id: (list[
//                                                                       index][
//                                                                   'verbal_bank_branch_id'] ==
//                                                               null)
//                                                           ? '0'
//                                                           : list[index][
//                                                                   'verbal_bank_branch_id']
//                                                               .toString(),
//                                                       bank_contact: list[index][
//                                                               'verbal_bank_contact']
//                                                           .toString(),
//                                                       bank_id: list[index]
//                                                               ['verbal_bank_id']
//                                                           .toString(),
//                                                       bank_officer: list[index][
//                                                               'verbal_bank_officer']
//                                                           .toString(),
//                                                       comment: list[index]
//                                                               ['verbal_comment']
//                                                           .toString(),
//                                                       contact: list[index]
//                                                               ['verbal_contact']
//                                                           .toString(),
//                                                       image: list[index]
//                                                               ['verbal_image']
//                                                           .toString(),
//                                                       option: list[index]
//                                                               ['verbal_option']
//                                                           .toString(),
//                                                       owner: list[index]
//                                                               ['verbal_owner']
//                                                           .toString(),
//                                                       user: list[index]
//                                                               ['verbal_user']
//                                                           .toString(),
//                                                       verbal_com: list[index]
//                                                               ['verbal_com']
//                                                           .toString(),
//                                                       verbal_con: list[index]
//                                                               ['verbal_con']
//                                                           .toString(),
//                                                       verbal: data_of_land,
//                                                       verbal_id: int.parse(
//                                                         list[index]['verbal_id']
//                                                             .toString(),
//                                                       ),
//                                                       n_pro: list[index][
//                                                               'property_type_name']
//                                                           .toString(),
//                                                       n_bank: list[index]
//                                                               ['bank_acronym']
//                                                           .toString(),
//                                                       n_agent: list[index]
//                                                               ['agenttype_name']
//                                                           .toString(),
//                                                       n_appro: list[index]
//                                                               ['approve_name']
//                                                           .toString(),
//                                                     ),
//                                                   ));
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 Icons.description_outlined,
//                                                 color: Colors.blue,
//                                                 size: 35,
//                                               ),
//                                               onPressed: () {
//                                                 index = index;
//                                                 // index = int.parse('verbal_id');
//                                                 detailItem(index,
//                                                     list[index]["verbal_id"]);
//                                               },
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 Icons.delete,
//                                                 color: Colors.red,
//                                                 size: 35,
//                                               ),
//                                               onPressed: () async {
//                                                 await AwesomeDialog(
//                                                   context: context,
//                                                   dialogType:
//                                                       DialogType.warning,
//                                                   headerAnimationLoop: false,
//                                                   animType:
//                                                       AnimType.bottomSlide,
//                                                   title:
//                                                       'Are you sure to delete?',
//                                                   buttonsTextStyle:
//                                                       const TextStyle(
//                                                           color: Colors.black),
//                                                   showCloseIcon: true,
//                                                   btnCancelOnPress: () {},
//                                                   btnOkOnPress: () {
//                                                     deleteItemToList(
//                                                         index,
//                                                         list[index]
//                                                             ["verbal_id"]);
//                                                   },
//                                                 ).show();
//                                                 Navigator.pop(context);
//                                                 print(list);
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Stack(
//                               children: [
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: list[index]
//                                                   ["property_type_name"] !=
//                                               null
//                                           ? Text(
//                                               list[index]["property_type_name"],
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 14),
//                                             )
//                                           : Text(
//                                               "N/A",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 14),
//                                             ),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Align(
//                                         alignment: Alignment.centerRight,
//                                         child: list[index]
//                                                         ["verbal_created_date"]
//                                                     .split(" ")[0] !=
//                                                 null
//                                             ? Text(
//                                                 list[index]
//                                                         ["verbal_created_date"]
//                                                     .split(" ")[0],
//                                               )
//                                             : Text(
//                                                 "N/A",
//                                               ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             // Container(
//                             //   padding: EdgeInsets.only(left: 10),
//                             //   alignment: Alignment.centerLeft,
//                             //   child: list[index]["property_type_name"] != null
//                             //       ? Text(
//                             //           list[index]["property_type_name"],
//                             //         )
//                             //       : Text(
//                             //           "N/A",
//                             //         ),
//                             // ),
//                             SizedBox(height: 10),

//                             // SizedBox(
//                             //   height: 3.0,
//                             // ),
//                             Divider(
//                               height: 1,
//                               thickness: 1,
//                               color: kPrimaryColor,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(width: 10),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Bank",
//                                       style: Label(),
//                                     ),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     Text(
//                                       "Agency",
//                                       style: Label(),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(width: 15),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(height: 2),
//                                     Text(
//                                       ':   ' +
//                                           list[index]["bank_name"].toString(),
//                                       style: Name(),
//                                     ),
//                                     SizedBox(
//                                       width: 3,
//                                     ),
//                                     list[index]["approve_name"] != null
//                                         ? Text(
//                                             ':   ' +
//                                                 list[index]["approve_name"]
//                                                     .toString(),
//                                             style: Name(),
//                                           )
//                                         : Text(
//                                             ':   ' + "N/A",
//                                             style: Name(),
//                                           )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 10, right: 10),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text.rich(
//                                   TextSpan(
//                                     children: <InlineSpan>[
//                                       WidgetSpan(
//                                           child: Icon(
//                                         Icons.location_on_sharp,
//                                         color: kPrimaryColor,
//                                         size: 14,
//                                       )),
//                                       TextSpan(
//                                         // ignore: prefer_if_null_operators
//                                         text:
//                                             // ignore: prefer_if_null_operators
//                                             list[index]["verbal_address"] !=
//                                                     null
//                                                 ? list[index]["verbal_address"]
//                                                 : "N/A",
//                                       ),
//                                     ],
//                                   ),
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             GFButton(
//                               shape: GFButtonShape.pills,
//                               color: Color.fromRGBO(33, 150, 243, 1),
//                               elevation: 10.0,
//                               fullWidthButton: true,
//                               onPressed: () async {
//                                 await getimage_m(
//                                     list[index]['verbal_id'].toString());
//                                 await getimage(
//                                     list[index]['verbal_id'].toString());

//                                 // print(
//                                 //     'verbal_id for list =${list[index]['verbal_id']}');
//                                 // await getimage(list[index]['verbal_id']);
//                                 // await getimage_m(list[index]['verbal_id']);
//                                 setState(() {
//                                   generatePdf(
//                                       i, list[index]['verbal_con'].toString());
//                                 });
//                                 // Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (context) =>
//                                 //             Get_Image_By_Firbase(
//                                 //               com_id: list[index]['verbal_id'],
//                                 //               fsv: list[index]['verbal_con'],
//                                 //               i: index,
//                                 //               property_check: '1',
//                                 //               image: image_i,
//                                 //               image_map: image_m,
//                                 //             )));
//                               },
//                               text: 'Print',
//                               icon: const Icon(
//                                 Icons.print,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               : const Center(child: CircularProgressIndicator()),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: kwhite_new,
//         onPressed: () {
//           // Add your onPressed code here!
//         },
//         child: IconButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) {
//                   return Search_verbal(id_uer: widget.id);
//                 },
//               ));
//             },
//             icon: Icon(Icons.search)),
//       ),
//     );
//   }

//   void Land(String i, String fsv) async {
//     double x = 0, n = 0;
//     var jsonData;
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=$i'));
//     if (rs.statusCode == 200) {
//       jsonData = jsonDecode(rs.body);
//       land = jsonData;
//       setState(() {
//         for (int i = 0; i < land.length; i++) {
//           total_MIN = total_MIN! + int.parse(land[i]["verbal_land_minvalue"]);
//           total_MAX = total_MAX! + int.parse(land[i]["verbal_land_maxvalue"]);
//           // address = land[i]["address"];
//           x = x + int.parse(land[i]["verbal_land_maxsqm"]);
//           n = n + int.parse(land[i]["verbal_land_minsqm"]);
//         }
//         fsvM = (total_MAX! * double.parse(fsv)) / 100;
//         fsvN = (total_MIN! * double.parse(fsv)) / 100;

//         if (land.length < 1) {
//           total_MIN = 0;
//           total_MAX = 0;
//         } else {
//           fx = x * (double.parse(fsv) / 100);
//           fn = n * (double.parse(fsv) / 100);
//         }

//         print("Total Data ${land}");
//       });
//     }
//   }

//   TextStyle Label() {
//     return TextStyle(color: kPrimaryColor, fontSize: 13);
//   }

//   TextStyle Name() {
//     return TextStyle(
//         color: kImageColor,
//         fontSize: 12,
//         fontWeight: FontWeight.bold,
//         overflow: TextOverflow.visible);
//   }

//   TextStyle NameProperty() {
//     return TextStyle(
//         color: kImageColor, fontSize: 16, fontWeight: FontWeight.bold);
//   }

//   void Load() async {
//     setState(() {});
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=${widget.id}'));

//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         list = jsonData;
//       });
//     }
//   }

//   List data_of_land = [];
//   Future<void> Get_land(id) async {
//     setState(() {
//       lb.clear();
//     });
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=$id'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);
//       setState(() {
//         data_of_land = jsonData;
//         for (int i = 0; i < data_of_land.length; i++) {
//           // lb.add(L_B(
//           //     data_of_land[i]['verbal_land_type'],
//           //     data_of_land[i]['verbal_land_des'],
//           //     data_of_land[i]['verbal_land_dp'],
//           //     data_of_land[i]['address'],
//           //     data_of_land[i]['verbal_landid'],
//           //     double.parse(data_of_land[i]['verbal_land_area']),
//           //     double.parse(data_of_land[i]['verbal_land_minsqm']),
//           //     double.parse(data_of_land[i]['verbal_land_maxsqm']),
//           //     double.parse(data_of_land[i]['verbal_land_minvalue']),
//           //     double.parse(data_of_land[i]['verbal_land_maxvalue'])));
//         }
//       });
//     }
//   }

//   Future<Uint8List> _generatePdf(PdfPageFormat format, String fsv) async {
//     // Create a new PDF document
//     final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
//     final font = await PdfGoogleFonts.nunitoExtraLight();
//     final ByteData bytes =
//         await rootBundle.load('assets/images/New_KFA_Logo.png');
//     final Uint8List byteList = bytes.buffer.asUint8List();
//     if (isApiCallProcess == true) ;
//     Uint8List bytes1 =
//         (await NetworkAssetBundle(Uri.parse('$image_m')).load('$image_m'))
//             .buffer
//             .asUint8List();
//     Uint8List bytes2 =
//         (await NetworkAssetBundle(Uri.parse('$image_i')).load('$image_i'))
//             .buffer
//             .asUint8List();

//     // Add a page to the PDF document
//     pdf.addPage(pw.MultiPage(
//       build: (context) {
//         return [
//           pw.Column(
//             children: [
//               pw.Container(
//                 height: 70,
//                 margin: pw.EdgeInsets.only(bottom: 5),
//                 child: pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Container(
//                       width: 80,
//                       height: 70,
//                       child: pw.Image(
//                           pw.MemoryImage(
//                             byteList,
//                             // bytes1,
//                           ),
//                           fit: pw.BoxFit.fill),
//                     ),
//                     pw.Text("VERBAL CHECK",
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold, fontSize: 20)),
//                     pw.Container(
//                       height: 50,
//                       width: 79,
//                       child: pw.BarcodeWidget(
//                           barcode: pw.Barcode.qrCode(),
//                           data:
//                               "https://www.latlong.net/c/?lat=${list[0]['latlong_log']}&long=${list[0]['latlong_la']}"),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.Container(
//                 child: pw.Column(children: [
//                   pw.Column(children: [
//                     pw.Container(
//                         child: pw.Row(children: [
//                       pw.Expanded(
//                         flex: 4,
//                         child: pw.Container(
//                           padding: pw.EdgeInsets.all(2),
//                           alignment: pw.Alignment.centerLeft,
//                           decoration: pw.BoxDecoration(border: pw.Border.all()),
//                           //color: Colors.red,
//                           child: pw.Text(
//                               "DATE: ${list[0]['verbal_created_date'].toString()}",
//                               style: pw.TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: pw.FontWeight.bold)),
//                           height: 25,
//                           //color: Colors.white,
//                         ),
//                       ),
//                       pw.Expanded(
//                         flex: 4,
//                         child: pw.Container(
//                           padding: pw.EdgeInsets.all(2),
//                           alignment: pw.Alignment.centerLeft,
//                           decoration: pw.BoxDecoration(border: pw.Border.all()),
//                           child: pw.Text(
//                               "CODE: ${list[0]['verbal_id'].toString()}",
//                               style: pw.TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: pw.FontWeight.bold)),
//                           height: 25,
//                           //color: Colors.yellow,
//                         ),
//                       ),
//                     ]))
//                   ])
//                 ]),
//               ),
//               pw.SizedBox(
//                 child: pw.Row(
//                   children: [
//                     pw.Expanded(
//                       flex: 8,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(
//                             "Requested Date :${list[0]['verbal_created_date'].toString()} ",
//                             style: pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.Container(
//                 padding: pw.EdgeInsets.all(2),
//                 alignment: pw.Alignment.centerLeft,
//                 decoration: pw.BoxDecoration(border: pw.Border.all()),
//                 child: pw.Text(
//                     "Referring to your request letter for verbal check by ${list[0]['bank_name'].toString()}, we estimated the value of property as below.",
//                     overflow: pw.TextOverflow.clip),
//                 height: 30,
//                 //color: Colors.blue,
//               ),
//               pw.SizedBox(
//                 child: pw.Row(
//                   children: [
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Property Information: ",
//                             style: pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 6,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(
//                             "${list[0]['property_type_name'].toString()}",
//                             style: pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(
//                 child: pw.Row(
//                   children: [
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Address : ",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 6,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(
//                             "${list[0]['verbal_address'].toString()}",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(
//                 child: pw.Row(
//                   children: [
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Owner Name ",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child:
//                             // name rest with api
//                             pw.Text("${list[0]['verbal_owner'].toString()}",
//                                 style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         // name rest with api
//                         child: pw.Text(
//                             "Contact No : ${list[0]['verbal_contact'].toString()} ",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(
//                 child: pw.Row(
//                   children: [
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Bank Officer ",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 30,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("${list[0]['bank_name'].toString()}",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 30,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(
//                             "Contact No : ${list[0]['bankcontact'].toString()}",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 30,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(
//                 child: pw.Row(
//                   children: [
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Latitude ",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("${list[0]['latlong_log'].toString()}",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Longtitude ",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("${list[0]['latlong_la'].toString()} ",
//                             style: const pw.TextStyle(fontSize: 12)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 5),
//               pw.Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
//                   textAlign: pw.TextAlign.center,
//                   style: const pw.TextStyle(fontSize: 12)),
//               pw.Container(
//                 height: 100,
//                 child: pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Container(
//                       width: 228,
//                       child: pw.Image(
//                           pw.MemoryImage(
//                             bytes1,
//                           ),
//                           fit: pw.BoxFit.fitWidth),
//                     ),
//                     pw.SizedBox(width: 0.1),
//                     pw.Container(
//                       width: 228,
//                       child: pw.Image(
//                           pw.MemoryImage(
//                             bytes2,
//                           ),
//                           fit: pw.BoxFit.fitWidth),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 5),
//               pw.Container(
//                   child: pw.Column(children: [
//                 pw.Container(
//                     child: pw.Row(children: [
//                   pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("DESCRIPTION: ",
//                             style: pw.TextStyle(
//                                 fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                         height: 25,
//                       )),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       padding: const pw.EdgeInsets.all(2),
//                       alignment: pw.Alignment.centerLeft,
//                       decoration: pw.BoxDecoration(border: pw.Border.all()),
//                       child: pw.Text("AREA/sqm: ",
//                           style: pw.TextStyle(
//                               fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                       height: 25,
//                       //color: Colors.blue,
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       padding: const pw.EdgeInsets.all(2),
//                       alignment: pw.Alignment.centerLeft,
//                       decoration: pw.BoxDecoration(border: pw.Border.all()),
//                       child: pw.Text("MIN/sqm: ",
//                           style: pw.TextStyle(
//                               fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                       height: 25,
//                       //color: Colors.blue,
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       padding: const pw.EdgeInsets.all(2),
//                       alignment: pw.Alignment.centerLeft,
//                       decoration: pw.BoxDecoration(border: pw.Border.all()),
//                       child: pw.Text("MAX/sqm: ",
//                           style: pw.TextStyle(
//                               fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                       height: 25,
//                       //color: Colors.blue,
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       padding: const pw.EdgeInsets.all(2),
//                       alignment: pw.Alignment.centerLeft,
//                       decoration: pw.BoxDecoration(border: pw.Border.all()),
//                       child: pw.Text("MIN-VALUE: ",
//                           style: pw.TextStyle(
//                               fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                       height: 25,
//                       //color: Colors.blue,
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       padding: const pw.EdgeInsets.all(2),
//                       alignment: pw.Alignment.centerLeft,
//                       decoration: pw.BoxDecoration(border: pw.Border.all()),
//                       child: pw.Text("MAX-VALUE: ",
//                           style: pw.TextStyle(
//                               fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                       height: 25,
//                       //color: Colors.blue,
//                     ),
//                   ),
//                 ])),
//                 if (land.length >= 1)
//                   pw.ListView.builder(
//                     itemCount: land.length,
//                     itemBuilder: (Context, index) {
//                       return pw.Container(
//                         child: pw.Row(children: [
//                           pw.Expanded(
//                             flex: 3,
//                             child: pw.Container(
//                               padding: pw.EdgeInsets.all(2),
//                               alignment: pw.Alignment.centerLeft,
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Text(
//                                   land[index]["verbal_land_type"] ?? "N/A",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold)),
//                               height: 25,
//                               //color: Colors.blue,
//                             ),
//                           ),
//                           pw.Expanded(
//                             flex: 2,
//                             child: pw.Container(
//                               padding: pw.EdgeInsets.all(2),
//                               alignment: pw.Alignment.centerLeft,
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Text(
//                                   land[index]["verbal_land_area"].toString(),
//                                   style: pw.TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: pw.FontWeight.bold)),
//                               height: 25,
//                               //color: Colors.blue,
//                             ),
//                           ),
//                           pw.Expanded(
//                             flex: 2,
//                             child: pw.Container(
//                               padding: pw.EdgeInsets.all(2),
//                               alignment: pw.Alignment.centerLeft,
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Text(
//                                   land[index]["verbal_land_minsqm"].toString(),
//                                   style: pw.TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: pw.FontWeight.bold)),
//                               height: 25,
//                               //color: Colors.blue,
//                             ),
//                           ),
//                           pw.Expanded(
//                             flex: 2,
//                             child: pw.Container(
//                               padding: pw.EdgeInsets.all(2),
//                               alignment: pw.Alignment.centerLeft,
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Text(
//                                   land[index]["verbal_land_maxsqm"].toString(),
//                                   style: pw.TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: pw.FontWeight.bold)),
//                               height: 25,
//                               //color: Colors.blue,
//                             ),
//                           ),
//                           pw.Expanded(
//                             flex: 2,
//                             child: pw.Container(
//                               padding: pw.EdgeInsets.all(2),
//                               alignment: pw.Alignment.centerLeft,
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Text(
//                                   land[index]["verbal_land_minvalue"]
//                                       .toString(),
//                                   style: pw.TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: pw.FontWeight.bold)),
//                               height: 25,
//                               //color: Colors.blue,
//                             ),
//                           ),
//                           pw.Expanded(
//                             flex: 2,
//                             child: pw.Container(
//                               padding: pw.EdgeInsets.all(2),
//                               alignment: pw.Alignment.centerLeft,
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Text(
//                                   land[index]["verbal_land_maxvalue"]
//                                       .toString(),
//                                   style: pw.TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: pw.FontWeight.bold)),
//                               height: 25,
//                               //color: Colors.blue,
//                             ),
//                           ),
//                         ]),
//                       );
//                     },
//                   ),
//                 pw.Container(
//                   child: pw.Row(children: [
//                     pw.Expanded(
//                       flex: 9,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Property Value(Estimate) ",
//                             style: pw.TextStyle(
//                               fontSize: 11,
//                             )),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(total_MIN.toString(),
//                             style: pw.TextStyle(fontSize: 11)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(total_MAX.toString(),
//                             style: pw.TextStyle(fontSize: 11)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ]),
//                 ),
//                 pw.Container(
//                   child: pw.Row(children: [
//                     pw.Expanded(
//                       flex: 9,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         // ទាយយក forceSale from  ForceSaleAndValuation
//                         child: pw.Text("Force Sale Value ${fsv.toString()}% ",
//                             style: const pw.TextStyle(
//                               fontSize: 11,
//                             )),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(fsvN.toString(),
//                             style: pw.TextStyle(fontSize: 11)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(fsvM.toString(),
//                             style: const pw.TextStyle(fontSize: 11)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ]),
//                 ),
//                 pw.Container(
//                   child: pw.Row(children: [
//                     pw.Expanded(
//                       flex: 5,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Force Sale Value: ",
//                             style: const pw.TextStyle(
//                               fontSize: 11,
//                             )),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("$fn",
//                             style: const pw.TextStyle(fontSize: 11)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("${fx}",
//                             style: const pw.TextStyle(fontSize: 11)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 4,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ]),
//                 ),
//                 pw.Container(
//                   child: pw.Row(children: [
//                     pw.Expanded(
//                       flex: 11,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text(
//                             "COMMENT: ${list[0]['verbal_comment'].toString()}",
//                             style: pw.TextStyle(
//                                 fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ]),
//                 ),
//                 pw.Container(
//                   child: pw.Row(children: [
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("Valuation:  ",
//                             style: pw.TextStyle(
//                                 fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 9,
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(2),
//                         alignment: pw.Alignment.centerLeft,
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Text("", style: pw.TextStyle(fontSize: 11)),
//                         height: 25,
//                         //color: Colors.blue,
//                       ),
//                     ),
//                   ]),
//                 ),
//               ])),
//               pw.SizedBox(height: 5),
//               pw.Text(
//                   '*Note : The land building size based on the bank officer provided, in case the land and building size are wrong provided when we have the actual size inspect, we are not response on this case.'),
//               pw.Text('Verbal Check Replied By:${name_user}',
//                   style:
//                       pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
//                   textAlign: pw.TextAlign.right),
//               pw.Text('${tel}',
//                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                   textAlign: pw.TextAlign.right),
//               pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//                 pw.Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
//                     style: pw.TextStyle(
//                         color: PdfColors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 10)),
//               ]),
//               pw.Row(
//                 children: [
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text('Hotline: 077 997 888',
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 7)),
//                       pw.Row(children: [
//                         pw.Text('H/P : (+855)23 988 855/(+855)23 999 761',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 7)),
//                       ]),
//                       pw.Row(children: [
//                         pw.Text('Email : info@kfa.com.kh',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 7)),
//                       ]),
//                       pw.Row(children: [
//                         pw.Text('Website: www.kfa.com.kh',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 7)),
//                       ]),
//                     ],
//                   ),
//                   pw.SizedBox(width: 10),
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                           'Villa #36A, Street No4, (Borey Peng Hout The Star',
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 7)),
//                       pw.Text('Natural 371) Sangkat Chak Angrae Leu,',
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 7)),
//                       pw.Text('Khan Mean Chey, Phnom Penh City, Cambodia,',
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 7)),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ];
//       },
//     ));

//     // Get the bytes of the PDF document
//     final pdfBytes = pdf.save();

//     // Print the PDF document to the default printer
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdfBytes);
//     return pdf.save();
//   }

//   var name_user, tel, get_user = [];
//   void getUser() async {
//     var id;
//     setState(() {
//       id = list[0]["verbal_user"];
//     });
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
//     if (rs.statusCode == 200) {
//       var jsonData = jsonDecode(rs.body);

//       setState(() {
//         get_user = jsonData;
//         name_user = get_user[0]['username'];
//         tel = get_user[0]['tel_num'];
//       });
//     }
//   }
// }

//  Positioned(
//                     bottom: 15,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 10, right: 10),
//                       width: wth - 20,
//                       height: 50,
//                       alignment: Alignment.center,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 if (all) {
//                                   all = false;
//                                   me = true;
//                                 } else {
//                                   all = true;
//                                   me = false;
//                                 }
//                               });
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               margin: EdgeInsets.all(10),
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     if (all)
//                                       BoxShadow(
//                                           blurRadius: 3, color: Colors.black54)
//                                   ],
//                                   color:
//                                       (all) ? Colors.blue : Colors.indigo[900]),
//                               child: Text(
//                                 "All",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 if (me) {
//                                   me = false;
//                                   all = true;
//                                 } else {
//                                   me = true;
//                                   all = false;
//                                 }
//                               });
//                             },
//                             child: Container(
//                               width: 100,
//                               alignment: Alignment.center,
//                               margin: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   boxShadow: [
//                                     if (me)
//                                       BoxShadow(
//                                           blurRadius: 3, color: Colors.black54)
//                                   ],
//                                   borderRadius: BorderRadius.circular(20),
//                                   color:
//                                       (me) ? Colors.blue : Colors.indigo[900]),
//                               child: Text(
//                                 "Me",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ))
