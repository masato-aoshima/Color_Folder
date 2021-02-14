import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class SharedPreferencesKey {
  // ノートの並び順
  static const keyOrderOfNotes = 'order_of_notes';
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
