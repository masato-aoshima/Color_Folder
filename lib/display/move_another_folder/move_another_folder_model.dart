import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class MoveAnotherFolderModel extends ChangeNotifier {
  var _folders = List<Folder>();

  List<Folder> get folders => _folders;

  int noteId;
  int noteFolderId;

  void getFolders() async {
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners(); // liveDataみたいな使い方はどうやるの
  }

  Future upDateFolderId(int newFolderId) async {
    await DBProvider.db.moveAnotherFolder(noteId, newFolderId);
  }
}
