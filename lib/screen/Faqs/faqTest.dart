// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../afa/components/contants.dart';

class Faqs2 extends StatefulWidget {
  const Faqs2({Key? key}) : super(key: key);

  @override
  State<Faqs2> createState() => _Faqs2State();
}

class _Faqs2State extends State<Faqs2> {
  final List<Item> _data = generateItems(20);

  Widget _buildListQuestion() {
    return ExpansionPanelList(
      dividerColor: Colors.blue,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue),
              );
            },
            body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('Useful Answer'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  //_data.removeWhere((curretItem) => item == curretItem);
                  //_data.add((curretItem) => item == curretItem);
                });
              },
            ),
            isExpanded: item.isExpanded);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite_new,
      appBar: AppBar(
        backgroundColor: kwhite_new,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        title: Text(
          'FAQ',
          style: TextStyle(
            //color: Color.fromRGBO(169, 203, 56, 1),
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/notification.svg"),
            onPressed: () {},
          )
        ],
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: _buildListQuestion(),
        ),
      ),
    );
  }
}

class Item {
  late String expandedValue;
  late String headerValue;
  late bool isExpanded;

  Item(
      {required this.expandedValue,
      required this.headerValue,
      this.isExpanded = false});
}

List<Item> generateItems(int numberOfItem) {
  return List.generate(numberOfItem, (index) {
    return Item(
        headerValue: 'Question $index',
        expandedValue: 'This is question number $index');
  });
}
