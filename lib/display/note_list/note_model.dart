import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class NoteModel extends ChangeNotifier {
  var _notes = List<Note>();

  List<Note> get notes => _notes;

  void getNotes(int folderId) async {
    _notes = await DBProvider.db.getNotesInFolder(folderId);
    notifyListeners();
  }

  void addNote(Note note) async {
    await DBProvider.db.insertNote(note);
    _notes = await DBProvider.db.getNotesInFolder(note.folderId);
    notifyListeners();
  }

  void deleteNote(int id, int folderId) async {
    await DBProvider.db.deleteNote(id.toString());
    _notes = await DBProvider.db.getNotesInFolder(folderId);
    notifyListeners();
  }

  void upDateNote(Note note) async {
    await DBProvider.db.updateNote(note);
    _notes = await DBProvider.db.getNotesInFolder(note.folderId);
    notifyListeners();
  }
}
