import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDBmap {
  late Database db;

  Future<void> createMainRaodT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBmap.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS mainRaod_Table( 
            name_road varchar(255) NOT NULL
          );
        ''');
      },
    );
  }

  Future<void> createRoadT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBroads.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS roads_Table(
            road_id int(11) NOT NULL, 
            road_name varchar(255) NOT NULL
          );
        ''');
      },
    );
  }

  Future<void> createlistRT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBlistR.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS listR_Table(
            Min_Value varchar(255) NOT NULL,
            Max_Value varchar(255) NOT NULL,
            Khan_ID int(11) NOT NULL, 
            Sangkat_ID int(11) NOT NULL
          );
        ''');
      },
    );
  }

  Future<void> createlistCT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBlistC.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS listC_Table(
            Min_Value varchar(255) NOT NULL,
            Max_Value varchar(255) NOT NULL,
            Khan_ID int(11) NOT NULL, 
            Sangkat_ID int(11) NOT NULL
          );
        ''');
      },
    );
  }

  Future<void> createKhanT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBKhan.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Khan_Table(
            Khan_ID int(11) NOT NULL, 
            province varchar(255) NOT NULL,
            Khan_Name varchar(255) NOT NULL
          );
        ''');
      },
    );
  }

  Future<void> createsangkatT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBsangkat.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS sangkat_Table(
            Sangkat_ID int(11) NOT NULL,
            Sangkat_Name varchar(255) NOT NULL 
          );
        ''');
      },
    );
  }

  Future<void> createoptionT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBoption.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS option_Table(
            opt_id int(11) NOT NULL,
            opt_des varchar(255) NOT NULL,
            opt_value int(11) NOT NULL
          );
        ''');
      },
    );
  }

  Future<void> createdropdownT() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MyDBdropdown.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS dropdown_Table(
            id int(11) NOT NULL,
            title varchar(255) NOT NULL,
            name varchar(255) NOT NULL,
            type varchar(255) NOT NULL
          );
        ''');
      },
    );
  }
}
