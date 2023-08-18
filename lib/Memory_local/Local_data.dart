// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PeopleController {
  late Repository _repository;
  PeopleController() {
    _repository = Repository();
  }

  Future<void> insertPeople(PeopleModel peopleModel) {
    return _repository.insertPeople('tbPeople', peopleModel);
  }

  Future<List<PeopleModel>> selectPeople() async {
    var response = await _repository.selectPeople('tbPeople') as List;
    List<PeopleModel> peopleList = [];
    response.map((value) {
      return peopleList.add(PeopleModel.fromJson(value));
    }).toList();
    return peopleList;
  }

  Future<void> deletePeople(int peopleId) {
    return _repository.deletePeople('tbPeople', peopleId);
  }

  Future<void> updatePeople(PeopleModel peopleModel) {
    return _repository.updatePeople(
      'tbPeople',
      peopleModel.toJson(),
      peopleModel.id,
    );
  }
}

class PeopleModel {
  final int id;
  final String name;
  final String password;

  PeopleModel({
    required this.id,
    required this.name,
    required this.password,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) => PeopleModel(
        id: json['id'] as int,
        name: json['name'] as String,
        password: json['password'] as String,
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
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
    // String path = join(documentsDirectory.path, 'db_name');
    // await deleteDatabase(path);
    // debugPrint('Here');
    //----------------------------------

    if (_database != null) return _database;
    _database = await _connectionDb.setDatabase();
    return _database;
  }

  insertPeople(table, PeopleModel data) async {
    var _con = await database;
    return await _con!.rawInsert(
      'INSERT INTO tbPeople(name,password) VALUES(?,?)',
      [data.name, data.password],
    );
  }

  selectPeople(table) async {
    var _con = await database;
    return await _con!.query(table);
  }

  deletePeople(table, id) async {
    var con = await database;
    return await con!.delete(table, where: "id = ?", whereArgs: [id]);
  }

  updatePeople(table, data, id) async {
    var con = await database;
    return await con!.update(table, data, where: "id= ?", whereArgs: [id]);
  }
}

class ConnectionDb {
  // Create a Database
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'kfa_project');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return database;
  }

// Create a Table of database
  _onCreateDatabase(Database database, int version) async {
    await database.execute(
      'CREATE TABLE tbPeople(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, password TEXT)',
    );
  }
}

class ShowPeoplePage extends StatefulWidget {
  const ShowPeoplePage({Key? key}) : super(key: key);

  @override
  State<ShowPeoplePage> createState() => _ShowPeoplePageState();
}

class _ShowPeoplePageState extends State<ShowPeoplePage> {
  @override
  void initState() {
    super.initState();
    selectPeople();
  }

  List<PeopleModel> list = [];
  bool status = false;

  selectPeople() async {
    list = await PeopleController().selectPeople();
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
                  PeopleController().deletePeople(data.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ShowPeoplePage()),
                  );
                  debugPrint('People deleted');
                },
                leading: CircleAvatar(
                  child: Text(data.id.toString()),
                ),
                title: Text(data.name),
                subtitle: Text(data.password),
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
