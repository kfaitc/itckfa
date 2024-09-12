// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../Option/screens/AutoVerbal/Verbal/Add.dart';

class WingBank extends GetxController {
  String notifyUrl =
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back_pay/6560';
  String token = '';
  String accessToken = '';
  var orderReferenceNo = ''.obs;
  String deeplinkHask = '';
  String redirectURL = '';
  var isQR = false.obs;
  var checkStatus = ''.obs;
  var orderbycode = ''.obs;
  var qrCode = ''.obs;
  var listQR = [].obs;
  Random random = Random();
  void createInvoice(
    String idUser,
    String price,
    String firstname,
    String lastname,
    String phone,
    String crc,
    String orderReferenceNo,
  ) async {
    print("orderReferenceNo : $orderReferenceNo");
    // print("orderReferenceNo : $orderReferenceNo");
    // print("orderReferenceNo : $orderReferenceNo");
    try {
      isQR.value = true;
      final url = Uri.parse(
        'https://eco-gateway.wingmarket.com/invoicing/api/invoice/ext/create',
      );

      // JSON data
      final jsonData = {
        "order_reference_no": orderReferenceNo,
        "type": "TAX",
        "currency": "USD",
        "issue_date": "2023-07-07T08:56:56.626Z",
        "sub_total": price,
        "total": price,
        "billing_from": "#711, PP, Cambodia",
        "billing_to": "#712, PP, Cambodia",
        "customer": {
          "first_name": firstname,
          "last_name": lastname,
          "phone": phone,
          "company_name": "My Company",
          "tin_number": "BI02‐220008523",
        },
        "invoice_items": [
          {
            "product_id": "kfa",
            "product": "V-point",
            "product_qty": 1,
            "product_unit_price": price,
            "currency": "USD",
            "amount": price,
          }
        ],
        "crc": crc,
        "gateway_setting": {
          "callback_url":
              "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/call_back/$idUser/6560"
        },
      };
      await getaccessToken();
      print("token : $token");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(jsonData),
      );

      if (response.statusCode == 200) {
        // print('Invoice created successfully. ${response}');
        final responseBody = json.decode(response.body);
        listQR.value = [responseBody];
        qrCode.value = responseBody['body']['qr_code_url'];
        // print("QR => $qrCode");
      } else {
        // Failed to create invoice
        print(
          'Failed to create invoice. Status code: ${response.statusCode} \n ${response.body}',
        );
      }
    } catch (e) {
      // print(e);
    } finally {
      isQR.value = false;
    }
  }

  Future<void> getaccessToken() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
        'https://eco-gateway.wingmarket.com/v2/identity/login?username=100224779&password=L3pvo4EiVkZ9vKVMeO2yu43nsGBV0LBs8zpYqKnydLMkCwS16wdEH1+wH2/ay3oTDCjWvEwYeplrKTRzWfCUFl/savqtmGZVUSNSY2nxAlnsKQNr8mzg1iBxwzEY1CAlnFD/Hp3DGscz3YLGcV9mO22DQG6ibxmCX0E4aHmUmPafRRwsG9RQ5n1gY+0q6vPKQNZAHvYWH9tnkXrj8Hsm1QQdjzgPH8L2k+ROaJXcn/w5Asro7G9wJsAJcPasD3jsGml77MXm4XCkpaYzvPV5Zxgo1BFdek4Sl+jCJ4uYqjzDoc9q0jR4ZJGrzKeupMo6yL/EvAmLFYs0H0vM+jP5ow==&grant_type=password&client_id=kfa&client_secret=YetKZu7yEHhnMxNatpjSaeQS8c+xXkgSJ8jqS/LCn/F5dp3oI+uiNZ5niwiDQWsyTfD+7LLk2yqT1HMWVL+AcdAF62OyPVgqsg3m0g/H7YbaZo1n5dj3W7I1F25hNo/KykTmB5V4p/6lBlIsmfG9sz+7h8rPxRRYoY+2mkUlP++rK7PVfYkFBeJR1c9+AseHzU+2Edvw62lQdoibFhie0foerppUBg//510U0s1jFxoJEW6U7UoqujLIE08xuVqU9ro8eELUIQJsm47Wh6Jnp8KSy28q9H27D2CYauM0dgw/Xa0QB2YBY34oji6cgOQnASYsZtXufOkvVIHQvVAlqw==',
      ),
    );
    request.body = json.encode({
      "username": "100224779",
      "password":
          "L3pvo4EiVkZ9vKVMeO2yu43nsGBV0LBs8zpYqKnydLMkCwS16wdEH1+wH2/ay3oTDCjWvEwYeplrKTRzWfCUFl/savqtmGZVUSNSY2nxAlnsKQNr8mzg1iBxwzEY1CAlnFD/Hp3DGscz3YLGcV9mO22DQG6ibxmCX0E4aHmUmPafRRwsG9RQ5n1gY+0q6vPKQNZAHvYWH9tnkXrj8Hsm1QQdjzgPH8L2k+ROaJXcn/w5Asro7G9wJsAJcPasD3jsGml77MXm4XCkpaYzvPV5Zxgo1BFdek4Sl+jCJ4uYqjzDoc9q0jR4ZJGrzKeupMo6yL/EvAmLFYs0H0vM+jP5ow==",
      "grant_type": "password",
      "client_id": "kfa",
      "client_secret":
          "YetKZu7yEHhnMxNatpjSaeQS8c+xXkgSJ8jqS/LCn/F5dp3oI+uiNZ5niwiDQWsyTfD+7LLk2yqT1HMWVL+AcdAF62OyPVgqsg3m0g/H7YbaZo1n5dj3W7I1F25hNo/KykTmB5V4p/6lBlIsmfG9sz+7h8rPxRRYoY+2mkUlP++rK7PVfYkFBeJR1c9+AseHzU+2Edvw62lQdoibFhie0foerppUBg//510U0s1jFxoJEW6U7UoqujLIE08xuVqU9ro8eELUIQJsm47Wh6Jnp8KSy28q9H27D2CYauM0dgw/Xa0QB2YBY34oji6cgOQnASYsZtXufOkvVIHQvVAlqw==",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      token = jsonResponse["body"]["access_token"];
    } else {
      // print(response.reasonPhrase);
    }
  }

  //Create Deeplink
  Future<bool> createOrderWing(price, option, context, String idUser) async {
    token = '';
    accessToken = '';
    deeplinkHask = '';
    redirectURL = '';
    orderReferenceNo.value =
        "${idUser}24K${RandomString(2)}F${RandomString(3)}A";
    print("orderReferenceNo : $orderReferenceNo");
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var url = Uri.parse(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Test_token',
    );
    // var body = {
    //   // 'username': 'online.mangogame',
    //   // // 'username': 'online.kfausd',
    //   // 'password': '914bade01fd32493a0f2efc583e1a5f6',
    //   // 'grant_type': 'password',
    //   // 'client_id': 'third_party',
    //   // 'client_secret': '16681c9ff419d8ecc7cfe479eb02a7a',
    // };
    // var requestBody = Uri(queryParameters: body).query;
    var response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      accessToken = jsonResponse['access_token'];
      var parts = accessToken.split('-');
      token = '${parts[0]}${parts[1]}${parts[2]}${parts[3]}${parts[4]}';
      // print('accessToken: $accessToken');
      // print('token: $token');
      // print('Price : $price');
      if (token != "") {
        deepLinkHask(accessToken, token, price, context);
        return true;
      }
    } else {
      // print('T: Request failed with status: ${response.statusCode}');
      // print('T: Response: ${response.body}');
      return false;
    }
    return false;
  }

  Future<void> deepLinkHask(accessToken, token, price, context) async {
    final url = Uri.parse(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/DeepLink_Hask',
    );
    final request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'str':
          // '$price#USD#00432#$orderReferenceNo#https://oneclickonedollar.com/wing',
          '$price#USD#00432#${orderReferenceNo.value}#https://oneclickonedollar.com/wing',
      'key': '$token',
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      deeplinkHask = jsonResponse['Deeplink_Hask'];
      if (deeplinkHask != "") {
        await callBackWing(context, price);
      }
    }
  }

  Future callBackWing(BuildContext context, price) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/LinkWing',
      ),
    );
    request.body = json.encode({
      "order_reference_no": orderReferenceNo.value,
      "amount": "$price",
      "txn_hash": deeplinkHask,
      "accessToken": accessToken,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      redirectURL = jsonResponse['redirect_url'];
      // print("\n$redirectURL\n");
      // await launchUrl(Uri.parse(redirect_url));
      await openDeepLink(redirectURL);
    } else {
      // print(response.reasonPhrase);
    }
  }

  Future openDeepLink(var qrString) async {
    if (Platform.isIOS) {
      try {
        bool checkLink = await launchUrl(Uri.parse(qrString));
        if (checkLink == false) {
          const playStoreUrl = 'https://onelink.to/dagdt6';

          if (await canLaunch(playStoreUrl)) {
            await launch(playStoreUrl);
          } else {
            throw 'Could not launch $playStoreUrl';
          }
        }
      } catch (e) {
        // print(e);
      }
    } else if (Platform.isAndroid) {
      try {
        bool checkLink = await launch(qrString);

        if (checkLink == false) {
          const playStoreUrl = 'https://onelink.to/dagdt6';

          if (await canLaunch(playStoreUrl)) {
            await launch(playStoreUrl);
          } else {
            throw 'Could not launch $playStoreUrl';
          }
        }
      } catch (e) {
        if (Platform.isAndroid) {
          const playStoreUrl = 'https://onelink.to/dagdt6';

          if (await canLaunch(playStoreUrl)) {
            await launch(playStoreUrl);
          } else {
            throw 'Could not launch $playStoreUrl';
          }
        }
      }
    }
  }

  Future<void> checkTransection(id) async {
    try {
      var request = http.Request(
        'GET',
        Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/checkdone/wing?order_reference_no=$id',
        ),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(await response.stream.bytesToString());

        if (jsonResponse["status"].toString() == "OK") {
          checkStatus.value = jsonResponse["status"].toString();
        }
      } else {
        // print(response.reasonPhrase);
      }
    } catch (e) {
      // print(e);
    } finally {}
  }

  Future<void> checkTransetionQR(id) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_done?order_reference_no=$id',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        orderbycode.value = json.encode(response.data);
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
      // print(e);
    } finally {}
  }
}
