import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class FolderModel extends ChangeNotifier {
  var _folders = List<Folder>();
  List<Folder> get folders => _folders;

  void getFolders() async {
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners(); // liveDataみたいな使い方はどうやるの
  }

  void addFolders(Folder folder) async {
    await DBProvider.db.insertFolder(folder);
    _folders = await DBProvider.db
        .getAllFolders(); // TODO ここ、データベースから取る必要はないかも？(フィールドに直接追加)
    notifyListeners();
  }

  void deleteFolder(int id) async {
    await DBProvider.db.deleteFolder(id.toString());
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners();
  }

  void upDateFolderName(Folder folder) async {
    await DBProvider.db.updateFolder(folder);
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners();
  }
}
