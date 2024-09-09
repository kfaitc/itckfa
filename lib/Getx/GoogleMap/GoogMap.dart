import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerMap extends GetxController {
  var isMain = true.obs;
  var isRoad = true.obs;
  var isPriceR = true.obs;
  var isPriceC = true.obs;
  var iskhan = true.obs;
  var isSongkat = true.obs;
  var isOption = true.obs;
  var isTypeCR = true.obs;
  List<Map<dynamic, dynamic>> listvalueMain = [];
  List<Map<dynamic, dynamic>> listvalueRaod = [];
  List<Map<dynamic, dynamic>> listvaluePriceR = [];
  List<Map<dynamic, dynamic>> listvaluePriceC = [];
  List<Map<dynamic, dynamic>> listvalueKhan = [];
  List<Map<dynamic, dynamic>> listvalueSongkat = [];
  List<Map<dynamic, dynamic>> listvalueOption = [];
  List<Map<dynamic, dynamic>> listvalueTypeCR = [];
  List<Map<dynamic, dynamic>> listvalueDropdown = [];
  List<String> raodData = [];
  List<String> listTypeRaodData = [];
  List<String> listRData = [];
  List<String> listCData = [];
  List<String> listKhanData = [];
  List<String> listSongkatData = [];
  List<String> listOptionData = [];
  List<String> listdropdownData = [];
  List listMainRoute = [].obs;
  List listRaod = [].obs;
  List listPriceR = [].obs;
  List listPriceC = [].obs;
  List listKhanP = [].obs;
  List listsang = [].obs;
  List listOption = [].obs;
  List listdropdown = [].obs;
  Future<void> mainAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    raodData = prefs.getStringList('listRaod') ?? [];
    listMainRoute = raodData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (raodData.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/raods',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listMainRoute = jsonDecode(json.encode(response.data));
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listMainRoute.length; i++) {
            listvalueMain.add(listMainRoute[i]);
          }

          raodData = responseData.map((item) => json.encode(item)).toList();
          raodList(raodData);
          print("=====> No.1");
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isMain.value = false;
      }
    } else {
      for (int i = 0; i < listMainRoute.length; i++) {
        listvalueMain.add(listMainRoute[i]);
      }
      isMain.value = false;
    }
  }

  Future<void> roadAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listTypeRaodData = prefs.getStringList('listTypeRaod') ?? [];
    listRaod = listTypeRaodData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
    print(listRaod.toString());
    if (listRaod.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/raod_option',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listRaod = jsonDecode(json.encode(response.data))['roads'];
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listRaod.length; i++) {
            listvalueRaod.add(listRaod[i]);
          }
          listTypeRaodData =
              responseData.map((item) => json.encode(item)).toList();
          typeRaod(listTypeRaodData);
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isRoad.value = false;
      }
    } else {
      print("=====> ENo.2");
      for (int i = 0; i < listRaod.length; i++) {
        listvalueRaod.add(listRaod[i]);
      }
      isRoad.value = false;
    }
  }

  Future<void> checkPriceListRAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listRData = prefs.getStringList('listR') ?? [];
    listPriceR = listRData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (listRData.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price/listR',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listPriceR = jsonDecode(json.encode(response.data))['r'];
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listPriceR.length; i++) {
            listvaluePriceR.add(listPriceR[i]);
          }

          listRData = responseData.map((item) => json.encode(item)).toList();
          listR(listRData);
          print("=====> No.3");
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isPriceR.value = false;
      }
    } else {
      for (int i = 0; i < listPriceR.length; i++) {
        listvaluePriceR.add(listPriceR[i]);
      }
      isPriceR.value = false;
    }
  }

  Future<void> checkPriceListCAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listCData = prefs.getStringList('listC') ?? [];
    listPriceC = listCData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (listCData.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price/listC',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listPriceC = jsonDecode(json.encode(response.data))['c'];
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listPriceC.length; i++) {
            listvaluePriceC.add(listPriceC[i]);
          }

          listCData = responseData.map((item) => json.encode(item)).toList();
          listC(listCData);
          print("=====> No.4");
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isPriceC.value = false;
      }
    } else {
      for (int i = 0; i < listPriceC.length; i++) {
        listvaluePriceC.add(listPriceC[i]);
      }
      isPriceC.value = false;
    }
  }

  Future<void> khanAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listKhanData = prefs.getStringList('listKhan') ?? [];
    listKhanP = listKhanData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (listKhanData.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan/list',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listKhanP = jsonDecode(json.encode(response.data));
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listKhanP.length; i++) {
            listvalueKhan.add(listKhanP[i]);
          }

          listKhanData = responseData.map((item) => json.encode(item)).toList();
          khanC(listKhanData);
          print("=====> No.5");
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        iskhan.value = false;
      }
    } else {
      for (int i = 0; i < listKhanP.length; i++) {
        listvalueKhan.add(listKhanP[i]);
      }
      iskhan.value = false;
    }
  }

  Future<void> songkatAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listSongkatData = prefs.getStringList('listsongkat') ?? [];
    listsang = listSongkatData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (listSongkatData.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat/list',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listsang = jsonDecode(json.encode(response.data));
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listsang.length; i++) {
            listvalueSongkat.add(listsang[i]);
          }

          listSongkatData =
              responseData.map((item) => json.encode(item)).toList();
          songkat(listSongkatData);
          print("=====> No.6");
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isSongkat.value = false;
      }
    } else {
      for (int i = 0; i < listsang.length; i++) {
        listvalueSongkat.add(listsang[i]);
      }
      isSongkat.value = false;
    }
  }

  Future<void> optionAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listOptionData = prefs.getStringList('listOption') ?? [];
    listOption = listOptionData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (listOptionData.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listOption = jsonDecode(json.encode(response.data));
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listOption.length; i++) {
            listvalueOption.add(listOption[i]);
          }

          listOptionData =
              responseData.map((item) => json.encode(item)).toList();
          option(listOptionData);
          print("=====> No.7");
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isOption.value = false;
      }
    } else {
      for (int i = 0; i < listOption.length; i++) {
        listvalueOption.add(listOption[i]);
      }
      isOption.value = false;
    }
  }

  Future<void> comparaCRAPI(int updateNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listdropdownData = prefs.getStringList('listdropdown') ?? [];
    listdropdown = listdropdownData
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();

    if (listdropdownData.isEmpty || updateNew == 1) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/compare/dropdown',
          options: Options(
            method: 'GET',
          ),
        );
        if (response.statusCode == 200) {
          listdropdown = jsonDecode(json.encode(response.data));
          List<dynamic> responseData = response.data;
          for (int i = 0; i < listdropdown.length; i++) {
            listvalueDropdown.add(listdropdown[i]);
          }

          listdropdownData =
              responseData.map((item) => json.encode(item)).toList();
          dropdowns(listdropdownData);
          print("=====> No.8");
        }
      } catch (e) {
        // print('Error occurred: $e');
      } finally {
        isTypeCR.value = false;
      }
    } else {
      for (int i = 0; i < listdropdown.length; i++) {
        listvalueDropdown.add(listdropdown[i]);
      }
      isTypeCR.value = false;
    }
  }

  raodList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listRaod', list);
    listMainRoute = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  typeRaod(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listTypeRaod', list);
    listRaod = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  listR(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listR', list);
    listRData = list;
    listPriceR = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  listC(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listC', list);
    listCData = list;
    listPriceC = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  khanC(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listKhan', list);
    listKhanData = list;
    listKhanP = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  songkat(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listsongkat', list);
    listSongkatData = list;
    listsang = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  option(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listOption', list);
    listOptionData = list;
    listOption = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  dropdowns(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listdropdown', list);
    listdropdownData = list;
    listdropdown = list
        .map((item) => json.decode(item))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  Future<void> checkGoogle(iduser) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"query": "siem reap"});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update/Auth/$iduser',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
    } else {
      // print(response.statusMessage);
    }
  }
}
