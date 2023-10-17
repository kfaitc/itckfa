import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itckfa/Memory_local/database.dart';

class AddStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddStudent();
  }
}

class _AddStudent extends State<AddStudent> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Student"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Stuent Name",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              TextField(
                controller: address,
                decoration: InputDecoration(
                  hintText: "Address:",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  mydb.db.rawInsert(
                      "INSERT INTO user (first_name, last_name, username, gender, tel_num, known_from, email, password) VALUES (?, ?, ?, ?, ?, ?, ? , ?);",
                      [name.text, rollno.text, address.text]);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("New Student Added")));

                  name.text = "";
                  rollno.text = "";
                  address.text = "";
                },
                child: Text("Save Student Data"),
              ),
              ElevatedButton(
                onPressed: () {
                  mydb.db.rawInsert(
                      "INSERT INTO class (name, roll_no, address) VALUES (?, ?, ?);",
                      [name.text, rollno.text, address.text]);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("New class Added")));

                  name.text = "";
                  rollno.text = "";
                  address.text = "";
                },
                child: Text("Save Class Data"),
              ),
            ],
          ),
        ));
  }
}
