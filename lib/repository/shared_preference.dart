import 'dart:ui';

import 'package:shared_preferences_settings/shared_preferences_settings.dart';
import 'package:sort_note/util/color.dart';

class SharedPreferencesKey {
  // ノートの並び順
  static const keyOrderOfNotes = 'order_of_notes';
  // アプリのテーマカラー
  static const keyThemeColor = 'theme_color';
}

List<String> orderOfNotesList = [
  'text ASC',
  'text DESC',
  'createdAt DESC',
  'createdAt ASC',
  'updatedAt DESC',
  'updatedAt ASC',
];

Future<String> getOrderOfNotesSetting() async {
  final value = await Settings()
      .getString(SharedPreferencesKey.keyOrderOfNotes, orderOfNotesList[0]);
  return value;
}

void saveOrderOfNotesSetting(String setting) {
  Settings().save(SharedPreferencesKey.keyOrderOfNotes, setting);
}

Future<String> getThemeColorString() {
  return Settings().getString(
      SharedPreferencesKey.keyThemeColor, '0xff1995AD'); // デフォルトのテーマカラーをここで決める
}
