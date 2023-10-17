import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;
  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    //join is from path package
    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

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

                    CREATE TABLE IF NOT EXISTS verbal( 
                          id primary key,
                          verbal_id int(50)  not null,
                          verbal_property_id int(11) default null,
                          verbal_property_code varchar(100) default null,
                          verbal_bank_id int(11) default null,
                          verbal_bank_branch_id int(10) default null,
                          verbal_bank_contact varchar(200) default null,
                          verbal_owner varchar(500) default null,
                          verbal_contact varchar(191) default null,
                          verbal_date varchar(191) default null,
                          verbal_bank_officer varchar(500) default null,
                          verbal_address varchar(500) default null,
                          verbal_province_id int(11) default null,
                          verbal_district_id int(11) default null,
                          verbal_commune_id int(11) default null,
                          verbal_approve_id int(11) default null,
                          verbal_approves_id int(11) default null,
                          verbal_comment varchar(500) default null,
                          verbal_image text  default null,
                          latlong_log double(11,7) default null,
                          latlong_la double(11,7) default null,
                          verbal_com varchar(50) default null,
                          verbal_con int(10) default null,
                          verbal_option int(10) default null,
                          verbal_status_id int(11) DEFAULT '1',
                          verbal_published tinyint(1) DEFAULT '0',
                          verbal_user int(100) default null,
                          verbal_comp int(10) DEFAULT '0',
                          VerifyAgent int(10) default null,
                          verbal_created_by int(11) default null,
                          verbal_created_date timestamp null DEFAULT CURRENT_TIMESTAMP,
                          verbal_modify_by int(11) default null
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
