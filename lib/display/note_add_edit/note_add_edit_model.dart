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

  void deleteNote(int id, int folderId) async {
    await DBProvider.db.deleteNote(id.toString());
  }

  void upDateNote(Note note) async {
    await DBProvider.db.updateNote(note);
  }

  void onPagePop() async {
    // 新規追加
    if (noteId == null) {
      if (inputText.isEmpty) return;
      final newNote = Note(text: inputText, folderId: folderId);
      await addNote(newNote);
    }
  }
}
