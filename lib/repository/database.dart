import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  static final _tableName = "folders";

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  Future<Database> initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'sort_note_database.db'),
        onCreate: (db, version) async {
      return db.execute(
        "CREATE TABLE folders(id INTEGER PRIMARY KEY, title TEXT, priority INTEGER)",
      );
    });
  }

  void insertFolder() async {
    final db = await database;
  }
}
