import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlertDialogScreen extends StatelessWidget {
  AlertDialogScreen(
      {super.key,
      required this.haveValue,
      required this.adding_price,
      required this.add_min,
      required this.add_max,
      required this.R_avg,
      required this.minSqm1,
      required this.maxSqm1,
      required this.C_avg,
      required this.minSqm2,
      required this.maxSqm2,
      required this.avg,
      required this.min,
      required this.max,
      required this.data_adding_correct,
      required this.commune,
      required this.district,
      required this.route});
  final bool haveValue;
  double fontsizes = 11;
  double heightModel = 50;
  final double add_min;
  final double add_max;
  final double adding_price;
  final double R_avg;
  final String minSqm1;
  final String maxSqm1;
  final double C_avg;
  final String minSqm2;
  final String maxSqm2;
  final double avg;
  final double min;
  final double max;
  final List data_adding_correct;
  final String commune;
  final String district;
  final String route;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  var colorbackground = const Color.fromARGB(255, 242, 242, 244);
  var colorstitle = const Color.fromARGB(255, 141, 140, 140);
  var colorsPrice = const Color.fromARGB(255, 241, 31, 23);
  double fontsize = 10;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
            image: AssetImage('assets/images/paper1.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 5, left: 5, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/papersib.png",
                    height: 30,
                    width: 30,
                    fit: BoxFit.fitHeight,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline_outlined,
                        color: Colors.black,
                      ))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (haveValue == true)
                    Card(
                      elevation: 10,
                      child: Container(
                        height: heightModel,
                        decoration: BoxDecoration(
                          color: colorbackground,
                          boxShadow: const [
                            BoxShadow(blurRadius: 1, color: Colors.grey)
                          ],
                          border: Border.all(width: 0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textb("Avg = "),
                                textPriceb(
                                    "${formatter.format(adding_price)}\$"),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    text("Min = "),
                                    textPrice(
                                        "${formatter.format(adding_price - (0.01 * adding_price))}\$"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    text("Max = "),
                                    textPrice(
                                        "${formatter.format(adding_price + (0.01 * adding_price))}\$"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Card(
                      elevation: 10,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 242, 244),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(2, 5),
                                color: Color.fromARGB(255, 0, 89, 255))
                          ],
                          border: Border.all(
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textb("Avg = "),
                                  textPriceb(
                                      "${formatter.format(adding_price)}\$")
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          text("Min = "),
                                          textPrice(
                                              "${formatter.format(adding_price - (0.01 * adding_price))}\$")
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          text("Min after - $add_min% = "),
                                          textPrice(
                                              "${formatter.format((adding_price - (0.01 * adding_price)) - ((add_min / 100) * (adding_price - (0.01 * adding_price))))}\$")
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          text("Max = "),
                                          textPrice(
                                              "${formatter.format(adding_price + (0.01 * adding_price))}\$")
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          text("Max after - $add_max% = "),
                                          textPrice(
                                              "${formatter.format((adding_price + (0.01 * adding_price)) - ((add_max / 100) * (adding_price + (0.01 * adding_price))))}\$")
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text("Residential",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontsizes)),
                      const SizedBox(height: 2),
                      Card(
                        elevation: 10,
                        child: Container(
                          height: heightModel,
                          decoration: BoxDecoration(
                            color: colorbackground,
                            boxShadow: const [
                              BoxShadow(blurRadius: 1, color: Colors.grey)
                            ],
                            border: Border.all(width: 0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textb("Avg = "),
                                  textPriceb("${formatter.format(R_avg)}\$")
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      text("Min = "),
                                      textPrice(
                                          "${formatter.format(double.parse(minSqm1))}\$")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      text("Max = "),
                                      textPrice(
                                          "${formatter.format(double.parse(maxSqm1))}\$")
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("Commercial",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontsizes)),
                      const SizedBox(height: 2),
                      Card(
                        elevation: 10,
                        child: Container(
                          height: heightModel,
                          decoration: BoxDecoration(
                            color: colorbackground,
                            boxShadow: const [
                              BoxShadow(blurRadius: 1, color: Colors.grey)
                            ],
                            border: Border.all(width: 0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textb("Avg = "),
                                  textPriceb("${formatter.format(C_avg)}\$")
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      text("Min = "),
                                      textPrice(
                                          "${formatter.format(double.parse(minSqm2))}\$")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      text("Max = "),
                                      textPrice(
                                          "${formatter.format(double.parse(maxSqm2))}\$")
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (haveValue == true)
                        Text("Calculator Compareble and Land_price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontsizes)),
                      if (haveValue == true) const SizedBox(height: 2),
                      if (haveValue == true)
                        Card(
                          elevation: 10,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: colorbackground,
                              border: Border.all(
                                width: 0.2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5,
                                    offset: Offset(2, 5),
                                    color: Color.fromARGB(255, 0, 89, 255))
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textb("Avg = "),
                                    textPriceb("${formatter.format(avg)}\$")
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            text("Min = "),
                                            textPrice(
                                                "${formatter.format(min)}\$")
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            textb("Min after - $add_min% = "),
                                            textPriceb(
                                                "${formatter.format(min! - ((add_min / 100) * min!))}\$")
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            text("Max = "),
                                            textPrice(
                                                "${formatter.format(max)}\$")
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            textb("Min after - $add_min% = "),
                                            textPriceb(
                                                "${formatter.format(max - ((add_max / 100) * max))}\$")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (haveValue == false)
                    if (data_adding_correct.length >= 5)
                      if (haveValue == false)
                        Text.rich(
                          TextSpan(
                            children: [
                              for (int i = 0;
                                  i < data_adding_correct.length;
                                  i++)
                                TextSpan(
                                    style: TextStyle(
                                      fontSize: fontsize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text:
                                        '${(i < data_adding_correct.length - 1) ? '${data_adding_correct[i]['comparable_adding_price']} + ' : data_adding_correct[i]['comparable_adding_price']}'),
                              TextSpan(
                                  text:
                                      ' / ${data_adding_correct.length} = ${formatter.format(adding_price)}\$',
                                  style: TextStyle(
                                      fontSize: fontsize,
                                      fontWeight: FontWeight.bold,
                                      color: colorsPrice)),
                            ],
                          ),
                        ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      Text(
                        "$commune /  $district / Route : ${route.toString()}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 9,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  if (haveValue == true)
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: fontsize,
                          fontWeight: FontWeight.bold,
                        ),
                        text:
                            '\n(${formatter.format(adding_price)}\$ + ${formatter.format(R_avg)}\$ + ${formatter.format(C_avg)}\$) /2 = ', // default text style
                        children: <TextSpan>[
                          TextSpan(
                              text: '${formatter.format(avg)}\$',
                              style: TextStyle(
                                  fontSize: fontsize,
                                  fontWeight: FontWeight.bold,
                                  color: colorsPrice)),
                        ],
                      ),
                    ),
                  const SizedBox(height: 5),
                  if (haveValue == true)
                    Card(
                      elevation: 10,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 242, 244),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(2, 5),
                                color: Color.fromARGB(255, 0, 89, 255))
                          ],
                          border: Border.all(
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < data_adding_correct.length;
                                      i++)
                                    Text(
                                        "${(i < data_adding_correct.length - 1) ? '${data_adding_correct[i]['comparable_adding_price']} + ' : data_adding_correct[i]['comparable_adding_price']}",
                                        style: TextStyle(
                                            fontSize: fontsize,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  textPriceb(" Avg /5 = "),
                                  textPriceb(
                                      "${formatter.format(adding_price)}\$"),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          textb("Min after - $add_min% = "),
                                          textPriceb(
                                              "${formatter.format(adding_price - (0.01 * adding_price) - ((adding_price - (0.01 * adding_price)) * add_min) / 100)}\$"),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          text("Min = "),
                                          textPrice(
                                              "${formatter.format(adding_price - (0.01 * adding_price))}\$"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          textb("Max after - $add_min% = "),
                                          textPrice(
                                              "${formatter.format(adding_price + (0.01 * adding_price) - ((adding_price + (0.01 * adding_price)) * add_min) / 100)}\$"),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          text("Max = "),
                                          textPrice(
                                              "${formatter.format(adding_price + (0.01 * adding_price))}\$"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textPriceb(txt) {
    return Text(txt,
        style: TextStyle(
          fontSize: fontsize,
          color: colorsPrice,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget textPrice(txt) {
    return Text(txt, style: TextStyle(fontSize: fontsize, color: colorsPrice));
  }

  Widget textb(txt) {
    return Text(txt,
        style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: colorstitle));
  }

  Widget text(txt) {
    return Text(txt, style: TextStyle(fontSize: fontsize, color: colorstitle));
  }
}
