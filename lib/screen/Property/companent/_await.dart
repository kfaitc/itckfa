// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Await_value extends StatefulWidget {
  Await_value({super.key, this.type, this.hometype, this.more});
  String? type;
  String? hometype;
  String? more;
  @override
  State<Await_value> createState() => _Await_valueState();
}

class _Await_valueState extends State<Await_value> {
  @override
  Widget build(BuildContext context) {
    return _reload();
  }

  Widget _reload() {
    return Column(
      children: [
        (widget.type == 'Yes')
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.03,
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 151, 150, 150),
                  highlightColor: const Color.fromARGB(255, 221, 221, 219),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.025,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.025,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: (widget.hometype == 'Hometype')
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height * 0.55,
          child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 151, 150, 150),
              highlightColor: const Color.fromARGB(255, 221, 221, 219),
              child: GridView.builder(
                itemCount: (widget.more == '2') ? 2 : 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.186,
                        child: Container(
                          color: const Color.fromARGB(255, 8, 103, 13),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              const Color.fromARGB(255, 73, 72, 69),),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              const Color.fromARGB(255, 73, 72, 69),),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          left: MediaQuery.of(context).size.width * 0.01,
                          top: MediaQuery.of(context).size.height * 0.15,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 106, 7, 86),
                                borderRadius: BorderRadius.circular(5),),
                            height: 25,
                            width: 50,
                          ),),
                      Positioned(
                          left: MediaQuery.of(context).size.width * 0.25,
                          top: MediaQuery.of(context).size.height * 0.15,
                          right: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 8, 48, 170),
                                borderRadius: BorderRadius.circular(5),),
                            height: 25,
                            width: 80,
                          ),),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.02,
                        top: MediaQuery.of(context).size.height * 0.02,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 109, 160, 6),
                              borderRadius: BorderRadius.circular(10),),
                          child: const Text(
                            'For Rent',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 250, 246, 245),
                                fontSize: 12,),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),),
        ),
      ],
    );
  }
}
