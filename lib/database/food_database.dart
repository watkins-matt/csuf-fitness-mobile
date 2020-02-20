import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class FoodDatabase {
  // DB info
  static final _databaseName = "food.db";
  static final _databaseVersion = 1;
  static final table_name = 'food';
  
  // DB columns
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnCalories = 'calorie';

  // Singleton ~~ only one instance
  FoodDatabase._privateConstructor();
  static final FoodDatabase instance = FoodDatabase._privateConstructor();

  // Database reference
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // initialize database if it is not created yet
    _database = await _initDatabase();
    return _database;
  }
  
  // Opens/Creates database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table_name
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table_name (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnCalories INTEGER NOT NULL
          )
          ''');
  }
}
