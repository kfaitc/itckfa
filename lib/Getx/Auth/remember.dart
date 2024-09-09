import 'package:get/get.dart';

class GetUserRemember extends GetxController {
  var listAuthR = [].obs;
  var isAuthR = false.obs;
  Future<void> rememberAuth(List list) async {
    listAuthR.value = list;
  }
}
