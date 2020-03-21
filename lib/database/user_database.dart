import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../sleep_log.dart';

class UserDatabase {
	// DB info
	static final _databaseName = "dbuser.db";
	static final _databaseVersion = 1;
	static final tableName = "user";
	
	// DB colums
	static final columnId = '_id';
	static final columnUsername = 'username';
	static final columnAge = 'age';
	static final columnHeight = 'height';
	static final columnWeight = 'height';
	static final columnBMI = 'bmi';
	static final columnTimestamp = 'timestamp';

	// beginning with an '_' means private constructor
	UserDatabase._privateConstructor();

	// Singleton ~~ only one instance
	static final UserDatabase instance = UserDatabase._privateConstructor();

	// Database reference
	static Database _database;

	// get database function
	Future<Databse> get database async {
		if (_database != null) return _database;
		_database = await _initDatabase();
		return _database;
	}

	// initialize database helper function for opening and creating database
	_initDatabase() async {
		Directory documentsDirectory = await getApplicationDocumentsDirectory();
		String path = join (documentsDirectory.path, _databaseName);
		return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
	}

	// helper function to create SQL table
	Future _onCreate(Database db, int version) async {
		// TODO
		
		/*
		await db.execute('''
			CREATE TABLE $tableName (
				$columnId INTEGER PRIMAY KEY
				$columnUsername TEXT NOT NULL,
				$columnAge INTEGER NOT NULL,
				$columnHeight REAL NOT NULL,
				$columnWeight REAL NOT NULL,
				$columnBMI REAL NOT NULL,
				$columnTimestamp INTEGER NOT NULL,
			)
		''');
		*/

	}

}
