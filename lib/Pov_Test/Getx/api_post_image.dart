// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MultipleImageUploader extends StatefulWidget {
  @override
  _MultipleImageUploaderState createState() => _MultipleImageUploaderState();
}

class _MultipleImageUploaderState extends State<MultipleImageUploader> {
  List<File> _images = [];

  Future<void> pickImages() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
      );
    } on Exception catch (e) {
      // Handle exception
    }

    List<File> files = [];
    for (var asset in resultList) {
      ByteData byteData = await asset.getByteData();
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${asset.name}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      files.add(file);
    }

    setState(() {
      _images = files;
    });
  }

  Future<File?> _upload_Image_Sale() async {
    for (int i = 0; i < _images.length; i++) {
      File image = _images[i];

      final url = Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mutiple_image_post');

      final request = http.MultipartRequest('POST', url);
      request.fields['id_ptys'] = '100';

      request.files
          .add(await http.MultipartFile.fromPath('images', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded!$i');
      } else {
        print('Error uploading image: ${response.reasonPhrase}($i)');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Image Uploader'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(_images.length, (index) {
                return Image.file(
                  _images[index],
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: pickImages,
            child: Text('Pick Images'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _upload_Image_Sale,
            child: Text('Upload Images'),
          ),
          ElevatedButton(
            onPressed: () {
              print(_images.toString());
            },
            child: Text('look'),
          ),
        ],
      ),
    );
  }
}
