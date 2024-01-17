// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, deprecated_member_use, camel_case_types, prefer_typing_uninitialized_variables, await_only_futures

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itckfa/contants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsSidebar extends StatefulWidget {
  const ContactsSidebar({Key? key}) : super(key: key);

  @override
  State<ContactsSidebar> createState() => _ContactsSidebarState();
}

class _ContactsSidebarState extends State<ContactsSidebar> {
  Future<void> _makePhoneCall(String url) async {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
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

  // _launchEmail() async {
  //   launch(
  //       "mailto:fluttercoolestpackages@gmail.com?subject=TestEmail&body=Test email%plugin");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(235, 7, 9, 145),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(235, 7, 9, 145),
        elevation: 0,
        centerTitle: true,
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
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.all(15),
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
                            fontSize: 18, fontWeight: FontWeight.bold,),
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
                            top: 10, right: 40, left: 40, bottom: 10,),
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
                                width: 10,
                              ),
                              Text('Get Direction in Map'),
                            ],
                          ),
                          onPressed: () async {
                            const String googleMapUrl =
                                "https://www.google.com/maps/d/viewer?mid=1Q4igXdd9aAegzPzyN7t9jvSAaat4uBMx&hl=en&ll=11.518657300000022%2C104.9172223&z=17";
                            await launch(
                              googleMapUrl,
                              forceSafariVC: false,
                              forceWebView: false,
                            );
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: 0.5,
                      ),
                      Text(
                        "Hotlines:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,),
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
                            fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        children: [
                          appIcons(
                              press: () async {
                                const url =
                                    "https://www.facebook.com/kfa.com.kh/";
                                if (await canLaunch(url)) {
                                  await launch(url,
                                      forceSafariVC: true,
                                      enableJavaScript: true,);
                                }
                              },
                              img: 'assets/images/Facebook_Logo.png',),
                          appIcons(
                              press: () async {
                                const url = "https://twitter.com/KFA_Cambodia";
                                if (await canLaunch(url)) {
                                  await launch(url,
                                      forceSafariVC: true,
                                      enableJavaScript: true,);
                                }
                              },
                              img: 'assets/images/twitter-logo.png',),
                          appIcons(
                              press: () async {
                                const url =
                                    "https://www.linkedin.com/company/khmerfoundationappraisal/";
                                if (await canLaunch(url)) {
                                  await launch(url,
                                      forceSafariVC: true,
                                      enableJavaScript: true,);
                                }
                              },
                              img:
                                  'assets/images/LinkedIn_icon_circle.svg.png',),
                          appIcons(
                              press: () {},
                              img:
                                  'assets/images/YouTube_full-color_icon_(2017).svg.webp',),
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
          iconSize: 40,
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
            side: BorderSide(color: Colors.black12, width: 0.5),),
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
