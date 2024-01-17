import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import 'UPay_qr.dart';

class UPAY extends GetxController {

  var set_id_user;
  static String baseUrl2 = 'https://upayapi.u-pay.com/upayApi/mc/mcOrder';
  var appUrl = '$baseUrl2/appCreate';
  var qrUrl = '$baseUrl2/create/qrcode';
  var loading = false;
  var thier_plan;
  Future<void> createOrder(
      var price, var numberOrder, idUser, BuildContext context,) async {
    if (loading) {
      return;
    }
    loading = true;
    var countNumber = numberOrder!.split(' ');

    if (countNumber[4] == "Day") {
      thier_plan = 1;
    } else if (countNumber[4] == "Week") {
      thier_plan = 7;
    } else if (countNumber[4] == "Mount") {
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
            "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_pay/6591/$idUser/$price/$thier_plan",
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
            upayDeeplink,
            forceSafariVC: false,
            forceWebView: false,
          );
          Navigator.pop(context);
        } else {}
      } catch (e) {}
      loading = false;
    }
  }
}
