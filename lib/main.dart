import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
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
    // incomingLinkHandler();
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
          if (args.contains('wing')) {
            Get.to(() => const ThankYouPage(
                  title: 'Wing',
                ));
          }
          if (args.contains('app')) {
            Get.to(() => const HomePage1(pf: true));
          }
        }
      },
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/app': (context) => const HomePage1(pf: true),
        '/wing': (context) => const ThankYouPage(
              title: 'Wing',
            )
      },
    );
  }
}

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  int _secondsRemaining = 5; // 10 minutes in seconds
  late Timer _timer;
  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (_secondsRemaining == 0) {
          timer.cancel();
          Get.to(() => const HomePage1());
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/WingBank-Logo_Square.png"))),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Payment done Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "You will be redirected to the home page shortly\nor click here to return to home page\n\n${_formatTime(_secondsRemaining)}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: GFButton(
                size: GFSize.LARGE,
                shape: GFButtonShape.standard,
                type: GFButtonType.outline2x,
                onPressed: () {
                  Get.to(() => const HomePage1());
                  dispose();
                },
                text: "Home",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
