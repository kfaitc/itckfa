// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller_hometype extends GetxController {
  var list_hometype = [].obs;
  var list_value = [].obs;
  var list_image = [].obs;
  var list_hometype_get;
  var hometype;
  @override
  void onInit() {
    list_hometype;
    list_image;
    list_value;

    super.onInit();
  }

  Future<void> verbal_Hometype() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_homeytpe'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        list_hometype.value = jsonBody;
        list_hometype = list_hometype;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}
