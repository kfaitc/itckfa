// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable, camel_case_types

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../afa/components/contants.dart';

class Feed_back extends StatefulWidget {
  const Feed_back({super.key});

  @override
  State<Feed_back> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feed_back> {
  TextEditingController email_kfa = TextEditingController();
  TextEditingController subject_kfa = TextEditingController();
  TextEditingController message_to_kfa = TextEditingController();

  @override
  void initState() {
    super.initState();
    email_kfa = TextEditingController(text: 'info@kfa.com.kh');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        centerTitle: true,
        title: Text('FeekBack'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Send us an email',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    readOnly: true,
                    controller: email_kfa,
                    decoration: InputDecoration(
                      fillColor: kwhite,
                      filled: true,
                      labelText: 'Gmail_KFA*',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14),
                    controller: subject_kfa,
                    maxLines: 2,
                    decoration: InputDecoration(
                      fillColor: kwhite,
                      labelText: 'Subject Title*',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Note \t',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Color.fromARGB(65, 158, 158, 158),
                    width: MediaQuery.of(context).size.width * 0.7,
                    alignment: Alignment.center,
                    child: Text(
                      ' Your Gmail/Yahoo and Other will \t\t\tgenerate Auto',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 12,
                          color: Color.fromARGB(255, 0, 0, 0),
                          overflow: TextOverflow.fade),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 236, 234, 221)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 30,
                    controller: message_to_kfa,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Message",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  String recipient = email_kfa.text;
                  String subject = subject_kfa.text;
                  String body = message_to_kfa.text;

                  final Uri email = Uri(
                    scheme: 'mailto',
                    path: recipient,
                    queryParameters: {
                      'subject': subject,
                      'body': body,
                    },
                  );
                  if (await canLaunchUrl(email)) {
                    await launchUrl(email);
                  } else {
                    debugPrint('error');
                  }
                },
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kwhite_new,
                  ),
                  child: Center(
                    child: Text(
                      "Send",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'mean required',
                style: TextStyle(color: Color.fromARGB(255, 182, 177, 177)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
