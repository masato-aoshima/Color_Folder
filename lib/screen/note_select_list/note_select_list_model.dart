import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

class NoteSelectListModel extends ChangeNotifier {
  var _notes = List<Note>();

  List<Note> get notes => _notes;

  Set<int> checkedNoteIds = Set<int>();

  Future getNotes(int folderId) async {
    if (_notes.length == 0) {
      _notes = await DBProvider.db.getNotesInFolder(folderId);
    }
    return _notes;
  }

  Future getNotesNotify(int folderId) async {
    _notes = await DBProvider.db.getNotesInFolder(folderId);
    notifyListeners();
  }

  Future deleteNote(int id, int folderId) async {
    await DBProvider.db.deleteNote(id.toString());
    _notes = await DBProvider.db.getNotesInFolder(folderId);
    notifyListeners();
  }

  void onItemCheck(int noteId, bool isCheck) {
    if (isCheck) {
      checkedNoteIds.add(noteId);
    } else {
      checkedNoteIds.remove(noteId);
    }
    notifyListeners();
  }

  void clear() {
    _notes = List<Note>();
    checkedNoteIds.clear();
  }
}
