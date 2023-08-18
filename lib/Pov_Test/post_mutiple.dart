// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;

class MyImagePicker2222 extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker2222> {
  List<Asset> images = <Asset>[];
  List<File> _images = [];
  Future<void> postImages() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/upload_45'),
    );

    for (var image in _images) {
      request.files.add(await http.MultipartFile.fromPath(
        'images_mutiple[]',
        image.path,
      ));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Images uploaded successfully');
    } else {
      print('Error uploading images: ${response.reasonPhrase}');
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,

        enableCamera: true,
        selectedAssets: images,
        // ignore: prefer_const_constructors
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
        ),
        // ignore: prefer_const_constructors
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Seleziona",
          allViewTitle: "Tutte le foto",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      // handle error
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      print('images = ${images.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: buildGridView(),
          ),
          ElevatedButton(
            child: Text("Select Images"),
            onPressed: loadAssets,
          ),
          ElevatedButton(
            child: Text("Post"),
            onPressed: postImages,
          ),
        ],
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        return AssetThumb(
          asset: images[index],
          width: 300,
          height: 300,
        );
      }),
    );
  }
}
