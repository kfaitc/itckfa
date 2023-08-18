// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, prefer_const_declarations, deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itckfa/contants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(235, 7, 9, 145),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(235, 7, 9, 145),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/notification.svg"),
            onPressed: () {},
          )
        ],
        title: Text(
          'Contact Us',
          style: TextStyle(
            //color: Color.fromRGBO(169, 203, 56, 1),
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70,
        // flexibleSpace: SafeArea(
        //   child: Text('FAQ'),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/logo1.png'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "KHMER FOUNDATION APPRAISAL",
                      style: TextStyle(
                        color: kImageColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Cards(
                      icon: LineAwesomeIcons.address_card_1,
                      title: 'Address: Phnom Penh, Phnom Penh',
                      onPressed: () async {
                        final String googleMapUrl =
                            "https://www.google.com/maps/d/viewer?mid=1Q4igXdd9aAegzPzyN7t9jvSAaat4uBMx&hl=en&ll=11.518657300000022%2C104.9172223&z=17";
                        if (await canLaunch(googleMapUrl)) {
                          await launch(googleMapUrl);
                        } else {
                          throw "Could not get URL";
                        }
                      },
                      //trailing: '',
                    ),
                    Cards(
                      icon: Icons.phone_android,
                      title: 'Phone number: +855 0987654321',
                      // trailing: '+855 0987654321',
                    ),
                    Cards(
                      icon: Icons.phone,
                      title: 'Hot-line: +855 0987654321',
                      //trailing: '+855 0987654321',
                    ),
                    Cards(
                      icon: Icons.email,
                      title: 'Email: company123@gmail.com',
                      //trailing: 'company123@gmail.com',
                    ),
                    Cards(
                      icon: Icons.phone,
                      title: 'Phone number: +855 0987654321',
                      //trailing: '+855 0987654321',
                    ),
                    Cards(
                      icon: Icons.facebook,
                      title: 'Facebook Page: KFA Comapany',
                      //trailing: 'KFA Comapany',
                    ),
                    Cards(
                      icon: Icons.telegram,
                      title: 'Telegram: +855 0987654321',
                      // trailing: '+855 0987654321',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String title;
  final icon;
  final onPressed;
  //final String trailing;

  const Cards({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
    //required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      //color: Colors.red,
      decoration: BoxDecoration(
        boxShadow: [kShadow],
        //color: kImageColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            margin: EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              //color: kImageColor,
              color: Colors.lightBlue[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: ListTile(
              // shape: ShapeBorder.,
              // trailing: Text(
              //   trailing,
              //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              // ),
              leading: Icon(
                icon,
                //color: Colors.white,
                color: Colors.white, size: 25,
              ),
              //textColor: Colors.white,
              title: Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
