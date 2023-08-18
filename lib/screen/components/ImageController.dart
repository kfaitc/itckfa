// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  // File? _image;
  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  String? _imagePath;
  String? get imagePath => _imagePath;
  final _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    _pickedFile = (await _picker.pickImage(source: source)) as PickedFile?;
    // if (_pickedFile != null) {
    //   setState(() {
    //     _image = File(_pickedFile!.path);
    //   });
    // }

    update();
  }

  Future<bool> upload() async {
    update();
    bool success = false;
    http.StreamedResponse response = await updateProfile(_pickedFile);

    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      success = true;
      _imagePath = message;
      // _pickedFile = null;
      //await getUserInfo();
      print(message);
    } else {
      print("Error uploading Image");
    }
    update();

    return success;
  }

  Future<http.StreamedResponse> updateProfile(PickedFile? data) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/upload"));
    // request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});

    if (GetPlatform.isMobile && data != null) {
      File file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split('/').last));
    }
    //
    http.StreamedResponse response = await request.send();
    return response;
  }
}
