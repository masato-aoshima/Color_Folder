import 'package:path/path.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  static final _folderTableName = "folders";
  static final _noteTableName = "notes";

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
      await db.execute("CREATE TABLE folders("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, "
          "priority INTEGER)");
      await db.execute("CREATE TABLE notes("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "text TEXT, "
          "priority INTEGER, "
          "folderId INTEGER, "
          "FOREIGN KEY(folderId) REFERENCES folders(id))");
    }, version: 1);
  }

  /**
   * フォルダーテーブル用　関数
   */

  /// フォルダーを一件追加
  Future insertFolder(Folder folder) async {
    final db = await database;
    // db.insert の戻り値として、最後に挿入された行のIDを返す (今回は受け取らない)
    await db.insert(_folderTableName, folder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// 全てのフォルダーを取得
  Future<List<Folder>> getAllFolders() async {
    final db = await database;
    final List<Map<String, dynamic>> folders =
        await db.query(_folderTableName, orderBy: "priority ASC");
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
    await db.update(_folderTableName, folder.toMap(),
        where: "id = ?", whereArgs: [folder.id]);
  }

  /// フォルダーを一件削除
  Future deleteFolder(String id) async {
    final db = await database;
    await db.delete(_folderTableName, where: "id = ?", whereArgs: [id]);
    await db.delete(_noteTableName,
        where: "folderId = ?", whereArgs: [id]); //TODO Database Inspector でデバッグ
  }

  /**
   * ノート テーブル用関数
   */

  /// ノートを一件追加
  Future insertNote(Note note) async {
    final db = await database;
    // db.insert の戻り値として、最後に挿入された行のIDを返す (今回は受け取らない)
    await db.insert(_noteTableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// そのフォルダ内の全てのノートを取得
  Future<List<Note>> getNotesInFolder(int folderId) async {
    final db = await database;
    final List<Map<String, dynamic>> notes = await db
        .query(_noteTableName, where: 'folderId = ?', whereArgs: [folderId]);
    return notes
        .map((note) => Note(
            id: note['id'],
            text: note['text'],
            priority: note['priority'],
            folderId: note['folderId']))
        .toList();
  }

  /// ノートを一件更新
  Future updateNote(Note note) async {
    final db = await database;
    await db.update(_noteTableName, note.toMap(),
        where: "id = ?", whereArgs: [note.id]);
  }

  /// ノートを一件削除
  Future deleteNote(String id) async {
    final db = await database;
    await db.delete(_noteTableName, where: "id = ?", whereArgs: [id]);
  }

  // ノートの所属するフォルダーを変更
  Future moveAnotherFolder(int noteId, int newFolderId) async {
    final db = await database;
    await db.rawUpdate(
        'UPDATE notes SET folderId = ? WHERE id = ?', [newFolderId, noteId]);
  }

  // フォルダーごとのノートの数を取得
  Future<Map<int, int>> getNotesCountByFolder() async {
    final db = await database;
    // テーブル全体
    final List<Map<String, dynamic>> notesCount = await db.rawQuery(
        'SELECT folderId, COUNT(*) from notes GROUP BY folderId order by folderId asc');
    Map<int, int> countMap = {};
    notesCount.forEach((count) {
      int folderId = count['folderId'];
      int notesCount = count['COUNT(*)'];
      countMap[folderId] = notesCount;
    });
    return countMap;
  }
}
