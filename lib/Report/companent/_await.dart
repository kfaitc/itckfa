// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Await_Transtion extends StatefulWidget {
  Await_Transtion({super.key, this.type, this.hometype, this.more});
  String? type;
  String? hometype;
  String? more;
  @override
  State<Await_Transtion> createState() => _Await_valueState();
}

class _Await_valueState extends State<Await_Transtion> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: _reload());
  }

  Widget _reload() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 180, 177, 177),
            highlightColor: const Color.fromARGB(255, 221, 221, 219),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              // color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _contaner(0.03, 0.15),
                  _contaner(0.03, 0.15),
                  _contaner(0.03, 0.15),
                  _contaner(0.03, 0.15),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 180, 177, 177),
                highlightColor: const Color.fromARGB(255, 221, 221, 219),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 176, 174, 174),
                              border: Border.all(width: 1),
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          const Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    );
                  },
                ),),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            width: double.infinity,
            // color: Colors.grey,
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 180, 177, 177),
              highlightColor: const Color.fromARGB(255, 221, 221, 219),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _contaner(0.03, 0.1),
                  _contaner(0.03, 0.1),
                  _contaner(0.03, 0.25),
                  const Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contaner(double h, double w) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * h,
        width: MediaQuery.of(context).size.width * w,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5),),
      ),
    );
  }
}
