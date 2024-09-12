// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itckfa/Getx/Bank/signUtil.dart';
import 'package:url_launcher/url_launcher.dart';

class UpayBank extends GetxController {
  static String baseUrl2 = 'https://upayapi.u-pay.com/upayApi/mc/mcOrder';
  String appUrl = '$baseUrl2/appCreate';
  String qrUrl = '$baseUrl2/create/qrcode';
  // String mcOrderId = '';
  String merchantId = '1726454244928921602';
  String merchantKey = '83ef634e4c80809edd6e2d53a8d49454';
  String goodsDetail = '1726454244928921602';
  String ccy = 'USD';
  String language = 'EN';
  String version = 'V1';
  String returnUrl = 'kfa://callback';
  String notifyUrl =
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_pay/6591';
//Variable
  var mcOrderId = "".obs;
  var qrCode = "".obs;
  var isQR = false.obs;
  var listQR = [].obs;
  var isTra = false.obs;
  var isDeeplink = false.obs;
  Future<void> createOrderQR(String amount, notifyMore) async {
    try {
      isQR.value = true;
      qrCode.value = '';
      mcOrderId.value = SignUtil().randomString(10);
      Map<String, String> map = {
        'currency': ccy,
        'goodsDetail': goodsDetail,
        'lang': language,
        'mcAbridge': 'Khmer Foundation Apprais',
        'mcId': merchantId,
        'mcOrderId': mcOrderId.value,
        'money': amount,
        'notifyUrl': "$notifyUrl/$notifyMore",
        'version': version,
      };
      var sign = SignUtil.getSign(map, merchantKey);
      map['sign'] = sign;

      var response = await Dio().post(qrUrl, data: map);
      if (response.statusCode == 200) {
        var data = response.data;
        var d1 = jsonEncode(data['data']);
        var d2 = json.decode(d1);
        qrCode.value = d2['qrcode'].toString();
        // print(qrCode.value);
      }
    } catch (e) {
      // print(e);
    } finally {
      isQR.value = false;
    }
  }

  Future<void> transetionID(mcOrderId) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/banks/Upay/$mcOrderId',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        listQR.value = jsonDecode(json.encode(response.data));
        // print(listQR.toString());
      }
    } catch (e) {
      // print(e);
    } finally {
      isTra.value = false;
    }
  }

  Future<void> createOrder(
    String amount,
    String notifyMore,
    BuildContext context,
  ) async {
    try {
      isDeeplink.value = true;
      var order = SignUtil().randomString(10).toString();
      Map<String, String> map = {
        'currency': ccy,
        'goodsDetail': goodsDetail,
        'lang': language,
        'mcAbridge': 'KFA',
        'mcId': merchantId,
        'mcOrderId': order,
        'money': amount,
        'returnUrl': returnUrl,
        'notifyUrl': "$notifyUrl/$notifyMore",
        'version': version,
      };
      var sign = SignUtil.getSign(map, merchantKey);
      map['sign'] = sign;
      try {
        var response = await Dio().post(appUrl, data: map);
        if (response.statusCode == 200) {
          var data = response.data;
          var upayDeeplink = data['data']['upayDeeplink'].toString();

          if (await canLaunch(upayDeeplink)) {
            await launch(
              upayDeeplink,
              forceSafariVC: false,
              forceWebView: false,
            );
          } else {
            if (Platform.isIOS) {
              await launch(
                data['data']['appStore'].toString(),
                forceSafariVC: false,
                forceWebView: false,
              );
            } else if (Platform.isAndroid) {
              await launch(
                data['data']['playStore'].toString(),
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          }

          // Get.back();
        }
      } catch (e) {
        // print(e);
      }
    } catch (e) {
      // print(e);
    } finally {
      isDeeplink.value = false;
    }
  }
}
