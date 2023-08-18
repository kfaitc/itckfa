// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:itckfa/screen/PDF%20file/Pdf_Api.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create Pdf file',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Create PDF file'),
              onPressed: () async {
                final pdfFile = await PdfApi.generateParagrap();
                PdfApi.openFile(pdfFile);
              },
            )
          ],
        )),
      ),
    );
  }
}
