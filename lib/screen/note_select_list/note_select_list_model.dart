import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

class NoteSelectListModel extends ChangeNotifier {
  var isInitializeComplete = false;
  var _notes = List<Note>();

  List<Note> get notes => _notes;

  Set<int> checkedNoteIds = Set<int>();

  Future getNotes(int folderId) async {
    if (isInitializeComplete) {
      return;
    }
    isInitializeComplete = true;
    if (_notes.length == 0) {
      _notes = await DBProvider.db.getNotesInFolder(folderId);
    }
    notifyListeners();
  }

  Future getNotesNotify() async {
    final folderId = notes.first.folderId;
    _notes = await DBProvider.db.getNotesInFolder(folderId);
    notifyListeners();
  }

  Future deleteNote(int id, int folderId) async {
    await DBProvider.db.deleteNote(id.toString());
    _notes = await DBProvider.db.getNotesInFolder(folderId);
    notifyListeners();
  }

  void onItemCheck(int noteId, bool isChecked) {
    if (isChecked) {
      checkedNoteIds.add(noteId);
    } else {
      checkedNoteIds.remove(noteId);
    }
    notifyListeners();
  }

  List<Note> getCheckedNoteList() {
    List<Note> noteList = List<Note>();
    checkedNoteIds.forEach((noteId) {
      final note = notes.firstWhere((note) => note.id == noteId);
      noteList.add(note);
    });
    checkedNoteIds.clear();
    return noteList;
  }

  void clear() {
    _notes = List<Note>();
    checkedNoteIds.clear();
    isInitializeComplete = false;
  }
}
