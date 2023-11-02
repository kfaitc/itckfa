// ignore_for_file: unused_element, must_be_immutable, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Print_property extends StatefulWidget {
  Print_property({super.key, required this.list, required this.verbal_ID});
  List list = [];

  String? verbal_ID;

  @override
  State<Print_property> createState() => _Print_propertyState();
}

class _Print_propertyState extends State<Print_property> {
  int index = 0;
  int? myMatch;
  late Map<String, dynamic> myElement;
  @override
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
    // print(myMatch);

    myElement =
        widget.list.firstWhere((element) => element['id_ptys'] == myMatch);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await Printing.layoutPdf(
              onLayout: (format) => _generatePdf(format, myElement));
        },
        icon: Icon(
          Icons.print_outlined,
          size: MediaQuery.of(context).size.height * 0.045,
          color: Color.fromARGB(255, 10, 16, 171),
        ));
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, items) async {
    // Create a new PDF document
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    //////////////////////////
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    Uint8List bytes1 = (await NetworkAssetBundle(Uri.parse('${items['url']}'))
            .load('${items['url']}'))
        .buffer
        .asUint8List();
    // Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse('${items['url_1']}'))
    //         .load('${items['url_1']}'))
    //     .buffer
    //     .asUint8List();
    // Uint8List bytes3 = (await NetworkAssetBundle(Uri.parse('${items['url_2']}'))
    //         .load('${items['url_2']}'))
    //     .buffer
    //     .asUint8List();
    ///////////Image //////////////////////////
    final ByteData aircon_type_b =
        await rootBundle.load('assets/icons/ice.png');
    final Uint8List aircon_type = aircon_type_b.buffer.asUint8List();
    final ByteData Size_b = await rootBundle.load('assets/icons/Size.png');
    final Uint8List Size = Size_b.buffer.asUint8List();
    final ByteData livingroom_b =
        await rootBundle.load('assets/icons/living_room.png');
    final Uint8List livingroom = livingroom_b.buffer.asUint8List();
    ///////////////////////
    final ByteData house_type_b =
        await rootBundle.load('assets/icons/house.png');
    final Uint8List house_type = house_type_b.buffer.asUint8List();
    final ByteData area_b = await rootBundle.load('assets/icons/area.png');
    final Uint8List area = area_b.buffer.asUint8List();
    final ByteData total_area_b =
        await rootBundle.load('assets/icons/total_area.png');
    final Uint8List total_area = total_area_b.buffer.asUint8List();
    final ByteData Size_house_b =
        await rootBundle.load('assets/icons/size_house.png');
    final Uint8List Size_house = Size_house_b.buffer.asUint8List();
    // final ByteData livingroom_b =
    //     await rootBundle.load('assets/icons/house.png');
    // final Uint8List livingroom = livingroom_b.buffer.asUint8List();
    final ByteData floor_b = await rootBundle.load('assets/icons/floor.png');
    final Uint8List floor = floor_b.buffer.asUint8List();
    final ByteData parking_b =
        await rootBundle.load('assets/icons/parking.png');
    final Uint8List parking = parking_b.buffer.asUint8List();
    final ByteData lot_b = await rootBundle.load('assets/icons/lot.png');
    final Uint8List lot = lot_b.buffer.asUint8List();
    final ByteData price_sqm_b = await rootBundle.load('assets/icons/Size.png');
    final Uint8List price_sqm = price_sqm_b.buffer.asUint8List();
    final ByteData bath_b = await rootBundle.load('assets/icons/bath.png');
    final Uint8List bath = bath_b.buffer.asUint8List();
    final ByteData bed_b = await rootBundle.load('assets/icons/bed.png');
    final Uint8List bed = bed_b.buffer.asUint8List();
    // Uint8List bytes2 =
    //     (await NetworkAssetBundle(Uri.parse('$image_i')).load('$image_i'))
    //         .buffer
    //         .asUint8List();
    final ByteData web_b = await rootBundle.load('assets/icons/web_icons.png');
    final Uint8List web = web_b.buffer.asUint8List();
    final ByteData gmail_b =
        await rootBundle.load('assets/icons/gmail_icon.png');
    final Uint8List gmail = gmail_b.buffer.asUint8List();
    final ByteData arrow_b =
        await rootBundle.load('assets/icons/arrow_icons.png');
    final Uint8List arrow = arrow_b.buffer.asUint8List();
    final ByteData phone_b =
        await rootBundle.load('assets/icons/phone_icon.png');
    final Uint8List phone = phone_b.buffer.asUint8List();
    var styp_text = pw.TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.008,
        color: PdfColors.grey600);
    var styp_text_ = pw.TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.012,
        color: PdfColors.grey900);
    var styp_address = pw.TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.007,
        color: PdfColors.grey900);
    var color_text = pw.TextStyle(
        color: PdfColors.grey800,
        fontSize: MediaQuery.of(context).size.height * 0.01);
    var Sizebox_2 = pw.SizedBox(height: 2);
    var Sizebox_2w = pw.SizedBox(width: 2);
    var Sizebox_10w = pw.SizedBox(width: 10);
    var Sizebox_5 = pw.SizedBox(height: 5);
    var Sizebox_10 = pw.SizedBox(height: 7);
    var font_ds = pw.TextStyle(
        color: PdfColors.grey800,
        fontSize: MediaQuery.of(context).size.height * 0.010);
    pw.Widget _text(text) {
      return pw.Text('$text',
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold));
    }

    pw.Widget icon_ds(icon, value) {
      return pw.Row(children: [
        pw.Container(
          width: 10,
          height: 9,
          child: pw.Image(
              pw.MemoryImage(
                // ${items![index]['price'].toString()}
                icon,
              ),
              fit: pw.BoxFit.cover),
        ),
        Sizebox_2w,
        pw.Text('$value', style: font_ds),
      ]);
    }

    pw.Widget _type() {
      return pw.Container(
          height: 20,
          width: double.infinity,
          decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              border: pw.Border.all(
                width: 0.03,
                color: PdfColors.grey400,
              )),
          child:
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.SizedBox(width: 1),
            pw.Container(height: 15, color: PdfColors.blue300, width: 4),
            pw.SizedBox(width: 3),
            pw.Text('${items['type'] ?? ""} > ',
                style: pw.TextStyle(color: PdfColors.blue, fontSize: 8)),
            pw.Text('\$${items['price'] ?? ""}',
                style: pw.TextStyle(color: PdfColors.red, fontSize: 8)),
          ]));
    }

    pw.Widget Reach_US() {
      return pw.Padding(
          padding: pw.EdgeInsets.only(left: 10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '(Reach Us) : #36A, St.04 Borey Peng Hourt The Star Natural. Sangkat Chakangre Leu, Khan Meanchey, Phnom Penh.',
                style: pw.TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.012),
                maxLines: 4,
              ),
            ],
          ));
    }

    pw.Widget icon_text(icon, text, value) {
      return pw.Container(
        child: pw.Row(
          children: [
            pw.Container(
              width: 22,
              height: 22,
              child: pw.Image(
                  pw.MemoryImage(
                    // ${items![index]['price'].toString()}
                    icon,
                  ),
                  fit: pw.BoxFit.cover),
            ),
            Sizebox_2w,
            pw.Container(
              alignment: pw.Alignment.center,
              width: 27,
              height: 22,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('$text',
                      style: pw.TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.008,
                          color: PdfColors.grey600)),
                  Sizebox_2,
                  pw.Text('$value',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.008,
                          color: PdfColors.grey800)),
                ],
              ),
            )
          ],
        ),
      );
    }

    pw.Widget _text_dc(text) {
      return pw.Text(
        text,
        style: pw.TextStyle(
            fontSize: 9,
            color: PdfColors.grey700,
            fontWeight: pw.FontWeight.bold),
      );
    }

    // Add a page to the PDF document
    pdf.addPage(pw.MultiPage(
      build: (context) {
        return [
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 0, bottom: 10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  height: 65,
                  margin: pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 80,
                              height: 50,
                              // color: PdfColors.red500,
                              child: pw.Image(
                                  pw.MemoryImage(
                                    byteList,
                                    // bytes1,
                                  ),
                                  fit: pw.BoxFit.fill),
                            ),
                            Sizebox_5,
                            pw.Text('KHMER FOUNDATION APPRAISALS',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 8,
                                    color: PdfColors.grey800))
                          ]),
                      pw.Text("Property Check",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 15)),
                      pw.Column(children: [
                        pw.Container(
                          height: 50,
                          width: 79,
                          // color: PdfColors.amberAccent100,
                          child: pw.BarcodeWidget(
                              barcode: pw.Barcode.qrCode(),
                              data:
                                  "https://www.latlong.net/c/?lat=${items['latlong_log']}&long=${items['latlong_la']}"),
                        ),
                        pw.SizedBox(height: 8),
                        _text_dc('verbal ID = ${items['id_ptys']}')
                      ])
                    ],
                  ),
                ),

                //Big image
                pw.Row(children: [
                  pw.Expanded(
                      // flex: 5,
                      child: (bytes1 != null)
                          ? pw.Container(
                              height: 180,
                              // width: 300,
                              // color: PdfColors.amber,
                              child: pw.Image(pw.MemoryImage(bytes1),
                                  fit: pw.BoxFit.fill),
                            )
                          : pw.SizedBox()),
                  pw.SizedBox(width: 10),
                  // (items['url_1'] != null || items['url_2'])
                  //     ? pw.Expanded(
                  //         flex: 3,
                  //         child: pw.Column(
                  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //           children: [
                  //             (items['url_1'] != null)
                  //                 ? pw.Container(
                  //                     // padding: const pw.EdgeInsets.only(left: 5),
                  //                     alignment: pw.Alignment.centerLeft,
                  //                     decoration: pw.BoxDecoration(
                  //                         // color: PdfColors.green,
                  //                         border: pw.Border.all(
                  //                             width: 2,
                  //                             color: PdfColors.white)),
                  //                     child: pw.Image(pw.MemoryImage(bytes2),
                  //                         fit: pw.BoxFit.fill),

                  //                     height: 87.5,
                  //                     //color: Colors.blue,
                  //                   )
                  //                 : pw.SizedBox(),
                  //             pw.SizedBox(height: 5),
                  //             (items['url_2'] != null)
                  //                 ? pw.Container(
                  //                     // padding: const pw.EdgeInsets.only(left: 5),
                  //                     alignment: pw.Alignment.centerLeft,
                  //                     decoration: pw.BoxDecoration(
                  //                       border: pw.Border.all(
                  //                           width: 2, color: PdfColors.white),
                  //                       // border: pw.Border.all(),
                  //                       // color: PdfColors.grey500,
                  //                     ),
                  //                     child: pw.Image(pw.MemoryImage(bytes3),
                  //                         fit: pw.BoxFit.fill),
                  //                     // name rest with api

                  //                     height: 87.5,
                  //                     //color: Colors.blue,
                  //                   )
                  //                 : pw.SizedBox(),
                  //           ],
                  //         ),
                  //       )
                  //     : pw.SizedBox()
                ]),
                Sizebox_10,
                _text('${items['Title'] ?? ""}'),
                Sizebox_5,
                _text('${items['address'] ?? ""} Cambodia'),
                Sizebox_5,
                _text_dc('FACE AND FEATURES'),
                Sizebox_5,
                pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                            width: 0.7, color: PdfColors.grey400)),
                    height: 320,
                    width: double.infinity,
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(top: 20),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceEvenly,
                                  children: [
                                    icon_text(house_type, 'hometype',
                                        '${items['type'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(
                                        bed, 'Bed', '${items['Bed'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(
                                        bath, 'Bath', '${items['type'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(lot, 'Lot(sqm)',
                                        '${items['land'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(Size, 'Size(sqm)',
                                        '${items['size_house'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(
                                        area,
                                        'Private_Area(${' m' + '\u00B2'})',
                                        '${items['Private_Area'] ?? ""}'),
                                  ]),
                              Sizebox_5,
                              pw.Divider(height: 0.7, color: PdfColors.grey200),
                              Sizebox_5,
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceEvenly,
                                  children: [
                                    icon_text(parking, 'Parking',
                                        '${items['Parking'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(floor, 'Floor',
                                        '${items['floor'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(livingroom, 'Livingroom',
                                        '${items['Livingroom'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(price_sqm, 'price(sqm)',
                                        '${items['price_sqm'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(aircon_type, 'Aircon',
                                        '${items['	aircon'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_text(
                                        total_area,
                                        'TotalArea(${' m' + '\u00B2'})',
                                        '${items['total_area'] ?? ""}'),
                                  ]),
                              Sizebox_10,
                              _type(),
                              Sizebox_10,
                              pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 10),
                                  child: pw.Column(children: [
                                    pw.Row(children: [
                                      _text_dc('PROPERTY DESCRIPTION'),
                                      Sizebox_10,
                                    ]),
                                    icon_ds(arrow,
                                        ' Price : \$${items['price'] ?? ""} (Negotiate)'),
                                    Sizebox_2w,
                                    icon_ds(
                                        arrow, ' Bed : ${items['bed'] ?? ""}'),
                                    Sizebox_2w,
                                    icon_ds(arrow,
                                        ' Bath : ${items['bath'] ?? ""}'),
                                    Sizebox_5,
                                    icon_ds(
                                      arrow,
                                      'Size House : ${items['Size_l'] ?? ""} x ${items['size_w'] ?? ""} = ${items['size_house'] ?? ""}' +
                                          ' m' +
                                          '\u00B2',
                                    ),
                                    Sizebox_5,
                                    icon_ds(
                                      arrow,
                                      'Size Land : ${items['land_l'] ?? ""} x ${items['land_w'] ?? ""} = ${items['land'] ?? ""}' +
                                          ' m' +
                                          '\u00B2',
                                    ),
                                    Sizebox_5,
                                    icon_ds(
                                      arrow,
                                      'Issuance of transfer service (hard copy)',
                                    ),
                                    Sizebox_5,
                                    pw.Row(children: [
                                      icon_ds(
                                        phone,
                                        '(CellCard) : 077 216 168',
                                      ),
                                      pw.SizedBox(width: 5),
                                      icon_ds(
                                        phone,
                                        '(Officer) : 023 999 855 | 023 988 911',
                                      ),
                                    ]),
                                    Sizebox_5,
                                    pw.Row(children: [
                                      icon_ds(
                                        web,
                                        'https://kfa.com.kh/contacts',
                                      ),
                                      Sizebox_2w,
                                      icon_ds(
                                        gmail,
                                        'info@kfa.com.kh',
                                      ),
                                    ]),
                                    Sizebox_5,
                                    pw.Text(
                                        "Text * Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.",
                                        style: styp_text_,
                                        maxLines: 5),
                                  ])),
                              Sizebox_5,
                              Reach_US(),
                            ]))),

                Sizebox_5,
              ],
            ),
          )
        ];
      },
    ));
    final Color_Test = Color.fromARGB(255, 131, 18, 10);
    final pdfBytes = pdf.save();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    return pdf.save();
  }
}
