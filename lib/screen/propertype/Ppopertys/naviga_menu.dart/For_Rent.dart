// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, dead_code, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:itckfa/models/search_model.dart';

import '../mapproperty/search_map.dart';

import '../List_Property/List_Sale.dart';

List<String> list1 = <String>[
  'Banteay Meanchey',
  'Siem reap',
  'Phnom penh',
  'Takae'
];
List<String> list = <String>['Sort', 'Price', 'Beds', 'Baths', 'B-Size'];

class For_Rent extends StatefulWidget {
  const For_Rent({super.key});

  @override
  State<For_Rent> createState() => For_RentState();
}

class For_RentState extends State<For_Rent> {
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;

  late SearchRequestModel requestModel;
  double? lat, log;
  final List<Marker> _markers = <Marker>[];
  CameraPosition? cameraPosition;
  int num = 0;
  List<MapType> style_map = [
    MapType.hybrid,
    MapType.normal,
  ];
  final ScrollController _scrollController = new ScrollController();

  int index = 0;
  @override
  void initState() {
    Property_Sale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "For Rent",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Search_Map(
                c_id: '',
                commune: (value) {},
                district: (value) {},
                lat: (value) {},
                log: (value) {},
                province: (value) {},
              ),
            ),
            Row(
              children: [
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.1,
                //     width: MediaQuery.of(context).size.width * 0.2,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: DropdownButton<String>(
                //         value: dropdownValue1,
                //         icon: const Icon(Icons.arrow_circle_down_outlined),
                //         elevation: 16,
                //         style: const TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15,
                //             color: Colors.black),
                //         underline: SizedBox(),
                //         // underline: null,
                //         onChanged: (String? value) {
                //           // This is called when the user selects an item.
                //           setState(() {
                //             dropdownValue1 = value!;
                //           });
                //         },
                //         items: list1
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),
                // Expanded(
                //     flex: 1,
                //     child: Text(
                //       'Location',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold, fontSize: 16),
                //     ))
              ],
            ),
            //Text('(number of list) Listings for sale/rent'),
            // SizedBox(
            //   height: 5,
            // ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          hintText: 'Find listing here...',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_circle_down_outlined),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return List_Sale();
                        },
                      ));
                    },
                    child: Text('Show all')),
              ],
            ),
            Flexible(
              flex: 6,
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const StackReusable(
                      imagere: 'assets/images/homeimage.jpeg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                    const StackReusable(
                      imagere: 'assets/images/villa.jpg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                    const StackReusable(
                      imagere: 'assets/images/vilas.jpg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                    const StackReusable(
                      imagere: 'assets/images/vla.jpeg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                    const StackReusable(
                      imagere: 'assets/images/homeimage.jpeg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                    const StackReusable(
                      imagere: 'assets/images/villa.jpg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                    const StackReusable(
                      imagere: 'assets/images/vilas.jpg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                    const StackReusable(
                      imagere: 'assets/images/vla.jpeg',
                      pricere: '10000',
                      sizere: '72',
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(
      //       builder: (context) {
      //         return Screen_post_Rent();
      //       },
      //     ));
      //   },
      //   child: Icon(Icons.post_add),
      // ),
    );
  }

  List list2_Sale = [];
  void Property_Sale() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_get'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)['Propery_Sale'];
      list2_Sale = jsonData;
      setState(() {
        list2_Sale;
        print('111111111111111111111${list2_Sale[0]['image'].toString()}');
      });
    }
  }
}

class StackReusable extends StatelessWidget {
  final imagere;
  final pricere;
  final sizere;
  const StackReusable({
    required this.imagere,
    required this.pricere,
    required this.sizere,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Container(
            height: 10,
            width: 100,
          ),
          Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              '$imagere',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            child: Container(
              height: 30,
              width: 85,
              color: Colors.purple,
              child: const Center(
                child: Text(
                  'FOR RENT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: SizedBox(
              child: Center(
                child: Text(
                  '$pricere dollar',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              child: Text(
                'Size: $sizere sqm',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
