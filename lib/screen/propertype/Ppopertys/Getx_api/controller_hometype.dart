// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class controller_for_hometype extends GetxController {
  var list_value_all_hometype = [].obs;
  var list_value_all_2SR = [].obs;
  final list_value_all_2SsR = [].obs;

  @override
  void onInit() {
    list_value_all_hometype;

    super.onInit();
  }

  Future<void> value_all_list_hometype(hometype) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_rent_sale/$hometype'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_all_hometype.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  // Future<void> value_all_list_2() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_a'));
  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonBody = jsonDecode(response.body);
  //       list_value_all_2SR.value = jsonBody;
  //       // print(list_value_all_2SR.toString());
  //     } else {
  //       print('Error value_all_list');
  //     }
  //   } catch (e) {
  //     print('Error value_all_list $e');
  //   }
  // }
  Future<void> value_all_list_2() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_all_2'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_all_2SR.value = jsonBody;
        // print(list_value_all_2SR.toString());
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  //Test only
}
