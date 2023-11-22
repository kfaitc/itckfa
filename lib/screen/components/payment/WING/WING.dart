// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_import, unused_local_variable, avoid_print, empty_catches, unnecessary_overrides, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../UPAY/UPay_qr.dart';
import '../componnet/show_dialogFun.dart';

class WING extends GetxController {
  var list_value_all = [].obs;
  String? province;

  @override
  void onInit() {
    list_value_all;
    super.onInit();
  }

  var token;
  var accessToken;
  Future<void> createOrder_Wing(price, option, context) async {
    Navigator.pop(context);
    _await(context);
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Test_token');
    var body = {
      // 'username': 'online.mangogame',
      // 'username': 'online.kfausd',
      // 'password': '914bade01fd32493a0f2efc583e1a5f6',
      // 'grant_type': 'password',
      // 'client_id': 'third_party',
      // 'client_secret': '16681c9ff419d8ecc7cfe479eb02a7a',
    };

    // Encode the body as a form-urlencoded string
    // var requestBody = Uri(queryParameters: body).query;

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonResponse = jsonDecode(response.body);
      accessToken = jsonResponse['access_token'];

      var parts = accessToken.split('-');
      token = '${parts[0]}${parts[1]}${parts[2]}${parts[3]}${parts[4]}';

      print('accessToken: ${accessToken}');
      print('token: ${token}');
      print('Price : $price');

      // await deeplink_hask(token);
      if (token != null) {
        await deeplinkHask(accessToken, token, price, option, context);
      }
    } else {
      print('T: Request failed with status: ${response.statusCode}');
      print('T: Response: ${response.body}');
    }
  }

  //Deeplink hask
  var deeplink_hask;
  Future<void> deeplinkHask(accessToken, token, price, option, context) async {
    // print('order_reference_no : $order_reference_no');
    // print('deeplinkHask = $token');
    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/DeepLink_Hask');

    // Create a POST request
    final request = http.MultipartRequest('POST', url);

    // Add form fields to the request
    request.fields.addAll({
      'str':
          '$price#USD#00432#$order_reference_no#https://oneclickonedollar.com ',
      'key': '$token',
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      deeplink_hask = jsonResponse['Deeplink_Hask'];
      if (deeplink_hask != null) {
        print(
            'deeplink_hask != null(200) = $deeplink_hask \n $order_reference_no');
        await call_back_wing(context, price);
        // var data = await button(deeplink_hask, accessToken, price);
      }
    } else {
      print('D: Request failed with status: ${response.reasonPhrase}');
    }
  }

  var redirect_url;
  var order_reference_no;
  Future call_back_wing(BuildContext context, price) async {
    // print('call_back_wing');
    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $accessToken'
    // };
    // var data = {
    //   "order_reference_no": "$order_reference_no",
    //   "amount": "$price",
    //   "currency": "USD",
    //   "merchant_name": "Khmer Foundation Appraisal Co.,Ltd",
    //   "merchant_id": "00432",
    //   "item_name": "Payin",
    //   "success_callback_url":
    //       "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Client/Wing/Callback",
    //   "schema_url": "https://oneclickonedollar.com",
    //   // "schema_url": "https://www.wingbank.com.kh/en/",
    //   "integration_type": "MOBAPP",
    //   "txn_hash": "$deeplink_hask",
    //   "product_detail": [
    //     {
    //       "product_id": "6205",
    //       "product_type": "Property",
    //       "product_qty": 1,
    //       "product_unit_price": "$price",
    //       "currency": "USD"
    //     }
    //   ]
    // };
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/LinkWing'));
    request.body = json.encode({
      "order_reference_no": "$order_reference_no",
      "amount": "$price",
      "txn_hash": "$deeplink_hask",
      "accessToken": "$accessToken"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      redirect_url = jsonResponse['redirect_url'];
      await launchUrl(Uri.parse(redirect_url));
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _await(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
