import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../../../Memory_local/convert_data_verbal_to_image.dart';
import '../../../../Memory_local/database.dart';
import '../Detail.dart';
import '../printer/save_image_for_Autoverbal.dart';
import 'Add.dart';

class List_Auto extends StatefulWidget {
  const List_Auto({
    super.key,
    required this.verbal_id,
    required this.id_control_user,
  });
  final String verbal_id;
  final String id_control_user;
  @override
  State<List_Auto> createState() => _List_AutoState();
}

class _List_AutoState extends State<List_Auto> {
  List list1 = [];
  bool check_data1 = false, check_data2 = false;
  void get_by_user_autoverbal() async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=${widget.id_control_user}',
      ),
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list1 = jsonData;
        print("object${list1.length}");
        check_data1 = true;
      });
    }
  }

  bool b1 = true, b2 = false;
  Future OpenDataBase() async {
    await mydb.open_offline();
    slist = await mydb.db.rawQuery('SELECT * FROM verbal_models_offline');
    setState(() {
      slist;
    });
  }

  List<Map>? slist;
  MyDb mydb = MyDb();
  @override
  void initState() {
    get_by_user_autoverbal();
    OpenDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width * 0.9;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: const Text("Auto Verbal List", style: TextStyle(fontSize: 22)),
        ),
        backgroundColor: const Color.fromARGB(255, 64, 120, 216),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: CustomPaint(
            size: Size(
              5,
              (5 * 0.5833333333333334).toDouble(),
            ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GFButton(
                        onPressed: () {
                          setState(() {
                            b1 = true;
                            b2 = false;
                          });
                        },
                        color: (b1)
                            ? const Color.fromRGBO(13, 71, 161, 1)
                            : Colors.blue,
                        text: "Your Verbal",
                        elevation: (b1) ? 10 : 0,
                        shape: GFButtonShape.pills,
                      ),
                      GFButton(
                        onPressed: () async {
                          setState(() {
                            b1 = false;
                            b2 = true;
                          });
                          await OpenDataBase();
                        },
                        color: (b2)
                            ? const Color.fromRGBO(13, 71, 161, 1)
                            : Colors.blue,
                        text: "\t\t\t\t\t\tSaved\t\t\t\t\t\t",
                        elevation: (b2) ? 10 : 0,
                        shape: GFButtonShape.pills,
                      ),
                    ],
                  ),
                ),
                if (b1)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Visibility(
                      visible: check_data1,
                      replacement: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return Container(
                            height: 220,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(217, 255, 255, 255),
                              // border: Border.all(
                              //     width: 1,
                              //     color: Color.fromRGBO(67, 160, 71, 1)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Verbal ID\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "${list1[i]['verbal_id']}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  9,
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bank\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Text(
                                              "${list1[i]['bank_name']}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bank Branch\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              "${list1[i]['bank_branch_name'] ?? ""}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Property Type\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              "${list1[i]['property_type_name']}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date :\t\t\t:\t\t',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  10,
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                    255,
                                                    16,
                                                    22,
                                                    192,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: Offset(-0.2, -1),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              "${list1[i]['verbal_date']}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(
                                                      context,
                                                    ).textScaleFactor *
                                                    9,
                                                overflow: TextOverflow.ellipsis,
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      16,
                                                      22,
                                                      192,
                                                    ),
                                                    blurRadius: 3,
                                                    offset: Offset(-0.2, -1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: FadeInImage.assetNetwork(
                                          fit: BoxFit.cover,
                                          placeholderFit: BoxFit.contain,
                                          placeholder: 'assets/earth.gif',
                                          image:
                                              "https://maps.googleapis.com/maps/api/staticmap?center=${list1[i]["latlong_log"]},${list1[i]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list1[i]["latlong_log"]},${list1[i]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI",
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GFButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            save_image_after_add_verbal(
                                                          set_data_verbal:
                                                              list1[i]
                                                                  ["verbal_id"],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  text: "Get Image",
                                                  color: Colors.green,
                                                  icon: const Icon(
                                                    Icons
                                                        .photo_library_outlined,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 5,
                                                        offset: Offset(1, 0.5),
                                                      )
                                                    ],
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                GFButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            detail_verbal(
                                                          set_data_verbal:
                                                              list1[i]
                                                                  ["verbal_id"],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  text: " Get PDF ",
                                                  color: const Color.fromRGBO(
                                                    229,
                                                    57,
                                                    53,
                                                    1,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.picture_as_pdf,
                                                    size: 20,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 5,
                                                        offset: Offset(1, 0.5),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                InkWell(
                                                  child:
                                                      const Icon(Icons.share),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      barrierLabel:
                                                          MaterialLocalizations
                                                                  .of(context)
                                                              .modalBarrierDismissLabel,
                                                      barrierColor: const ui
                                                          .Color.fromARGB(
                                                        0,
                                                        0,
                                                        0,
                                                        0,
                                                      ),
                                                      builder: (context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                context,
                                                              ).size.height *
                                                              0.6,
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).size.height *
                                                                      0.8,
                                                                  color: const ui
                                                                      .Color.fromARGB(
                                                                    97,
                                                                    0,
                                                                    0,
                                                                    0,
                                                                  ),
                                                                  child:
                                                                      convert_data_verbal_to_image(
                                                                    set_data_verbal:
                                                                        list1[i]
                                                                            [
                                                                            "verbal_id"],
                                                                    sh_in_list:
                                                                        true,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            GFButton(
                                              onPressed: () {
                                                // var data = verbalModel(
                                                //   verbalId:
                                                //       '${list1[i]["verbal_id"] ?? ''}',
                                                //   bank_branch_name:
                                                //       '${list1[i]["bank_branch_name"] ?? ''}',
                                                //   bank_name:
                                                //       '${list1[i]["bank_name"] ?? ''}',
                                                //   property_type_name:
                                                //       '${list1[i]["property_type_name"] ?? ''}',
                                                //   tel_num:
                                                //       '${list1[i]["tel_num"] ?? ''}',
                                                //   username:
                                                //       '${list1[i]["username"] ?? ''}',
                                                //   verbal_address:
                                                //       '${list1[i]["verbal_address"] ?? ''}',
                                                //   verbal_contact:
                                                //       '${list1[i]["verbal_contact"] ?? ''}',
                                                //   verbal_date:
                                                //       '${list1[i]["verbal_date"] ?? ''}',
                                                //   verbal_owner:
                                                //       '${list1[i]["verbal_owner"] ?? ''}',
                                                // );

                                                // await PeopleController()
                                                //     .insertverbal(data);
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  barrierLabel:
                                                      MaterialLocalizations.of(
                                                              context)
                                                          .modalBarrierDismissLabel,
                                                  barrierColor:
                                                      const ui.Color.fromARGB(
                                                    0,
                                                    0,
                                                    0,
                                                    0,
                                                  ),
                                                  builder: (context) {
                                                    return Container(
                                                      height: MediaQuery.of(
                                                            context,
                                                          ).size.height *
                                                          0.6,
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: MediaQuery
                                                                          .of(
                                                                    context,
                                                                  )
                                                                      .size
                                                                      .height *
                                                                  0.8,
                                                              color: const ui
                                                                  .Color.fromARGB(
                                                                97,
                                                                0,
                                                                0,
                                                                0,
                                                              ),
                                                              child:
                                                                  convert_data_verbal_to_image(
                                                                set_data_verbal:
                                                                    list1[i][
                                                                        "verbal_id"],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              text: "\tSave for offline\t",
                                              size: GFSize.MEDIUM,
                                              icon: const Icon(
                                                Icons.note_alt_outlined,
                                                color: Colors.white,
                                                size: 20,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 5,
                                                    offset: Offset(1, 0.5),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: list1.length,
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: (slist!.isEmpty && slist == null)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            // stuone["roll_no"]
                            child: Column(
                              children: slist!.map((stuone) {
                                return InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(
                                            left: 40,
                                            right: 40,
                                            bottom: 100,
                                            top: 90,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Scaffold(
                                            body: Container(
                                              alignment: Alignment.center,
                                              child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 50,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Image.memory(
                                                            base64Decode(
                                                              stuone[
                                                                  "verbal_image"],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              GFButton(
                                                                onPressed:
                                                                    () async {
                                                                  await mydb
                                                                      .open_offline();
                                                                  int b = await mydb
                                                                      .db
                                                                      .rawDelete(
                                                                          "DELETE FROM verbal_models_offline WHERE verbal_id = ?",
                                                                          [
                                                                        stuone[
                                                                            "verbal_id"]
                                                                      ]);
                                                                  if (b == 1) {
                                                                    const snackBar =
                                                                        SnackBar(
                                                                      content: Text(
                                                                          'Data Deleted!...'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                    );

                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackBar);

                                                                    Navigator
                                                                        .pop(
                                                                      context,
                                                                    );
                                                                    setState(
                                                                        () {
                                                                      b1 = true;
                                                                      b2 =
                                                                          false;
                                                                    });
                                                                  } else {
                                                                    const snackBar =
                                                                        SnackBar(
                                                                      content: Text(
                                                                          'Data Deleted felse!...'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                    );

                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackBar);

                                                                    Navigator
                                                                        .pop(
                                                                      context,
                                                                    );
                                                                  }
                                                                },
                                                                text:
                                                                    "Delete\t\t",
                                                                color: const ui
                                                                    .Color.fromRGBO(
                                                                  255,
                                                                  23,
                                                                  68,
                                                                  1,
                                                                ),
                                                                type: GFButtonType
                                                                    .outline2x,
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .delete_outline_rounded,
                                                                  color: ui
                                                                          .Color
                                                                      .fromRGBO(
                                                                    255,
                                                                    23,
                                                                    68,
                                                                    1,
                                                                  ),
                                                                ),
                                                              ),
                                                              GFButton(
                                                                onPressed:
                                                                    () async {
                                                                  final result =
                                                                      await ImageGallerySaver
                                                                          .saveImage(
                                                                    base64Decode(
                                                                        stuone[
                                                                            "verbal_image"]),
                                                                  );
                                                                  const snackBar =
                                                                      SnackBar(
                                                                    content: Text(
                                                                        'Data Saved!'),
                                                                    duration: Duration(
                                                                        seconds:
                                                                            2),
                                                                  );

                                                                  // ignore: use_build_context_synchronously
                                                                  ScaffoldMessenger
                                                                      .of(
                                                                    context,
                                                                  ).showSnackBar(
                                                                    snackBar,
                                                                  );
                                                                  // ignore: use_build_context_synchronously
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                  setState(() {
                                                                    b1 = true;
                                                                    b2 = false;
                                                                  });
                                                                },
                                                                text:
                                                                    "download",
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .download,
                                                                  color: ui
                                                                          .Color
                                                                      .fromARGB(
                                                                    255,
                                                                    23,
                                                                    65,
                                                                    255,
                                                                  ),
                                                                ),
                                                                type: GFButtonType
                                                                    .outline2x,
                                                                color: const ui
                                                                    .Color.fromARGB(
                                                                  255,
                                                                  23,
                                                                  65,
                                                                  255,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.redAccent[400],
                                                      child: const Icon(
                                                          Icons.close),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Image.memory(
                                            base64Decode(
                                              stuone["verbal_image"],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
