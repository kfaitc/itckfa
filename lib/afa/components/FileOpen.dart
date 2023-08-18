// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:file_picker/file_picker.dart';
import 'package:itckfa/afa/components/contants.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

class FileOpen extends StatefulWidget {
  @override
  State<FileOpen> createState() => _FileOpenState();
}

class _FileOpenState extends State<FileOpen> {
  var fileopen;

  late String nameFile = '';

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null) return;
    final file = result.files.first;
    setState(() {
      fileopen = file;
      nameFile = result.files.first.name;
    });
    print(nameFile);
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              // padding: EdgeInsets.only(left: 30, right: 30),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.file_present_sharp,
                          color: kImageColor,
                        ),
                        SizedBox(width: 3),
                        TextButton(
                          onPressed: () {
                            _pickFile();
                          },
                          child: Text(
                            'Choose File',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        child: nameFile != ''
                            ? Text(nameFile.toString(),
                                style: TextStyle(color: kImageColor))
                            : Text(
                                nameFile.toString(),
                                style: TextStyle(color: kImageColor),
                              ),
                        onTap: () => _openFile(fileopen),
                        // onTap: ()=>_pickImage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
