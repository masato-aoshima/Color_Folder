import 'package:flutter/cupertino.dart';

class FolderDefaultColorModel extends ChangeNotifier {
  Color _color;

  Color get color {
    return _color;
  }

  String inputText;

  void setColor(Color color) {
    if (_color == null) {
      _color = color;
    }
  }

  void selectColor(Color color) {
    this._color = color;
    notifyListeners();
  }

  Future onTapSave() async {}

  void clear() {
    _color = null;
  }
}
