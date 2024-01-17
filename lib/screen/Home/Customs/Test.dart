// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, unused_import, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itckfa/contants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            //color: Color.fromRGBO(169, 203, 56, 1),
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
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
                    profile_pic(),
                    Divider(
                      color: Colors.blueAccent,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        ProfileData(
                          title: 'Firstname',
                          value: 'Name',
                        ),
                        ProfileData(
                          title: 'Lastname',
                          value: 'Name',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ProfileData1(
                          title: 'Email',
                          value: 'abc@gmail.com',
                        ),
                        ProfileData1(
                          title: 'Phone',
                          value: '0987654321',
                        ),
                        ProfileData1(
                          title: 'Phone',
                          value: '0987654321',
                        ),
                        ProfileData1(
                          title: 'Phone',
                          value: '0987654321',
                        ),
                      ],
                    ),
                  ],
                ),
              )

              // ignore: deprecated_member_use
            ],
          ),
        ),
      ),
    );
  }
}

class profile_pic extends StatelessWidget {
  const profile_pic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.red,
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 60,
                minRadius: 50,
                backgroundColor: kBackgroundColor,
                backgroundImage: AssetImage('assets/images/profile1.webp'),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fullname',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    'ID:',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            left: 82,
            bottom: 20,
            child: SizedBox(
              height: 40,
              width: 40,
              // ignore: deprecated_member_use
              // child: FlatButton(
              //   padding: EdgeInsets.zero,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(50),
              //       side: BorderSide(
              //         color: Colors.blue,
              //       )),
              //   color: kBackgroundColor,
              //   onPressed: () {},
              //   child: SvgPicture.asset(
              //     "assets/icons/camera.svg",
              //     color: Colors.black,
              //     height: 24,
              //     width: 24,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  final String title;
  final String value;
  const ProfileData({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
        top: 10,
      ),
      width: 173,
      //color: Colors.red,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                      // fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Divider(
                  thickness: 1,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
          Icon(LineAwesomeIcons.pen_fancy, size: 25.0),
        ],
      ),
    );
  }
}

class ProfileData1 extends StatelessWidget {
  final String title;
  final String value;
  const ProfileData1({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
        top: 10,
      ),
      //width: 2,
      //color: Colors.red,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                      // fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: 305,
                child: Divider(
                  thickness: 1,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
          Icon(LineAwesomeIcons.pen_fancy, size: 25.0),
        ],
      ),
    );
  }
}
