import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itckfa/Option/components/colors.dart';

import '../../models/login_model.dart';
import '../../screen/Home/Home.dart';

class Authentication extends GetxController {
  var listAuth = [].obs;

  var isAuth = false.obs;

 

  var listAuthR = [].obs;
  var isAuthR = false.obs;

  // Fetch the login data
  Future<void> login(LoginRequestModel requestModel, bool check) async {
    isAuth.value = true;
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "email": requestModel.email,
        "password": requestModel.password,
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/loginAccount',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        listAuth.value = jsonDecode(json.encode(response.data));

        if (check == true) {
          Get.to(const HomePage1());
        }
      }
    } catch (e) {
      // Handle error
    } finally {
      isAuth.value = false;

      if (listAuth.isNotEmpty && check == true) {
        Get.to(const HomePage1());
      } else {
        showErrorSnackbar();
      }
    }
  }

  // Fetch user data

  void showErrorSnackbar() {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        'Please Try again',
        style: TextStyle(color: greyColor, fontSize: 14),
      ),
      messageText: Text(
        'Please check email and password',
        style: TextStyle(color: greyColorNolots, fontSize: 12),
      ),
      borderRadius: 5,
      backgroundColor: const Color.fromARGB(255, 235, 242, 246),
      icon: const Icon(Icons.add_alert),
    );
  }
}
