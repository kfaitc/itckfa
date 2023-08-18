// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller_verbal extends GetxController {
  var list_last_verbalID = [].obs;
  var list_cummone = [].obs;
  var list_hometype = [].obs;
  var id_last;
  var hometype;
  @override
  void onInit() {
    list_last_verbalID;
    list_cummone;
    list_hometype;
    super.onInit();
  }

  Future<void> verbal_Hometype() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_homeytpe'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        list_hometype.value = jsonBody;
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

  Future<void> verbal_Commune_25_all() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Commune_25_all'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        list_cummone.value = jsonBody;
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<void> verbal_last_ID() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/id_sale_last?property=0'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list_last_verbalID.value = jsonBody;
        id_last = list_last_verbalID[0]['id_ptys'] + 1;
        print(id_last.toString());
        // print('id no + = ${list_last_verbalID[0]['id_ptys']}');
        // print('id + 1 = $id_last');
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}
