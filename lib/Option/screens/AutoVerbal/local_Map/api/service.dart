import 'package:get/get.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../data/MyDB.dart';

class API_Controller extends GetxController {
  var listmainRaod = <dynamic>[].obs;
  MyDBmap mydb = MyDBmap();

  @override
  void onInit() {
    super.onInit();
    mainRaod();
  }

  Future<void> mainRaod() async {
    await mydb.createMainRaodT();
    listmainRaod.value = await mydb.db.rawQuery('SELECT * FROM mainRaod_Table');
    print("No.1");
    if (listmainRaod.isEmpty) {
      print("No.2");

      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/raods',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        listmainRaod.value = response.data;
        for (var road in listmainRaod) {
          await mydb.db.rawInsert(
            "INSERT INTO mainRaod_Table(name_road) VALUES (?);",
            [road['name_road'].toString()],
          );
        }
      } else {
        print(response.statusMessage);
      }
    }
  }
}
