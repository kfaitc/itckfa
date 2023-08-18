// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, import_of_legacy_library_into_null_safe, camel_case_types, unused_import, annotate_overrides, unnecessary_new, sized_box_for_whitespace

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itckfa/screen/Promotion/PromoDetail.dart';
import 'package:itckfa/screen/Promotion/Title.dart';
import 'package:transparent_image/transparent_image.dart';

class Promotion extends StatefulWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
  }
  // void initState() {
  //   super.initState();
  //   controller =
  //       //     AnimationController(duration: const Duration(seconds: 5), vsync: this);
  //       // animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
  //       // controller.repeat();

  //       controller = AnimationController(
  //           duration: const Duration(seconds: 5), vsync: this);
  //   animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
  //   controller.repeat();
  // }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          width: double.infinity,
          child: AnimatedBackground(
            behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
                spawnMaxRadius: 10,
                spawnMinSpeed: 10.00,
                particleCount: 50,
                spawnMaxSpeed: 50,
                minOpacity: 0.3,
                spawnOpacity: 0.4,
                baseColor: Colors.blue,
                // image: Image(image: AssetImage('assets/images/new_logo.png')),
              ),
            ),
            vsync: this,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Promo-pic.jpg')),
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),
        ),
        Container(
          height: 150,
          width: double.infinity,
          child: AnimatedBackground(
            behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
                spawnMaxRadius: 10,
                spawnMinSpeed: 10.00,
                particleCount: 50,
                spawnMaxSpeed: 50,
                minOpacity: 0.3,
                spawnOpacity: 0.4,
                baseColor: Colors.blue,
                // image: Image(image: AssetImage('assets/images/new_logo.png')),
              ),
            ),
            vsync: this,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Promo-pic.jpg')),
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),
        ),
        Container(
          height: 150,
          width: double.infinity,
          child: AnimatedBackground(
            behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
                spawnMaxRadius: 10,
                spawnMinSpeed: 10.00,
                particleCount: 50,
                spawnMaxSpeed: 50,
                minOpacity: 0.3,
                spawnOpacity: 0.4,
                baseColor: Colors.blue,
                // image: Image(image: AssetImage('assets/images/new_logo.png')),
              ),
            ),
            vsync: this,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Promo-pic.jpg')),
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Title_promo extends StatelessWidget {
  const Title_promo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            'Promotions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              //color: Colors.blue,
              color: Colors.black,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PromoDetail();
                }),
              );
            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Show all',
                  style: TextStyle(
                      fontSize: 14,
                      height: 1,
                      color: Color.fromARGB(255, 12, 119, 206)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Color.fromARGB(255, 30, 7, 241),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
