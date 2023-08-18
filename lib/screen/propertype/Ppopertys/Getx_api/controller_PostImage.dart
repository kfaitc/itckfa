// ignore_for_file: avoid_print

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _image = Rx<File?>(null);

  set image(File? value) => _image.value = value;
  File? get image => _image.value;

  Future<void> uploadImageToServer(verbalid) async {
    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Image_ptys_post_id_last/202347267');

    final request = http.MultipartRequest('POST', url);
    request.fields['id_image'] = '202347267';
    request.fields['hometype'] = 'sdfjkjhhsd';
    request.fields['property_type_id'] = '12';
    request.files
        .add(await http.MultipartFile.fromPath('image_name_sale', image!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded!');
    } else {
      print('Error uploading image: ${response.reasonPhrase}');
    }
  }
}
