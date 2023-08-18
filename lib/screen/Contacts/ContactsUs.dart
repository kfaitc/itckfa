// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, prefer_const_declarations, prefer_typing_uninitialized_variables, deprecated_member_use, unused_import, avoid_print, unused_element, await_only_futures, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../afa/components/contants.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Future<void> _makePhoneCall(String url) async {
    await launch(url);
    print("Could get Url");
  }

  Future<void> _googleMap(String url) async {
    if (await canLaunch(url)) {
      print('can launch $url');
      await launch(
        url,
      );
    } else {
      print('Could not launch $url');
    }
  }

  final Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.defaultMarker;
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(11.518936, 104.934026),
          icon: mapMarker,
          infoWindow: InfoWindow(
            title: "Khmer Foundation Appraisal Co., Ltd",
            snippet: "Real estate agent",
          ),
        ),
      );
    });
  }
  // Future OpenDialog() => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('You can open Url'),
  //       ),
  //     );

  // _launchEmail() async {
  //   launch(
  //       "mailto:fluttercoolestpackages@gmail.com?subject=TestEmail&body=Test email%plugin");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite_new,
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
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
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(25),
              //   topRight: Radius.circular(25),
              // ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "KFA Head Office",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop_sharp,
                            color: kImageColor,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Location:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '#36A, St.04 Borey Peng Hourt The Star Natural. Sangkat Chakangre Leu, Khan Meanchey, Phnom Penh.',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.lightBlue),
                        ),
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          markers: _markers,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(11.518936, 104.934026),
                            zoom: 18,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: 10, right: 40, left: 40, bottom: 10),
                        child: ElevatedButton(
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Get Direction in Map'),
                            ],
                          ),
                          // onPressed: () => setState(() {
                          //   _googleMap(
                          //       'https://www.google.com/maps/d/viewer?mid=1Q4igXdd9aAegzPzyN7t9jvSAaat4uBMx&hl=en&ll=11.518657300000022%2C104.9172223&z=17');
                          //   //OpenDialog();
                          // }),
                          onPressed: () async {
                            final String googleMapUrl =
                                "https://www.google.com/maps/d/viewer?mid=1Q4igXdd9aAegzPzyN7t9jvSAaat4uBMx&hl=en&ll=11.518657300000022%2C104.9172223&z=17";
                            await launch(
                              googleMapUrl,
                              forceSafariVC: false,
                              enableJavaScript: false,
                            );
                          },
                        ),
                      ),
                      // Link(
                      //   target: LinkTarget.self,
                      //   uri: Uri.parse(
                      //       'https://www.google.com/maps/d/viewer?mid=1Q4igXdd9aAegzPzyN7t9jvSAaat4uBMx&hl=en&ll=11.518657300000022%2C104.9172223&z=17'),
                      //   builder: (context, followLink) => ElevatedButton(
                      //       onPressed: followLink, child: Text('Open in Maps')),
                      // ),
                      // Divider(
                      //   color: Colors.black12,
                      //   thickness: 0.5,
                      // ),
                      Text(
                        "Hotlines:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Hotline(
                        onPress: () => setState(() {
                          _makePhoneCall('tel:077 216 168');
                        }),
                        icon: Icons.phone,
                        phone: '(855) 77 216 168',
                      ),
                      Hotline(
                        onPress: () => setState(() {
                          _makePhoneCall('tel:023 999 855');
                        }),
                        icon: Icons.phone,
                        phone: '(855) 23 999 855',
                      ),
                      Hotline(
                        onPress: () => setState(() {
                          _makePhoneCall('tel:023 988 911');
                        }),
                        icon: Icons.phone,
                        phone: '(855) 23 988 911',
                      ),
                      Hotline(
                        onPress: () => setState(() {
                          // _launchEmail();
                        }),
                        icon: Icons.email,
                        phone: 'info@kfa.com.kh',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: 0.5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Find out more about KFA:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        children: [
                          appIcons(
                              press: () async {
                                final String url =
                                    "https://www.facebook.com/kfa.com.kh/";
                                await launch(
                                  url,
                                  forceSafariVC: false,
                                  forceWebView: false,
                                );
                                // OpenDialog();
                              },
                              img: 'assets/images/Facebook_Logo.png'),
                          appIcons(
                              press: () async {
                                final url = "https://twitter.com/KFA_Cambodia";
                                await launch(
                                  url,
                                  forceSafariVC: false,
                                  forceWebView: false,
                                );
                              },
                              img: 'assets/images/twitter-logo.png'),
                          appIcons(
                              press: () async {
                                final url =
                                    "https://www.linkedin.com/company/khmerfoundationappraisal/";
                                await launch(
                                  url,
                                  forceSafariVC: false,
                                  forceWebView: false,
                                );
                                print("okay");
                              },
                              img:
                                  'assets/images/LinkedIn_icon_circle.svg.png'),
                          appIcons(
                              press: () {},
                              img:
                                  'assets/images/YouTube_full-color_icon_(2017).svg.webp'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class appIcons extends StatelessWidget {
  final img;
  final press;
  const appIcons({
    Key? key,
    this.img,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: press,
          icon: Image.asset(
            img,
          ),
          iconSize: 30,
        )
      ],
    );
  }
}

class Hotline extends StatelessWidget {
  final String phone;
  final icon;
  final onPress;
  const Hotline({
    Key? key,
    required this.phone,
    this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        top: 5,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            // minimumSize: Size.fromRadius(40),
            side: BorderSide(color: Colors.black12, width: 0.5)),
        onPressed: onPress,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blue,
            ),
            SizedBox(
              width: 10,
            ),
            Text(phone),
          ],
        ),
      ),
    );
  }
}
