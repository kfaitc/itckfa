// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, use_build_context_synchronously, non_constant_identifier_names, unused_import, deprecated_member_use

import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Memory_local/database.dart';
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
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'Customs/Feed_back.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  String? user;
  String? first_name;
  String? last_name;
  String? email;
  String? gender;
  String? from;
  String? tel;
  int? id;
  double? log;
  String? password;
  String? control_user;
  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      await mydb.open();
      slist = await mydb.db.rawQuery('SELECT * FROM user');
      setState(() {
        var i;
        if (slist.length > 0) {
          i = slist.length - 1;
          user = '${slist[i]['first_name']} ${slist[0]['last_name']}';
          first_name = slist[i]['first_name'];
          last_name = slist[i]['last_name'];
          email = slist[i]['email'];
          gender = slist[i]['gender'];
          from = slist[i]['known_from'];
          tel = slist[i]['tel_num'];
          id = slist[i]['id'];
          control_user = slist[i]['username'];
          password = slist[i]['password'];
          // fetchDataFromAPI(control_user ?? "");
        }
        OneSignal.User.addEmail(slist[i]['email']);
      });
    });
  }

  Map? datatest;
  List<Map> slist = [];
  MyDb mydb = new MyDb();
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

  String? expiry;
  List list = [];
  String? now_day;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    now_day = DateFormat('yyyy-MM-dd').format(now);

    final tabs = [
      Body(
        username: user ?? '',
        email: email ?? '',
        first_name: first_name ?? '',
        last_name: last_name ?? '',
        gender: gender ?? '',
        from: from ?? '',
        tel: tel ?? '',
        id: id.toString(),
        password: password ?? "",
        control_user: control_user ?? "",
      ),
      //Center(child: Faps()),
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
                      username: user ?? '',
                      email: email ?? '',
                      first_name: first_name ?? '',
                      last_name: last_name ?? '',
                      gender: gender ?? '',
                      from: from ?? '',
                      tel: tel ?? '',
                      id: id.toString(),
                      password: password ?? "",
                      control_user: control_user ?? "",
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
                      id: id.toString(),
                      id_control_user: control_user ?? "",
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
            // MyDrawerList(
            //   icon: Icons.question_answer,
            //   title: 'FAQ',
            //   Press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) {
            //         return FapsSidebar();
            //       }),
            //     );
            //   },
            // ),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.question_answer),
          //   label: "FAQ",
          //   backgroundColor: kwhite_new,
          // ),
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

  // Future<Map<String, dynamic>> fetchDataFromAPI(String userId) async {
  //   final apiUrl =
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_dateVpoint?id_user_control=$userId';

  //   var data;
  //   final response = await http.get(Uri.parse(apiUrl));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       data = json.decode(response.body);
  //       print('$data');
  //       expiry = data['expiry'];
  //       print('Expiry: $expiry');
  //       DateTime expiryDate = DateTime.parse(expiry!);
  //       DateTime nowDate = DateTime.parse(now_day!);
  //       Duration difference = expiryDate.difference(nowDate);
  //       print(difference.inDays.toString());
  //       if (difference.inDays == 1) {
  //         final player = AudioPlayer();
  //         player.play(AssetSource('nor.mp3'));
  //         Get.snackbar('Message', 'Your V-Point Expiry 1 Days',
  //             colorText: const Color.fromARGB(255, 5, 4, 4),
  //             icon: CircleAvatar(
  //               backgroundImage: AssetImage('assets/images/KFA_CRM.png'),
  //               backgroundColor: Colors.white,
  //             ),
  //             snackPosition: SnackPosition.TOP,
  //             snackbarStatus: (status) => SnackbarStatus.OPENING,
  //             snackStyle: SnackStyle.GROUNDED);
  //       } else {
  //         print('No Expiry');
  //       }
  //     });
  //   }
  //   return data;
  // }
}
