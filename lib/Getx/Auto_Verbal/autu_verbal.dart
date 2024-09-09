// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/autoverbal_model.dart';

class AuthVerbal extends GetxController {
  var iduser = ''.obs;
  AuthVerbal({
    required String Iduser,
  }) {
    iduser.value = Iduser;
  }
  @override
  void onInit() {
    super.onInit();

    checkVpoint(iduser.value);
    getUsers(iduser.value);
    print(countAccount.value.toString());
  }

  var listAuto = [].obs;
  var isAuto = false.obs;
  var verbalID = "".obs;
  var expiry = "".obs;
  var formattedDate = "".obs;
  var isAuthGet = false.obs;
  var countAccount = 0.obs;
  var updateNew = 0.obs;
  var listGetUser = [].obs;
  var listCheckVP = [].obs;
  var theirPlans = "".obs;

  Future<void> saveAuto(
    Data datamodel,
    BuildContext context,
    imagelogo,
    String base64string,
    List listUser,
    List landbuiding,
    int iduser,
  ) async {
    // print("titleNumber : ${datamodel.titleNumber}");
    // print("borey : ${datamodel.borey}");
    // print("road : ${datamodel.road}");
    // print("propertyTypeId : ${datamodel.verbalPropertyId}");
    // print("verbalBankId : ${datamodel.verbalBankId}");
    // print("verbalBankBranchId : ${datamodel.verbalBankBranchId}");
    // print("verbalBankContact : ${datamodel.verbalBankContact}");
    // print("verbalOwner : ${datamodel.verbalOwner}");
    // print("verbalContact : ${datamodel.verbalContact}");
    // print("verbalBankOfficer : ${datamodel.verbalBankOfficer}");
    // print("verbalAddress : ${datamodel.verbalAddress}");
    // print("approveId : ${datamodel.approveId}");
    // print("latlongLog : ${datamodel.latlongLog}");
    // print("latlongLa : ${datamodel.latlongLa}");
    // print("verbalUser : ${datamodel.verbalUser}");
    // print("verbalOption : ${datamodel.verbalOption}");
    // print("protectID : ${datamodel.protectID}");
    // print("base64string : $base64string");
    // print("landbuiding : $landbuiding");

    try {
      isAuthGet.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "protectID": datamodel.protectID,
        "title_number": datamodel.titleNumber,
        "borey": datamodel.borey,
        "road": datamodel.road,
        "verbal_property_id": datamodel.propertyTypeId,
        "verbal_bank_id": datamodel.verbalBankId,
        "verbal_bank_branch_id": datamodel.verbalBankBranchId,
        "verbal_bank_contact": datamodel.verbalBankContact,
        "verbal_owner": datamodel.verbalOwner,
        "verbal_contact": datamodel.verbalContact,
        "verbal_bank_officer": datamodel.verbalBankOfficer,
        "verbal_address": datamodel.verbalAddress,
        "verbal_approve_id": datamodel.approveId,
        // "VerifyAgent": datamodel.verifyAgent,
        "latlong_log": datamodel.latlongLog,
        "latlong_la": datamodel.latlongLa,
        "verbal_image": base64string,
        // "verbal_image": "No",
        "verbal_user": datamodel.verbalUser,
        "verbal_option": datamodel.verbalOption,
        "VerbalType": landbuiding
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add/verbal',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        // print("Post Successfuly");

        listAuto.value = jsonDecode(json.encode(response.data))['data'];
      } else {}
    } catch (e) {
      // print(e);
    } finally {
      if (listAuto.isNotEmpty) {
        await paymentDone(
          datamodel,
          context,
          imagelogo,
          listAuto,
          listUser,
        );
        verbalID.value =
            "$iduser${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}}";
      }
    }
  }

  Future<void> paymentDone(
    Data requestModelAuto,
    BuildContext context,
    imagelogo,
    List listAuto,
    List listUser,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "id_user_control": requestModelAuto.controlUser,
        "count_autoverbal": "-1",
        "created_verbals": "1"
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_count_verbal/0',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        countAccount.value = int.parse(response.data.toString());
        Get.snackbar(
          "Done",
          "Post successfuly",
          colorText: Colors.black,
          padding:
              const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
          borderColor: const Color.fromARGB(255, 48, 47, 47),
          borderWidth: 1.0,
          borderRadius: 5,
          backgroundColor: const Color.fromARGB(255, 235, 242, 246),
          icon: const Icon(Icons.add_alert),
        );
        await checkVpoint(iduser);

        // Get.back();
        // showModalBottomSheet(
        //   backgroundColor: Colors.transparent,
        //   context: context,
        //   isScrollControlled: true,
        //   builder: (BuildContext context) {
        //     return PDfButton(
        //       verbalID: requestModelAuto.verbalUser.toString(),
        //       listUser: listUser,
        //       position: true,
        //       type: (value) {
        //         // setState(() {
        //         //   widget.backvalue(value);
        //         // });
        //       },
        //       check: (value) {
        //         // setState(() {
        //         //   widget.backvalue(value);
        //         // });
        //       },
        //       title: "Ok",
        //       list: listAuto,
        //       i: 0,
        //       imagelogo: imagelogo,
        //       iconpdfcolor: Colors.red,
        //     );
        //   },
        // );
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isAuthGet.value = false;
    }
  }

  Future<void> getUsers(String userID) async {
    try {
      isAuthGet.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/getUser/user/$userID',
        options: Options(method: 'GET'),
      );

      if (response.statusCode == 200) {
        listGetUser.value = jsonDecode(json.encode(response.data));
      }
    } catch (e) {
      // Handle error
    } finally {
      isAuthGet.value = false;
      countAccount.value = listGetUser[0]['count_autoverbal'];
      updateNew.value = listGetUser[0]['update_new'];
    }
  }

  Future<void> checkVpoint(id) async {
    try {
      isAuthGet.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_dateVpoint?id_user_control=$id',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(json.encode(response.data));
        listCheckVP.value = [data];
        countAccount.value = listCheckVP[0]['vpoint'];

        if (listCheckVP[0]['their_plans'].toString() == "1 day") {
          theirPlans.value = "1 Day";
        } else if (listCheckVP[0]['their_plans'].toString() == "7 day") {
          theirPlans.value = "1 Week";
        } else if (listCheckVP[0]['their_plans'].toString() == "30 day") {
          theirPlans.value = "1 Mount";
        } else {
          theirPlans.value = listCheckVP[0]['their_plans'].toString();
        }
        if (listCheckVP[0]['expiry'].toString() != "0") {
          expiry.value = listCheckVP[0]['expiry'].toString();
        } else {
          DateTime timeNow = DateTime.now();
          expiry.value = timeNow.toString();
        }
        if (expiry.value != "") {
          DateTime timeNow = DateTime.parse(expiry.value);

          formattedDate.value = DateFormat('d MMMM yyyy').format(timeNow);
        }
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {
      isAuthGet.value = false;
    }
  }
}
