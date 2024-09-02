import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import '../../../../screen/Property/Screen_Page/Search_Screen.dart';
import 'Add_verbal_Approbal.dart';
import 'add_PropertyPrce.dart';
import 'listview.dart';

class Menu_Add_verbal extends StatefulWidget {
  const Menu_Add_verbal({
    super.key,
    required this.id,
    required this.id_control_user,
  });
  final String id;
  final String id_control_user;
  @override
  State<Menu_Add_verbal> createState() => _Menu_Add_verbalState();
}

class _Menu_Add_verbalState extends State<Menu_Add_verbal> {
  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      // setState(() {
      //   permissionGranted = true;
      // });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      // setState(() {
      //   permissionGranted = false;
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    _getStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.yellow,
      Colors.lightGreen,
      Color.fromRGBO(169, 255, 194, 1),
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Horizon',
      color: Colors.white,
      shadows: [Shadow(blurRadius: 2, color: Colors.deepPurpleAccent)],
    );
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 100),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: ui.Color.fromARGB(255, 191, 197, 186),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(250),
                  bottomRight: Radius.circular(250),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Add_with_property(
                              id: widget.id,
                              id_control_user: widget.id_control_user),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 50),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(90)),
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                        ],
                      ),
                      child: const Text(
                        "Cross check price",
                        style: colorizeTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Add_with_Approval(
                            id: widget.id,
                            id_control_user: widget.id_control_user,
                          ),
                        ),
                      );
                    },
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 50, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          boxShadow: const [
                            BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                          ],
                        ),
                        child: const Text("Verbal Check by Approval",
                            style: colorizeTextStyle)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => List_Auto(
                            verbal_id: widget.id,
                            id_control_user: widget.id_control_user,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 50),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                        ],
                      ),
                      child: const Text(
                        "List Auto Verbal",
                        style: colorizeTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Map_List_search(
                            get_commune: (value) {},
                            get_district: (value) {},
                            get_lat: (value) {},
                            get_log: (value) {},
                            get_max1: (value) {},
                            get_max2: (value) {},
                            get_min1: (value) {},
                            get_min2: (value) {},
                            get_province: (value) {},
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 50),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                        ),
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                        ],
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Search Map',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                            speed: const Duration(milliseconds: 70),
                          )
                        ],
                        //child: Text("Search Map")
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Map_List_search(
                                get_commune: (value) {},
                                get_district: (value) {},
                                get_lat: (value) {},
                                get_log: (value) {},
                                get_max1: (value) {},
                                get_max2: (value) {},
                                get_min1: (value) {},
                                get_min2: (value) {},
                                get_province: (value) {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              right: 1,
              child: SizedBox(
                height: 90,
                child: Image.asset("assets/images/KFA_CRM.png"),
              ),
            ),
            Positioned(
              top: 1,
              left: 1,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.chevron_left_outlined,
                    size: 35, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
