import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:sort_note/repository/shared_preference.dart';
import 'package:sort_note/util/color.dart';

import '../../main.dart';

class SettingsModel extends ChangeNotifier {
  void onRefresh() {
    notifyListeners();
  }

  ///
  /// アプリのテーマ設定
  ///
  Color pickerColor;

  Future<Color> getColor() async {
    final colorString = await getThemeColorString();
    final color = rawStringToColor(colorString);
    return color;
  }

  void onColorSelected(BuildContext context) {
    // sharedPreferences に 保存
    saveThemeColor(pickerColor);
    // appThemeに反映
    DynamicTheme.of(context)
        .setThemeData(brightThemeData(context, Brightness.light, pickerColor));
  }

  void onColorSelectedDefault(BuildContext context) {
    // sharedPreferences に 保存
    saveThemeColor(defaultThemeColor);
    // appThemeに反映
    DynamicTheme.of(context).setThemeData(
        brightThemeData(context, Brightness.light, defaultThemeColor));
  }

  ///
  /// フォルダーの色設定
  ///
  Color folderColor;

  Future<Color> getFolderColor() async {
    final colorString = await getFolderDefaultColor();
    final color = rawStringToColor(colorString);
    return color;
  }

  void saveFolderColor(Color color) async {
    folderColor = color;
    notifyListeners();
    saveFolderDefaultColor(color);
  }

  ///
  /// ノートの並び順設定
  ///
  String orderBy;

  Future<String> getSortOrder() async {
    return await getOrderOfNotesSetting();
  }
}
