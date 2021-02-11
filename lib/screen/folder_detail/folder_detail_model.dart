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
    await DBProvider.db.updateFolder(folder);
    notifyListeners();
  }

  void onTapSave() {
    print('保存ボタンが押されました');
  }
}
