// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class controller_for_Rent extends GetxController {
  var list_value_all = [].obs;
  var list_value_pid = [].obs;
  var list_value_urgent = [].obs;
  var list_hometype = [].obs;
  var list_value_all1 = [].obs;
  @override
  void onInit() {
    list_value_all;

    super.onInit();
  }

  Future<void> value_all_list_Rent() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_all_k'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_all.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> value_all_list_property_id(property_id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_all_i/${property_id}'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_pid.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> value_all_list_all(hometype) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_all_h/$hometype'));
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

  Future<void> verbal_Hometype() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_homeytpe'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        list_hometype.value = jsonBody;
        print(list_hometype.toString());
        // for (int i = 0; i < list_hometype.length; i++) {
        //   hometype = list_hometype[i]['hometype'].toString();
        //   print('$i : ${hometype.toString()}');
        // }
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> value_all_list_Rent_a() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_all_k'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_value_all1.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}
