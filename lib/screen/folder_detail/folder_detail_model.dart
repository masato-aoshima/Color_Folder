import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/database.dart';
import 'package:sort_note/util/color.dart';

class FolderDetailModel extends ChangeNotifier {
  Folder folder;

  Color _color;

  Color get color {
    if (_color != null) {
      return _color;
    }
    if (folder != null) {
      return folder.color;
    }
    return defaultFolderColor;
  }

  void selectColor(Color color) {
    this._color = color;
    notifyListeners();
  }

  void deleteFolder(int id, int priority) async {
    await DBProvider.db.deleteFolder(id.toString(), priority);
    notifyListeners();
  }

  void upDateFolderName(Folder folder) async {
    await DBProvider.db.updateFolder(folder);
    notifyListeners();
  }
}
