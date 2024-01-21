// ignore_for_file: unused_import, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_is_empty, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/getwidget.dart';
import 'package:itckfa/Memory_local/database.dart';
import 'package:itckfa/Memory_local/show_data_saved_offline.dart';
import 'package:itckfa/afa/screens/Auth/register.dart';
import 'package:itckfa/afa/screens/AutoVerbal/search/protect.dart';
import 'package:itckfa/api/api_service.dart';
import 'package:itckfa/models/login_model.dart';
import 'package:itckfa/models/register_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:itckfa/screen/Home/Home.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:developer' as developer;
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
  static bool status = false;
  late TextEditingController Email;
  late TextEditingController Password;

  // selectPeople() async {
  //   // list = await PeopleController().selectPeople();
  //   // if (list.isEmpty) {
  //   //   setState(() {
  //   //     status = false;
  //   //   });
  //   // } else {
  //   //   setState(() {
  //   //     int i = list.length - 1;
  //   //     status = true;
  //   //     Email = TextEditingController(text: list[i].name);
  //   //     Password = TextEditingController(text: list[i].password);
  //   //   });
  //   // }

  //   slist = await mydb.db.rawQuery('SELECT * FROM user');
  //   slist.map((e) {
  //     setState(() {
  //       datatest = e;
  //       // print("\n\n\n\n\n\n kokokoko =  ${datatest!['email']}\n\n\n\n\n\n");
  //     });
  //   });
  //   if (slist.isEmpty) {
  //     setState(() {
  //       status = false;
  //     });
  //   } else {
  //     setState(() {
  //       int i = slideList.length - 1;
  //       status = true;
  //       // print("\n\n\n\n\n\n kokokoko =  ${datatest!['email']}\n\n\n\n\n\n");
  //       // Email = TextEditingController(text: list[i].name);
  //       // Password = TextEditingController(text: list[i].password);
  //     });
  //   }
  // }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      await mydb.open_user();
      slist = await mydb.db.rawQuery('SELECT * FROM user');
      setState(() {
        if (slist.length > 0) {
          int i = slist.length - 1;
          // print("\n\n\n\nkokoko" + slist.toString() + "\n\n\n\nkokoko");
          status = true;
          id = slist[i]['id'];
          control_user = slist[i]['username'];
          print("objects: $id");
          Email = TextEditingController(text: slist[i]['email']);
          Password = TextEditingController(text: slist[i]['password']);

          // OneSignal.logout();
          OneSignalPushSubscription().optIn().then((value) {});
          OneSignal.login(control_user);
          OneSignal.User.addAlias("fb_id", "$control_user");
          OneSignal.User.addEmail(slist[i]['email'].toString());
          // OneSignal.User.addAlias("fb_id", "kfa123");
          // OneSignal.User.addAliases({"fb_id": "11525-52442"});
          // OneSignal.login(slist[i]['username'].toString());
          // OneSignal.User.addAlias(
          //   "fb_id$id",
          //   slist[i]['username'].toString(),
          // );

          print(OneSignal.Notifications.toString());
        } else {
          // print("\n\n\n\nkakakaka" + slist.toString() + "\n\n\n\nkakakak");
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
  RegisterRequestModel requestModel_sql = RegisterRequestModel(
    email: "",
    password: "",
    first_name: '',
    gender: '',
    known_from: '',
    last_name: '',
    tel_num: '',
    password_confirmation: '',
    control_user: '',
  );
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
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

    return _updateConnectionStatus(result);
  }

  bool offline = false;
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if ((_connectionStatus == ConnectivityResult.mobile) ||
          (_connectionStatus == ConnectivityResult.wifi)) {
        setState(() {
          offline = true;
          _connectivitySubscription.cancel();
          print("result = $offline\n");
        });
      } else if (_connectionStatus == ConnectivityResult.none) {
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
        if (!offline) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _connectivitySubscription.cancel();
        }
      }
    });
  }

  @override
  void initState() {
    getdata();
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initConnectivity();

    super.initState();
    requestModel = LoginRequestModel(email: "", password: "");
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool welcome = false;
  bool check_elcome = false;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kwhite_new,
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/images/KFA_CRM.png',
            height: 160,
            width: 160,
          ),
          toolbarHeight: 130,
        ),
        backgroundColor: kwhite_new,
        body: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kwhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100.0),
              bottomRight: Radius.circular(100.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }

  Widget login(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 25.0,
          ),

          ((status == false) ? input(context) : Output(context)),

          SizedBox(
            height: 10.0,
          ),
          // ignore: deprecated_member_use
          SizedBox(
            width: 150,
            child: AnimatedButton(
              text: 'Login',
              color: kwhite_new,
              pressEvent: () async {
                await initConnectivity();
                if (!offline) {
                } else {
                  if (validateAndSave()) {
                    setState(() {
                      // final player = AudioPlayer();
                      // player.play(AssetSource('nor.mp3'));
                      isApiCallProcess = true;
                    });
                    APIservice apIservice = APIservice();
                    apIservice.login(requestModel).then((value) async {
                      Load(value.token);
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (value.message == "Login Successfully!") {
                        if (slist.length == 0) {
                          await mydb.db.rawInsert(
                              "INSERT INTO user (id ,first_name, last_name, username, gender, tel_num, known_from, email, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);",
                              [
                                value.user['id'],
                                value.user['first_name'],
                                value.user['last_name'],
                                value.user['control_user'],
                                value.user['gender'],
                                value.user['tel_num'],
                                value.user['known_from'],
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
                                  value.user!['id'],
                                  value.user['first_name'],
                                  value.user['last_name'],
                                  value.user['control_user'],
                                  value.user['gender'],
                                  value.user['tel_num'],
                                  value.user['known_from'],
                                  requestModel.email,
                                  requestModel.password
                                ]);
                          }
                        }
                        AwesomeDialog(
                          btnOkOnPress: () {},
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.success,
                          showCloseIcon: false,
                          title: value.message,
                          autoHide: Duration(seconds: 3),
                          onDismissCallback: (type) {
                            // debugPrint('Dialog Dissmiss from callback $type');
                            dispose();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage1(),
                              ),
                            );
                          },
                        ).show();
                      } else if (value.message == "Login unSuccessfully!") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          body: Text("Incorrect Email or Password"),
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                        // print(value.message);
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          body: Text("Incorrect Email or Password"),
                          desc: value.message,
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      }
                    });
                  }
                }
              },
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Don't have any account? ",
                  style: TextStyle(fontSize: 16.0, color: kTextLightColor),
                ),
                TextSpan(
                  text: 'Register',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    color: kPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
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

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget input(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            // controller: Email,
            onSaved: (input) => requestModel.email = input!,
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
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          //   height: 55,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            // controller: password,
            // initialValue: "list[0].password",
            onSaved: (input) => requestModel.password = input!,
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
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                // borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget Output(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            controller: Email,
            onSaved: (input) => requestModel.email = input!,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(
                Icons.email,
                color: kPrimaryColor,
              ),
            ),
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          //   height: 55,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            controller: Password,
            // initialValue: "list[0].password",
            onSaved: (input) => requestModel.password = input!,
            obscureText: _isObscure,
            decoration: InputDecoration(
              fillColor: kwhite,
              filled: true,
              labelText: 'Enter password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(
                Icons.key,
                color: kPrimaryColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  color: kPrimaryColor,
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
