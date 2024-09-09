// ignore_for_file: unused_import, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_is_empty, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/getwidget.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/Memory_local/show_data_saved_offline.dart';
import 'package:itckfa/Option/components/colors.dart';
import 'package:itckfa/Option/screens/Auth/register.dart';
import 'package:itckfa/Option/screens/AutoVerbal/search/protect.dart';
import 'package:itckfa/api/api_service.dart';
import 'package:itckfa/models/login_model.dart';
import 'package:itckfa/models/register_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:itckfa/screen/Home/Home.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:developer' as developer;
import '../../../Getx/Auth/Auth.dart';
import '../../../Getx/Auth/remember.dart';
import '../../../screen/Customs/responsive.dart';
import '../../components/contants.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({required this.lat, required this.log, Key? key, required thi})
      : super(key: key);
  double? lat;
  double? log;

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  int? id;
  late String username = "";
  late String first_name = "";
  late String last_name = "";
  late String email = "";
  late String gender = "";
  late String from = "";
  late String tel = "";
  late String control_user = "";
  bool status = false;
  GetUserRemember getUserRemember = GetUserRemember();
  Authentication authentication = Get.put(Authentication());
  late TextEditingController Email;
  late TextEditingController Password;
  Future getdata() async {
    Future.delayed(Duration(milliseconds: 500), () async {
      await mydb.open_user();
      slist = await mydb.db.rawQuery('SELECT * FROM user');
      setState(() {
        if (slist.length > 0) {
          int i = slist.length - 1;
          status = true;
          id = slist[i]['id'];
          control_user = slist[i]['username'];
          print("objects: $id");
          print(slist.toString());
          requestModel.email = slist[i]['email'];
          requestModel.password = slist[i]['password'];
          if (slist.isNotEmpty) {
            authentication.login(requestModel, true);
          }
        } else {
          authentication.listAuth.clear();
        }
      });
    });
  }

  // Map? datatest;
  List<Map> slist = [];
  MyDb mydb = MyDb();
  late AnimationController controller;
  late Animation<double> animation;
  late PageController _pageController;
  late List slideList;
  late int initialPage;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      if ((result == ConnectivityResult.mobile) ||
          (result == ConnectivityResult.wifi)) {
        setState(() {
          offline = true;
          print("result = $offline\n");
        });
      } else if (result == ConnectivityResult.none) {
        setState(() {
          offline = false;
          print("result = $offline\n");
        });
        final snackBar = SnackBar(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
          padding: EdgeInsets.all(0),
          // showCloseIcon: true,
          // onVisible: () {
          //   Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => data_verbal_saved()));
          // },
          content: GFCard(
            padding: EdgeInsets.all(0),
            boxFit: BoxFit.cover,
            color: Colors.white,
            title: GFListTile(
              color: Colors.white,
              avatar: Icon(
                Icons.download_for_offline_outlined,
                color: Colors.blue,
                size: 50,
              ),
              title: Text('You\'re offline'),
              subTitle: Text('Watch saved data in your Library'),
            ),
            content: Text("All data had save!"),
            buttonBar: GFButtonBar(
              children: <Widget>[
                GFButton(
                  onPressed: () {
                    setState(() {
                      offline = true;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => data_verbal_saved(),
                      ),
                    );
                  },
                  color: GFColors.SUCCESS,
                  text: 'Go to watch',
                ),
              ],
            ),
          ),
        );
        setState(() {
          if (offline == false) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            _connectivitySubscription.cancel();
            dispose();
          }
        });
      }
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
  }

  bool offline = false;

  @override
  void initState() {
    // main();
    getdata();
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;

    super.initState();

    requestModel = LoginRequestModel(email: "", password: "");
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  bool welcome = false;
  bool check_elcome = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite_new,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Responsive(
              mobile: login(context),
              tablet: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 500,
                          child: login(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 500,
                          child: login(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              phone: login(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget login(BuildContext contex) {
    return Form(
      key: _formKey,
      child: Obx(
        () {
          if (authentication.isAuth.value) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  opacity: 0.4,
                  filterQuality: FilterQuality.medium,
                  image: AssetImage('assets/images/first.gif'),
                ),
                gradient: LinearGradient(
                  colors: const [
                    Color.fromARGB(226, 76, 83, 175),
                    Color.fromARGB(211, 101, 59, 255)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (authentication.listAuth.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 50),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/KFA_CRM.png',
                    height: 160,
                    width: 160,
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        const SizedBox(height: 25.0),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: SizedBox(
                            height: 55,
                            child: TextFormField(
                              onChanged: (input) => requestModel.email = input,
                              keyboardAppearance: Brightness.light,
                              keyboardType: TextInputType.emailAddress,
                              scrollPadding: const EdgeInsets.only(top: 5000),
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                filled: true,
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: kPrimaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return 'require email*';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: SizedBox(
                            height: 55,
                            child: TextFormField(
                              onSaved: (input) =>
                                  requestModel.password = input!,
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                fillColor: kwhite,
                                filled: true,
                                labelText: 'Enter password',
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: kPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    color: kPrimaryColor,
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return "require password *";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 100,
                          child: AnimatedButton(
                            text: 'Login',
                            color: kwhite_new,
                            pressEvent: () async {
                              if (validateAndSave()) {
                                setState(() {
                                  // final player = AudioPlayer();
                                  // player.play(AssetSource('nor.mp3'));
                                  isApiCallProcess = true;
                                });
                                await authentication.login(
                                  requestModel,
                                  true,
                                );
                                // await getUserRemember
                                //     .rememberAuth(authVerbal.listGetUser);
                                if (slist.length == 0) {
                                  await mydb.db.rawInsert(
                                      "INSERT INTO user (id ,first_name, last_name, username, gender, tel_num, known_from, email, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);",
                                      [
                                        authentication.listAuth[0]['id'],
                                        authentication.listAuth[0]
                                            ['first_name'],
                                        authentication.listAuth[0]['last_name'],
                                        authentication.listAuth[0]
                                            ['control_user'],
                                        authentication.listAuth[0]['gender'],
                                        authentication.listAuth[0]['tel_num'],
                                        authentication.listAuth[0]
                                            ['known_from'],
                                        requestModel.email,
                                        requestModel.password
                                      ]);
                                } else {
                                  var check_Sql = await mydb.db.rawQuery(
                                    'SELECT * FROM user  WHERE  email=? AND password=?',
                                    [requestModel.email, requestModel.password],
                                  );
                                  if (check_Sql.length == 0) {
                                    mydb.db.rawInsert(
                                        "UPDATE user SET id=? ,first_name=?, last_name=?, username=?, gender=?, tel_num=?, known_from=?, email=?, password=? WHERE 1",
                                        [
                                          authentication.listAuth[0]!['id'],
                                          authentication.listAuth[0]
                                              ['first_name'],
                                          authentication.listAuth[0]
                                              ['last_name'],
                                          authentication.listAuth[0]
                                              ['control_user'],
                                          authentication.listAuth[0]['gender'],
                                          authentication.listAuth[0]['tel_num'],
                                          authentication.listAuth[0]
                                              ['known_from'],
                                          requestModel.email,
                                          requestModel.password
                                        ]);
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have any account? ",
                                style: TextStyle(
                                    fontSize: 16.0, color: kTextLightColor),
                              ),
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          16,
                                  color: kPrimaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('No Data');
          }
        },
      ),
    );
  }

  void Load(String token) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      await OneSignal.shared.setAppId("d3025f03-32f5-444a-8100-7f7637a7f631");
      OneSignal.shared
          .promptUserForPushNotificationPermission()
          .then((accepted) {
        print("Accepted permission: $accepted");
      });
      await _handleSetExternalUserId();
      setState(() {
        id = jsonData["id"];
        username = jsonData['username'];
        first_name = jsonData['first_name'];
        last_name = jsonData['last_name'];
        email = jsonData['email'];
        gender = jsonData['gender'];
        from = jsonData['known_from'];
        tel = jsonData['tel_num'];
        control_user = jsonData['control_user'];
      });
      // print(id.toString());
    }
  }

  var subscription_id;
  Future _handleSetExternalUserId() async {
    final status = await OneSignal.shared.getDeviceState();
    subscription_id = status!.userId.toString();
    if (subscription_id != null) {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/onesignal'));
      request.body = json.encode(
          {"control_user": control_user, "subscription_id": subscription_id});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
