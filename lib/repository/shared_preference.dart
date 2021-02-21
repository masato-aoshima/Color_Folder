import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKey {
  // アプリのテーマカラー
  static const keyThemeColor = 'theme_color';

  // ノートの並び順
  static const keyOrderOfNotes = 'order_of_notes';
}

///
/// アプリのテーマカラー
///
Future<String> getThemeColorString() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferencesKey.keyThemeColor) ??
      '0xff1995AD'; // デフォルトのテーマカラーをここで決める
}

///
/// メモの並び順
///
List<String> orderOfNotesList = [
  'text ASC',
  'text DESC',
  'createdAt DESC',
  'createdAt ASC',
  'updatedAt DESC',
  'updatedAt ASC',
];

Future<String> getOrderOfNotesSetting() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferencesKey.keyOrderOfNotes) ?? 'text ASC';
}

void saveOrderOfNotesSetting(String setting) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(SharedPreferencesKey.keyOrderOfNotes, setting);
}
