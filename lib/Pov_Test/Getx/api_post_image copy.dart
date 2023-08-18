// ignore_for_file: prefer_is_empty, prefer_const_constructors, sized_box_for_whitespace, unused_catch_clause, avoid_print, unused_element, use_key_in_widget_constructors, unused_field, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, unused_local_variable, deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageCompressionExamsssple extends StatefulWidget {
  @override
  _ImageCompressionExampleState createState() =>
      _ImageCompressionExampleState();
}

class _ImageCompressionExampleState extends State<ImageCompressionExamsssple> {
  File? _originalImage;
  File? _compressedImage;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _originalImage = File(result.files.first.path!);
        _compressedImage = null;
      });
    }
  }

  Future<void> _compressImage() async {
    if (_originalImage != null) {
      String targetPath = '${_originalImage!.path}_compressed.jpg';

      try {
        File? compressedFile =
            await testCompressAndGetFile(_originalImage!, targetPath);

        setState(() {
          _compressedImage = compressedFile;
        });
      } catch (e) {
        print('Error compressing image: $e');
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Compression Example'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                child: Column(
                  children: [],
                ),
              ),
              (_images.length != 0)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: (_images.length < 3)
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: List.generate(_images.length, (index) {
                            return Image.file(
                              _images[index],
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: InkWell(
                  onTap: pickImages,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 47, 22, 157)),
                    child: Text(
                      'Mutiple Image',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: InkWell(
                  onTap: _uploadImageSaleMultiple,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 47, 22, 157)),
                    child: Text(
                      'Post',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: InkWell(
                  onTap: pickImage,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 47, 22, 157)),
                    child: Text(
                      'Origener name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    return result;
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      String fileName = await getFileName(image);
      print('Original File Name: $fileName');
      return image;
    }
    return null;
  }

  Future<String> getFileName(File file) async {
    String fileName = basename(file.path);
    return fileName;
  }

  File? result;
  Future<void> _uploadImageSaleMultiple() async {
    for (int i = 0; i < _images.length; i++) {
      File image = _images[i];
      // print('image$i =${_images[i].toString()}');

      final url = Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mutiple_image_post');

      final request = http.MultipartRequest('POST', url);
      request.fields['id_ptys'] = '2000';
      // request.fields['hometype'] = 'sdfsd';
      // request.fields['property_type_id'] = '1212';

      // Compress the image file
      String targetPath = '${image.path}_compressed.jpg';

      try {
        File? compressedFile = await testCompressAndGetFile(image, targetPath);

        setState(() {
          _compressedImage = compressedFile;
        });
      } catch (e) {
        print('Error compressing image: $e');
      }
      // print('image$i =${image.toString()}');
      request.files.add(await http.MultipartFile.fromPath(
          'images$i', _compressedImage!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded! $i');
      } else {
        print('Error uploading image: ${response.reasonPhrase} ($i)');
      }
    }
  }
}
