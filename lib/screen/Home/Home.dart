// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, use_build_context_synchronously, non_constant_identifier_names, unused_import, deprecated_member_use

import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:intl/intl.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:itckfa/afa/screens/Auth/login.dart';
import 'package:itckfa/afa/screens/AutoVerbal/Add.dart';
import 'package:itckfa/afa/screens/walletscreen.dart';
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
import 'package:itckfa/screen/Property/Home_Screen_property.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'Customs/Feed_back.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({
    Key? key,
    this.pf,
  }) : super(key: key);
  final bool? pf;
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

  void getdata() {
    if (widget.pf != null) {
      Future.delayed(Duration(seconds: 1), () async {
        await mydb.open();
        slist = await mydb.db.rawQuery('SELECT * FROM user');
        setState(() {
          int i;
          if (slist.isNotEmpty) {
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
            OneSignal.login(slist[i]['username'].toString());
            OneSignal.User.addAlias(
              "fb_id$id",
              slist[i]['username'].toString(),
            );
            OneSignal.User.addTagWithKey(
              "fb_id$id",
              slist[i]['username'].toString(),
            );
          }
        });
      });
      setState(() {
        check = true;
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          check = false;
        });
      });
    } else {
      Future.delayed(Duration(seconds: 1), () async {
        await mydb.open();
        slist = await mydb.db.rawQuery('SELECT * FROM user');
        setState(() {
          int i;
          if (slist.isNotEmpty) {
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
            OneSignal.login(slist[i]['username'].toString());
            OneSignal.User.addAlias(
              "fb_id$id",
              slist[i]['username'].toString(),
            );
            OneSignal.User.addTagWithKey(
              "fb_id$id",
              slist[i]['username'].toString(),
            );
          }
        });
      });
    }
  }

  Map? datatest;
  List<Map> slist = [];
  MyDb mydb = MyDb();
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  String? expiry;
  List list = [];
  String? now_day;
  Future _showCustomSnackbar(String message) async {
    final snackbar = SnackBar(
      content: Container(
        alignment: Alignment.center,
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/done.png'),
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  int _currentIndex = 0;
  bool check = false;
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
      Center(child: Faps()),
      Center(child: Contacts()),
      Center(child: Abouts()),
      Center(child: Feed_back()),
    ];
    if (slist.isNotEmpty) {
      if ((check == false)) {
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
                      MaterialPageRoute(
                        builder: (context) {
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
                        },
                      ),
                    );
                  },
                ),
                MyDrawerList(
                  icon: Icons.list,
                  title: 'Add Verbal',
                  Press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Add(
                            id: id.toString(),
                            id_control_user: control_user ?? "",
                          );
                        },
                      ),
                    );
                  },
                ),
                MyDrawerList(
                  icon: Icons.villa,
                  title: 'Property',
                  Press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Home_Screen_property();
                        },
                      ),
                    );
                  },
                ),
                MyDrawerList(
                  icon: Icons.wallet,
                  title: 'Wallet',
                  Press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Walletscreen();
                        },
                      ),
                    );
                  },
                ),
                MyDrawerList(
                  icon: Icons.question_answer,
                  title: 'FAQ',
                  Press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FapsSidebar();
                        },
                      ),
                    );
                  },
                ),
                MyDrawerList(
                  icon: Icons.contact_phone,
                  title: 'Contact Us',
                  Press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ContactsSidebar();
                        },
                      ),
                    );
                  },
                ),
                MyDrawerList(
                  icon: Icons.people,
                  title: 'About Us',
                  Press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AboutSidebar();
                        },
                      ),
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
      } else {
        return Scaffold(
          body: SafeArea(
            child: InkWell(
              onTap: () {
                setState(() {
                  check = false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    opacity: 0.4,
                    filterQuality: FilterQuality.medium,
                    image: AssetImage('assets/images/design_page.png'),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(227, 76, 175, 79),
                      const Color.fromARGB(212, 255, 235, 59),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      height: 90,
                      width: double.infinity,
                      color: Colors.white38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Thank you for payment\t",
                            style: TextStyle(
                              overflow: TextOverflow.visible,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 18,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.black,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 200,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 1,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(blurRadius: 20, color: Colors.grey),
                              ],
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(50),
                              //     bottomRight: Radius.circular(50)),
                            ),
                            child: SizedBox(
                              height: 200,
                              child: Image.asset(
                                'assets/images/check-mark.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(blurRadius: 20, color: Colors.grey),
                              ],
                            ),
                            child: Text(
                              "Payment Successfully\t",
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                                color: const Color.fromRGBO(0, 225, 1, 1),
                                fontWeight: FontWeight.w800,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    } else {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.4,
                filterQuality: FilterQuality.medium,
                image: AssetImage('assets/images/first.gif'),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(226, 76, 83, 175),
                  Color.fromARGB(211, 101, 59, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }
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
