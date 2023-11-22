// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_import, unused_local_variable, avoid_print, empty_catches, unnecessary_overrides, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../UPAY/UPay_qr.dart';
import 'show_dialogFun.dart';

class GetVpoint extends GetxController {
  List<dynamic> list_User_by_id = [].obs;

  @override
  void onInit() {
    list_User_by_id;
    super.onInit();
  }

  int v_point = 0;
  Future<void> get_count(set_id_user) async {
    print(set_id_user.toString());
    final response = await http.get(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_dateVpoint?id_user_control=${set_id_user}'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      v_point = int.parse(jsonData['vpoint'].toString());
      print(v_point.toString());
    }
  }

  var set_id_user;
  var set_email;
  Future<void> get_control_user(id) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      list_User_by_id = jsonData;
      set_id_user = list_User_by_id[0]['control_user'].toString();
      set_email = list_User_by_id[0]['email'].toString();
      print('ID User : ${set_id_user.toString()}');
    }
  }
}
