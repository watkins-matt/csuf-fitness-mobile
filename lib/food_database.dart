import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'food_item.dart';

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

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(FoodItem food) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
        columnName: '$food.name',
        columnCalories: '$food.calories'
    };
    print('inserted row : id: $columnId , food: $columnName, calories: $columnCalories');
    return await db.insert(table_name, row);
  }

  // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table_name);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table_name'));
  }

  // We are assuming here that the id column in the map is set. The other 
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table_name, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is 
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table_name, where: '$columnId = ?', whereArgs: [id]);
  }
}
