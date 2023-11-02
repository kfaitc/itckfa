import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:itckfa/Memory_local/save_data_verbal_local.dart';
import 'package:itckfa/afa/components/contants.dart';

class data_verbal_saved extends StatefulWidget {
  const data_verbal_saved({super.key});

  @override
  State<data_verbal_saved> createState() => _data_verbal_savedState();
}

class _data_verbal_savedState extends State<data_verbal_saved> {
  List<verbalModel> list = [];
  bool? status;
  selectPeople() async {
    list = await PeopleController().selectverbal();
    // print(list);
    if (list.isEmpty) {
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  void initState() {
    selectPeople();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite_new,
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        title: const Text("Your Saved"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left_outlined,
              size: 40,
            )),
      ),
      body: Visibility(
        visible: status ?? false,
        replacement: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height * 1,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return Stack(
                children: [
                  Container(
                    height: 140,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 212, 212, 212),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Verbal ID\t\t:\t\t',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          10,
                                  shadows: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 16, 22, 192),
                                        blurRadius: 3,
                                        offset: Offset(-0.2, -1))
                                  ]),
                            ),
                            Text(
                              " ${list[i].verbalId}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          9,
                                  shadows: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 16, 22, 192),
                                        blurRadius: 3,
                                        offset: Offset(-0.2, -1))
                                  ]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Bank\t\t\t:\t\t',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          10,
                                  shadows: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 16, 22, 192),
                                        blurRadius: 3,
                                        offset: Offset(-0.2, -1))
                                  ]),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                " ${list[i].bank_name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            9,
                                    overflow: TextOverflow.ellipsis,
                                    shadows: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 16, 22, 192),
                                          blurRadius: 3,
                                          offset: Offset(-0.2, -1))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Branch\t\t\t:\t\t',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          10,
                                  shadows: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 16, 22, 192),
                                        blurRadius: 3,
                                        offset: Offset(-0.2, -1))
                                  ]),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                " ${list[i].bank_branch_name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            9,
                                    overflow: TextOverflow.ellipsis,
                                    shadows: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 16, 22, 192),
                                          blurRadius: 3,
                                          offset: Offset(-0.2, -1))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Property Type\t\t\t:\t\t',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          10,
                                  shadows: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 16, 22, 192),
                                        blurRadius: 3,
                                        offset: Offset(-0.2, -1))
                                  ]),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                " ${list[i].property_type_name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            9,
                                    overflow: TextOverflow.ellipsis,
                                    shadows: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 16, 22, 192),
                                          blurRadius: 3,
                                          offset: Offset(-0.2, -1))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Date :\t\t\t:\t\t',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          10,
                                  shadows: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 16, 22, 192),
                                        blurRadius: 3,
                                        offset: Offset(-0.2, -1))
                                  ]),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                " ${list[i].verbal_date}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            9,
                                    overflow: TextOverflow.ellipsis,
                                    shadows: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 16, 22, 192),
                                          blurRadius: 3,
                                          offset: Offset(-0.2, -1))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 1,
                    top: -1,
                    child: GFButton(
                      onPressed: () async {
                        setState(() {
                          list;

                          list;
                        });

                        await PeopleController().deleteverbal(list[i].verbalId);

                        final snackBar = SnackBar(
                          content: const Text('Deleted !'),
                          action: SnackBarAction(
                            label: 'Replese',
                            onPressed: () {
                              setState(() {
                                list;

                                list;
                              });
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      text: "\tDelete\t",
                      size: GFSize.MEDIUM,
                      color: Colors.red,
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 20,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(1, 0.5))
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
