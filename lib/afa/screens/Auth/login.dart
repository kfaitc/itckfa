// ignore_for_file: unused_import, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_is_empty

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/getwidget.dart';
import 'package:itckfa/Memory_local/Local_data.dart';
import 'package:itckfa/afa/screens/Auth/register.dart';
import 'package:itckfa/api/api_service.dart';
import 'package:itckfa/models/login_model.dart';
import 'package:itckfa/screen/Customs/ProgressHUD.dart';
import 'package:itckfa/screen/Home/Home.dart';
import 'package:http/http.dart' as http;

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

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  late int id = 0;
  late String username = "";
  late String first_name = "";
  late String last_name = "";
  late String email = "";
  late String gender = "";
  late String from = "";
  late String tel = "";
  static List<PeopleModel> list = [];
  static bool status = false;
  PeopleModel? peopleModel;
  late TextEditingController Email;
  late TextEditingController Password;
  selectPeople() async {
    list = await PeopleController().selectPeople();
    if (list.isEmpty) {
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        int i = list.length - 1;
        status = true;
        Email = TextEditingController(text: list[i].name);
        Password = TextEditingController(text: list[i].password);
      });
    }
  }

  late AnimationController controller;
  late Animation<double> animation;
  late PageController _pageController;
  late List<Widget> slideList;
  late int initialPage;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    selectPeople();
    status;
    list;
    super.initState();
    requestModel = LoginRequestModel(email: "", password: "");
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
  }

  bool welcome = false;
  bool check_elcome = false;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 20), () async {
      setState(() {
        welcome = true;
      });
    });
    Future.delayed(const Duration(seconds: 1), () async {
      setState(() {
        check_elcome = true;
      });
    });
    if (check_elcome) {
      return ProgressHUD(
          color: kPrimaryColor,
          inAsyncCall: isApiCallProcess,
          opacity: 0.5,
          // child: (status || welcome)
          //     ?
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
                  // topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(100.0),
                  // bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
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
          )
          // : Scaffold(
          //     backgroundColor: Color.fromARGB(255, 142, 41, 155),
          //     body: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Container(
          //           width: MediaQuery.of(context).size.width,
          //           height: MediaQuery.of(context).size.height * 0.8,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(20),
          //                 topRight: Radius.circular(20)),
          //             image: DecorationImage(
          //                 image: AssetImage('assets/images/first.gif'),
          //                 fit: BoxFit.fill),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               welcome = true;
          //             });
          //           },
          //           child: Container(
          //             height: 45,
          //             decoration: BoxDecoration(
          //               color: Color.fromARGB(255, 41, 72, 163),
          //               boxShadow: const [
          //                 BoxShadow(
          //                     blurRadius: 10,
          //                     offset: Offset(0.0, -0.9),
          //                     color: Colors.white)
          //               ],
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 GFAnimation(
          //                     turnsAnimation: animation,
          //                     controller: controller,
          //                     type: GFAnimationType.rotateTransition,
          //                     alignment: Alignment.center,
          //                     child: Row(
          //                       children: const [
          //                         Icon(
          //                           Icons.shape_line_outlined,
          //                           color: Colors.white,
          //                           shadows: [
          //                             Shadow(
          //                                 blurRadius: 10,
          //                                 offset: Offset(0.0, -0.9),
          //                                 color: Colors.white)
          //                           ],
          //                         )
          //                       ],
          //                     )),
          //                 SizedBox(width: 10),
          //                 GFAnimation(
          //                     turnsAnimation: animation,
          //                     controller: controller,
          //                     type: GFAnimationType.rotateTransition,
          //                     alignment: Alignment.center,
          //                     child: Row(
          //                       children: const [
          //                         Icon(
          //                           Icons.shape_line_outlined,
          //                           color: Colors.white,
          //                           shadows: [
          //                             Shadow(
          //                                 blurRadius: 10,
          //                                 offset: Offset(0.0, -0.9),
          //                                 color: Colors.white)
          //                           ],
          //                         )
          //                       ],
          //                     )),
          //                 SizedBox(width: 10),
          //                 Text(
          //                   "Continue...",
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.w600),
          //                 ),
          //                 SizedBox(width: 10),
          //                 GFAnimation(
          //                     turnsAnimation: animation,
          //                     controller: controller,
          //                     type: GFAnimationType.rotateTransition,
          //                     alignment: Alignment.center,
          //                     child: Row(
          //                       children: const [
          //                         Icon(
          //                           Icons.shape_line_outlined,
          //                           color: Colors.white,
          //                           shadows: [
          //                             Shadow(
          //                                 blurRadius: 10,
          //                                 offset: Offset(0.0, -0.9),
          //                                 color: Colors.white)
          //                           ],
          //                         )
          //                       ],
          //                     )),
          //                 SizedBox(width: 10),
          //                 GFAnimation(
          //                     turnsAnimation: animation,
          //                     controller: controller,
          //                     type: GFAnimationType.rotateTransition,
          //                     alignment: Alignment.center,
          //                     child: Row(
          //                       children: const [
          //                         Icon(
          //                           Icons.shape_line_outlined,
          //                           color: Colors.white,
          //                           shadows: [
          //                             Shadow(
          //                                 blurRadius: 10,
          //                                 offset: Offset(0.0, -0.9),
          //                                 color: Colors.white)
          //                           ],
          //                         )
          //                       ],
          //                     )),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          // ),
          );
    } else {
      return SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
      ));
    }
  }

  Widget login(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 25.0,
          ),
          // const Text.rich(
          //   TextSpan(
          //     // ignore: prefer_const_literals_to_create_immutables
          //     children: [
          //       TextSpan(
          //         text: "ONE CLICK ",
          //         style: TextStyle(
          //           fontSize: 22.0,
          //           fontWeight: FontWeight.bold,
          //           color: kImageColor,
          //         ),
          //       ),
          //       TextSpan(
          //         text: "1\$",
          //         style: TextStyle(
          //           fontSize: 40.0,
          //           fontWeight: FontWeight.bold,
          //           color: kerror,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

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
              pressEvent: () {
                if (validateAndSave()) {
                  setState(() {
                    // final player = AudioPlayer();
                    // player.play(AssetSource('nor.mp3'));
                    isApiCallProcess = true;
                  });
                  APIservice apIservice = APIservice();
                  apIservice.login(requestModel).then((value) {
                    Load(value.token);
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (value.message == "Login Successfully!") {
                      var people = PeopleModel(
                        id: 0,
                        name: requestModel.email,
                        password: requestModel.password,
                      );
                      PeopleController().insertPeople(people);
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage1(
                                  log: 0,
                                  lat: 0,
                                  user: username,
                                  email: email,
                                  first_name: first_name,
                                  last_name: last_name,
                                  gender: gender,
                                  from: from,
                                  tel: tel,
                                  id: id.toString(),
                                ),
                              ));
                        },
                      ).show();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Error',
                        desc: value.message,
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.red,
                      ).show();
                      print(value.message);
                    }
                  });
                  print(requestModel.toJson());
                }
              },
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),

          Text.rich(TextSpan(children: [
            TextSpan(
              text: "Don't have any account? ",
              style: TextStyle(fontSize: 16.0, color: kTextLightColor),
            ),
            TextSpan(
              text: 'Register',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 16,
                  color: kPrimaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
            ),
          ])),
        ],
      ),
    );
  }

  void Load(String token) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user'),
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
      });
      print(id.toString());
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
              // enabledBorder: OutlineInputBorder(
              //     // borderSide: BorderSide(
              //     //   width: 1,
              //     //   color: Color.fromARGB(255, 255, 255, 255),
              //     // ),
              //     borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(40),
              //         bottomRight: Radius.circular(40))),
              // errorBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     width: 1,
              //     color: Color.fromARGB(255, 249, 0, 0),
              //   ),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     width: 1,
              //     color: Color.fromARGB(255, 249, 0, 0),
              //   ),
              //   //  borderRadius: BorderRadius.circular(10.0),
              // ),
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
              // errorBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     width: 1,
              //     color: kerror,
              //   ),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     width: 2,
              //     color: kerror,
              //   ),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     width: 1,
              //     color: kPrimaryColor,
              //   ),
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(40),
              //       topRight: Radius.circular(40)),
              // ),
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
