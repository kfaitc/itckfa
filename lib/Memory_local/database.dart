import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;
  Future open_user() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    //join is from path package
    // print(
    //     path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
                    CREATE TABLE IF NOT EXISTS user( 
                        id primary key,
                        first_name varchar(255)  not null,
                        last_name varchar(255)  not null,
                        username varchar(255)  not null,
                        gender varchar(255)  not null,
                        tel_num varchar(255)  not null,
                        known_from varchar(255)  not null,
                        email varchar(255)  not null,
                        password varchar(255)  not null
                      );
                  ''');
    },);
  }

  Future open_land_verbal() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS comverbal_land_models(
                                    
                                    verbal_landid varchar(255)  not null,
                                    verbal_land_dp varchar(255)  not null,
                                    verbal_land_type varchar(255)  not null,
                                    verbal_land_des varchar(255)  not null,
                                    verbal_land_area double  not null,
                                    verbal_land_minsqm double  not null,
                                    verbal_land_maxsqm double  not null,
                                    verbal_land_minvalue double  not null,
                                    verbal_land_maxvalue double  not null,
                                    address varchar(255)  not null,
                                    local_offline default 0
                                );
                  ''');
    },);
  }

  Future open_verbal() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo2.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS verbal_models(
                          id_v primary key,
                          verbal_id varchar(255)  not null,
                          verbal_khan varchar(255)  not null,
                          verbal_property_id varchar(100) not null,
                          verbal_bank_id varchar(255)  not null,
                          verbal_bank_branch_id varchar(255)  not null,
                          verbal_bank_contact varchar(200) DEFAULT NULL,
                          verbal_owner varchar(255)  not null,
                          verbal_contact varchar(255)  not null,
                          verbal_date text DEFAULT NULL,
                          verbal_bank_officer varchar(255)  not null,
                          verbal_address varchar(255)  not null,
                          verbal_approve_id varchar(255)  not null,
                          VerifyAgent varchar(255)  not null,
                          verbal_comment varchar(255)  not null,
                          latlong_log varchar(255)  not null,
                          latlong_la varchar(255)  not null,
                          verbal_image BLOB  DEFAULT null,
                          verbal_com varchar(255)  not null,
                          verbal_con varchar(255)  not null,
                          verbal_property_code varchar(255)  not null,
                          verbal_user varchar(255)  not null,
                          verbal_option varchar(255)  not null,
                          local_offline default 0
                      );
                  ''');
    },);
  }

  Future open_offline() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo3.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS verbal_models_offline(
                          id_v primary key,
                          verbal_id varchar(255)  DEFAULT null,
                          verbal_image BLOB  DEFAULT null
                      );
                  ''');
    },);
  }
}
