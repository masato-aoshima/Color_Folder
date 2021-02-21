import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sort_note/util/color.dart';

class SharedPreferencesKey {
  // アプリのテーマカラー
  static const keyThemeColor = 'theme_color';

  // ノートの並び順
  static const keyOrderOfNotes = 'order_of_notes';

  // フォルダーの初期色
  static const keyFolderDefaultColor = 'folder_default_color';
}

///
/// アプリのテーマカラー
///
Future<String> getThemeColorString() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferencesKey.keyThemeColor) ??
      rawColorToString(defaultThemeColor); // デフォルトのテーマカラー
}

void saveThemeColor(Color color) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final saveColor = rawColorToString(color);
  prefs.setString(SharedPreferencesKey.keyThemeColor, saveColor);
}

///
/// メモの並び順
///
Map<String, String> orderOfNotesMap = {
  'text ASC': '本文の昇順',
  'text DESC': '本文の降順',
  'createdAt DESC': '作成日の新しい順',
  'createdAt ASC': '作成日の古い順',
  'updatedAt DESC': '変更日の新しい順',
  'updatedAt ASC': '変更日の古い順',
};

Future<String> getOrderOfNotesSetting() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferencesKey.keyOrderOfNotes) ?? 'text ASC';
}

void saveOrderOfNotesSetting(String setting) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(SharedPreferencesKey.keyOrderOfNotes, setting);
}

///
/// フォルダーの色選択で、最初に選択されている色
///
Future<String> getFolderDefaultColor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferencesKey.keyFolderDefaultColor) ??
      rawColorToString(defaultFolderColor); // デフォルトのテーマカラー
}

void saveFolderDefaultColor(Color color) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final saveColor = rawColorToString(color);
  prefs.setString(SharedPreferencesKey.keyFolderDefaultColor, saveColor);
}
