// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_import, unused_local_variable, avoid_print, empty_catches, unnecessary_overrides, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class controller_api extends GetxController {
  var list_value_all = [].obs;
  String? province;

  /// For Rent

  @override
  void onInit() {
    list_value_all;

    super.onInit();
  }

  Future<void> value_all_list(property_type_id_province) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_b/$property_type_id_province'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_all.value = jsonBody;
        province = list_value_all[0]['Name_cummune'].toString();
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
  // Future<void> value_all_list(property_type_id_province) async {
  //   // ignore: prefer_typing_uninitialized_variables
  //   var jsonData;
  //   final response = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_b/$property_type_id_province'));

  //   if (response.statusCode == 200) {
  //     jsonData = jsonDecode(response.body);
  //     list_value_all = jsonData;
  //   }
  // }
}
