import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/afa/components/contants.dart';

import 'Edit.dart';

class ProtectDataCrossCheck extends StatefulWidget {
  const ProtectDataCrossCheck({super.key, required this.id_user});
  final String id_user;
  @override
  State<ProtectDataCrossCheck> createState() => _ProtectDataCrossCheckState();
}

class _ProtectDataCrossCheckState extends State<ProtectDataCrossCheck> {
  MyDb mydb_lb = new MyDb();
  MyDb mydb_vb = new MyDb();
  List<Map>? DataAutoVerbal;
  Future find() async {
    await mydb_vb.open_verbal();
    await mydb_lb.open_land_verbal();
    // var k = await mydb_lb.db.rawQuery("SELECT * FROM comverbal_land_models");
    setState(() {
      print("object: ${widget.id_user}\n");
    });

    DataAutoVerbal = await mydb_vb.db.rawQuery(
        "SELECT * FROM verbal_models  WHERE verbal_user = ? AND local_offline = ?",
        [widget.id_user.toString(), 0]);
    setState(() {
      print("local_offline: ${DataAutoVerbal![0]['local_offline']}\n");
    });
  }

  @override
  void initState() {
    find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (DataAutoVerbal == null) {
      find();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: MediaQuery.of(context).textScaleFactor * 18,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => find(),
        child: SingleChildScrollView(
          child: Container(
              child: (DataAutoVerbal == null)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: DataAutoVerbal!.map((stuone) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          padding: EdgeInsets.all(0),
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [Colors.white30, Colors.black12])),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: (stuone["verbal_image"] != 'null' ||
                                        stuone["verbal_image"] != 'No')
                                    ? Column(
                                        children: [
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     margin: EdgeInsets.all(2),
                                          //     decoration: BoxDecoration(
                                          //       image: DecorationImage(
                                          //         image: MemoryImage(
                                          //             base64.decode(stuone[
                                          //                 "verbal_image"])),
                                          //         // NetworkImage(
                                          //         //     'https://maps.googleapis.com/maps/api/staticmap?center=${stuone["latlong_la"]},${stuone["latlong_log"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${stuone["latlong_la"]},${stuone["latlong_log"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://maps.googleapis.com/maps/api/staticmap?center=${stuone["latlong_log"]},${stuone["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${stuone["latlong_log"]},${stuone["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://maps.googleapis.com/maps/api/staticmap?center=${stuone["latlong_log"]},${stuone["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${stuone["latlong_log"]},${stuone["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(TextSpan(children: [
                                          const TextSpan(
                                              text: "ID : ",
                                              style: TextStyle(
                                                  color: kwhite_new,
                                                  fontSize: 10)),
                                          TextSpan(
                                              text:
                                                  "${stuone["verbal_id"].toString()}",
                                              style: const TextStyle(
                                                  color: kwhite_new,
                                                  fontSize: 10))
                                        ])),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                            "${stuone["verbal_khan"]} ${(stuone["verbal_address"] != "no") ? stuone["verbal_address"] : ""}",
                                            style: const TextStyle(
                                                color: kwhite_new,
                                                fontSize: 10)),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        Text.rich(TextSpan(children: [
                                          const TextSpan(
                                              text: "Bank Officer : ",
                                              style: TextStyle(
                                                  color: kwhite_new,
                                                  fontSize: 10)),
                                          if (stuone["verbal_bank_officer"] !=
                                              "no")
                                            TextSpan(
                                                text:
                                                    "${stuone["verbal_bank_officer"]}",
                                                style: const TextStyle(
                                                    color: kwhite_new,
                                                    fontSize: 10))
                                        ])),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await mydb_vb.db.rawDelete(
                                                "DELETE FROM verbal_models WHERE verbal_id = ?",
                                                [stuone["verbal_id"]]);
                                            await mydb_lb.db.rawDelete(
                                                "DELETE FROM comverbal_land_models WHERE verbal_landid = ?",
                                                [stuone["verbal_id"]]);
                                            setState(() {
                                              print(
                                                  "object: ${stuone["verbal_id"]}");
                                              find();
                                            });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              color: Color.fromARGB(
                                                  255, 234, 15, 15),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 3,
                                                    offset: Offset(1, 1),
                                                    color: Color.fromARGB(
                                                        255, 112, 111, 153))
                                              ],
                                            ),
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Edit(
                                                          verbal_id: stuone[
                                                              "verbal_id"],
                                                          user_id_controller:
                                                              stuone[
                                                                  "verbal_user"],
                                                          // address: stuone[
                                                          //             "verbal_khan"]
                                                          //         .toString() +
                                                          //     stuone[
                                                          //         "verbal_address"],
                                                          // agent: '',
                                                          // approve_id: stuone[
                                                          //     "verbal_approve_id"],
                                                          // bank_branch_id: stuone[
                                                          //     "verbal_bank_branch_id"],
                                                          // bank_contact: stuone[
                                                          //     "verbal_bank_contact"],
                                                          // bank_id: stuone[
                                                          //     "verbal_bank_id"],
                                                          // bank_officer: stuone[
                                                          //     "verbal_bank_officer"],
                                                          // comment: stuone[
                                                          //     "verbal_comment"],
                                                          // contact: stuone[
                                                          //     "verbal_contact"],
                                                          // image: stuone[
                                                          //     "verbal_id"],
                                                          // lat: stuone[
                                                          //     "latlong_la"],
                                                          // lng: stuone[
                                                          //     "latlong_log"],
                                                          // n_agent: '',
                                                          // n_appro: '',
                                                          // n_bank: '',
                                                          // n_pro: '',
                                                          // option: '',
                                                          // owner: '',
                                                          // property_type_id: '',
                                                          // user: '',
                                                          // verbal: [],
                                                          // verbal_com: '',
                                                          // verbal_con: '',
                                                        )));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: const BoxDecoration(
                                              color: kPrimaryColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 3,
                                                    offset: Offset(-1, -1),
                                                    color: Color.fromARGB(
                                                        255, 112, 111, 153))
                                              ],
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            child: const Text(
                                              "Check Out",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }).toList(),
                    )),
        ),
      ),
    );
  }
}
