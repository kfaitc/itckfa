// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, camel_case_types

import 'package:flutter/material.dart';

List<String> list = <String>[
  'Banteay Meanchey',
  'Siem reap',
  'Phnom penh',
  'Takae'
];

class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _Home_TypeState();
}

class _Home_TypeState extends State<Price> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 20, 163),
        centerTitle: true,
        title: Text(
          "Price",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Price Range',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Min',
                  hintText: 'Min',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Min';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Do something with the value
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Max',
                  hintText: 'Max',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Max';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Do something with the value
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 17, 99, 165),
                      borderRadius: BorderRadius.circular(10)),
                  height: 40,
                  width: 120,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
