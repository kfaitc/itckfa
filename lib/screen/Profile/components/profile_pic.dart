// ignore_for_file: import_of_legacy_library_into_null_safe, deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, camel_case_types, unused_field, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itckfa/contants.dart';

class Profile_pic extends StatefulWidget {
  const Profile_pic({Key? key}) : super(key: key);

  @override
  State<Profile_pic> createState() => _Profile_picState();
}

class _Profile_picState extends State<Profile_pic> {
  // PickedFile? _imagefile;
  XFile? _imagefile;
  final ImagePicker _picker = ImagePicker();
  // final ImageCropper _cropper = ImageCropper();

  File? _image;
  final ImageCropper _cropper = ImageCropper();

  // void TakePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(
  //     source: source,
  //   );
  //   if (pickedFile != null) {
  //     final cropedFile = await _cropper.cropImage(
  //         sourcePath: _imagefile.path,
  //         aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //         compressQuality: 100,
  //         maxHeight: 100,
  //         maxWidth: 100,
  //         compressFormat: ImageCompressFormat.jpg,
  //         androidUiSettings: AndroidUiSettings(
  //           toolbarColor: Colors.blue,
  //           toolbarTitle: "Croped Your profile",
  //           statusBarColor: Colors.blue,
  //           backgroundColor: Colors.white,
  //         ));
  //     setState(() {
  //       _imagefile = cropedFile as PickedFile?;
  //     });
  //   }

  //   setState(() {
  //     _imagefile = pickedFile;
  //   });
  // }
  getImage(ImageSource source) async {
    // _imagefile = await _picker.getImage(source: source);
    _imagefile = await _picker.pickImage(source: source);

    if (_imagefile != null) {
      CroppedFile? cropped = await _cropper.cropImage(
        sourcePath: _imagefile!.path,
        //aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 90,
        maxHeight: 100,
        maxWidth: 100,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      setState(() {
        _image = cropped as File?;
      });
    } else {
      throw "Could not cropped Image";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //color: Colors.red,
      child: SizedBox(
        height: 120,
        width: 120,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  radius: 71,
                  backgroundColor: Colors.black38,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: Colors.grey,
                    //foregroundImage: AssetImage('assets/images/KFA-Logo.png'),
                    backgroundImage: _imagefile == null
                        ? null
                        : FileImage(File(_imagefile!.path)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 160),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meng Chanrithty',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '123456789',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              //right: 230,
              left: 0,
              bottom: 0,
              child: SizedBox(
                height: 40,
                width: 40,
                // child: FlatButton(
                //   padding: EdgeInsets.zero,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(50),
                //       side: BorderSide(
                //         color: kImageColor,
                //       )),
                //   color: kImageColor,
                //   onPressed: () {
                //     showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return AlertDialog(
                //             title: Text(
                //               'Choose option',
                //               style: TextStyle(
                //                 color: Colors.blue,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //             content: SingleChildScrollView(
                //               child: Column(
                //                 children: [
                //                   EditPicture(
                //                     icon: Icons.camera,
                //                     title: 'Camera',
                //                     press: () {
                //                       getImage(ImageSource.camera);
                //                     },
                //                   ),
                //                   EditPicture(
                //                     icon: Icons.image,
                //                     title: 'Gallary',
                //                     press: () {
                //                       getImage(ImageSource.gallery);
                //                     },
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           );
                //         });
                //   },
                //   child: SvgPicture.asset(
                //     "assets/icons/camera.svg",
                //     color: Colors.black,
                //     height: 24,
                //     width: 24,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPicture extends StatelessWidget {
  final String title;
  final icon;
  final press;
  const EditPicture({
    Key? key,
    required this.title,
    required this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        InkWell(
          onTap: press,
          splashColor: Colors.lightBlue,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  icon,
                  color: kImageColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ],
    );
  }
}
