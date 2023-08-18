// // ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types, body_might_complete_normally_nullable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

// import 'package:flutter/material.dart';

// class Province_detail_List extends StatefulWidget {
//   List? value_province;
//   String? property_id;
//   Province_detail_List(
//       {super.key, required this.value_province, required this.property_id});

//   @override
//   State<Province_detail_List> createState() => _HHHHSSsState();
// }

// class _HHHHSSsState extends State<Province_detail_List> {
//   String? indexn;
//   int? indexN;
//   @override
//   void initState() {
//     // indexn = widget.value_province!.toString();
//     super.initState();
//     // for (int i = 0; i < widget.value_province!.length; i++) {
//     //   // print(widget.value_province!);
//     //   if (widget.value_province![i]['property_type_id'].toString() ==
//     //       '${widget.property_id}') {
//     //     print('${widget.value_province![i]}');
//     //     indexN = i;
//     //     // Get.to(HHHHSSs(value_province: list2_Sale2[i]));
//     //   }
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('${widget.property_id}'),
//         ),
//         body: Column(
//           children: [
//             for (int i = 0; i < widget.value_province!.length; i++)
//               Column(
//                 children: [
//                   (widget.value_province![i]['property_type_id'].toString() ==
//                           widget.property_id)
//                       ? Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                               '($i) / property_type_id : (${widget.value_province![i]['property_type_id']})'),
//                         )
//                       : SizedBox(),
//                 ],
//               ),
//           ],
//         )
//         // body: Container(
//         //   height: double.infinity,
//         //   width: double.infinity,
//         //   child: ListView.builder(
//         //     itemCount: widget.value_province!.length,
//         //     itemBuilder: (context, index) {
//         //       return Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Container(

//         //         ),
//         //       );
//         //     },
//         //   ),
//         // ),
//         );
//   }
// }
