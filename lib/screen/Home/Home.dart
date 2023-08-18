// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, use_build_context_synchronously, non_constant_identifier_names, unused_import, deprecated_member_use

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/afa/screens/Auth/login.dart';
import 'package:itckfa/afa/screens/AutoVerbal/Add.dart';
import 'package:itckfa/screen/Abouts/Abouts.dart';
import 'package:itckfa/screen/Abouts/aboutSideBar.dart';
import 'package:itckfa/screen/Account/account.dart';
import 'package:itckfa/screen/Contacts/ContactUs_sidebar.dart';
import 'package:itckfa/screen/Contacts/ContactsUs.dart';
import 'package:itckfa/screen/Faqs/fapsSidebar.dart';
import 'package:itckfa/screen/Faqs/faqs.dart';
import 'package:itckfa/screen/Home/Body.dart';
import 'package:itckfa/screen/Home/Customs/Drawer_menu.dart';
import 'package:itckfa/screen/Home/Customs/MyDrawerList.dart';
import 'package:itckfa/screen/Promotion/PartnerList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Customs/Feed_back.dart';

class HomePage1 extends StatefulWidget {
  final String? user;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? gender;
  final String? from;
  final String? tel;
  final String? id;
  final double? log;
  final double? lat;

  const HomePage1({
    Key? key,
    this.user,
    this.first_name,
    this.last_name,
    this.email,
    this.gender,
    this.from,
    this.tel,
    this.id,
    this.log,
    this.lat,
  }) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  Future logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    Fluttertoast.showToast(
      msg: 'Log Out',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.blue,
      fontSize: 20,
    );
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  @override
  void initState() {
    print(widget.id);
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Center(
          child: Body(
        lat: widget.lat,
        log: widget.log,
        user: widget.user ?? '',
        email: widget.email ?? '',
        first_name: widget.first_name ?? '',
        last_name: widget.last_name ?? '',
        gender: widget.gender ?? '',
        from: widget.from ?? '',
        tel: widget.tel ?? '',
        id: widget.id ?? '',
      )),
      Center(child: Faps()),
      Center(child: Contacts()),
      Center(child: Abouts()),
      Center(child: Feed_back()),
    ];
    return Scaffold(
      body: tabs[_currentIndex],
      drawer: Drawer(
        width: 270,
        child: ListView(
          children: [
            //MyHeaderDrawer(),
            MyDrawerList(
              icon: Icons.people,
              title: 'Account',
              Press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Account(
                      username: widget.user ?? '',
                      email: widget.email ?? '',
                      first_name: widget.first_name ?? '',
                      last_name: widget.last_name ?? '',
                      gender: widget.gender ?? '',
                      from: widget.from ?? '',
                      tel: widget.tel ?? '',
                      id: widget.id ?? '',
                    );
                  }),
                );
              },
            ),
            MyDrawerList(
              icon: Icons.list,
              title: 'Add Verbal',
              Press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Add(
                      id: widget.id ?? '',
                    );
                  }),
                );
              },
            ),
            MyDrawerList(
              icon: Icons.villa,
              title: 'Property',
              Press: () {},
            ),
            MyDrawerList(
              icon: Icons.wallet,
              title: 'Wallet',
              Press: () {},
            ),
            MyDrawerList(
              icon: Icons.question_answer,
              title: 'FAQ',
              Press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return FapsSidebar();
                  }),
                );
              },
            ),
            MyDrawerList(
              icon: Icons.contact_phone,
              title: 'Contact Us',
              Press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ContactsSidebar();
                  }),
                );
              },
            ),
            MyDrawerList(
              icon: Icons.people,
              title: 'About Us',
              Press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AboutSidebar();
                  }),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              color: Colors.blueAccent,
            ),
            MyDrawerList(
              icon: Icons.lock,
              title: 'Log Out',
              Press: () {
                logOut();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kwhite_new,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
            backgroundColor: kwhite_new,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: "FAQ",
            backgroundColor: kwhite_new,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: "Contact",
            backgroundColor: kwhite_new,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "About",
            backgroundColor: kwhite_new,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: "FeedBack",
            backgroundColor: kwhite_new,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
