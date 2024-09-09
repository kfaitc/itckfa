import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../models/ImageModel.dart';
import '../local/mydb.dart';

MyLocalhost mydb = MyLocalhost();
MyLocalhost lb = MyLocalhost();
ImageDBModel imageDBModel = ImageDBModel();

class PDFController extends GetxController {
  var imagelogo = false.obs;
  var listPDF = [].obs;

  Future<void> imagePDF() async {
    await mydb.imageDB();
    listPDF.value = await mydb.db.rawQuery('SELECT * FROM ImageDB');
    if (listPDF.isEmpty) {
      // print("IsEmpty");
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/pdf/15',
          options: Options(
            method: 'GET',
          ),
        );

        if (response.statusCode == 200) {
          listPDF.value = jsonDecode(json.encode(response.data));
          if (listPDF.isNotEmpty) {
            await mydb.db.rawInsert(
              "INSERT INTO imageDB (id, image) VALUES (15, '${listPDF[0]['image']}');",
            );
          }
        }
      } catch (e) {
        // print(e);
      } finally {
        imagelogo.value = false;
        if (listPDF.isNotEmpty) {}
      }
    } else {
      // print("IsnotEmpty");
    }
  }
}
