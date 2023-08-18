// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:itckfa/afa/components/contants.dart';

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
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                ),
                QuestionList(
                  question: 'What is going on?',
                  answer:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
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
