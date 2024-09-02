// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:itckfa/Option/components/contants.dart';

import 'package:getwidget/getwidget.dart';

class FapsSidebar extends StatefulWidget {
  const FapsSidebar({Key? key}) : super(key: key);

  @override
  State<FapsSidebar> createState() => _FapsSidebarState();
}

class _FapsSidebarState extends State<FapsSidebar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite_new,
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'FAQ',
          style: TextStyle(
            //color: Color.fromRGBO(169, 203, 56, 1),
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                //color: kBackgroundColor,
                //borderRadius: BorderRadius.all(Radius.circular(25)),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(25),
                //   topRight: Radius.circular(25),
                // ),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // QuestionList(),

                QuestionList(
                  question: 'What is One Click One Dollar?',
                  answer:
                      'One ckick one dollar is an mobile app of KFA company that allows client can search markit price of real estate in Cambodia.',
                ),
                QuestionList(
                  question: 'How to add property?',
                  answer:
                      'Go to home page click on feature property and click on button Add Property after that you can add property.',
                ),
                QuestionList(
                  question: 'How to check Verbal list?',
                  answer:
                      'Go to home page click on Verbal list feature then there are two button for searching verbal list. The first one is for searhing with map and the second one is for searching with list.',
                ),
                QuestionList(
                  question: 'How to add verbal?',
                  answer:
                      '1. Go to Home page click on Cross Check feature then click on add auto verbal after that complete data and click button submit',
                ),
                QuestionList(
                  question: 'How to search property?',
                  answer:
                      'Go to home page click on Property feature fill property you want to search in button search at ther top of app.',
                ),
                QuestionList(
                  question: 'How to View property in Map?',
                  answer:
                      'Go to home page click on Property feature and click Property Search Google map button then set date you want to search.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionList extends StatelessWidget {
  final String question;
  final String answer;
  const QuestionList({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      expandedTitleBackgroundColor: kImageColor,
      // titleBorder: Border.all(
      //   color: Colors.blue,
      //   width: 1,
      //   style: BorderStyle.solid,
      // ),
      contentBorder: Border.all(
        color: Colors.blue,
        width: 1,
        style: BorderStyle.solid,
      ),
      titleBorderRadius: BorderRadius.all(Radius.circular(10)),
      contentBorderRadius: BorderRadius.all(Radius.circular(10)),
      title: question,
      content: answer,
    );
  }
}
