// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_import, unused_local_variable, avoid_print, empty_catches, unnecessary_overrides, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, deprecated_member_use
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import 'UPay_qr.dart';
import '../componnet/show_dialogFun.dart';

class UPAY extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var set_id_user;
  static String baseUrl2 = 'https://upayapi.u-pay.com/upayApi/mc/mcOrder';
  var appUrl = '$baseUrl2/appCreate';
  var qrUrl = '$baseUrl2/create/qrcode';
  var loading = false;
  var thier_plan;
  Future<void> createOrder(
      var price, var number_order, id_user, BuildContext context) async {
    if (loading) {
      return;
    }
    loading = true;
    var count_number = number_order!.split(' ');

    if (count_number[4] == "Day") {
      thier_plan = 1;
    } else if (count_number[4] == "Week") {
      thier_plan = 7;
    } else if (count_number[4] == "Mount") {
      thier_plan = 30;
    }
    if (thier_plan != null) {
      var merchantKey = '83ef634e4c80809edd6e2d53a8d49454';
      var order = SignUtil().RandomString(10).toString();
      Map<String, String> map = {
        'currency': "USD",
        'goodsDetail': "0001",
        'lang': "EN",
        'mcAbridge': 'KFA',
        'mcId': '1726454244928921602',
        'mcOrderId': order,
        'money': price.toString(),
        'returnUrl': "kfa://callback",
        'notifyUrl':
            "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_upay/8899/${id_user}/${price}/${thier_plan}",
        'version': 'V1',
      };
      var sign = SignUtil.getSign(map, merchantKey);
      map['sign'] = sign;
      //upayDeeplink
      try {
        var response = await Dio().post(appUrl, data: map);
        if (response.statusCode == 200) {
          var data = response.data;
          var upayDeeplink = data['data']['upayDeeplink'].toString();
          // await launchUrl(Uri.parse(upayDeeplink));
          await launch(
            '$upayDeeplink',
            forceSafariVC: false,
            forceWebView: false,
          );

          await showSuccessDialog(context, price.toString(), context);
          Navigator.pop(context);
        } else {
          showErrorDialog(response.statusMessage ?? '', context);
        }
      } catch (e) {
        showErrorDialog(e.toString(), context);
      }
      loading = false;
    }
  }
}
