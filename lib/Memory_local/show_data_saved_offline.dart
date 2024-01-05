import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/afa/components/contants.dart';

class data_verbal_saved extends StatefulWidget {
  const data_verbal_saved({super.key});

  @override
  State<data_verbal_saved> createState() => _data_verbal_savedState();
}

class _data_verbal_savedState extends State<data_verbal_saved> {
  bool? status;
  OpenDataBase() async {
    await mydb.open_offline();
    slist = await mydb.db.rawQuery('SELECT * FROM verbal_models_offline');
    setState(() {
      slist;
    });
  }

  List<Map> slist = [];
  MyDb mydb = new MyDb();
  @override
  void initState() {
    OpenDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (slist == null) {
      OpenDataBase();
    }

    return Scaffold(
      backgroundColor: kwhite_new,
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        title: const Text("Your Saved"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left_outlined,
              size: 40,
            )),
      ),
      body: SingleChildScrollView(
        // stuone["roll_no"]
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: slist!.map((stuone) {
              return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: 40, right: 40, bottom: 100, top: 90),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Scaffold(
                            body: Container(
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Image.memory(
                                            base64Decode(
                                              stuone["verbal_image"],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GFButton(
                                                  onPressed: () async {
                                                    await mydb.open_offline();
                                                    int b = await mydb.db.rawDelete(
                                                        "DELETE FROM verbal_models_offline WHERE verbal_id = ?",
                                                        [stuone["verbal_id"]]);
                                                    if (b == 1) {
                                                      const snackBar = SnackBar(
                                                        content: Text(
                                                            'Data Deleted!...'),
                                                        duration: Duration(
                                                            seconds: 2),
                                                      );

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);

                                                      Navigator.pop(context);
                                                    } else {
                                                      const snackBar = SnackBar(
                                                        content: Text(
                                                            'Data Deleted felse!...'),
                                                        duration: Duration(
                                                            seconds: 2),
                                                      );

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);

                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  text: "Delete\t\t",
                                                  type: GFButtonType.outline2x,
                                                  icon: Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                  ),
                                                ),
                                                GFButton(
                                                  onPressed: () async {
                                                    final result =
                                                        await ImageGallerySaver
                                                            .saveImage(base64Decode(
                                                                stuone[
                                                                    "verbal_image"]));
                                                    const snackBar = SnackBar(
                                                      content:
                                                          Text('Data Saved!'),
                                                      duration:
                                                          Duration(seconds: 2),
                                                    );

                                                    // ignore: use_build_context_synchronously
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.pop(context);
                                                  },
                                                  text: "download",
                                                  icon: Icon(
                                                    Icons.download,
                                                  ),
                                                  type: GFButtonType.outline2x,
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.redAccent[400],
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Image.memory(
                              base64Decode(stuone["verbal_image"])))
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
