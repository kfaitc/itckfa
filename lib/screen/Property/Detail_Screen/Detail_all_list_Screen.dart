// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, prefer_adjacent_string_concatenation, avoid_print, unused_local_variable, must_be_immutable, unnecessary_brace_in_string_interps, file_names, unnecessary_null_comparison, unused_element, deprecated_member_use
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itckfa/screen/Property/Detail_Screen/print.dart';

import 'package:url_launcher/url_launcher.dart';

class Detail_property_sale_all extends StatefulWidget {
  List? list_get_sale;

  String? verbal_ID;
  Detail_property_sale_all({
    super.key,
    required this.verbal_ID,
    required this.list_get_sale,
  });

  @override
  State<Detail_property_sale_all> createState() => _Detail_propertyState();
}

class _Detail_propertyState extends State<Detail_property_sale_all> {
  int? myMatch;
  String? verbal;
  late Map<String, dynamic> myElement;
  @override
  void initState() {
    super.initState();

    List<int> myNumbers = widget.verbal_ID!.split(',').map(int.parse).toList();
    int myId = int.parse(widget.verbal_ID!);
    for (int num in myNumbers) {
      if (num == myId) {
        myMatch = num;
        break;
      }
    }
    print(myMatch);

    myElement = widget.list_get_sale!
        .firstWhere((element) => element['id_ptys'] == myMatch);
    // print(myElement);
    // lat_log();
  }

  double lat = 0;
  double log = 0;
  List list_latlog = [];
  // Future<void> lat_log() async {
  //   var jsonData;
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/loglat_property/${myMatch.toString()}'));

  //   if (response.statusCode == 200) {
  //     jsonData = jsonDecode(response.body)['data'];
  //     list_latlog = jsonData;
  //     setState(() {
  //       print(list_latlog.toString());
  //       // list_latlog;
  //       lat = double.parse(list_latlog[0]['lat'].toString());
  //       log = double.parse(list_latlog[0]['log'].toString());
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _title_field(text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 131, 128, 128),
          fontSize: MediaQuery.of(context).size.height * 0.015),
    );
  }

  var Sizebox_5 = SizedBox(height: 5);
  var Sizebox_10 = SizedBox(height: 10);
  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _image(),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: mutiple_image(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: []),
                _location(),
                Sizebox_5,
                _title_field('FACE AND FEATURES'),
                Sizebox_10,
                type(),
                Sizebox_10,
                filed(),
                Sizebox_5,
                _title_field('PROPERTY DESCRIPTION'),
                Sizebox_10,
                text_ds(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dc() {
    return Column(
      children: [
        Row(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.04,
                child: Image.asset(
                  'assets/icons/arrow_icons.png',
                  fit: BoxFit.cover,
                )),
            SizedBox(width: 10),
            Text(
              'Desciption ៖ ',
              // maxLines: 30,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015),
            ),
          ],
        ),
        Text(
          'So it’s tough out there for a novelist, which is why we built this generator: to try and give you some inspiration. Any of the titles that you score through it are yours to use. We’d be even more delighted if you dropped us the success story at service@reedsy.com! If you find that you need even more of a spark beyond our generator, the Internet’s got you covered. Here are some of our other favorite generators on the web:',
          maxLines: 10,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        )
      ],
    );
  }

  Widget text_ds() {
    return Container(
      height: MediaQuery.of(context).size.height * 1.2,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _icons_text('assets/icons/arrow_icons.png', 'Price', '\$',
              '${myElement['price'] ?? ""}', '(Negotiate)'),
          dc(),
          _size(
              'assets/icons/arrow_icons.png',
              'Size Land',
              '${myElement['land_w'] ?? ""}',
              '៖',
              '${myElement['land_l'] ?? ""}',
              '${myElement['land'] ?? ""}'),
          _size(
              'assets/icons/arrow_icons.png',
              'Size House',
              '${myElement['Size_l'] ?? ""}',
              '៖',
              '${myElement['size_w'] ?? ""}',
              '${myElement['size_house'] ?? ""}'),
          issuance(),
          Sizebox_10,
          _text('Plese Contact ៖'),
          Sizebox_10,
          _phone('assets/icons/phone_icon.png', '(CellCard)', '077 216 168'),
          Sizebox_10,
          _phone('assets/icons/phone_icon.png', 'Officer',
              '023 999 855 | 023 988 911'),
          Sizebox_10,
          InkWell(
            onTap: () {
              setState(() {
                launch(
                  'https://kfa.com.kh/contacts',
                  forceSafariVC: false,
                  forceWebView: false,
                );
              });
            },
            child: _phone('assets/icons/web_icons.png', '',
                'https://kfa.com.kh/contacts'),
          ),
          Sizebox_10,
          InkWell(
            onTap: () {
              setState(() {
                launch(
                  'https://kfa.com.kh/contacts',
                  forceSafariVC: false,
                  forceWebView: false,
                );
              });
            },
            child: _phone(
                'assets/icons/gmail_icon.png', '(Gmail) : ', 'info@kfa.com.kh'),
          ),
          Sizebox_10,
          InkWell(
            onTap: () {
              setState(() {
                launch(
                  'https://www.google.com/maps/@11.5193408,104.9162703,20z?entry=ttu',
                  forceSafariVC: false,
                  forceWebView: false,
                );
              });
            },
            child: Reach_US(
              'assets/icons/mylocation.png',
            ),
          ),
          Sizebox_10,
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                link_url('assets/icons/facebook.png',
                    'https://www.facebook.com/kfa.com.kh/'),
                SizedBox_w_5,
                link_url(
                    'assets/icons/telegram.png', 'https://t.me/kfa_official'),
                SizedBox_w_5,
                link_url('assets/icons/twitter.jpg',
                    'https://twitter.com/i/flow/login?redirect_after_login=%2FKFA_Cambodia'),
                SizedBox_w_5,
                link_url('assets/icons/in.png',
                    'https://www.linkedin.com/company/khmerfoundationappraisal/'),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: 20),
          map(),
        ],
      ),
    );
  }

  Widget map() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: InkWell(
        onTap: () {
          // setState(() {
          //   print('Google map');
          //   Navigator.push(context, MaterialPageRoute(
          //     builder: (context) {
          //       return GoogleMapScreen(
          //         id: '${myElement['id_ptys'].toString()}',
          //       );
          //     },
          //   ));
          // });
        },
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholderFit: BoxFit.contain,
          placeholder: 'assets/earth.gif',
          image:
              "https://maps.googleapis.com/maps/api/staticmap?center=${myElement['lat'].toString()},${myElement['log'].toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${myElement['lat'].toString()},${myElement['log'].toString()}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI",
        ),
      ),
    );
  }

  Widget price(icon, url) {
    return InkWell(
      onTap: () async {
        print('${myMatch.toString()}');
        // await Printing.layoutPdf(
        //     onLayout: (format) =>
        //         _generatePdf(format, widget.list_get_sale!, 1));
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.018,
        backgroundImage: AssetImage('$icon'),
      ),
    );
  }

  var SizedBox_w_5 = SizedBox(width: 6);
  Widget link_url(icon, url) {
    return InkWell(
      onTap: () {
        setState(() {
          launch(
            '$url',
            forceSafariVC: false,
            forceWebView: false,
          );
        });
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.018,
        backgroundImage: AssetImage('$icon'),
      ),
    );
  }

  Widget Reach_US(icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _phone('assets/icons/mylocation.png', '(Reach US) : ', ''),
          ],
        ),
        Sizebox_5,
        Text(
          ' #36A, St.04 Borey Peng Hourt The Star Natural. Sangkat Chakangre Leu, Khan Meanchey, Phnom Penh.',
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
          maxLines: 5,
        ),
      ],
    );
  }

  Widget _phone(icon, man, text) {
    return Row(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.053,
            child: Image.asset(
              '$icon',
              fit: BoxFit.cover,
            )),
        SizedBox(width: 8),
        Text(
          '$man  $text',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        )
      ],
    );
  }

  Widget issuance() {
    return Row(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.04,
            child: Image.asset(
              'assets/icons/arrow_icons.png',
              fit: BoxFit.cover,
            )),
        SizedBox(width: 8),
        Text(
          'issuance of transfer service (hard copy)',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        ),
      ],
    );
  }

  Widget _size(icon, text, man, l, w, size) {
    return Row(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.04,
            child: Image.asset(
              'assets/icons/arrow_icons.png',
              fit: BoxFit.cover,
            )),
        SizedBox(width: 8),
        Text(
          '$text $man $l x $w = $size' + ' m' + '\u00B2',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        )
      ],
    );
  }

  Widget _icons_text(icon, text, type, value, explan) {
    return Row(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.04,
            child: Image.asset(
              'assets/icons/arrow_icons.png',
              fit: BoxFit.cover,
            )),
        SizedBox(width: 8),
        Text(
          '$text ៖ $type$value $explan',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        ),
      ],
    );
  }

  Widget filed() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 242, 240, 240),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 0.06)),
          height: MediaQuery.of(context).size.height * 0.045,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.height * 0.0044,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 13, 101, 173),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '${myElement['type'] ?? ""} >',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: Color.fromARGB(255, 15, 93, 157)),
              ),
              Text(
                '\$${myElement['price'] ?? ""}',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: Color.fromARGB(255, 160, 29, 20)),
              ),
              Spacer(),
              Print_property(
                  list: widget.list_get_sale!, verbal_ID: widget.verbal_ID),
              SizedBox(width: 10),
            ],
          ),
        )
      ],
    );
  }

  Widget _Icons(text, text1, value) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Row(
        children: [
          Column(
            children: [
              // Text(
              //   '$text1',
              //   style: TextStyle(
              //       fontSize: MediaQuery.of(context).size.height * 0.015),
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.07,
                child: Image.asset(text),
              ),
            ],
          ),
          SizedBox(width: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _text_type(text1),
              _text_type(value),
            ],
          )
        ],
      ),
    );
  }

  Widget _text_type(text) {
    return Text(
      text,
      style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.011),
    );
  }

  Widget _text(text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.014,
          fontWeight: FontWeight.bold),
    );
  }

  Widget type() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Icons('assets/icons/house.png', 'hometype',
                '${myElement['type'] ?? ""}'),
            _Icons('assets/icons/lot.png', 'lot(sqm)',
                '${myElement['land'] ?? ""}'),
            _Icons('assets/icons/parking.png', 'parking',
                '${myElement['Parking'] ?? ""}'),
            _Icons(
                'assets/icons/size_house.png',
                "price(sqm)",
                // '${myElement['Livingroom'] ?? ""}'),
                '${myElement['price_sqm'] ?? ""}'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Icons('assets/icons/bed.png', 'Bed', '${myElement['bed'] ?? ""}'),
            _Icons('assets/icons/Size.png', 'Size(sqm)',
                '${myElement['sqm'] ?? ""}'),
            _Icons('assets/icons/floor.png', 'Floor',
                '${myElement['floor'] ?? ""}'),
            _Icons(
                'assets/icons/ice.png',
                "Aircon",
                // '${myElement['Livingroom'] ?? ""}'),
                '${myElement['aircon'] ?? ""}'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Icons(
                'assets/icons/bath.png', 'bath', '${myElement['bath'] ?? ""}'),
            _Icons('assets/icons/area.png', 'Private_Area(${' m' + '\u00B2'})',
                '${myElement['Private_Area'] ?? ""}'),
            _Icons('assets/icons/living_room.png', 'Livingroom',
                '${myElement['Livingroom'] ?? ""}'),
            _Icons(
                'assets/icons/total_area.png',
                "TotalArea(${' m' + '\u00B2'})",
                // '${myElement['Livingroom'] ?? ""}'),
                '${myElement['total_area'] ?? ""}'),
          ],
        ),
      ],
    );
  }

  Widget _location() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Sizebox_5,
        Text(
          '${myElement['Title']}',
          maxLines: 3,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.014,
              color: Colors.black),
        ),
        SizedBox(height: 5),
        _text(
            '${myElement['address'] ?? ""} / ${myElement['Name_cummune'] ?? ""} / Cambodia'),
      ],
    );
  }

  Widget mutiple_image() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: myElement['url_1'].toString(),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: myElement['url_1'].toString(),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: myElement['url_2'].toString(),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: myElement['url_2'].toString(),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _image() {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //<-- SEE HERE
        ),
        child: CachedNetworkImage(
          imageUrl: myElement['url'].toString(),
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).size.height * 0.05,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: MediaQuery.of(context).size.height * 0.05,
              color: Colors.white,
            )),
      ),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.21,
          left: 10,
          child: Text(
            'ID : ${myElement['id_ptys']}',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.018),
          )),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.235,
          left: 10,
          child: Text(
            '${myElement['type']}  ${myElement['urgent']}',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.018),
          )),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.27,
          left: 10,
          child: Text(
            '\$ ${myElement['price']}',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.03),
          )),
    ]);
  }
}
