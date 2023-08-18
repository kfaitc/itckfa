// ignore_for_file: import_of_legacy_library_into_null_safe, camel_case_types, prefer_const_constructors, deprecated_member_use, unused_field, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'ImageController.dart';

class Save_Image extends StatefulWidget {
  const Save_Image({Key? key}) : super(key: key);

  @override
  State<Save_Image> createState() => _Save_ImageState();
}

class _Save_ImageState extends State<Save_Image> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return Scaffold(
        appBar: AppBar(
          title: Text('Save Image'),
        ),
        body: GetBuilder<ImageController>(
          builder: (imageController) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(35),
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        child: Text('Select An Image'),
                        onTap: () =>
                            imageController.pickImage(ImageSource.gallery),
                        // onTap: ()=>_pickImage(),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: imageController.pickedFile != null
                          ? Image.file(
                              File(imageController.pickedFile!.path),
                              // width: 100,
                              // height: 100,
                              fit: BoxFit.cover,
                            )
                          : Text("Please select an image"),
                    ),

                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: GestureDetector(
                        child: Text('Server upload'),
                        //onPressed: _openImagePicker,
                        onTap: () => Get.find<ImageController>().upload(),
                      ),
                    ),
                    SizedBox(height: 35),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 180,
                      color: Colors.grey[300],
                      child: imageController.imagePath != null
                          ? Image.network(
                              "https://www.oneclickonedollar.com/laravel_kfa_2023/public" +
                                  imageController.imagePath!,
                              fit: BoxFit.cover,
                            )
                          : const Text('No image from server'),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
