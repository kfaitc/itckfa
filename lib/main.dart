import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:itckfa/afa/screens/Auth/login.dart';
import 'package:itckfa/afa/screens/AutoVerbal/search/Edit.dart';
import 'package:itckfa/firebase_options.dart';
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
  if (Platform.isIOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
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
  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  // OneSignal.initialize("d3025f03-32f5-444a-8100-7f7637a7f631");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  // OneSignal.Notifications.requestPermission(true);
  //======|One signal |======
  // handleIncomingLinks();
// virak test
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  await OneSignal.shared.setAppId("d3025f03-32f5-444a-8100-7f7637a7f631");
  // OneSignal.shared.disablePush(false);
  // bool userProvidedPrivacyConsent =
  //     await OneSignal.shared.userProvidedPrivacyConsent();
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

String? user_id_control;
String? verbal_id;

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
    // OneSignal.Notifications.addPermissionObserver((state) {
    //   // print("Has permission $state");
    // });
    // OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  }

  // String link = 'https://kfaapp.page.link/service';

  // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(link));
  // This widget is the root of your application.

  late StreamSubscription streamSubscription;

  @override
  void initState() {
    // incomingLinkHandler();
    super.initState();
    _getInstallPermission();
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

  var li;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.name;

        if (args != null) {
          if (args.contains("/aba")) {
            List<String> pathSegments = extractPathSegments(args);

            if (pathSegments.length > 2) {
              user_id_control = pathSegments.length > 1 ? pathSegments[1] : '';
              verbal_id = pathSegments.length > 2 ? pathSegments[2] : '';

              if (user_id_control != null && verbal_id != null) {
                return MaterialPageRoute(
                  builder: (context) {
                    return const ThankYouPage(title: "varbal");
                  },
                );
              }
            } else {
              return MaterialPageRoute(
                builder: (context) {
                  return const ThankYouPage(title: "aba");
                },
              );
            }
          } else if (args.contains("/wing")) {
            Uri uri = Uri.parse(args);

            List<String> pathSegments = uri.pathSegments;
            if (pathSegments.length > 1) {
              user_id_control =
                  pathSegments.length > 1 ? pathSegments[1] : null;
              verbal_id = pathSegments.length > 2 ? pathSegments[2] : null;
              if (user_id_control != null && verbal_id != null) {
                return MaterialPageRoute(
                  builder: (context) {
                    return const ThankYouPage(title: "varbal");
                  },
                );
              }
            } else {
              return MaterialPageRoute(
                builder: (context) {
                  return const ThankYouPage(title: "wing");
                },
              );
            }
          }
        }
        return null;
      },
      initialRoute: '/',
      // home: ThankYouPage(title: "aba"),
      routes: {
        '/': (context) => const Login(),
        "/aba": (context) => const ThankYouPage(title: "aba"),
        "/wing": (context) => const ThankYouPage(title: "wing"),
        '/Edit': (context) => const ThankYouPage(title: "varbal"),
      },
    );
  }

  List<String> extractPathSegments(String path) {
    List<String> pathSegments = path.split('/');
    // Filter out empty segments
    pathSegments = pathSegments.where((segment) => segment.isNotEmpty).toList();
    return pathSegments;
  }

  List<String> extractPathSegments_wing(String path) {
    List<String> pathSegments = path.split('/');
    // Filter out empty segments
    pathSegments = pathSegments.where((segment) => segment.isNotEmpty).toList();
    return pathSegments;
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
  var image;
  void check_bank_after_pay() {
    if (widget.title.toString() == "aba") {
      setState(() {
        image = "assets/images/check-mark.png";
      });
    } else if (widget.title.toString() == "wing") {
      setState(() {
        image = "assets/images/WingBank-Logo_Square.png";
      });
    } else if (widget.title.toString() == "upay") {
      setState(() {
        image = "assets/images/check-mark.png";
      });
    } else {
      setState(() {
        image = "assets/images/check-mark.png";
      });
    }
  }

  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  int _secondsRemaining = 9; // 10 minutes in seconds
  late Timer _timer;
  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (_secondsRemaining == 0) {
          timer.cancel();
          if (widget.title.toString() == "varbal") {
            Get.to(
              () => Edit(
                user_id_controller: user_id_control!,
                verbal_id: verbal_id!,
              ),
            );
          } else {
            Get.to(() => const HomePage1());
          }
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
    check_bank_after_pay();
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
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(image)),
              ),
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
            const Text(
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
              style: const TextStyle(
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
                  if (widget.title.toString() == "varbal") {
                    Get.to(
                      () => Edit(
                        user_id_controller: user_id_control!,
                        verbal_id: verbal_id!,
                      ),
                    );
                  } else {
                    Get.to(() => const HomePage1());
                  }
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

class kokok extends StatelessWidget {
  const kokok({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashBubbleIcon(),
    );
  }
}

class DashBubbleIcon extends StatefulWidget {
  const DashBubbleIcon({super.key});

  @override
  State<DashBubbleIcon> createState() => _DashBubbleIconState();
}

class _DashBubbleIconState extends State<DashBubbleIcon> {
  Offset position = const Offset(0.0, 0.0);
  double minX = 0.0;
  double minY = 0.0;
  double maxX = 200.0; // Set your desired maximum X-coordinate
  double maxY = 200.0; // Set your desired maximum Y-coordinate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Move Icons with Pan Gesture'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            color: Colors.red,
            child: Center(
              child: GestureDetector(
                onPanUpdate: (details) {
                  double newPosX = position.dx + details.delta.dx;
                  double newPosY = position.dy + details.delta.dy;

                  // Check if the new position is within the specified boundary
                  if (newPosX >= minX &&
                      newPosX <= maxX &&
                      newPosY >= minY &&
                      newPosY <= maxY) {
                    setState(() {
                      position = Offset(newPosX, newPosY);
                    });
                  }
                },
                child: Stack(
                  children: [
                    Positioned(
                      left: position.dx,
                      top: position.dy,
                      child: const Icon(
                        Icons.star,
                        size: 50.0,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    double dashWidth = 5.0;
    double dashSpace = 3.0;
    double distance = 0.0;
    while (distance < size.width) {
      canvas.drawPath(
        path.shift(Offset(distance, 0)),
        paint,
      );
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
