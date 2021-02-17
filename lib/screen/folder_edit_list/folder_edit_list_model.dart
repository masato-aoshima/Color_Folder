import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class FolderEditModel extends ChangeNotifier {
  var isInitializeComplete = false;

  var _folders = List<Folder>();

  List<Folder> get folders => _folders;

  var _noteCounts = Map<int, int>();

  Map<int, int> get noteCounts => _noteCounts;

  Set<int> checkedFolderIds = Set<int>();

  Future getFolders() async {
    if (isInitializeComplete) {
      return;
    }
    isInitializeComplete = true;
    if (_folders.length == 0) {
      _folders = await DBProvider.db.getAllFolders();
    }
    notifyListeners();
  }

  Future getFoldersNotify() async {
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners();
  }

  void clear() {
    _folders = List<Folder>();
    checkedFolderIds.clear();
    isInitializeComplete = false;
  }

  Future deleteFolder(int id, int priority) async {
    await DBProvider.db.deleteFolder(id.toString(), priority);
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners();
  }

  Future deleteFolders() async {
    final deleteFolders = checkedFolderIds
        .map((id) => folders.firstWhere((folder) => id == folder.id));
    deleteFolders.forEach((folder) {
      DBProvider.db.deleteFolder(folder.id.toString(), folder.priority);
    });
    checkedFolderIds.clear();
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
    final id = (item).id;
    // データベースの更新処理 (フォルダ全体を渡して１件ずつ更新？)
    await DBProvider.db.onDragAndDrop(id, oldIndex, newIndex);
    _folders.removeAt(oldIndex);
    _folders.insert(newIndex, item);
    notifyListeners();
  }

  void onItemCheck(int folderId, bool isCheck) {
    if (isCheck) {
      checkedFolderIds.add(folderId);
    } else {
      checkedFolderIds.remove(folderId);
    }
    notifyListeners();
  }
}
