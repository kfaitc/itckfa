// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required int id, required String code})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 1000,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          PartnersCard(
            img: 'assets/images/Partners/APD-Bank-1-1.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/ABA_Logo.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/BIC-bank.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Caltex.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Maritime.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/PPCB-bank.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/abc.jfif',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Angkor-capital-bank.jfif',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Cam-Commercial.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/CAMPU_BANK.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/campu-lonpac.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/cash-u-up.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Chevron-logo.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/chief-bank.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Chip-Mong-Bank.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/cimb-bank-logo.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/compu.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/first-bank.jfif',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/FTB-bank.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/J-Trust-Royal-Bank.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/mia-finacial.jfif',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Ow-bank.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/PPCB-bank.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/RHB-bank.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/sathapana.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/sbi_lh_logo.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/TBB.jfif',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/union-bank.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/vattanac-bank.png',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/Worldbridge-Homes.jpg',
            press: () {},
          ),
          PartnersCard(
            img: 'assets/images/Partners/WorldBridge.jfif',
            press: () {},
          ),
          SizedBox(
            height: 500,
          ),
        ],
      ),
    );
  }
}

class PartnersCard extends StatelessWidget {
  final String img;
  final press;
  const PartnersCard({
    Key? key,
    required this.img,
    // required this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
        ),
        height: 130,
        child: InkWell(
          onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              img,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
