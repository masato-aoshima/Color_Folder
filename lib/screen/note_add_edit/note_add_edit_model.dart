import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class NoteAddEditModel extends ChangeNotifier {
  Note note;
  Folder folder;
  String inputText;

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
    if (note == null) {
      if (inputText == null || inputText.isEmpty) return;
      final newNote = Note(text: inputText, folderId: folder.id);
      await addNote(newNote);
    }

    // 更新・削除
    if (note != null) {
      if (inputText.isNotEmpty) {
        // 更新
        final newNote = Note(id: note.id, text: inputText, folderId: folder.id);
        await upDateNote(newNote);
      }
      if (inputText.isEmpty) {
        // 削除
        await deleteNote(note.id);
      }
    }
  }
}
