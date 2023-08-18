// // ignore_for_file: file_names, avoid_print, prefer_const_constructors

// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:kfa_project/screen/components/slideUp.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthController {
//   static login(Map userData) async {
//     print(userData);
//     var response = {"id": "id", "token": "token"};
//     var any = await SharedPreferences.getInstance();

//     any.setString("userData", json.encode(response));
//     Get.off(HomePage());
//   }

//   Future<bool> tryAutoLogin() async {
//     var any = await SharedPreferences.getInstance();
//     if (!any.containsKey('map')) {
//       return false;
//     } else {
//       return true;
//     }
//   }
// }
