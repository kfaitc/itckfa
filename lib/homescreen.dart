import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Feed_back_11 extends StatefulWidget {
  const Feed_back_11({Key? key}) : super(key: key);

  @override
  State<Feed_back_11> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Feed_back_11> {
  TextEditingController recipientController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    recipientController =
        TextEditingController(text: 'oukpovsiemreap12@gmail.com');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: recipientController,
              decoration: InputDecoration(
                hintText: "Recipient",
              ),
            ),
            TextFormField(
              controller: subjectController,
              decoration: InputDecoration(
                hintText: "Subjecdddddt",
              ),
            ),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(
                hintText: "Body",
              ),
            ),
            GestureDetector(
              onTap: () async {
                String recipient = recipientController.text;
                String subject = subjectController.text;
                String body = bodyController.text;

                final Uri email = Uri(
                  scheme: 'mailto',
                  path: recipient,
                  query: 'subject=' +
                      Uri.encodeComponent(subject) +
                      '&body=' +
                      Uri.encodeComponent(body),
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
                color: Colors.orange,
                child: Center(
                  child: Text("Send"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
