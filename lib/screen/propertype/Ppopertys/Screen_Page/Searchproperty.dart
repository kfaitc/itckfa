// import 'package:flutter/material.dart';
// import 'package:kfa_project/Property/bodymap.dart';
// class SearchProperty extends StatefulWidget {
//   const SearchProperty({super.key});
  
//   @override
//   State<SearchProperty> createState() => _SearchPropertyState();
// }
// const List<String> list = <String>['Bed', 'Bath', 'Room', 'Price'];
//  String dropdownValue = list.first;
//  final TextEditingController _controller = TextEditingController();
// class _SearchPropertyState extends State<SearchProperty> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Search Property"),
//         actions: [
//           IconButton(
//                 onPressed: () {
//                   setState(() {
//                     Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>  
//                       Body_Map(c_id: '', commune: (value) {  }, district: (value) {  }, lat: (value) {  }, log: (value) {  }, province: (value) {  },)
//                      ),
//                      );
                    
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.search,
//                   size: 30,
//                 )),
//           // child: const Icon(Icons.search,color: Colors.amber,)    
//           // TextFormField(   
//           //             controller: _controller,
//           //           decoration: const InputDecoration(
//           //             prefixIcon: Icon(Icons.search),
//           //           labelText: 'Search',
//           //             border: OutlineInputBorder(),
//           //                      ),
//           //                    validator: (value) {
//           //                    if (value!.isEmpty) {
//           //                return 'Please enter some text';
//           //                 }
//           //             return null;
//           //           },
//           //         ),
//         ],
        
//       ),
//          body: Column(
//            children: [
//             Flexible(
//               flex: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(4.0),
//                     child: SizedBox(
//                       height: 20,
//                       width: 180,
//                       child: Text("List for sale",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
//                     ),
//                   ),
//                    DropdownButton<String>(
//                    value: dropdownValue,
//                    icon: const Icon(Icons.arrow_downward),
//                  elevation: 19,
//                     style: const TextStyle(color: Colors.deepPurple),
//                   underline: Container(
//                      height: 2,
//                    color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? value) {
//                      // This is called when the user selects an item.
//                               setState(() {
//                            dropdownValue = value!;
//                           });
//                              },
//                       items: list.map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                         value: value,
//                       child: Text(value),
//                    );
//                     }).toList(),
//                  )
//                 ],
//               ),
//             ),
//             // Flexible(
//             //   flex: 1,
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //        SizedBox(
//             //         width: 250,
//             //         height: 50,
//             //         child: TextFormField(   
//             //           controller: _controller,
//             //         decoration: const InputDecoration(
//             //           prefixIcon: Icon(Icons.search),
//             //         labelText: 'Search',
//             //           border: OutlineInputBorder(),
//             //                    ),
//             //                  validator: (value) {
//             //                  if (value!.isEmpty) {
//             //              return 'Please enter some text';
//             //               }
//             //           return null;
//             //         },
//             //       ),
//             //       ),
//             //        DropdownButton<String>(
//             //        value: dropdownValue,
//             //        icon: const Icon(Icons.arrow_downward),
//             //      elevation: 19,
//             //         style: const TextStyle(color: Colors.deepPurple),
//             //       underline: Container(
//             //          height: 2,
//             //        color: Colors.deepPurpleAccent,
//             //             ),
//             //             onChanged: (String? value) {
//             //          // This is called when the user selects an item.
//             //                   setState(() {
//             //                dropdownValue = value!;
//             //               });
//             //                  },
//             //           items: list.map<DropdownMenuItem<String>>((String value) {
//             //             return DropdownMenuItem<String>(
//             //             value: value,
//             //           child: Text(value),
//             //        );
//             //         }).toList(),
//             //      )
//             //     ],
//             //   ),
//             // ),
//              Flexible(
//               flex: 4,
//               child: Container(
//                 child: Body_Map(c_id: '', commune: (value) {  }, district: (value) {  }, lat: (value) {  }, log: (value) {  }, province: (value) {  },),
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 //width: 200,
//               ),

//               ),
//             //),
//              Flexible(
//                flex : 6,
//                  child: GridView.count(  
//                         crossAxisCount: 2,  
//                         crossAxisSpacing: 2.0,  
//                         mainAxisSpacing: 2.0,  
//                         // ignore: prefer_const_literals_to_create_immutables
//                         children: [
//                             const StackReusable(
//                             imagere: 'assets/images/homeimage.jpeg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                             const StackReusable(
//                             imagere: 'assets/images/villa.jpg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                             const StackReusable(
//                             imagere: 'assets/images/vilas.jpg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                             const StackReusable(
//                             imagere: 'assets/images/vla.jpeg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                            const StackReusable(
//                             imagere: 'assets/images/homeimage.jpeg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                             const StackReusable(
//                             imagere: 'assets/images/villa.jpg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                             const StackReusable(
//                             imagere: 'assets/images/vilas.jpg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                             const StackReusable(
//                             imagere: 'assets/images/vla.jpeg',
//                             pricere: '10000',
//                             sizere: '72',
//                            ),
//                         ]
//                         ),
//                ),
//              //),
//            ],
//          )  
//     );
//   }
// }

// class StackReusable extends StatelessWidget {
//   final imagere;
//   final pricere;
//   final sizere;
//   const StackReusable({
//    required this.imagere,
//    required this.pricere,
//    required this.sizere,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: Stack(
//         children: [
//           Container(
//             height: 10,
//             width: 100,
//           ),
//           Container(
//           color: Colors.blue,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Image.asset('$imagere',fit: BoxFit.cover,),
//         ),
//          Positioned(  
//                   top: 30,  
//                   left: 0,  
//                   child: Container(  
//       height: 30,  
//       width: 105,  
//       color: Colors.purple,  
//       child: const Center(  
//         child: Text(  
//           'FOR SALE',  
//           style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),  
//         ),  
//       ),  
//                   ),  
//                 ),  
//                  Positioned(  
//                   bottom: 20,  
//                   right: 0,  
//                   child: SizedBox(  
//       child:  Center(  
//         child: Text(  
//           '$pricere dollar',  
//           style: const TextStyle(color: Colors.yellow, fontSize: 14,fontWeight: FontWeight.bold),  
//         ),  
//       ),  
//                   ),  
//                 ), 
//       Positioned(  
//       bottom: 0,  
//       left: 0,  
//       child: SizedBox(   
//       child:  Text(  
//         'Size: $sizere sqm',  
//         style: const TextStyle(color: Colors.yellow, fontSize: 14,fontWeight: FontWeight.bold),  
//       ),  
//                   ),  
//                 ),   
//         ],
         
//       ),
//     );
//   }
// }