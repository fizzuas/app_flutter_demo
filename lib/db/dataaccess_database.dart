import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'data_access.dart';

class DataAccessDatabase {
  static const TABLE = "DataAccess";

  DataAccessDatabase._();

  factory DataAccessDatabase() => _getInstance();

  static DataAccessDatabase _instance;

  static DataAccessDatabase get instance => _getInstance();

  static DataAccessDatabase _getInstance() {
    if (_instance == null) {
      _instance = new DataAccessDatabase._();
    }
    return _instance;
  }

  static Database _database;

  createDatabase() async {
    final defaultPath = await getDatabasesPath();
    final path = join(defaultPath, "data_access.db");
    final exist = await databaseExists(path);
    if (!exist) {
      Directory directory = Directory(defaultPath);
      if (!directory.existsSync()) {
        print("没有创建好路径！有错！");
        await directory.create();
      }
      _database = await openDatabase(path, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $TABLE(id INTEGER PRIMARY KEY,sn TEXT,dataAccessCode TEXT)",
        );
      }, version: 1);
    } else {
      _database = await openDatabase(path);
    }
  }

  Future<int> insertValidMachine(DataAccess dataAccess) async {
    if (_database == null) {
      await createDatabase();
    }
    return await _database.insert(
      TABLE,
      dataAccess.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DataAccess>> queryValidMachine(String sn) async {
    if (_database == null) {
      await createDatabase();
    }
    List<Map> maps = await _database.query(
      TABLE,
      where: "sn = ?",
      whereArgs: [sn],
    );
    if (maps == null || maps.length == 0) {
      return null;
    }
    return List.generate(maps.length, (index) {
      return DataAccess.fromJson(maps[index]);
    });
  }

  Future<int> deleteMachine(String sn) async {
    if (_database == null) {
      await createDatabase();
    }
    return await _database.delete(TABLE, where: "sn =? ", whereArgs: [sn]);
  }



}
