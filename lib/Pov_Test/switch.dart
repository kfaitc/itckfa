// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   List<String> _imageUrls = [];
//   int _currentPage = 1;

//   @override
//   void initState() {
//     super.initState();
//     _fetchImageUrls();
//   }

//   void _fetchImageUrls() async {
//     final response = await http.get(Uri.parse('https://example.com/api/images?page=$_currentPage&perPage=10'));
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       setState(() {
//         _imageUrls.addAll(responseData['imageUrls']);
//         _currentPage++;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemCount: _imageUrls.length,
//         itemBuilder: (context, index) {
//           return Image.network(_imageUrls[index]);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _fetchImageUrls,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }