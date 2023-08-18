// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/Autho_verbal.dart';

class APi_property {
  Future<AutoVerbal_property> saveAuto_property_Sale(
      AutoVerbal_property_a requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbal_property.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbal_property.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<AutoVerbal_property> saveAuto_property_Rent(
      AutoVerbal_property_a requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_Post'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbal_property.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbal_property.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
