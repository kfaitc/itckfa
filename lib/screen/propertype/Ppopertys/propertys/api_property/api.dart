// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Model/Autho_verbal.dart';
import '../../Model/update_property.dart';

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

// For Sale update value
  Future<AutoVerbal_property_update> saveAutoVerbal_Update_property(
      AutoVerbal_property_update_1 requestModel, int id_ptys) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_update/$id_ptys'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbal_property_update.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbal_property_update.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

// For Rent update value
  Future<AutoVerbal_property_update_Rent> saveAutoVerbal_Update_property_Rent(
      AutoVerbal_property_update_Rent_k requestModel, int id_ptys) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_rent_update/$id_ptys'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbal_property_update_Rent.fromJson(
          json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbal_property_update_Rent.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<AutoVerbal_property_update> Sale_Update_Image_property(
      AutoVerbal_property_update_1 requestModel, int id_ptys) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/property_sale_update/$id_ptys'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbal_property_update.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbal_property_update.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
