import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/models.dart';
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
        "CREATE TABLE folders(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, priority INTEGER)",
      );
    }, version: 1);
  }

  /// フォルダーを一件追加
  Future insertFolder(Folder folder) async {
    final db = await database;
    // db.insert の戻り値として、最後に挿入された行のIDを返す (今回は受け取らない)
    await db.insert(_tableName, folder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// 全てのフォルダーを取得
  Future<List<Folder>> getAllFolders() async {
    final db = await database;
    final List<Map<String, dynamic>> folders = await db.query(_tableName);
    return folders
        .map((folder) => Folder(
            id: folder['id'],
            title: folder['title'],
            priority: folder['priority']))
        .toList();
  }

  /// フォルダーを一件更新
  Future updateFolder(Folder folder) async {
    final db = await database;
    await db.update(_tableName, folder.toMap(),
        where: "id = ?", whereArgs: [folder.id]);
  }

  /// フォルダーを一件削除
  Future deleteFolder(String id) async {
    final db = await database;
    await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}
