import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class MoveAnotherFolderModel extends ChangeNotifier {
  var _folders = List<Folder>();
  List<Folder> get folders => _folders;

  var _noteCounts = Map<int, int>();
  Map<int, int> get noteCounts => _noteCounts;

  int noteId;
  String noteText;

  Future getFolders() async {
    _folders = await DBProvider.db.getAllFolders();
    return _folders;
  }

  Future onTapFolder(int newFolderId) async {
    // ノート一覧からの遷移
    if (noteText == null) {
      await DBProvider.db.moveAnotherFolder(noteId, newFolderId);
    }

    // ノート追加編集ページからの遷移
    if (noteText != null) {
      // 新規追加
      if (noteId == null) {
        final newNote =
            Note(id: null, text: noteText, priority: 0, folderId: newFolderId);
        await DBProvider.db.insertNote(newNote);
      } else {
        // 編集
        final newNote = Note(
            id: noteId, text: noteText, priority: 0, folderId: newFolderId);
        await DBProvider.db.updateNote(newNote);
      }
    }
  }

  Future<Map<int, int>> getNotesCount() async {
    _noteCounts = await DBProvider.db.getNotesCountByFolder();
    return _noteCounts;
  }
}
