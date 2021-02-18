import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class MoveAnotherFolderModel extends ChangeNotifier {
  Note note;
  List<Note> noteList;

  var _folders = List<Folder>();
  List<Folder> get folders => _folders;

  var _noteCounts = Map<int, int>();
  Map<int, int> get noteCounts => _noteCounts;

  Future getFolders() async {
    _folders = await DBProvider.db.getAllFolders();
    return _folders;
  }

  Future onTapFolder(int newFolderId) async {
    final nowDateTime = DateTime.now().toString();
    // ノート一覧からの遷移
    if (note.text == null) {
      await DBProvider.db.moveAnotherFolder(note.id, newFolderId);
    }

    // ノート追加編集ページからの遷移
    if (note.text != null) {
      // 新規追加
      if (note.id == null) {
        final newNote = Note(
            id: null,
            text: note.text,
            createdAt: nowDateTime,
            updatedAt: nowDateTime,
            folderId: newFolderId);
        await DBProvider.db.insertNote(newNote);
      } else {
        // 編集
        final newNote = Note(
            id: note.id,
            text: note.text,
            createdAt: note.createdAt,
            updatedAt: nowDateTime,
            folderId: newFolderId);
        await DBProvider.db.updateNote(newNote);
      }
    }
  }

  Future onTapFolderMultiNote(int newFolderId) async {
    await DBProvider.db.moveAnotherFolderMulti(
        noteList.map((note) => note.id).toList(), newFolderId);
  }

  Future<Map<int, int>> getNotesCount() async {
    _noteCounts = await DBProvider.db.getNotesCountByFolder();
    return _noteCounts;
  }
}
