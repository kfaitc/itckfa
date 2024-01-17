// ignore_for_file: override_on_non_overriding_member, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Detail_Screen/Detail_all_list_Screen.dart';

class GridView_More extends StatefulWidget {
  GridView_More({super.key, required this.list});
  List list;
  @override
  State<GridView_More> createState() => _gridviewState();
}

class _gridviewState extends State<GridView_More> {
  @override
  var color_texts = const Color.fromARGB(255, 0, 0, 0);
  var color_text = const Color.fromARGB(255, 83, 83, 83);
  @override
  Widget build(BuildContext context) {
    return gridview(widget.list);
  }

  Widget gridview(List list) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.235,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              final item = list[index];

              return InkWell(
                onTap: () {
                  setState(() {
                    verbal_ID = list[index]['id_ptys'].toString();
                  });
                  detail_property_sale(index, list);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.3),
                      color: const Color.fromARGB(255, 251, 250, 249),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                // bottomLeft: Radius.circular(20.0),
                                // bottomRight: Radius.circular(20.0),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: item['url'] ?? "N/A",
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress,),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.186,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    (item['price'] != null)
                                        ? Text(
                                            'Price : ${item['price'] ?? "N/A"}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color_text,
                                                fontSize: 10,),
                                          )
                                        : const Text('N/A'),
                                    const Text(
                                      '\$',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 48, 92, 5),
                                          fontSize: 10,),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    (item['land'] != null)
                                        ? Text(
                                            'Land : ${item['land'] ?? "N/A"} sqm',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color_text,
                                                fontSize: 10,),
                                          )
                                        : const Text('N/A'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                              // Text(obj_controller_value['price']
                              //     .toString()),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    (item['bed'] != null)
                                        ? Text(
                                            'bed : ${item['bed'].toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color_text,
                                                fontSize: 10,),
                                          )
                                        : const Text('N/A'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    (item['bed'] != null)
                                        ? Text(
                                            'bath : ${item['bath'] ?? "N/A"}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color_text,
                                                fontSize: 10,),
                                          )
                                        : const Text('N/A'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            left: MediaQuery.of(context).size.width * 0.01,
                            top: MediaQuery.of(context).size.height * 0.15,
                            child: Container(
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //     color: Color.fromARGB(255, 106, 7, 86),
                                //     borderRadius: BorderRadius.circular(5)),
                                height: 25,
                                width: 50,
                                child: item['urgent'] != null
                                    ? Text(
                                        '${item['urgent'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: color_texts,
                                        ),
                                      )
                                    : const Text(''),),),
                        Positioned(
                            left: MediaQuery.of(context).size.width * 0.25,
                            top: MediaQuery.of(context).size.height * 0.15,
                            right: 1,
                            child: Container(
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //     color: Color.fromARGB(255, 8, 48, 170),
                                //     borderRadius: BorderRadius.circular(5)),
                                height: 25,
                                width: 80,
                                child: item['Name_cummune'] != null
                                    ? Text(
                                        '${item['Name_cummune'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: color_texts,
                                        ),
                                      )
                                    : const Text(''),),),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.02,
                          top: MediaQuery.of(context).size.height * 0.02,
                          child: Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 74, 108, 6),
                                borderRadius: BorderRadius.circular(10),),
                            child: Text(
                              '${item['type'] ?? ""}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 185, 182, 182),
                                  fontSize: 10,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),),
    );
  }

  String? verbal_ID;
  Future<void> detail_property_sale(index, widgetList) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail_property_sale_all(
          verbal_ID: verbal_ID.toString(),
          list_get_sale: widgetList,
        ),
      ),
    );
  }
}
