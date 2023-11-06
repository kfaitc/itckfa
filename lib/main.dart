import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:itckfa/afa/screens/Auth/login.dart';
import 'package:itckfa/screen/Property/Home_Screen_property.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // final ImagePickerPlatform imagePickerImplementation =
  //     ImagePickerPlatform.instance;
  // if (imagePickerImplementation is ImagePickerAndroid) {
  //   imagePickerImplementation.useAndroidPhotoPicker = true;
  // }
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // Check if you received the link via `getInitialLink` first
  // final PendingDynamicLinkData? initialLink =
  //     await FirebaseDynamicLinks.instance.getInitialLink();

  // if (initialLink != null) {
  //   final Uri deepLink = initialLink.link;
  //   // Example of using the dynamic link to push the user to a different screen
  // }

  //======|One signal |======
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("d3025f03-32f5-444a-8100-7f7637a7f631");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  //======|One signal |======

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future _getInstallPermission() async {
    if (await Permission.requestInstallPackages.request().isGranted) {
      // setState(() {
      //   permissionGranted = true;
      // });
    } else if (await Permission.requestInstallPackages
        .request()
        .isPermanentlyDenied) {
      // await openAppSettings();
    } else if (await Permission.requestInstallPackages.request().isDenied) {
      // setState(() {
      //   permissionGranted = false;
      // });
    }
    OneSignal.Notifications.addPermissionObserver((state) {
      // print("Has permission $state");
    });
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  }

  // String link = 'https://kfaapp.page.link/service';

  // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(link));
  // This widget is the root of your application.

  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    _getInstallPermission();
    incomingLinkHandler();
  }

  Future incomingLinkHandler() async {
    try {
      Uri? uri = await getInitialUri();
      if (uri != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // openAppLink(uri);
          // print({"====|$uri|===="});
        });
      }
      streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (uri == null) {
          return;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // print({"====|Listen|====": uri});
            // openAppLink(uri);
          });
        }
      });
      OneSignal.Notifications.permission;
      OneSignal.Notifications.requestPermission(true);
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
