// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class controller_for_sale extends GetxController {
  var list_value_all = [].obs;
  var list_value_all1 = [].obs;
  var list_value_hometype = [].obs;
  var list_value_urgent = [].obs;
  var list_value_all_for_Rent = [].obs;
  @override
  void onInit() {
    list_value_all;

    super.onInit();
  }

  Future<void> value_all_list_sale() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_a'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_all.value = jsonBody;
        print(list_value_all.toString());
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> value_all_list_hometype(hometype) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_c/$hometype'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_hometype.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> value_all_list_urgent(hometype) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Urgent_property_hometype/$hometype'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_urgent.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  ///Test
  Future<void> value_all_list_rents() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/getall_rent'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        list_value_all_for_Rent.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> value_all_list_sale1() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_a'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_all1.value = jsonBody;
        print('property = ${list_value_all.toString()}');
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}
