// ignore_for_file: prefer_const_constructors, camel_case_types, deprecated_member_use, non_constant_identifier_names, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'List_Detail.dart';
import 'Propert_khae.dart';

class ALl_Khae_cambodia extends StatefulWidget {
  ALl_Khae_cambodia({
    super.key,
    required this.property_type_id,
  });
  String? property_type_id;

  @override
  State<ALl_Khae_cambodia> createState() => _ALl_Khae_cambodiaState();
}

class _ALl_Khae_cambodiaState extends State<ALl_Khae_cambodia> {
  String? property_type_id;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 221, 220, 220), body: body(),);
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),),),
            ),
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 20, 13, 113),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),),),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListTile(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),),
                    title: Center(
                      child: Text(
                        'Province',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02,),
                      ),
                    ),
                    trailing: Column(
                      children: [
                        Icon(
                          Icons.public,
                          color: Colors.white,
                        ),
                        Text(
                          'count',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.01,),
                        ),
                        Text(
                          '(25)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.01,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],),
          SizedBox(height: 10),
          girdview()
        ],
      ),
    );
  }

  Widget add() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(8),),
      ),
    );
  }

  final Fruitlist = [
    'Battambong',
    'Phnom Penh',
    'Bonteaymeanchey',
    'KamponChnang',

    // ///
    'KampongThom',
    'Kandal',
    'kam pot',
    'Kep',

    'Kracheh',
    'Oudormeanchey',
    'Preah Vihea',
    'Prey Veng',

    'Rathanakiri',
    'Siehanuk',
    'Siem Reab',
    'Steng Treng',

    'Svang Rieng',
    'Ta kao',
    'TbongKhmom',
    'Pur sat',

    // /////

    'Pai lin',
    'Mondolkiri',
    'Kohkong',
    'Kampong_Cham',
    'KampongChhnang',
    // //
    // 'Kratie',
  ];
  final imageList = [
    'assets/images/25_commune/Battambang.jpg',
    'assets/images/25_commune/PhnomPenh.jpg',

    'assets/images/25_commune/Bonteaymeanchey.jpg',
    'assets/images/25_commune/KamponChnang.jpg',
    'assets/images/25_commune/KampongThom.jpg',
    'assets/images/25_commune/Kandal.jpg',
    // // // ///
    'assets/images/25_commune/kampot.jpg',

    'assets/images/25_commune/Kep.jpg',
    'assets/images/25_commune/Kracheh.jpg',

    // ///
    'assets/images/25_commune/Oudormeanchey.jpg',

    'assets/images/25_commune/Preah_Vihea.jpg',
    'assets/images/25_commune/PreyVeng.jpeg',

    // // ///
    'assets/images/25_commune/Rathanakiri.jpg',
    'assets/images/25_commune/Siehanuk.jpg',
    'assets/images/25_commune/Siemreab.jpg',
    'assets/images/25_commune/Steng_Treng.jpg',

    // ///
    'assets/images/25_commune/SvangRieng.jpg',
    'assets/images/25_commune/takao.jpg',
    'assets/images/25_commune/tbongKhmom.jpeg',
    'assets/images/25_commune/Pursat.jpg',
    // // /////////
    'assets/images/25_commune/Pailin.jpg',
    'assets/images/25_commune/munduolmiri.jpg',
    // /////
    'assets/images/25_commune/Kohkong.jpg',
    'assets/images/25_commune/Kampong_Cham.jpg',
    'assets/images/25_commune/KampongChhnang.jpg',
  ];
  Widget girdview() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30),),),
      height: MediaQuery.of(context).size.height * 0.84,
      width: double.infinity,
      child: GridView.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return PartnersCard_khae(
            img: imageList[index],
            press: () async {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return List_detail(
                    index_P: index.toString(),
                    listget: [],
                    reloard: 'No',
                    add: 'add',
                    province_id: index.toString(),
                    type: '${Fruitlist[index].toString()}',
                  );
                },
              ),);
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
          childAspectRatio: 1,
        ),
      ),
    );
  }
}
