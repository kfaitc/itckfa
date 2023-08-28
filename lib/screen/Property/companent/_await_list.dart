// ignore_for_file: must_be_immutable, unused_element, unused_local_variable, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Await_list extends StatefulWidget {
  Await_list({
    super.key,
  });

  @override
  State<Await_list> createState() => _Await_valueState();
}

class _Await_valueState extends State<Await_list> {
  @override
  Widget build(BuildContext context) {
    return _reload();
  }

  Widget _reload() {
    var size5 = SizedBox(height: 5);
    var size10w = SizedBox(width: 1);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 151, 150, 150),
          highlightColor: Color.fromARGB(255, 221, 221, 219),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: double.infinity,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: container(0.02, 0.3),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 5),
                        child: container(0.02, 0.25),
                      ),
                      size5,
                      Divider(height: 1, color: Colors.grey),
                      size5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _Row(),
                          _Row(),
                          _Row(),
                          _Row(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          container(0.04, 0.1),
                          container(0.04, 0.1),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _Row() {
    var size2w = SizedBox(width: 2);
    return Row(
      children: [
        container(
          0.025,
          0.045,
        ),
        size2w,
        container(
          0.01,
          0.04,
        ),
      ],
    );
  }

  Widget container(double h, double w) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      height: MediaQuery.of(context).size.height * h,
      width: MediaQuery.of(context).size.height * w,
    );
  }
}
