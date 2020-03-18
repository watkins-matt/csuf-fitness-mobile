import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../food_log_item.dart';

class FoodDatabase {
  // DB info
  static final _databaseName = "dbfood.db";
  static final _databaseVersion = 1;
  static final tableName = 'food';

  // DB columns
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnCalories = 'calorie';
  static final columnTime = 'time';

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
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table_name
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnCalories INTEGER NOT NULL,
            $columnTime INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(FoodLogItem food) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      columnName: '${food.name}',
      columnCalories: '${food.calories}',
      columnTime: '${food.time.millisecondsSinceEpoch}'
    };
    return await db.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<void> printAllRows() async {
    Database db = await instance.database;
    var table = await db.query(tableName);
    table.forEach((row) {
      print(
          'id: ${row["$columnId"]}, name: ${row["$columnName"]}, calories: ${row["$columnCalories"]}, time: ${row["$columnTime"]}');
    });
  }

  Future<void> printRow(var row) async {
    print(
        'id: ${row["$columnId"]}, name: ${row["$columnName"]}, calories: ${row["$columnCalories"]}, time: ${row["$columnTime"]}');
  }

  Future<List<FoodLogItem>> queryBetweenDates(
      DateTime leftDate, DateTime rightDate) async {
    Database db = await instance.database;
	leftDate = leftDate.subtract(Duration(hours:leftDate.hour, minutes:leftDate.minute, seconds:leftDate.second, milliseconds:leftDate.millisecond));
	rightDate = rightDate.add(Duration(hours:23-rightDate.hour, minutes:59-rightDate.minute, seconds:59-rightDate.second, milliseconds:999-rightDate.millisecond));

	print(leftDate);
	print(rightDate);
    var leftEpoch = leftDate.millisecondsSinceEpoch;
    var rightEpoch = rightDate.millisecondsSinceEpoch;
    var rows = await db.rawQuery(
        'SELECT * FROM $tableName WHERE $columnTime BETWEEN $leftEpoch AND $rightEpoch');
    List<FoodLogItem> items = new List<FoodLogItem>();
    print('PRINTING FROM $leftDate to $rightDate');
    rows.forEach((row) {
      items.add(FoodLogItem(row[columnName], row[columnCalories],
          DateTime.fromMillisecondsSinceEpoch(row[columnTime])));
      print(
          'id: ${row["$columnId"]}, name: ${row["$columnName"]}, calories: ${row["$columnCalories"]}, time: ${row["$columnTime"]}');
    });
    return items;
  }

  Future<void> queryDate(DateTime date) async {
    // TODO
  }

  Future<void> deleteAllRows() async {
    Database db = await instance.database;
    var table = await db.query(tableName);
    table.forEach((row) {
      delete(row['_id']);
    });
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteByTimestamp(DateTime dateTime) async {
    Database db = await instance.database;
    return await db.delete(tableName,
        where: '$columnTime = ?', whereArgs: [dateTime.millisecondsSinceEpoch]);
  }
}
