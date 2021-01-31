import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class NoteAddEditModel extends ChangeNotifier {
  int noteId;
  String inputText;
  int folderId;

  void changeText(String text) {
    inputText = text;
  }

  Future addNote(Note note) async {
    await DBProvider.db.insertNote(note);
  }

  Future deleteNote(int id) async {
    await DBProvider.db.deleteNote(id.toString());
  }

  Future upDateNote(Note note) async {
    await DBProvider.db.updateNote(note);
  }

  void onPagePop() async {
    // 新規追加
    if (noteId == null) {
      if (inputText.isEmpty) return;
      final newNote = Note(text: inputText, folderId: folderId);
      await addNote(newNote);
    }

    // 更新・削除
    if (noteId != null) {
      if (inputText.isNotEmpty) {
        // 更新
        final newNote = Note(id: noteId, text: inputText, folderId: folderId);
        await upDateNote(newNote);
      }
      if (inputText.isEmpty) {
        // 削除
        await deleteNote(noteId);
      }
    }
  }
}
