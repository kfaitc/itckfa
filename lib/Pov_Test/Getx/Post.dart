import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  List<Asset> images = <Asset>[];

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
        ),
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
        ],
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
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
