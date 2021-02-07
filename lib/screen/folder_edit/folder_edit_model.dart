import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class FolderEditModel extends ChangeNotifier {
  var _folders = List<Folder>();

  List<Folder> get folders => _folders;

  var _noteCounts = Map<int, int>();

  Map<int, int> get noteCounts => _noteCounts;

  Future getFolders() async {
    if (_folders.length == 0) {
      _folders = await DBProvider.db.getAllFolders();
    }
    notifyListeners();
  }

  void clearFolder() {
    _folders = List<Folder>();
  }

  void addFolders(Folder folder) async {
    await DBProvider.db.insertFolder(folder);
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners();
  }

  void deleteFolder(int id, int priority) async {
    await DBProvider.db.deleteFolder(id.toString(), priority);
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners();
  }

  void upDateFolderName(Folder folder) async {
    await DBProvider.db.updateFolder(folder);
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners();
  }

  Future<Map<int, int>> getNotesCount() async {
    _noteCounts = await DBProvider.db.getNotesCountByFolder();
    return _noteCounts;
  }

  void notifyNotesCount() async {
    _noteCounts = await DBProvider.db.getNotesCountByFolder();
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) async {
    if (newIndex > folders.length) newIndex = folders.length;
    if (oldIndex < newIndex) newIndex -= 1;

    final item = _folders[oldIndex]; // 移動するアイテム
    final id = (item as Folder).id;
    // データベースの更新処理 (フォルダ全体を渡して１件ずつ更新？)
    await DBProvider.db.onDragAndDrop(id, oldIndex, newIndex);
    _folders.removeAt(oldIndex);
    _folders.insert(newIndex, item);
    notifyListeners();
  }
}
