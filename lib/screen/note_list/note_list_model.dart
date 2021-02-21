import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class NoteListModel extends ChangeNotifier {
  var _notes = List<Note>();

  List<Note> get notes => _notes;

  String dateDisplaySetting = 'UPDATE_DATE';

  Future getNotes(int folderId) async {
    _notes = await DBProvider.db.getNotesInFolder(folderId);
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
}
