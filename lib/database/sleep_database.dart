import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SleepDatabase {
  // DB info
  static final _databaseName = "dbsleep.db";
  static final _databaseVersion = 1;
  static final tableName = "sleep";

  // DB colums
  static final columnId = '_id';
  static final columnStartTime = 'start_time';
  static final columnEndTime = 'end_time';

  // beginning with an '_' means private constructor
  SleepDatabase._privateConstructor();

  // Singleton ~~ only one instance
  static final SleepDatabase instance = SleepDatabase._privateConstructor();

  // Database reference
  static Database _database;

  // get database function
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // initialize database helper function for opening and creating database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // helper function to create SQL table
  Future _onCreate(Database db, int version) async {
    /*
		await db.execute('''
			CREATE TABLE $tableName (
				$columnId INTEGER PRIMAY KEY
				$columnStartTime INTEGER NOT NULL,
				$columnEndTime INTEGER NOT NULL,
			)
		''');
		*/
  }
}
