import 'package:flutter/cupertino.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/database.dart';
import 'package:sort_note/util/color.dart';

class FolderDetailModel extends ChangeNotifier {
  Folder _folder;

  Color _color;

  Color get color {
    if (_color != null) {
      return _color;
    }
    if (_folder != null) {
      return _folder.color;
    }
    return defaultFolderColor;
  }

  String inputText;

  void setFolder(Folder folder) {
    if (folder != null) {
      this._folder = folder;
      this.inputText = folder.title;
    }
  }

  void selectColor(Color color) {
    this._color = color;
    notifyListeners();
  }

  void changeText(String text) {
    inputText = text;
  }

  void deleteFolder(int id, int priority) async {
    await DBProvider.db.deleteFolder(id.toString(), priority);
    notifyListeners();
  }

  void upDateFolderName(Folder folder) async {
    await DBProvider.db.updateFolderTitle(folder);
    notifyListeners();
  }

  Future onTapSave() async {
    // 新規作成
    if (_folder == null) {
      final newFolder = Folder(
        title: inputText,
        color: color,
      );
      await DBProvider.db.insertFolder(newFolder);
    }
    // 更新
    if (_folder != null) {
      final updateFolder = Folder(
          id: _folder.id,
          title: inputText,
          color: color,
          priority: _folder.priority);
      await DBProvider.db.updateFolder(updateFolder);
    }
  }

  void clear() {
    _folder = null;
    _color = null;
    inputText = null;
  }
}
