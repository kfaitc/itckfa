// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PeopleController {
  late Repository _repository;
  PeopleController() {
    _repository = Repository();
  }

  Future<void> insertverbal(verbalModel peopleModel) {
    return _repository.insertverbal('tbverbal', peopleModel);
  }

  Future<List<verbalModel>> selectverbal() async {
    var response = await _repository.selectverbal('tbverbal') as List;
    List<verbalModel> verbalList = [];
    response.map((value) {
      return verbalList.add(verbalModel.fromJson(value));
    }).toList();
    return verbalList;
  }

  Future<void> deleteverbal(String verbalId) {
    debugPrint(verbalId);
    return _repository.deleteverbal('tbverbal', verbalId);
  }

  Future<void> updatePeople(verbalModel verbalModel) {
    return _repository.updateverbal(
      'tbverbal',
      verbalModel.toJson(),
      verbalModel.verbalId,
    );
  }
}

class verbalModel {
  final String verbalId;
  final String verbal_date;
  final String bank_name;
  final String bank_branch_name;
  final String property_type_name;
  final String verbal_address;
  final String verbal_owner;
  final String verbal_contact;
  final String username;
  final String tel_num;
  verbalModel({
    required this.verbalId,
    required this.verbal_date,
    required this.bank_name,
    required this.bank_branch_name,
    required this.property_type_name,
    required this.verbal_address,
    required this.verbal_owner,
    required this.verbal_contact,
    required this.username,
    required this.tel_num,
  });

  factory verbalModel.fromJson(Map<String, dynamic> json) => verbalModel(
        verbalId: json['verbalId'] as String,
        verbal_date: json['verbal_date'] as String,
        bank_name: json['bank_name'] as String,
        bank_branch_name: json['bank_branch_name'] as String,
        property_type_name: json['property_type_name'] as String,
        verbal_address: json['verbal_address'] as String,
        verbal_owner: json['verbal_owner'] as String,
        verbal_contact: json['verbal_contact'] as String,
        username: json['username'] as String,
        tel_num: json['tel_num'] as String,
      );
  Map<String, dynamic> toJson() {
    return {
      'verbalId': verbalId,
      'verbal_date': verbal_date,
      'bank_name': bank_name,
      'bank_branch_name': bank_branch_name,
      'property_type_name': property_type_name,
      'verbal_address': verbal_address,
      'verbal_owner': verbal_owner,
      'verbal_contact': verbal_contact,
      'username': username,
      'tel_num': tel_num,
    };
  }
}

class Repository {
  late ConnectionDb _connectionDb;
  Repository() {
    _connectionDb = ConnectionDb();
  }
  static Database? _database;
  Future<Database?> get database async {
    //------------- Restart Database -----------
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, 'kfa_project1');
    // // await deleteDatabase(path);
    // debugPrint('Here');
    //----------------------------------
    _database = await _connectionDb.setDatabase();
    if (_database != null) return _database;

    return _database;
  }

  insertverbal(table, verbalModel data) async {
    var _con = await database;
    return await _con!.rawInsert(
      'INSERT INTO tbverbal(verbalId,verbal_date,bank_name,bank_branch_name,property_type_name,verbal_address,verbal_owner,verbal_contact,username,tel_num) VALUES(?,?,?,?,?,?,?,?,?,?)',
      [
        data.verbalId,
        data.verbal_date,
        data.bank_name,
        data.bank_branch_name,
        data.property_type_name,
        data.verbal_address,
        data.verbal_owner,
        data.verbal_contact,
        data.username,
        data.tel_num,
      ],
    );
  }

  selectverbal(table) async {
    var _con = await database;
    return await _con!.query(table);
  }

  deleteverbal(table, id) async {
    var con = await database;

    return await con!.delete(table, where: "verbalId= ?", whereArgs: [id]);
  }

  updateverbal(table, data, id) async {
    var con = await database;
    return await con!
        .update(table, data, where: "verbalId= ?", whereArgs: [id]);
  }
}

class ConnectionDb {
  // Create a Database
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'kfa_project1');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return database;
  }

// Create a Table of database
  _onCreateDatabase(Database database, int version) async {
    await database.execute(
      'CREATE TABLE tbverbal(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, verbalId TEXT, verbal_date TEXT,bank_name TEXT,bank_branch_name TEXT,property_type_name TEXT,verbal_address TEXT,verbal_owner TEXT,verbal_contact TEXT,username TEXT,tel_num TEXT)',
    );
  }
}

class ShowPeoplePage1 extends StatefulWidget {
  const ShowPeoplePage1({Key? key}) : super(key: key);

  @override
  State<ShowPeoplePage1> createState() => _ShowPeoplePageState();
}

class _ShowPeoplePageState extends State<ShowPeoplePage1> {
  @override
  void initState() {
    super.initState();
    selectPeople();
  }

  List<verbalModel> list = [];
  bool status = false;
  var data = verbalModel(
      bank_branch_name: 'asd',
      bank_name: 'asd',
      property_type_name: 'df',
      tel_num: 'sdf',
      username: 'sdf',
      verbalId: 'sdf',
      verbal_address: 'sdf',
      verbal_contact: 'sdf',
      verbal_date: 'sdf',
      verbal_owner: 'sdf');
  selectPeople() async {
    await PeopleController().insertverbal(data);
    list = await PeopleController().selectverbal();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List People'),
      ),
      body: Visibility(
        visible: true,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = list[index];
            return Card(
              child: ListTile(
                onTap: () {
                  PeopleController().deleteverbal(data.verbalId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ShowPeoplePage1()),
                  );
                  debugPrint('People deleted');
                },
                leading: CircleAvatar(
                  child: InkWell(
                      onTap: () => PeopleController()
                          .deleteverbal(data.verbalId.toString()),
                      child: Text("delete")),
                ),
                title: Text(data.verbalId),
                subtitle: Text(data.verbalId),
                // trailing: Text(data.gender),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => CreatePeoplePage()),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
