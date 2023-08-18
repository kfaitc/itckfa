// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itckfa/screen/Profile/components/FieldBox.dart';
import 'package:itckfa/screen/Profile/components/TwinBox.dart';
import 'package:itckfa/screen/Profile/components/genderBox.dart';
import 'package:itckfa/screen/Profile/components/profile_pic.dart';
import 'package:itckfa/screen/Profile/components/singleBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            //color: Color.fromRGBO(169, 203, 56, 1),
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: 700,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //   // topLeft: Radius.circular(20),
              //   // topRight: Radius.circular(20),
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              //---Profile---//
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //width: MediaQuery.of(context).size.width /2,
                  child: Column(
                    children: [
                      //Profile_pic(),
                      Divider(
                        color: Colors.blueAccent,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          TwinBox(
                            fname: '',
                            lname: '',
                            labelText1: 'First Name',
                            labelText2: 'Last Name',
                            get_fname: (value) {},
                            get_lname: (value) {},
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          GenderBox(
                            gender: 'widget.gender',
                            from: 'widget.from',
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SingleBox(
                            phone: '',
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Field_box(
                            name: 'Email',
                            email: '',
                            get_email: (value) {},
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Field_box(
                            name: 'Address',
                            email: '',
                            get_email: (value) {},
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),

                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(40.0),
                        child: ElevatedButton(
                          child: Text('Save Change'),
                          onPressed: () {
                            //SaveImage();
                          },
                        ),
                      )
                      // Column(
                      //   children: [

                      //   ],
                      // ),
                    ],
                  ),
                )

                // ignore: deprecated_member_use
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void SaveImage(path) async {
  //   SharedPreferences saveimage = await SharedPreferences.getInstance();
  //   saveimage.setString('imagepath', path);
  // }

  // void LoadImage() async {
  //   SharedPreferences saveimage = await SharedPreferences.getInstance();
  //   setState(() {
  //     _imagepath = saveimage.getString("imagepath")!;
  //   });
  // }
}

// class profile_pic extends StatelessWidget {
//   const profile_pic({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       //color: Colors.red,
//       width: double.infinity,
//       height: 150,
//       child: Stack(
//         children: [
//           Row(
//             //mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 maxRadius: 60,
//                 minRadius: 50,
//                 backgroundColor: kBackgroundColor,
//                 backgroundImage: AssetImage('assets/images/profile1.webp'),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Meng Chanrithty',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     '123456789',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           Positioned(
//             left: 82,
//             bottom: 20,
//             child: SizedBox(
//               height: 40,
//               width: 40,
//               // ignore: deprecated_member_use
//               child: FlatButton(
//                 padding: EdgeInsets.zero,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     side: BorderSide(
//                       color: Colors.blue,
//                     )),
//                 color: kBackgroundColor,
//                 onPressed: () {},
//                 child: SvgPicture.asset(
//                   "assets/icons/camera.svg",
//                   color: Colors.black,
//                   height: 24,
//                   width: 24,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//}

// class ProfileData extends StatelessWidget {
//   final String title;
//   final String value;
//   const ProfileData({Key? key, required this.title, required this.value})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         right: 5,
//         left: 5,
//         top: 10,
//       ),
//       width: 173,
//       //color: Colors.red,
//       child: Row(
//         //mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                       color: Colors.grey,
//                       // fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               TextField(
//                 value,
//                 style: Theme.of(context).textTheme.subtitle2?.copyWith(
//                       color: Colors.black,
//                       //fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 3,
//                 child: Divider(
//                   thickness: 1,
//                   color: Colors.lightBlue,
//                 ),
//               ),
//             ],
//           ),
//           Icon(LineAwesomeIcons.pen_fancy, size: 25.0),
//         ],
//       ),
//     );
//   }
// }

// class ProfileData1 extends StatelessWidget {
//   final String title;
//   final String value;
//   const ProfileData1({Key? key, required this.title, required this.value})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         right: 5,
//         left: 5,
//         top: 10,
//       ),
//       //width: 2,
//       //color: Colors.red,
//       child: Row(
//         //mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                       color: Colors.grey,
//                       // fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               Text(
//                 value,
//                 style: Theme.of(context).textTheme.subtitle2?.copyWith(
//                       color: Colors.black,
//                       //fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               SizedBox(
//                 width: 305,
//                 child: Divider(
//                   thickness: 1,
//                   color: Colors.lightBlue,
//                 ),
//               ),
//             ],
//           ),
//           Icon(LineAwesomeIcons.pen_fancy, size: 25.0),
//         ],
//       ),
//     );
//   }
//}