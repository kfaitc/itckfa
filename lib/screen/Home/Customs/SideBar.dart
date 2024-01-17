// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itckfa/screen/Home/Customs/Drawer_menu.dart';
import 'package:itckfa/screen/Home/Customs/MyDrawerList.dart';
import 'package:itckfa/screen/Home/Customs/Test.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late final AnimationController _animationController;
  late final StreamController<bool> isSidebarOpenedStreamController;
  late final Stream<bool> isSidebarOpenedStream;
  late final StreamSink<bool> isSidebarOpenedSink;
  //final bool isSiderbarOpened = true;
  final _animationDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 35,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  //width: 50,
                  color: Colors.white,
                  child: Column(
                    children: [
                      MyHeaderDrawer(),
                      MyDrawerList(
                        icon: Icons.people,
                        title: 'Account',
                        Press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Test();
                            },),
                          );
                        },
                      ),
                      MyDrawerList(
                        icon: Icons.list,
                        title: 'Add Verbal',
                        Press: () {},
                      ),
                      MyDrawerList(
                        icon: Icons.villa,
                        title: 'Property',
                        Press: () {},
                      ),
                      MyDrawerList(
                        icon: Icons.wallet,
                        title: 'Wallet',
                        Press: () {},
                      ),
                      MyDrawerList(
                        icon: Icons.question_answer,
                        title: 'FAQ',
                        Press: () {},
                      ),
                      MyDrawerList(
                        icon: Icons.contact_phone,
                        title: 'Contact Us',
                        Press: () {},
                      ),
                      MyDrawerList(
                        icon: Icons.people,
                        title: 'About Us',
                        Press: () {},
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Divider(
                        color: Colors.blueAccent,
                      ),
                      MyDrawerList(
                        icon: Icons.lock,
                        title: 'Log Out',
                        Press: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.88),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final heigth = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, heigth / 2 - 20, width, heigth / 2);
    path.quadraticBezierTo(width + 1, heigth / 2 + 20, 10, heigth - 16);
    path.quadraticBezierTo(0, heigth - 8, 0, heigth);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
