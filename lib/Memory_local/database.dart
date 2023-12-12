import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;
  Future open() async {
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
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS verbal_models(
                          id primary key,
                          verbal_id  varchar(255)  DEFAULT NULL,
                          verbal_property_id  varchar(255)  DEFAULT NULL,
                          verbal_property_code varchar(100) DEFAULT NULL,
                          verbal_bank_id  varchar(255)  DEFAULT NULL,
                          verbal_bank_branch_id int(10)  DEFAULT NULL,
                          verbal_bank_contact varchar(200) DEFAULT NULL,
                          verbal_owner varchar(255) DEFAULT NULL,
                          verbal_contact varchar(191) DEFAULT NULL,
                          verbal_date TEXT DEFAULT NULL,
                          verbal_bank_officer varchar(255) DEFAULT NULL,
                          verbal_address varchar(255) DEFAULT NULL,
                          verbal_province_id  varchar(255)  DEFAULT NULL,
                          verbal_district_id  varchar(255)  DEFAULT NULL,
                          verbal_commune_id  varchar(255)  DEFAULT NULL,
                          verbal_approve_id  varchar(255)  DEFAULT NULL,
                          verbal_approves_id  varchar(255)  DEFAULT NULL,
                          verbal_comment varchar(255) DEFAULT NULL,
                          verbal_image BLOB DEFAULT NULL,
                          latlong_log double  DEFAULT NULL,
                          latlong_la double  DEFAULT NULL,
                          verbal_com varchar(50) DEFAULT NULL,
                          verbal_con int(10)  DEFAULT NULL,
                          verbal_option int(10)  DEFAULT NULL,
                          verbal_status_id  varchar(255) DEFAULT 1,
                          verbal_published int(1)  DEFAULT NULL,
                          verbal_user int(100)  DEFAULT NULL,
                          verbal_comp int(10)  DEFAULT NULL,
                          VerifyAgent int(10)  DEFAULT NULL,
                          verbal_created_by  varchar(255)  DEFAULT NULL,
                          verbal_created_date TEXT DEFAULT NULL,
                          verbal_modify_by  varchar(255)  DEFAULT NULL,
                          verbal_khan varchar(255) DEFAULT NULL
                      );

                  ''');
    });
  }

  // Future<Map<dynamic, dynamic>?> getStudent(int rollno) async {
  //   List<Map> maps =
  //       await db.query('students', where: 'roll_no = ?', whereArgs: [rollno]);
  //   //getting student data with roll no.
  //   if (maps.length > 0) {
  //     return maps.first;
  //   }
  //   return null;
  // }
}
