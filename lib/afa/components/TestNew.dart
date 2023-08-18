// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_application/components/contants.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:anim_search_bar/anim_search_bar.dart';

// class TestAuto extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _controller = TextEditingController();
//   var uuid = Uuid();
//   late String _sessionToken = '';
//   List<dynamic> _placeList = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       _onChanged();
//     });
//   }

//   _onChanged() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(_controller.text);
//   }

//   void getSuggestion(String input) async {
//     String kPLACES_API_KEY = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
//     String type = 'address';
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken&type=$type&components=country:kh';
//     var response = await http.get(Uri.parse(request));
//     if (response.statusCode == 200) {
//       setState(() {
//         _placeList = json.decode(response.body)['predictions'];
//       });
//     } else {
//       throw Exception('Failed to load predictions');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimSearchBar(
//           width: 500,
//           textController: _controller,
//           onSuffixTap: () {
//             setState(() {
//               _controller.clear();
//             });
//           },
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 100),
//           child: Positioned(
//             child: Container(
//               color: kPrimaryColor,
//               child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: _placeList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () {
//                       _controller.text = _placeList[index]["description"];
//                       print(_placeList[index]["description"]);
//                     },
//                     title: Text(_placeList[index]["description"]),
//                   );
//                 },
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
