import '../sleep_log.dart';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SleepDatabase {
  // DB info
  static final _databaseName = "sl33p.db";
  static final _databaseVersion = 1;
  static final tableName = "sl33p";

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
		await db.execute('''
			CREATE TABLE $tableName (
				$columnId INTEGER PRIMAY KEY,
				$columnStartTime INTEGER NOT NULL,
				$columnEndTime INTEGER NOT NULL
			);
		''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(SleepEvent sleep) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      columnStartTime: '${sleep.start.millisecondsSinceEpoch}',
      columnEndTime: '${sleep.end.millisecondsSinceEpoch}'
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
          'id: ${row["$columnId"]}, start time: ${row["$columnStartTime"]}, end time: ${row["$columnEndTime"]}');
      });
  }

  Future<void> printRow(var row) async {
    print(
          'id: ${row["$columnId"]}, start time: ${row["$columnStartTime"]}, end time: ${row["$columnEndTime"]}');
  }

  Future<List<SleepEvent>> queryBetweenDates(
      DateTime leftDate, DateTime rightDate) async {
    Database db = await instance.database;
    leftDate = leftDate.normalize();
    rightDate = rightDate.normalize();
    var leftEpoch = leftDate.millisecondsSinceEpoch;
    var rightEpoch = rightDate.millisecondsSinceEpoch;
    var rows = await db.rawQuery(
        'SELECT * FROM $tableName WHERE $columnStartTime BETWEEN $leftEpoch AND $rightEpoch');
    List<SleepEvent> items = new List<SleepEvent>();
    print('PRINTING FROM $leftDate to $rightDate');
    rows.forEach((row) {
      items.add(SleepEvent(row[columnStartTime], row[columnEndTime]));
    });
    return items;
  }

  Future<void> queryDate(DateTime date) async {
    return queryBetweenDates(date, date);
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

}

