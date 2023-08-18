// ignore_for_file: prefer_const_constructors, camel_case_types, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Propert_khae.dart';

class ALl_Khae_cambodia extends StatefulWidget {
  const ALl_Khae_cambodia({super.key});

  @override
  State<ALl_Khae_cambodia> createState() => _ALl_Khae_cambodiaState();
}

class _ALl_Khae_cambodiaState extends State<ALl_Khae_cambodia> {
  final url_list = [
    'https://www.google.com/maps/place/Battambang+Province/@13.5378954,102.6313534,7z/data=!4m6!3m5!1s0x310539b6f12b360d:0xc252532b6e35e364!8m2!3d13.0286971!4d102.989615!16zL20vMDJoMjJ3',
    'https://www.google.com/maps/place/Banteay+Meanchey+Province/@13.105634,103.4749036,8z/data=!4m6!3m5!1s0x311ae57f609dc479:0x432d0df30974e37b!8m2!3d13.7531914!4d102.989615!16zL20vMDJoMjIy',
    'https://www.google.com/maps/place/Kampong+Chhnang+Province/@12.1727152,103.4150913,8z/data=!3m1!4b1!4m6!3m5!1s0x310e93304cbcc8a9:0x581bb573e69ae0f6!8m2!3d12.1392352!4d104.5655273!16zL20vMDJoMjNy',
    'https://www.google.com/maps/place/Kampong+Thom+Province/@12.4504823,104.9152681,8z/data=!4m6!3m5!1s0x310de21fe3d2c3ab:0x64bcff54ced9347c!8m2!3d12.8221829!4d105.1258955!16zL20vMDJoMjRt',
    ////////////////
    'https://www.google.com/maps/place/Kampot+Province/@10.6671174,104.4165539,9.25z/data=!4m6!3m5!1s0x310905ad816f8233:0xfcf397aabf9d3301!8m2!3d10.7325351!4d104.3791912!16zL20vMDJoMjVm',
    'https://www.google.com/maps/place/Kandal+Province/@11.3998479,105.0943213,9z/data=!4m6!3m5!1s0x310958eb100f7943:0xbfb1d20c8597be6!8m2!3d11.2237383!4d105.1258955!16zL20vMDJoMjV3',
    'https://www.google.com/maps/place/Kep+Province/@10.5250332,104.3302635,12.25z/data=!4m6!3m5!1s0x310836851a8b389f:0x1d6a42c22bd268ae!8m2!3d10.536089!4d104.3559158!16s%2Fm%2F0crfr1v',
    'https://www.google.com/maps/place/Krong+Kracheh/@12.474532,106.0659806,12z/data=!4m6!3m5!1s0x310d1a5a3f19ca7b:0xd41402b200a1cf79!8m2!3d12.4896877!4d106.0287512!16zL20vMGdnZHF4',
    // ///////
    'https://www.google.com/maps/place/Oddar+Meanchey+Province/@14.15902,102.6502684,8z/data=!3m1!4b1!4m6!3m5!1s0x311099b79d8c8ce1:0x391ceefc4120f30f!8m2!3d14.1609738!4d103.8216261!16zL20vMDJoMjhk',
    'https://www.google.com/maps/place/Phnom+Penh/@11.5024419,104.3101475,9.75z/data=!4m6!3m5!1s0x3109513dc76a6be3:0x9c010ee85ab525bb!8m2!3d11.5563738!4d104.9282099!16zL20vMGRsd2o',
    'https://www.google.com/maps/place/Preah+Vihear+Province/@13.7466906,104.0076636,8z/data=!3m1!4b1!4m6!3m5!1s0x31118018bbd8e741:0xbe2f77d8dba66407!8m2!3d14.0085797!4d104.8454619!16zL20vMDJoMmJ3',
    'https://www.google.com/maps/place/Prey+Veng+Province/@11.3662346,104.8960152,9z/data=!3m1!4b1!4m6!3m5!1s0x310b936cb013b065:0x3a05a414cdd1429b!8m2!3d11.3802442!4d105.5005483!16zL20vMDJoMmM5',
    //
    'https://www.google.com/maps/place/Ratanakiri+Province/@13.9322387,106.5183404,9z/data=!3m1!4b1!4m6!3m5!1s0x316ce51d2f4b1115:0x946ed78d4e2e97dd!8m2!3d13.8576607!4d107.1011931!16zL20vMDJoMmNy',
    'https://www.google.com/maps/place/Sihanoukville/@10.9207608,103.0694251,9z/data=!3m1!4b1!4m6!3m5!1s0x3107e1115d295281:0x699effa4268b5f59!8m2!3d10.7581899!4d103.8216261!16zL20vMDJoMmJk',
    'https://www.google.com/maps/place/Siem+Reap+Province/@13.344535,102.9153687,8z/data=!3m1!4b1!4m6!3m5!1s0x3110170b07d4a0f5:0x5ddbd370ce73acb9!8m2!3d13.330266!4d104.1001326!16zL20vMDRqNmNx',
    'https://www.google.com/maps/place/Steung+Treng+Province/@13.8538665,105.033657,8z/data=!3m1!4b1!4m6!3m5!1s0x31131f9015642519:0x8de13390ce08b88b!8m2!3d13.576473!4d105.9699878!16zL20vMDFjeWtw',
    //
    'https://www.google.com/maps/place/Krong+Svay+Rieng/@11.0909892,105.6737419,11z/data=!3m1!4b1!4m6!3m5!1s0x310b07bdd65bf709:0x7092f4d1ca161066!8m2!3d11.0877866!4d105.800951!16zL20vMGdnZmJj',
    'https://www.google.com/maps/place/Tak%C3%A9o+Province/@10.936957,104.1932356,9z/data=!3m1!4b1!4m6!3m5!1s0x31097ea70af3c445:0x73e3a94e2827c36a!8m2!3d10.9321519!4d104.798771!16zL20vMDJoMmRs',
    'https://www.google.com/maps/place/Tbong+Khmum+Province/@11.9505042,104.8152733,8z/data=!3m1!4b1!4m6!3m5!1s0x310c728a36aeb3ad:0x22401b5bf292b69f!8m2!3d11.8891023!4d105.876004!16s%2Fm%2F0_1n0kq',
    'https://www.google.com/maps/place/Pursat+Province/@12.4626177,102.9872074,9z/data=!3m1!4b1!4m6!3m5!1s0x310f7ecb64bac5f3:0x33613a63cd5a43cd!8m2!3d12.2720956!4d103.7289167!16zL20vMDJoMjh2',
    //////////////
    'https://www.google.com/maps/place/Pailin+Province/@12.8892644,102.3392265,10z/data=!3m1!4b1!4m6!3m5!1s0x3104d0174751c057:0x482f6ee3e8f23cde!8m2!3d12.9092962!4d102.6675575!16zL20vMDRqNnFy',
    'https://www.google.com/maps/place/Mondulkiri+Province/@12.7393087,106.4105646,9z/data=!4m6!3m5!1s0x316d648f58c68bcd:0x89b9120d08b3ff2a!8m2!3d12.7879427!4d107.1011931!16zL20vMDk2dnEx',
    'https://www.google.com/maps/place/Koh+Kong+Province/@11.4581761,102.8597714,9z/data=!3m1!4b1!4m6!3m5!1s0x3105f033a39282f3:0x37e95344b24a2873!8m2!3d11.5762804!4d103.3587288!16zL20vMDJoMjY5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 27, 35, 197),
        title: Text('List of Province'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 13,
        mainAxisSpacing: 15,
        crossAxisCount: 3,
        children: <Widget>[
          PartnersCard_khae(
            img: 'assets/images/25_commune/Battambang.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Battambang+Province/@13.5378954,102.6313534,7z/data=!4m6!3m5!1s0x310539b6f12b360d:0xc252532b6e35e364!8m2!3d13.0286971!4d102.989615!16zL20vMDJoMjJ3';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Bonteaymeanchey.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Banteay+Meanchey+Province/@13.105634,103.4749036,8z/data=!4m6!3m5!1s0x311ae57f609dc479:0x432d0df30974e37b!8m2!3d13.7531914!4d102.989615!16zL20vMDJoMjIy';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/KamponChnang.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Kampong+Chhnang+Province/@12.1727152,103.4150913,8z/data=!3m1!4b1!4m6!3m5!1s0x310e93304cbcc8a9:0x581bb573e69ae0f6!8m2!3d12.1392352!4d104.5655273!16zL20vMDJoMjNy';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/KampongThom.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Kampong+Thom+Province/@12.4504823,104.9152681,8z/data=!4m6!3m5!1s0x310de21fe3d2c3ab:0x64bcff54ced9347c!8m2!3d12.8221829!4d105.1258955!16zL20vMDJoMjRt';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/kampot.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Kampot+Province/@10.6671174,104.4165539,9.25z/data=!4m6!3m5!1s0x310905ad816f8233:0xfcf397aabf9d3301!8m2!3d10.7325351!4d104.3791912!16zL20vMDJoMjVm';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Kandal.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Kandal+Province/@11.3998479,105.0943213,9z/data=!4m6!3m5!1s0x310958eb100f7943:0xbfb1d20c8597be6!8m2!3d11.2237383!4d105.1258955!16zL20vMDJoMjV3';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Kep.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Kep+Province/@10.5250332,104.3302635,12.25z/data=!4m6!3m5!1s0x310836851a8b389f:0x1d6a42c22bd268ae!8m2!3d10.536089!4d104.3559158!16s%2Fm%2F0crfr1v';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Kracheh.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Krong+Kracheh/@12.474532,106.0659806,12z/data=!4m6!3m5!1s0x310d1a5a3f19ca7b:0xd41402b200a1cf79!8m2!3d12.4896877!4d106.0287512!16zL20vMGdnZHF4';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Oudormeanchey.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Oddar+Meanchey+Province/@14.15902,102.6502684,8z/data=!3m1!4b1!4m6!3m5!1s0x311099b79d8c8ce1:0x391ceefc4120f30f!8m2!3d14.1609738!4d103.8216261!16zL20vMDJoMjhk';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/PhnomPenh.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Phnom+Penh/@11.5024419,104.3101475,9.75z/data=!4m6!3m5!1s0x3109513dc76a6be3:0x9c010ee85ab525bb!8m2!3d11.5563738!4d104.9282099!16zL20vMGRsd2o';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Preah_Vihea.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Preah+Vihear+Province/@13.7466906,104.0076636,8z/data=!3m1!4b1!4m6!3m5!1s0x31118018bbd8e741:0xbe2f77d8dba66407!8m2!3d14.0085797!4d104.8454619!16zL20vMDJoMmJ3';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/PreyVeng.jpeg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Prey+Veng+Province/@11.3662346,104.8960152,9z/data=!3m1!4b1!4m6!3m5!1s0x310b936cb013b065:0x3a05a414cdd1429b!8m2!3d11.3802442!4d105.5005483!16zL20vMDJoMmM5';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Rathanakiri.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Ratanakiri+Province/@13.9322387,106.5183404,9z/data=!3m1!4b1!4m6!3m5!1s0x316ce51d2f4b1115:0x946ed78d4e2e97dd!8m2!3d13.8576607!4d107.1011931!16zL20vMDJoMmNy';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Siehanuk.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Sihanoukville/@10.9207608,103.0694251,9z/data=!3m1!4b1!4m6!3m5!1s0x3107e1115d295281:0x699effa4268b5f59!8m2!3d10.7581899!4d103.8216261!16zL20vMDJoMmJk';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Siemreab.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Siem+Reap+Province/@13.344535,102.9153687,8z/data=!3m1!4b1!4m6!3m5!1s0x3110170b07d4a0f5:0x5ddbd370ce73acb9!8m2!3d13.330266!4d104.1001326!16zL20vMDRqNmNx';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Steng_Treng.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Steung+Treng+Province/@13.8538665,105.033657,8z/data=!3m1!4b1!4m6!3m5!1s0x31131f9015642519:0x8de13390ce08b88b!8m2!3d13.576473!4d105.9699878!16zL20vMDFjeWtw';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/SvangRieng.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Krong+Svay+Rieng/@11.0909892,105.6737419,11z/data=!3m1!4b1!4m6!3m5!1s0x310b07bdd65bf709:0x7092f4d1ca161066!8m2!3d11.0877866!4d105.800951!16zL20vMGdnZmJj';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/takao.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Tak%C3%A9o+Province/@10.936957,104.1932356,9z/data=!3m1!4b1!4m6!3m5!1s0x31097ea70af3c445:0x73e3a94e2827c36a!8m2!3d10.9321519!4d104.798771!16zL20vMDJoMmRs';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/tbongKhmom.jpeg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Tbong+Khmum+Province/@11.9505042,104.8152733,8z/data=!3m1!4b1!4m6!3m5!1s0x310c728a36aeb3ad:0x22401b5bf292b69f!8m2!3d11.8891023!4d105.876004!16s%2Fm%2F0_1n0kq';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Pursat.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Pursat+Province/@12.4626177,102.9872074,9z/data=!3m1!4b1!4m6!3m5!1s0x310f7ecb64bac5f3:0x33613a63cd5a43cd!8m2!3d12.2720956!4d103.7289167!16zL20vMDJoMjh2';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Pailin.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Pailin+Province/@12.8892644,102.3392265,10z/data=!3m1!4b1!4m6!3m5!1s0x3104d0174751c057:0x482f6ee3e8f23cde!8m2!3d12.9092962!4d102.6675575!16zL20vMDRqNnFy';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/munduolmiri.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Mondulkiri+Province/@12.7393087,106.4105646,9z/data=!4m6!3m5!1s0x316d648f58c68bcd:0x89b9120d08b3ff2a!8m2!3d12.7879427!4d107.1011931!16zL20vMDk2dnEx';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          PartnersCard_khae(
            img: 'assets/images/25_commune/Kohkong.jpg',
            press: () async {
              const url =
                  'https://www.google.com/maps/place/Koh+Kong+Province/@11.4581761,102.8597714,9z/data=!3m1!4b1!4m6!3m5!1s0x3105f033a39282f3:0x37e95344b24a2873!8m2!3d11.5762804!4d103.3587288!16zL20vMDJoMjY5';
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
