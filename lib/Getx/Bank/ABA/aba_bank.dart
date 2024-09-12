// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ABABank extends GetxController {
  var qrCode = ''.obs;
  var checkQR = "2".obs;
  var listABA = [].obs;
  var isABA = false.obs;
  Future traslationABA(
    String tranID,
    String setEmail,
    String setPhone,
    String price,
    String idsetUser,
    int thierPlan,
    String reqTime,
  ) async {
    try {
      isABA.value = true;
      qrCode.value = '';

      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/transaction/aba',
        ),
      );
      request.body = json.encode({
        "req_time": reqTime,
        "tran_id": tranID,
        // "firstname": "${widget.id_set_use.toString()}",
        // "lastname": "$thier_plan",
        "email": setEmail,
        "phone": setPhone,
        "amount": price,
        "payment_option": "abapay_khqr_deeplink",
        "return_url":
            "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_pay/6467/$idsetUser/1.00/$thierPlan?amount=1.00&orderId=$tranID"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(await response.stream.bytesToString());
        qrCode.value = jsonResponse['checkout_qr_url'];

        if (qrCode.value != "") {
          await openDeepLink(jsonResponse['abapay_deeplink']);
        }
      }
    } catch (e) {
      // print(e);
    } finally {
      isABA.value = false;
    }
  }

  Future openDeepLink(var qrString) async {
    try {
      bool checkLink = await launch(qrString);
      print("check_link $checkLink");
    } catch (e) {
      if (Platform.isAndroid) {
        const playStoreUrl =
            'https://play.google.com/store/apps/details?id=com.paygo24.ibank';
        if (await canLaunch(playStoreUrl)) {
          await launch(playStoreUrl);
        } else {
          throw 'Could not launch $playStoreUrl';
        }
      }
      if (Platform.isIOS) {
        const playStoreUrl =
            'https://itunes.apple.com/al/app/aba-mobile-bank/id968860649?mt=8';
        if (await canLaunch(playStoreUrl)) {
          await launch(playStoreUrl);
        } else {
          throw 'Could not launch $playStoreUrl';
        }
      }
    }
  }

  Future checkTraslationABAisNot(
    String reqTime,
    String tranID,
    BuildContext context,
  ) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"req_time": reqTime, "tran_id": tranID});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_transaction/aba',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      checkQR.value = response.data['status'].toString();
    }
  }
}
