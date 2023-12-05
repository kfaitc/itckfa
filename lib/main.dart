import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:itckfa/afa/screens/Auth/login.dart';
import 'package:itckfa/screen/Home/Home.dart';
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
  // handleIncomingLinks();
  runApp(const MyApp());
}

// Future<void> handleIncomingLinks() async {
//   // Get the initial link when the app is launched
//   String? initialLink = await getInitialLink();
//   if (initialLink != null) {
//     // Handle the initial link, e.g., parse and navigate
//     print('\n\nInitial link received: $initialLink\n\n');
//     var data = initialLink.toString().split('/');
//     var value = data[1].toString();
//     if (value.toString() == "app") {
//       HomePage1();
//     }
//   }

//   // Listen for incoming links
//   // ignore: deprecated_member_use
//   getLinksStream().listen((String? link) {
//     if (link != null) {
//       // Handle the link, e.g., parse and navigate
//       print('\n\nLink received: $link\n\n');
//       var data = link.toString().split('/');
//       var value = data[1].toString();
//       if (value.toString() == "app") {
//         HomePage1();
//       }
//     }
//   });
// }

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
    incomingLinkHandler();
    super.initState();
    // _getInstallPermission();
  }

  Future incomingLinkHandler() async {
    // Get the initial link when the app is launched
    String? initialLink = await getInitialLink();
    if (initialLink != null) {
      if (initialLink.contains('app')) {
        Get.to(() => const HomePage1(pf: true));
      }
    }

    // ignore: deprecated_member_use
    getLinksStream().listen((String? link) {
      if (link != null) {
        if (link.contains('app')) {
          Get.to(() => const HomePage1(pf: true));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.name;
        // correct screen.
        if (args != null) {
          if (args.contains('app')) {
            Get.to(() => const HomePage1(pf: true));
          }
        }
      },
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/app': (context) => const HomePage1(pf: true)
      },
    );
  }
}
