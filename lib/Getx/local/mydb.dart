import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyLocalhost {
  late Database db;
  Future imageDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Image_DB.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
                    CREATE TABLE IF NOT EXISTS ImageDB( 
                        id int(11),
                        image Text
                      );
                  ''');
      },
    );
  }

  Future autoVerbalDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'AutoDB.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
                    CREATE TABLE IF NOT EXISTS verbal_models( 
                        protectID int(40),
                        titleNumber Text,
                        borey int(11),
                        road int(11),
                        verbal_property_id int(11),
                        verbal_bank_id int(11),
                        verbal_bank_branch_id int(11),
                        verbal_bank_contact Text,
                        verbal_owner Text,
                        verbal_contact Text,
                        verbal_bank_officer Text,
                        verbal_address Text,
                        verbal_approve_id int(11),
                        latlong_log double(11,9),
                        latlong_la double(11,9),
                        verbal_image Text,
                        verbalUser int(11),
                        verbal_option int(11)
                      );
                  ''');
      },
    );
  }

  Future landbuildingDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'LandbuildingDB.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
                    CREATE TABLE IF NOT EXISTS verbal_land_models( 
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
      },
    );
  }
}
