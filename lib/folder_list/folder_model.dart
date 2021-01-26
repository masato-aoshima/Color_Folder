import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/model/models.dart';
import 'package:sort_note/repository/database.dart';

// 2. モデルクラスで、ChangeNotifierを継承する
class FolderModel extends ChangeNotifier {
  var _folders = List<Folder>();
  List<Folder> get folders => _folders;

  void getFolders() async {
    _folders = await DBProvider.db.getAllFolders();
    notifyListeners(); // liveDataみたいな使い方はどうやるの
  }
}
