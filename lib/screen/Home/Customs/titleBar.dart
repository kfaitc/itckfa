// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/KFA-Logo.png',
              height: 55,
              width: 55,
            ),
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('ONE CLICK  ',
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(color: Colors.white)),
                ],
                pause: const Duration(milliseconds: 300),
                isRepeatingAnimation: true,
                repeatForever: true,
                onTap: () {},
              ),
            ),
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    '1\$',
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      //color: Color.fromRGBO(169, 203, 56, 1),
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.yellow,
                          offset: Offset(1.5, 1.5),
                        ),
                      ],
                    ),
                  )
                ],
                pause: const Duration(milliseconds: 300),
                isRepeatingAnimation: true,
                repeatForever: true,
                onTap: () {},
              ),
            ),
            // Text(
            //   ' ONE CLICK  ',
            //   style: TextStyle(
            //     //color: Color.fromRGBO(169, 203, 56, 1),
            //     color: Colors.white,
            //     fontSize: 15,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   '1\$',
            //   style: TextStyle(
            //     //color: Color.fromRGBO(169, 203, 56, 1),
            //     color: Colors.yellow,
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     shadows: [
            //       Shadow(
            //         blurRadius: 5.0,
            //         color: Colors.yellow,
            //         offset: Offset(1.5, 1.5),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
