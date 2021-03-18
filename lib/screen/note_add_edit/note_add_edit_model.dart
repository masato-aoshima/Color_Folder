import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class NoteAddEditModel extends ChangeNotifier {
  Note note;
  Folder folder;
  String inputText;

  bool isTextFieldFocus = false;

  void changeText(String text) {
    inputText = text;
  }

  void onFocusChange(bool focus) {
    isTextFieldFocus = focus;
    notifyListeners();
  }

  Future addNoteWhenOnPagePop(Note newNote) async {
    await DBProvider.db.insertNote(newNote);
    note = null;
    folder = null;
    inputText = null;
  }

  Future addNoteWhenOnPause(Note newNote) async {
    final newId = await DBProvider.db.insertNote(newNote);
    if (note.id == null) {
      note = Note(
          id: newId,
          text: note.text,
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
          folderId: note.folderId);
    }
  }

  Future deleteNote(int id) async {
    await DBProvider.db.deleteNote(id.toString());
  }

  Future upDateNote(Note note) async {
    await DBProvider.db.updateNote(note);
  }

  void onPagePop() async {
    final nowDateTime = DateTime.now().toString();
    // 新規追加
    if (note == null) {
      if (inputText == null || inputText.isEmpty) return;
      final newNote = Note(
          text: inputText,
          createdAt: nowDateTime,
          updatedAt: nowDateTime,
          folderId: folder.id);
      await addNoteWhenOnPagePop(newNote);
    }

    // 更新・削除
    if (note != null) {
      if (inputText.isNotEmpty) {
        // 更新
        if (note.text != inputText) {
          final newNote = Note(
              id: note.id,
              text: inputText,
              createdAt: note.createdAt,
              updatedAt: nowDateTime,
              folderId: folder.id);
          await upDateNote(newNote);
        }
      }
      if (inputText.isEmpty) {
        // 削除
        await deleteNote(note.id);
      }
    }
  }

  void onPause() async {
    final nowDateTime = DateTime.now().toString();
    // 新規追加
    if (note == null) {
      if (inputText == null || inputText.isEmpty) return;
      final newNote = Note(
          text: inputText,
          createdAt: nowDateTime,
          updatedAt: nowDateTime,
          folderId: folder.id);
      note = newNote;
      await addNoteWhenOnPause(newNote);
    }

    // 更新・削除
    if (note != null) {
      if (inputText.isNotEmpty) {
        // 更新
        if (note.text != inputText) {
          final newNote = Note(
              id: note.id,
              text: inputText,
              createdAt: note.createdAt,
              updatedAt: nowDateTime,
              folderId: folder.id);
          note = newNote;
          await upDateNote(newNote);
        }
      }
    }
  }
}
